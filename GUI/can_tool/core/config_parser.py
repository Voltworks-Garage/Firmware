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
    cmd_id: int
    cmd_type: str
    io_index: int
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
        """Parse a single commandService_config.h file"""
        try:
            with open(config_path, 'r') as f:
                content = f.read()
            
            device_name = self._extract_device_name(config_path)
            tx_id, rx_id = self._extract_can_ids(content, device_name)
            command_definitions = self._extract_command_definitions(content)
            command_map = self._extract_command_map(content)
            commands = self._build_commands(command_map, command_definitions)
            
            config = DeviceConfig(
                device_name=device_name,
                tx_id=tx_id,
                rx_id=rx_id,
                commands=commands,
                command_definitions=command_definitions
            )
            
            return config
            
        except Exception as e:
            print(f"Error parsing config file {config_path}: {e}")
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
        # Try to find CAN ID definitions in comments or code
        # For now, use predefined mappings based on device name
        id_mappings = {
            'BMS': (0x7A1, 0x7A2),
            'MCU': (0x7A3, 0x7A4),
            'Dash': (0x7A5, 0x7A6)
        }
        
        return id_mappings.get(device_name, (0x7A1, 0x7A2))
    
    def _extract_command_definitions(self, content: str) -> Dict[str, int]:
        """Extract #define CMD_* definitions"""
        definitions = {}
        
        # Match patterns like: #define CMD_SET_DEBUG_LED 0x01
        pattern = r'#define\s+(CMD_\w+)\s+(0x[0-9A-Fa-f]+|\d+)'
        matches = re.findall(pattern, content)
        
        for name, value_str in matches:
            try:
                value = int(value_str, 0)  # Auto-detect hex/decimal
                definitions[name] = value
            except ValueError:
                continue
                
        return definitions
    
    def _extract_command_map(self, content: str) -> List[Dict]:
        """Extract commandMap entries"""
        commands = []
        
        # Find the commandMap array - handle nested braces properly
        map_pattern = r'const\s+CommandMapEntry_S\s+commandMap\[\]\s*=\s*\{(.*?)\};'
        map_match = re.search(map_pattern, content, re.DOTALL)
        
        if not map_match:
            return commands
            
        map_content = map_match.group(1)
        
        # Parse individual entries like: {CMD_SET_DEBUG_LED, CMD_TYPE_SET_DIGITAL_OUT, 0, 2, "Set Debug LED"}
        entry_pattern = r'\{\s*([^,]+),\s*([^,]+),\s*(\d+),\s*(\d+),\s*"([^"]+)"\s*\}'
        entries = re.findall(entry_pattern, map_content)
        
        for cmd_name, cmd_type, io_index, min_length, description in entries:
            commands.append({
                'cmd_name': cmd_name.strip(),
                'cmd_type': cmd_type.strip(),
                'io_index': int(io_index),
                'min_payload_length': int(min_length),
                'description': description.strip()
            })
            
        return commands
    
    def _build_commands(self, command_map: List[Dict], command_definitions: Dict[str, int]) -> Dict[str, CommandDefinition]:
        """Build CommandDefinition objects from parsed data"""
        commands = {}
        
        for entry in command_map:
            cmd_name = entry['cmd_name']
            cmd_type = entry['cmd_type']
            
            # Get command ID from definitions
            cmd_id = command_definitions.get(cmd_name, 0)
            
            # Determine parameters based on command type
            params = self._get_params_for_command_type(cmd_type, entry['min_payload_length'])
            
            # Create friendly name from description
            friendly_name = entry['description']
            
            command_def = CommandDefinition(
                cmd_id=cmd_id,
                cmd_type=cmd_type,
                io_index=entry['io_index'],
                min_payload_length=entry['min_payload_length'],
                description=entry['description'],
                params=params
            )
            
            commands[friendly_name] = command_def
            
        return commands
    
    def _get_params_for_command_type(self, cmd_type: str, min_payload_length: int) -> List[str]:
        """Determine parameter list based on command type"""
        type_mappings = {
            'CMD_TYPE_SET_DIGITAL_OUT': ['io_index', 'state'],
            'CMD_TYPE_GET_DIGITAL_IN': ['io_index'],
            'CMD_TYPE_SET_PWM_OUT': ['io_index', 'duty_cycle'],
            'CMD_TYPE_GET_ANALOG_IN': ['io_index'],
            'CMD_TYPE_GET_VOLTAGE': ['io_index'],
            'CMD_TYPE_GET_CURRENT': ['io_index'],
            'CMD_TYPE_CUSTOM': []
        }
        
        base_params = type_mappings.get(cmd_type, [])
        
        # Adjust based on minimum payload length
        # min_payload_length includes the command ID, so subtract 1 for actual params
        expected_param_count = min_payload_length - 1
        
        if len(base_params) > expected_param_count:
            return base_params[:expected_param_count]
        elif len(base_params) < expected_param_count:
            # Add generic parameters if needed
            for i in range(len(base_params), expected_param_count):
                base_params.append(f'param_{i}')
                
        return base_params
    
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