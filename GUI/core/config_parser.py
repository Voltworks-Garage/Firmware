"""
CommandService Config Parser
============================

This module parses commandService_config.h files to extract command definitions
and provides dynamic configuration for the ISO-TP tab based on CAN IDs.
"""

import os
import re
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass


@dataclass
class CommandDefinition:
    """Represents a single command definition from config file"""
    command_type: int      # 8-bit command type (0x01, 0x02, etc.)
    array_index: int       # 8-bit array index (0, 1, 2, etc.)
    cmd_type_name: str     # String name like "CMD_TYPE_SET_DIGITAL_OUT"
    min_payload_length: int
    description: str
    params: List[str]


@dataclass
class DeviceConfig:
    """Represents a complete device configuration"""
    device_name: str
    tx_id: int
    rx_id: int
    commands: Dict[str, CommandDefinition]
    command_definitions: Dict[str, int]  # Command name -> ID mapping


class ConfigParser:
    """Parser for commandService_config.h files"""
    
    def __init__(self, firmware_root: str):
        """Initialize parser with firmware root directory"""
        self.firmware_root = firmware_root
        self.device_configs: Dict[str, DeviceConfig] = {}
        self.id_to_device: Dict[int, str] = {}  # Maps CAN IDs to device names
        
    def scan_for_configs(self) -> List[str]:
        """Scan for all commandService_config.h files in project directories"""
        config_files = []
        projects_dir = os.path.join(self.firmware_root, "Projects")
        
        if os.path.exists(projects_dir):
            for project_dir in os.listdir(projects_dir):
                config_path = os.path.join(projects_dir, project_dir, "commandService_config.h")
                if os.path.exists(config_path):
                    config_files.append(config_path)
                    
        return config_files
    
    def parse_config_file(self, config_path: str) -> Optional[DeviceConfig]:
        """Parse project directory for IO.h and generate commands"""
        try:
            device_name = self._extract_device_name(config_path)
            tx_id, rx_id = self._extract_can_ids("", device_name)
            
            # Find and parse IO.h file in the same directory
            project_dir = os.path.dirname(config_path)
            io_h_path = os.path.join(project_dir, "IO.h")
            
            if not os.path.exists(io_h_path):
                print(f"IO.h not found in {project_dir}")
                return None
                
            commands = self._parse_io_h_file(io_h_path)
            
            config = DeviceConfig(
                device_name=device_name,
                tx_id=tx_id,
                rx_id=rx_id,
                commands=commands,
                command_definitions={}  # No longer needed
            )
            
            return config
            
        except Exception as e:
            print(f"Error parsing project {config_path}: {e}")
            return None
    
    def _extract_device_name(self, config_path: str) -> str:
        """Extract device name from config file path"""
        # Extract from path like ".../BMS_App_02.X/commandService_config.h"
        parts = config_path.replace('\\', '/').split('/')
        for part in reversed(parts):
            if part.endswith('.X'):
                # Remove .X suffix and convert to friendly name
                name = part[:-2]
                if name.startswith('BMS_'):
                    return 'BMS'
                elif name.startswith('MCU_'):
                    return 'MCU'
                elif name.startswith('Dash_'):
                    return 'Dash'
                else:
                    return name.replace('_', ' ')
        return "Unknown"
    
    def _extract_can_ids(self, content: str, device_name: str) -> Tuple[int, int]:
        """Extract CAN IDs from config content or use defaults"""
        # Since we're using TX_ID dropdown for addressing, 
        # these values are only used for internal organization
        # Return placeholder values as they're not used for actual communication
        return (0x000, 0x000)
    
    def _parse_io_h_file(self, io_h_path: str) -> Dict[str, CommandDefinition]:
        """Parse IO.h file to extract function pointer arrays and generate commands"""
        commands = {}
        
        try:
            with open(io_h_path, 'r') as f:
                content = f.read()
            
            # Parse each function pointer array
            arrays = {
                'setDigitalOutFunctions': {'type_id': 0x01, 'params': ['state'], 'prefix': 'Set Digital Out'},
                'getDigitalInFunctions': {'type_id': 0x02, 'params': [], 'prefix': 'Get Digital In'},
                'setPwmOutFunctions': {'type_id': 0x03, 'params': ['duty_cycle'], 'prefix': 'Set PWM Out'},
                'getAnalogInFunctions': {'type_id': 0x04, 'params': [], 'prefix': 'Get Analog In'},
                'getVoltageFunctions': {'type_id': 0x05, 'params': [], 'prefix': 'Get Voltage'},
                'getCurrentFunctions': {'type_id': 0x06, 'params': [], 'prefix': 'Get Current'}
            }
            
            for array_name, config in arrays.items():
                array_commands = self._parse_function_array(content, array_name, config)
                commands.update(array_commands)
            
            return commands
            
        except Exception as e:
            print(f"Error parsing IO.h file {io_h_path}: {e}")
            return {}
    
    def _parse_function_array(self, content: str, array_name: str, config: Dict) -> Dict[str, CommandDefinition]:
        """Parse a specific function pointer array from IO.h"""
        commands = {}
        
        # Find the array definition
        pattern = rf'static\s+const\s+\w+\s+{array_name}\[\]\s*=\s*\{{(.*?)\}};'
        match = re.search(pattern, content, re.DOTALL)
        
        if not match:
            return commands
        
        array_content = match.group(1)
        
        # Split array content into individual entries
        entries = []
        for line in array_content.split('\n'):
            line = line.strip()
            if not line or line.startswith('//'):
                continue
            # Remove trailing comma and extract entry
            entry = line.rstrip(',').strip()
            if entry:
                entries.append(entry)
        
        # Process each entry with its natural array index
        for index, entry in enumerate(entries):
            # Skip NULL entries but continue processing
            if entry == 'NULL' or entry.startswith('NULL'):
                continue
                
            # Remove any inline comments
            if '//' in entry:
                entry = entry.split('//')[0].strip()
            
            # Remove trailing comma if it exists
            func_name = entry.rstrip(',').strip()
            
            if func_name and func_name != 'NULL':
                # Create unique key for storage (with action prefix)
                unique_key = func_name[3:] if func_name.startswith('IO_') else func_name
                
                # Create clean display name (without action prefix)
                display_name = self._function_name_to_description(func_name, config['prefix'])
                
                # Use separate command type and array index (much simpler!)
                command_type = config['type_id']  # Just the 8-bit type value
                array_index = index               # Just the 8-bit index value
                
                # Determine minimum payload length
                min_length = 2 + len(config['params'])  # 2 bytes for type+index + param bytes
                
                # Generate cleaner command type name for display
                type_name = array_name.replace('Functions', '')
                if type_name == 'setDigitalOut':
                    display_type = 'SET_DIGITAL_OUT'
                elif type_name == 'getDigitalIn':
                    display_type = 'GET_DIGITAL_IN'
                elif type_name == 'setPwmOut':
                    display_type = 'SET_PWM_OUT'
                elif type_name == 'getAnalogIn':
                    display_type = 'GET_ANALOG_IN'
                elif type_name == 'getVoltage':
                    display_type = 'GET_VOLTAGE'
                elif type_name == 'getCurrent':
                    display_type = 'GET_CURRENT'
                else:
                    display_type = type_name.upper()
                
                command_def = CommandDefinition(
                    command_type=command_type,
                    array_index=array_index,
                    cmd_type_name=f"CMD_TYPE_{display_type}",
                    min_payload_length=min_length,
                    description=display_name,  # Use clean display name
                    params=config['params'].copy()
                )
                
                commands[unique_key] = command_def  # Use unique key for storage
        
        return commands
    
    def _function_name_to_description(self, func_name: str, prefix: str) -> str:
        """Convert function name like IO_SET_DEBUG_LED_EN to display name"""
        # Remove IO_ prefix first
        if func_name.startswith('IO_'):
            name = func_name[3:]  # Remove "IO_" prefix
        else:
            name = func_name
            
        # Remove action prefixes (SET_, GET_) for cleaner display
        for action_prefix in ['SET_', 'GET_']:
            if name.startswith(action_prefix):
                name = name[len(action_prefix):]
                break
                
        return name
    
    
    def load_all_configs(self):
        """Load all available configuration files"""
        config_files = self.scan_for_configs()
        print(f"🔍 Found {len(config_files)} config files")
        
        for config_file in config_files:
            config = self.parse_config_file(config_file)
            if config:
                self.device_configs[config.device_name] = config
                self.id_to_device[config.tx_id] = config.device_name
                self.id_to_device[config.rx_id] = config.device_name
                print(f"✅ {config.device_name}: {len(config.commands)} commands")
            else:
                print(f"❌ Failed to parse config file: {config_file}")
    
    def get_device_for_ids(self, tx_id: int, rx_id: int) -> Optional[str]:
        """Get device name for given TX/RX ID pair"""
        for device_name, config in self.device_configs.items():
            if config.tx_id == tx_id and config.rx_id == rx_id:
                return device_name
        return None
    
    def get_commands_for_device(self, device_name: str) -> Dict[str, CommandDefinition]:
        """Get all commands for a specific device"""
        config = self.device_configs.get(device_name)
        return config.commands if config else {}
    
    def get_all_devices(self) -> List[str]:
        """Get list of all available device names"""
        return list(self.device_configs.keys())
    
    def get_config_for_device(self, device_name: str) -> Optional[DeviceConfig]:
        """Get complete configuration for a device"""
        return self.device_configs.get(device_name)