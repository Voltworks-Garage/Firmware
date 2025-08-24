"""
CANopen SDO Tab Plugin
======================

This plugin provides CANopen SDO (Service Data Object) functionality for reading
and writing object dictionary entries using EDS files.

Features:
- EDS file parsing and object dictionary management
- SDO read/write operations with proper protocol handling
- Object browser with search functionality
- Data type conversion and validation
- Real-time SDO communication logging
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog
import can
import struct
import time
import configparser
from typing import Dict, Any, Optional, List, Tuple, Union
from enum import Enum
from dataclasses import dataclass
import os

# Try to import canopen library
try:
    import canopen
    CANOPEN_AVAILABLE = True
except ImportError:
    CANOPEN_AVAILABLE = False
    print("📦 canopen library not available. Install with: pip install canopen")

# Import base class - handle both relative and absolute imports
try:
    from ..gui.base_tab import BaseTab
except ImportError:
    from can_tool.gui.base_tab import BaseTab


class CANopenDataTypes(Enum):
    """CANopen data types according to CiA 301"""
    BOOLEAN = 0x01
    INTEGER8 = 0x02
    INTEGER16 = 0x03
    INTEGER32 = 0x04
    UNSIGNED8 = 0x05
    UNSIGNED16 = 0x06
    UNSIGNED32 = 0x07
    REAL32 = 0x08
    VISIBLE_STRING = 0x09
    OCTET_STRING = 0x0A
    UNICODE_STRING = 0x0B
    TIME_OF_DAY = 0x0C
    TIME_DIFFERENCE = 0x0D
    DOMAIN = 0x0F
    INTEGER24 = 0x10
    REAL64 = 0x11
    INTEGER40 = 0x12
    INTEGER48 = 0x13
    INTEGER56 = 0x14
    INTEGER64 = 0x15
    UNSIGNED24 = 0x16
    UNSIGNED40 = 0x18
    UNSIGNED48 = 0x19
    UNSIGNED56 = 0x1A
    UNSIGNED64 = 0x1B


class SDOAbortCode(Enum):
    """SDO Abort Codes according to CiA 301"""
    TOGGLE_BIT_NOT_ALTERNATED = 0x05030000
    SDO_PROTOCOL_TIMED_OUT = 0x05040000
    COMMAND_SPECIFIER_NOT_VALID = 0x05040001
    INVALID_BLOCK_SIZE = 0x05040002
    INVALID_SEQUENCE_NUMBER = 0x05040003
    CRC_ERROR = 0x05040004
    OUT_OF_MEMORY = 0x05040005
    UNSUPPORTED_ACCESS = 0x06010000
    ATTEMPT_TO_READ_WRITE_ONLY = 0x06010001
    ATTEMPT_TO_WRITE_READ_ONLY = 0x06010002
    OBJECT_DOES_NOT_EXIST = 0x06020000
    OBJECT_CANNOT_BE_MAPPED = 0x06040041
    PDO_LENGTH_EXCEEDED = 0x06040042
    GENERAL_PARAMETER_INCOMPATIBILITY = 0x06040043
    GENERAL_INTERNAL_INCOMPATIBILITY = 0x06040047
    HARDWARE_FAULT = 0x06060000
    DATA_TYPE_LENGTH_MISMATCH = 0x06070010
    DATA_TYPE_LENGTH_TOO_HIGH = 0x06070012
    DATA_TYPE_LENGTH_TOO_LOW = 0x06070013
    SUB_INDEX_NOT_EXIST = 0x06090011
    VALUE_RANGE_EXCEEDED = 0x06090030
    VALUE_TOO_HIGH = 0x06090031
    VALUE_TOO_LOW = 0x06090032
    MAX_VALUE_LESS_THAN_MIN = 0x06090036
    GENERAL_ERROR = 0x08000000
    DATA_TRANSFER_OR_STORE_ERROR = 0x08000020
    LOCAL_CONTROL_ERROR = 0x08000021
    DEVICE_STATE_ERROR = 0x08000022


@dataclass
class ObjectDictionaryEntry:
    """Represents an entry in the object dictionary"""
    index: int
    sub_index: int
    name: str
    data_type: int
    access_type: str
    pdo_mapping: bool
    default_value: Any = None
    min_value: Any = None
    max_value: Any = None
    obj_flags: int = 0


@dataclass
class PendingSDORequest:
    """Tracks pending SDO requests for response matching"""
    node_id: int
    index: int
    sub_index: int
    is_write: bool
    timestamp: float
    data_sent: bytes = b''


@dataclass
class MainObjectInfo:
    """Information about a main object (not a sub-index)"""
    index: int
    name: str
    object_type: int
    sub_number: int = 0

class EDSParser:
    """Parser for EDS (Electronic Data Sheet) files"""
    
    def __init__(self, eds_file_path: str):
        self.eds_file_path = eds_file_path
        self.object_dictionary: Dict[Tuple[int, int], ObjectDictionaryEntry] = {}
        self.main_objects: Dict[int, MainObjectInfo] = {}  # Store main object info separately
        self.device_info: Dict[str, Any] = {}
        self.file_info: Dict[str, Any] = {}
        self.vendor_name = "Unknown"
        self.product_name = "Unknown"
        self._parse_eds_file()
    
    def _parse_eds_file(self):
        """Parse the EDS file and build object dictionary"""
        try:
            # Disable interpolation to handle % characters in parameter names
            config = configparser.ConfigParser(interpolation=None)
            config.read(self.eds_file_path)
            
            # Parse file info
            if 'FileInfo' in config:
                self.file_info = dict(config['FileInfo'])
            
            # Parse device info
            if 'DeviceInfo' in config:
                self.device_info = dict(config['DeviceInfo'])
                self.vendor_name = self.device_info.get('VendorName', 'Unknown')
                self.product_name = self.device_info.get('ProductName', 'Unknown')
            
            # Parse object dictionary entries
            for section_name in config.sections():
                if section_name.startswith('[') and section_name.endswith(']'):
                    continue
                    
                # Check if this is an object section (hex number)
                try:
                    if 'sub' in section_name.lower():
                        # Sub-index entry like "1018sub1"
                        parts = section_name.lower().split('sub')
                        index = int(parts[0], 16)
                        sub_index = int(parts[1], 16)
                        
                        # Parse the sub-index object entry
                        entry = self._parse_object_entry(config[section_name], index, sub_index)
                        if entry:
                            self.object_dictionary[(index, sub_index)] = entry
                    else:
                        # Main object entry like "1400" or standalone "5180"
                        index = int(section_name, 16)
                        
                        # Parse main object information for tree structure
                        main_info = self._parse_main_object(config[section_name], index)
                        if main_info:
                            self.main_objects[index] = main_info
                        
                        # Also parse as object entry (for standalone objects or objects with implicit sub-index 0)
                        entry = self._parse_object_entry(config[section_name], index, 0)
                        if entry:
                            self.object_dictionary[(index, 0)] = entry
                        
                except ValueError:
                    # Not a hex number, skip
                    continue
                    
        except Exception as e:
            print(f"Error parsing EDS file {eds_file_path}: {e}")
    
    def _parse_main_object(self, section: configparser.SectionProxy, index: int) -> Optional[MainObjectInfo]:
        """Parse a main object section (e.g., [1400])"""
        try:
            name = section.get('ParameterName', f'Object_{index:04X}')
            object_type = int(section.get('ObjectType', '0'), 0)
            sub_number = int(section.get('SubNumber', '0'), 0)
            
            return MainObjectInfo(
                index=index,
                name=name,
                object_type=object_type,
                sub_number=sub_number
            )
        except Exception as e:
            print(f"Error parsing main object {index:04X}: {e}")
            return None
    
    def _parse_object_entry(self, section: configparser.SectionProxy, index: int, sub_index: int) -> Optional[ObjectDictionaryEntry]:
        """Parse a single object dictionary entry"""
        try:
            name = section.get('ParameterName', f'Object_{index:04X}_{sub_index:02X}')
            
            # Parse data type
            data_type_str = section.get('DataType', '0x0000')
            if data_type_str.startswith('0x') or data_type_str.startswith('0X'):
                data_type = int(data_type_str, 16)
            else:
                data_type = int(data_type_str)
            
            access_type = section.get('AccessType', 'rw').lower()
            pdo_mapping = section.get('PDOMapping', '0') == '1'
            
            # Parse optional values
            default_value = self._parse_value(section.get('DefaultValue', ''))
            min_value = self._parse_value(section.get('LowLimit', ''))
            max_value = self._parse_value(section.get('HighLimit', ''))
            
            obj_flags_str = section.get('ObjFlags', '0')
            if obj_flags_str.startswith('0x'):
                obj_flags = int(obj_flags_str, 16)
            else:
                obj_flags = int(obj_flags_str) if obj_flags_str.isdigit() else 0
            
            return ObjectDictionaryEntry(
                index=index,
                sub_index=sub_index,
                name=name,
                data_type=data_type,
                access_type=access_type,
                pdo_mapping=pdo_mapping,
                default_value=default_value,
                min_value=min_value,
                max_value=max_value,
                obj_flags=obj_flags
            )
        
        except Exception as e:
            print(f"Error parsing object {index:04X}:{sub_index:02X}: {e}")
            return None
    
    def _parse_value(self, value_str: str) -> Any:
        """Parse a value string from EDS file"""
        if not value_str or value_str.upper() in ['', 'NO', 'NONE']:
            return None
        
        # Try hex format
        if value_str.startswith('0x') or value_str.startswith('0X'):
            try:
                return int(value_str, 16)
            except ValueError:
                pass
        
        # Try decimal format
        try:
            return int(value_str)
        except ValueError:
            pass
        
        # Return as string
        return value_str
    
    def get_object(self, index: int, sub_index: int = 0) -> Optional[ObjectDictionaryEntry]:
        """Get an object dictionary entry"""
        return self.object_dictionary.get((index, sub_index))
    
    def find_objects_by_name(self, name: str) -> List[ObjectDictionaryEntry]:
        """Find objects by name (case-insensitive partial match)"""
        name = name.lower()
        return [entry for entry in self.object_dictionary.values() 
                if name in entry.name.lower()]
    
    def get_all_objects(self) -> List[ObjectDictionaryEntry]:
        """Get all object dictionary entries sorted by index"""
        objects = list(self.object_dictionary.values())
        return sorted(objects, key=lambda x: (x.index, x.sub_index))
    
    def get_main_object_name(self, index: int) -> Optional[str]:
        """Get the main object name for a given index"""
        if index in self.main_objects:
            return self.main_objects[index].name
        return None


class DataTypeConverter:
    """Converts between Python values and CANopen data types"""
    
    @staticmethod
    def encode_value(value: Any, data_type: int) -> bytes:
        """Encode a Python value to bytes according to CANopen data type"""
        try:
            if data_type == CANopenDataTypes.BOOLEAN.value:
                return struct.pack('<B', 1 if value else 0)
            
            elif data_type == CANopenDataTypes.INTEGER8.value:
                val = int(value)
                if not (-128 <= val <= 127):
                    raise ValueError(f"Value {val} out of range for INTEGER8 (-128 to 127)")
                return struct.pack('<b', val)
            
            elif data_type == CANopenDataTypes.INTEGER16.value:
                val = int(value)
                if not (-32768 <= val <= 32767):
                    raise ValueError(f"Value {val} out of range for INTEGER16 (-32768 to 32767)")
                return struct.pack('<h', val)
            
            elif data_type == CANopenDataTypes.INTEGER32.value:
                val = int(value)
                if not (-2147483648 <= val <= 2147483647):
                    raise ValueError(f"Value {val} out of range for INTEGER32 (-2147483648 to 2147483647)")
                return struct.pack('<i', val)
            
            elif data_type == CANopenDataTypes.UNSIGNED8.value:
                val = int(value)
                if not (0 <= val <= 255):
                    raise ValueError(f"Value {val} out of range for UNSIGNED8 (0 to 255)")
                return struct.pack('<B', val)
            
            elif data_type == CANopenDataTypes.UNSIGNED16.value:
                val = int(value)
                if not (0 <= val <= 65535):
                    raise ValueError(f"Value {val} out of range for UNSIGNED16 (0 to 65535)")
                return struct.pack('<H', val)
            
            elif data_type == CANopenDataTypes.UNSIGNED32.value:
                val = int(value)
                if not (0 <= val <= 4294967295):
                    raise ValueError(f"Value {val} out of range for UNSIGNED32 (0 to 4294967295)")
                return struct.pack('<I', val)
            
            elif data_type == CANopenDataTypes.REAL32.value:
                return struct.pack('<f', float(value))
            
            elif data_type == CANopenDataTypes.REAL64.value:
                return struct.pack('<d', float(value))
            
            elif data_type in [CANopenDataTypes.VISIBLE_STRING.value, 
                              CANopenDataTypes.OCTET_STRING.value]:
                if isinstance(value, str):
                    return value.encode('utf-8')
                elif isinstance(value, bytes):
                    return value
                else:
                    return str(value).encode('utf-8')
            
            else:
                # Default to 32-bit unsigned for unknown types
                return struct.pack('<I', int(value))
        
        except Exception as e:
            raise ValueError(f"Cannot encode value {value} (type: {type(value)}) as data type {data_type:04X}: {e}")
    
    @staticmethod
    def decode_value(data: bytes, data_type: int) -> Any:
        """Decode bytes to Python value according to CANopen data type"""
        if not data:
            return None
        
        try:
            if data_type == CANopenDataTypes.BOOLEAN.value:
                return struct.unpack('<B', data[:1])[0] != 0
            
            elif data_type == CANopenDataTypes.INTEGER8.value:
                return struct.unpack('<b', data[:1])[0]
            
            elif data_type == CANopenDataTypes.INTEGER16.value:
                return struct.unpack('<h', data[:2])[0]
            
            elif data_type == CANopenDataTypes.INTEGER32.value:
                return struct.unpack('<i', data[:4])[0]
            
            elif data_type == CANopenDataTypes.UNSIGNED8.value:
                return struct.unpack('<B', data[:1])[0]
            
            elif data_type == CANopenDataTypes.UNSIGNED16.value:
                return struct.unpack('<H', data[:2])[0]
            
            elif data_type == CANopenDataTypes.UNSIGNED32.value:
                return struct.unpack('<I', data[:4])[0]
            
            elif data_type == CANopenDataTypes.REAL32.value:
                return struct.unpack('<f', data[:4])[0]
            
            elif data_type == CANopenDataTypes.REAL64.value:
                return struct.unpack('<d', data[:8])[0]
            
            elif data_type in [CANopenDataTypes.VISIBLE_STRING.value,
                              CANopenDataTypes.OCTET_STRING.value]:
                # Remove null terminator if present
                if data[-1:] == b'\x00':
                    data = data[:-1]
                return data.decode('utf-8', errors='ignore')
            
            else:
                # Return as integer for unknown types
                if len(data) == 1:
                    return struct.unpack('<B', data)[0]
                elif len(data) == 2:
                    return struct.unpack('<H', data)[0]
                elif len(data) >= 4:
                    return struct.unpack('<I', data[:4])[0]
                else:
                    return int.from_bytes(data, byteorder='little')
        
        except (struct.error, UnicodeDecodeError) as e:
            print(f"Error decoding data type {data_type}: {e}")
            return f"0x{data.hex().upper()}"
    
    @staticmethod
    def get_data_type_name(data_type: int) -> str:
        """Get human-readable name for data type"""
        for dt in CANopenDataTypes:
            if dt.value == data_type:
                return dt.name
        return f"UNKNOWN_{data_type:02X}"
    
    @staticmethod
    def get_data_type_size(data_type: int) -> int:
        """Get the size in bytes for a data type"""
        size_map = {
            CANopenDataTypes.BOOLEAN.value: 1,
            CANopenDataTypes.INTEGER8.value: 1,
            CANopenDataTypes.INTEGER16.value: 2,
            CANopenDataTypes.INTEGER32.value: 4,
            CANopenDataTypes.UNSIGNED8.value: 1,
            CANopenDataTypes.UNSIGNED16.value: 2,
            CANopenDataTypes.UNSIGNED32.value: 4,
            CANopenDataTypes.REAL32.value: 4,
            CANopenDataTypes.REAL64.value: 8,
        }
        return size_map.get(data_type, 4)  # Default to 4 bytes


class CANopenSDOTab(BaseTab):
    """CANopen SDO communication tab"""
    
    @property
    def tab_name(self) -> str:
        return "CANopen SDO"
    
    @property 
    def tab_description(self) -> str:
        return "CANopen SDO read/write operations using EDS object dictionary"
    
    def __init__(self, parent_notebook: ttk.Notebook, app_instance):
        super().__init__(parent_notebook, app_instance)
        self.eds_parser = None
        self.current_node_id = 1
        self.pending_requests: Dict[int, PendingSDORequest] = {}  # COB-ID -> request
        self.selected_object = None
        self.sdo_timeout_seconds = 1.0  # SDO timeout in seconds
        self.timeout_timer = None
        
        # CANopen library integration
        self.canopen_network = None
        self.canopen_node = None
        self.use_canopen_lib = False
        
        # Load EDS file
        self._load_eds_file()
    
    def _load_eds_file(self):
        """Load the EDS file"""
        # Try to find EDS file relative to the GUI
        current_dir = os.path.dirname(__file__)  # plugins/
        can_tool_dir = os.path.dirname(current_dir)  # can_tool/
        gui_dir = os.path.dirname(can_tool_dir)  # GUI/
        firmware_dir = os.path.dirname(gui_dir)  # Firmware/
        eds_path = os.path.join(firmware_dir, "SevconController", "new_EDS.eds")
        
        if os.path.exists(eds_path):
            try:
                self.eds_parser = EDSParser(eds_path)
                print(f"✅ Loaded EDS file: {eds_path}")
                print(f"   Objects loaded: {len(self.eds_parser.object_dictionary)}")
                print(f"   Device: {self.eds_parser.vendor_name} - {self.eds_parser.product_name}")
            except Exception as e:
                print(f"❌ Error loading EDS file: {e}")
                self.eds_parser = None
        else:
            print(f"❌ EDS file not found: {eds_path}")
            self.eds_parser = None
    
    def create_widgets(self):
        """Create the CANopen interface with SDO and PDO sub-tabs"""
        main_frame = self.tab_frame
        
        if not self.eds_parser:
            # Show error message if EDS file couldn't be loaded
            error_frame = ttk.LabelFrame(main_frame, text="Error")
            error_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
            
            ttk.Label(error_frame, text="❌ EDS file could not be loaded.", 
                     font=("Arial", 12)).pack(pady=20)
            ttk.Button(error_frame, text="Browse for EDS file", 
                      command=self._browse_eds_file).pack(pady=5)
            return
        
        # Create sub-tab notebook
        self.notebook = ttk.Notebook(main_frame)
        self.notebook.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Create SDO tab
        self.sdo_frame = ttk.Frame(self.notebook)
        self.notebook.add(self.sdo_frame, text="SDO")
        
        # Create PDO tab
        self.pdo_frame = ttk.Frame(self.notebook)
        self.notebook.add(self.pdo_frame, text="PDO")
        
        # Create SDO widgets
        self._create_sdo_widgets()
        
        # Create PDO widgets
        self._create_pdo_widgets()
    
    def _create_sdo_widgets(self):
        """Create the SDO interface widgets"""
        main_frame = self.sdo_frame
        
        # Create main paned window (left: browser, right: operations)
        main_paned = ttk.PanedWindow(main_frame, orient=tk.HORIZONTAL)
        main_paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left panel: Object browser
        browser_frame = ttk.LabelFrame(main_paned, text="Object Dictionary")
        main_paned.add(browser_frame, weight=1)
        
        # Search frame
        search_frame = ttk.Frame(browser_frame)
        search_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(search_frame, text="Search:").pack(side=tk.LEFT)
        self.search_var = tk.StringVar()
        self.search_entry = ttk.Entry(search_frame, textvariable=self.search_var)
        self.search_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(5, 0))
        self.search_entry.bind('<KeyRelease>', self._on_search_changed)
        
        # Object tree
        tree_frame = ttk.Frame(browser_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Create treeview with scrollbars
        self.object_tree = ttk.Treeview(tree_frame, columns=('type', 'access'), show='tree headings')
        self.object_tree.heading('#0', text='Object')
        self.object_tree.heading('type', text='Type')
        self.object_tree.heading('access', text='Access')
        
        self.object_tree.column('#0', width=300)
        self.object_tree.column('type', width=100)
        self.object_tree.column('access', width=60)
        
        tree_scroll_y = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.object_tree.yview)
        tree_scroll_x = ttk.Scrollbar(tree_frame, orient=tk.HORIZONTAL, command=self.object_tree.xview)
        self.object_tree.configure(yscrollcommand=tree_scroll_y.set, xscrollcommand=tree_scroll_x.set)
        
        self.object_tree.grid(row=0, column=0, sticky='nsew')
        tree_scroll_y.grid(row=0, column=1, sticky='ns')
        tree_scroll_x.grid(row=1, column=0, sticky='ew')
        
        tree_frame.grid_rowconfigure(0, weight=1)
        tree_frame.grid_columnconfigure(0, weight=1)
        
        self.object_tree.bind('<<TreeviewSelect>>', self._on_object_selected)
        
        # Right panel: Operations
        ops_frame = ttk.LabelFrame(main_paned, text="SDO Operations")
        main_paned.add(ops_frame, weight=1)
        
        # Node ID selection
        node_frame = ttk.Frame(ops_frame)
        node_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(node_frame, text="Node ID:").pack(side=tk.LEFT)
        self.node_id_var = tk.StringVar(value="1")
        self.node_id_spin = ttk.Spinbox(node_frame, from_=1, to=127, width=5, 
                                       textvariable=self.node_id_var)
        self.node_id_spin.pack(side=tk.LEFT, padx=(5, 20))
        
        # Update preview when node ID changes
        self.node_id_var.trace('w', self._update_can_preview)
        
        # SDO Timeout setting
        ttk.Label(node_frame, text="Timeout (s):").pack(side=tk.LEFT, padx=(20, 5))
        self.timeout_var = tk.StringVar(value="1.0")
        timeout_spin = ttk.Spinbox(node_frame, from_=0.1, to=10.0, width=4, 
                                  textvariable=self.timeout_var, increment=0.1)
        timeout_spin.pack(side=tk.LEFT, padx=(0, 20))
        
        # Update timeout when changed
        self.timeout_var.trace('w', self._on_timeout_changed)
        
        # Device info
        device_text = f"{self.eds_parser.vendor_name} - {self.eds_parser.product_name}"
        ttk.Label(node_frame, text=device_text, font=("Arial", 9, "italic")).pack(side=tk.LEFT)
        
        # NMT Control frame
        nmt_frame = ttk.LabelFrame(ops_frame, text="NMT Network Management")
        nmt_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # NMT controls in one row
        nmt_controls_frame = ttk.Frame(nmt_frame)
        nmt_controls_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(nmt_controls_frame, text="NMT State:").pack(side=tk.LEFT)
        self.nmt_state_var = tk.StringVar()
        self.nmt_state_combo = ttk.Combobox(nmt_controls_frame, textvariable=self.nmt_state_var, 
                                           state="readonly", width=20)
        # NMT command states according to CiA 301
        nmt_commands = [
            "Start Remote Node",
            "Stop Remote Node", 
            "Enter Pre-operational",
            "Reset Node",
            "Reset Communication"
        ]
        self.nmt_state_combo.config(values=nmt_commands)
        self.nmt_state_combo.set("Start Remote Node")  # Default selection
        self.nmt_state_combo.pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(nmt_controls_frame, text="Target Node:").pack(side=tk.LEFT)
        self.nmt_node_var = tk.StringVar(value="1")
        self.nmt_node_entry = ttk.Entry(nmt_controls_frame, textvariable=self.nmt_node_var, width=5)
        self.nmt_node_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Button(nmt_controls_frame, text="Send NMT", command=self._send_nmt_command).pack(side=tk.LEFT, padx=5)
        
        # Object selection frame
        obj_frame = ttk.LabelFrame(ops_frame, text="Selected Object")
        obj_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # All object info in one row: Index, Sub, Name, Type, Access
        info_frame = ttk.Frame(obj_frame)
        info_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(info_frame, text="Index:").pack(side=tk.LEFT)
        self.index_var = tk.StringVar()
        self.index_entry = ttk.Entry(info_frame, textvariable=self.index_var, width=8)
        self.index_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(info_frame, text="Sub:").pack(side=tk.LEFT)
        self.sub_index_var = tk.StringVar()
        self.sub_index_entry = ttk.Entry(info_frame, textvariable=self.sub_index_var, width=4)
        self.sub_index_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(info_frame, text="Name:").pack(side=tk.LEFT)
        self.obj_name_var = tk.StringVar()
        ttk.Label(info_frame, textvariable=self.obj_name_var, font=("Arial", 9, "bold"), width=20, anchor="w").pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(info_frame, text="Type:").pack(side=tk.LEFT)
        self.obj_type_var = tk.StringVar()
        ttk.Label(info_frame, textvariable=self.obj_type_var, width=12, anchor="w").pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(info_frame, text="Access:").pack(side=tk.LEFT)
        self.obj_access_var = tk.StringVar()
        ttk.Label(info_frame, textvariable=self.obj_access_var, width=8, anchor="w").pack(side=tk.LEFT, padx=(5, 10))
        
        # Value operations frame
        value_frame = ttk.LabelFrame(ops_frame, text="Value Operations")
        value_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # All value operations in one row: Read, Current, New Value, Write
        operations_frame = ttk.Frame(value_frame)
        operations_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Button(operations_frame, text="Read Value", command=self._read_object).pack(side=tk.LEFT)
        
        ttk.Label(operations_frame, text="Current:").pack(side=tk.LEFT, padx=(10, 5))
        self.current_value_var = tk.StringVar()
        # Width 15 to hold "0x" + 8 hex digits (uint32) = 10 chars + some extra for readability
        ttk.Label(operations_frame, textvariable=self.current_value_var, 
                 font=("Courier", 9), background="white", relief="sunken", width=15, anchor="w").pack(side=tk.LEFT, padx=(0, 10))
        
        ttk.Label(operations_frame, text="New Value:").pack(side=tk.LEFT)
        self.write_value_var = tk.StringVar(value="0x")
        self.write_entry = ttk.Entry(operations_frame, textvariable=self.write_value_var, width=15)
        self.write_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        # Bind events to handle hex input formatting
        self.write_entry.bind('<KeyPress>', self._on_value_key_press)
        self.write_entry.bind('<FocusIn>', self._on_value_focus_in)
        self.write_value_var.trace('w', self._update_can_preview)  # Live update on value change
        
        ttk.Button(operations_frame, text="Write Value", command=self._write_object).pack(side=tk.LEFT)
        
        # CAN Message Preview
        preview_frame = ttk.Frame(value_frame)
        preview_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(preview_frame, text="CAN Preview:").pack(side=tk.LEFT)
        self.can_preview_var = tk.StringVar(value="Select object and enter value...")
        preview_label = ttk.Label(preview_frame, textvariable=self.can_preview_var, 
                                 font=("Courier", 9), background="#f0f0f0", relief="sunken", 
                                 foreground="#333")
        preview_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(5, 0))
        
        # Range info
        range_frame = ttk.Frame(value_frame)
        range_frame.pack(fill=tk.X, padx=5, pady=2)
        
        self.range_info_var = tk.StringVar()
        ttk.Label(range_frame, textvariable=self.range_info_var, 
                 font=("Arial", 8), foreground="gray").pack(side=tk.LEFT)
        
        # Communication log
        log_frame = ttk.LabelFrame(ops_frame, text="SDO Communication Log")
        log_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.sdo_log = scrolledtext.ScrolledText(log_frame, wrap=tk.WORD, height=8)
        self.sdo_log.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Log control buttons
        log_control_frame = ttk.Frame(log_frame)
        log_control_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Button(log_control_frame, text="Clear Log", command=self._clear_log).pack(side=tk.LEFT)
        ttk.Button(log_control_frame, text="Browse EDS File", command=self._browse_eds_file).pack(side=tk.RIGHT)
        
        # Populate object tree
        self._populate_object_tree()
        
        # Initial log message
        self._log_message("✅ CANopen SDO plugin initialized")
        self._log_message(f"📁 EDS file loaded: {len(self.eds_parser.object_dictionary)} objects")
    
    def _create_pdo_widgets(self):
        """Create the PDO configuration interface"""
        main_frame = self.pdo_frame
        
        # Create main layout
        pdo_notebook = ttk.Notebook(main_frame)
        pdo_notebook.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # RPDO (Receive PDO) tab
        rpdo_frame = ttk.Frame(pdo_notebook)
        pdo_notebook.add(rpdo_frame, text="RPDO (Receive)")
        
        # TPDO (Transmit PDO) tab  
        tpdo_frame = ttk.Frame(pdo_notebook)
        pdo_notebook.add(tpdo_frame, text="TPDO (Transmit)")
        
        # Create RPDO interface
        self._create_rpdo_interface(rpdo_frame)
        
        # Create TPDO interface
        self._create_tpdo_interface(tpdo_frame)
    
    def _create_rpdo_interface(self, parent_frame):
        """Create RPDO (Receive PDO) configuration interface"""
        # PDO selection frame
        pdo_select_frame = ttk.LabelFrame(parent_frame, text="RPDO Selection")
        pdo_select_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(pdo_select_frame, text="RPDO Number:").pack(side=tk.LEFT, padx=5)
        self.rpdo_number_var = tk.StringVar(value="1")
        rpdo_combo = ttk.Combobox(pdo_select_frame, textvariable=self.rpdo_number_var, 
                                 values=["1", "2", "3", "4"], width=5, state="readonly")
        rpdo_combo.pack(side=tk.LEFT, padx=5)
        rpdo_combo.bind('<<ComboboxSelected>>', self._on_rpdo_selected)
        
        # PDO configuration frame
        config_frame = ttk.LabelFrame(parent_frame, text="PDO Configuration")
        config_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # COB-ID
        cob_frame = ttk.Frame(config_frame)
        cob_frame.pack(fill=tk.X, padx=5, pady=2)
        ttk.Label(cob_frame, text="COB-ID:").pack(side=tk.LEFT)
        self.rpdo_cob_var = tk.StringVar(value="0x200")
        ttk.Entry(cob_frame, textvariable=self.rpdo_cob_var, width=10).pack(side=tk.LEFT, padx=5)
        
        # Transmission type
        trans_frame = ttk.Frame(config_frame)
        trans_frame.pack(fill=tk.X, padx=5, pady=2)
        ttk.Label(trans_frame, text="Transmission Type:").pack(side=tk.LEFT)
        self.rpdo_trans_var = tk.StringVar(value="255")
        rpdo_trans_combo = ttk.Combobox(trans_frame, textvariable=self.rpdo_trans_var, width=25, state="readonly")
        rpdo_trans_combo['values'] = [
            "1 - Synchronous (every SYNC)",
            "2 - Synchronous (every 2nd SYNC)", 
            "10 - Synchronous (every 10th SYNC)",
            "50 - Synchronous (every 50th SYNC)",
            "100 - Synchronous (every 100th SYNC)",
            "254 - Manufacturer-specific async",
            "255 - Event-driven/async"
        ]
        rpdo_trans_combo.set("255 - Event-driven/async")  # Default for RPDO
        rpdo_trans_combo.pack(side=tk.LEFT, padx=5)
        
        # Mapping frame
        mapping_frame = ttk.LabelFrame(parent_frame, text="Object Mapping")
        mapping_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Mapping table
        columns = ('slot', 'object', 'subindex', 'length', 'description')
        self.rpdo_mapping_tree = ttk.Treeview(mapping_frame, columns=columns, show='headings', height=8)
        
        for col in columns:
            self.rpdo_mapping_tree.heading(col, text=col.title())
            
        self.rpdo_mapping_tree.column('slot', width=50)
        self.rpdo_mapping_tree.column('object', width=80)
        self.rpdo_mapping_tree.column('subindex', width=80)
        self.rpdo_mapping_tree.column('length', width=60)
        self.rpdo_mapping_tree.column('description', width=200)
        
        # Scrollbar for mapping tree
        mapping_scroll = ttk.Scrollbar(mapping_frame, orient=tk.VERTICAL, command=self.rpdo_mapping_tree.yview)
        self.rpdo_mapping_tree.configure(yscrollcommand=mapping_scroll.set)
        
        self.rpdo_mapping_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        mapping_scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        # Control buttons
        button_frame = ttk.Frame(parent_frame)
        button_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Button(button_frame, text="Load Configuration", command=self._load_rpdo_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Save Configuration", command=self._save_rpdo_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Add Mapping", command=self._add_rpdo_mapping).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Remove Mapping", command=self._remove_rpdo_mapping).pack(side=tk.LEFT, padx=5)
    
    def _create_tpdo_interface(self, parent_frame):
        """Create TPDO (Transmit PDO) configuration interface"""
        # Similar structure to RPDO but for transmit PDOs
        # PDO selection frame
        pdo_select_frame = ttk.LabelFrame(parent_frame, text="TPDO Selection")
        pdo_select_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(pdo_select_frame, text="TPDO Number:").pack(side=tk.LEFT, padx=5)
        self.tpdo_number_var = tk.StringVar(value="1")
        tpdo_combo = ttk.Combobox(pdo_select_frame, textvariable=self.tpdo_number_var, 
                                 values=["1", "2", "3", "4"], width=5, state="readonly")
        tpdo_combo.pack(side=tk.LEFT, padx=5)
        tpdo_combo.bind('<<ComboboxSelected>>', self._on_tpdo_selected)
        
        # PDO configuration frame
        config_frame = ttk.LabelFrame(parent_frame, text="PDO Configuration")
        config_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # COB-ID
        cob_frame = ttk.Frame(config_frame)
        cob_frame.pack(fill=tk.X, padx=5, pady=2)
        ttk.Label(cob_frame, text="COB-ID:").pack(side=tk.LEFT)
        self.tpdo_cob_var = tk.StringVar(value="0x180")
        ttk.Entry(cob_frame, textvariable=self.tpdo_cob_var, width=10).pack(side=tk.LEFT, padx=5)
        
        # Transmission type
        trans_frame = ttk.Frame(config_frame)
        trans_frame.pack(fill=tk.X, padx=5, pady=2)
        ttk.Label(trans_frame, text="Transmission Type:").pack(side=tk.LEFT)
        self.tpdo_trans_var = tk.StringVar(value="255")
        tpdo_trans_combo = ttk.Combobox(trans_frame, textvariable=self.tpdo_trans_var, width=25, state="readonly")
        tpdo_trans_combo['values'] = [
            "1 - Synchronous (every SYNC)",
            "2 - Synchronous (every 2nd SYNC)", 
            "10 - Synchronous (every 10th SYNC)",
            "50 - Synchronous (every 50th SYNC)",
            "100 - Synchronous (every 100th SYNC)",
            "254 - Manufacturer-specific async",
            "255 - Event-driven/async"
        ]
        tpdo_trans_combo.set("255 - Event-driven/async")  # Default for TPDO
        tpdo_trans_combo.pack(side=tk.LEFT, padx=5)
        
        # Event timer
        timer_frame = ttk.Frame(config_frame)
        timer_frame.pack(fill=tk.X, padx=5, pady=2)
        ttk.Label(timer_frame, text="Event Timer (ms):").pack(side=tk.LEFT)
        self.tpdo_timer_var = tk.StringVar(value="0")
        ttk.Entry(timer_frame, textvariable=self.tpdo_timer_var, width=10).pack(side=tk.LEFT, padx=5)
        
        # Mapping frame
        mapping_frame = ttk.LabelFrame(parent_frame, text="Object Mapping")
        mapping_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Mapping table
        columns = ('slot', 'object', 'subindex', 'length', 'description')
        self.tpdo_mapping_tree = ttk.Treeview(mapping_frame, columns=columns, show='headings', height=8)
        
        for col in columns:
            self.tpdo_mapping_tree.heading(col, text=col.title())
            
        self.tpdo_mapping_tree.column('slot', width=50)
        self.tpdo_mapping_tree.column('object', width=80)
        self.tpdo_mapping_tree.column('subindex', width=80)
        self.tpdo_mapping_tree.column('length', width=60)
        self.tpdo_mapping_tree.column('description', width=200)
        
        # Scrollbar for mapping tree
        mapping_scroll = ttk.Scrollbar(mapping_frame, orient=tk.VERTICAL, command=self.tpdo_mapping_tree.yview)
        self.tpdo_mapping_tree.configure(yscrollcommand=mapping_scroll.set)
        
        self.tpdo_mapping_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        mapping_scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        # Control buttons
        button_frame = ttk.Frame(parent_frame)
        button_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Button(button_frame, text="Load Configuration", command=self._load_tpdo_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Save Configuration", command=self._save_tpdo_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Add Mapping", command=self._add_tpdo_mapping).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Remove Mapping", command=self._remove_tpdo_mapping).pack(side=tk.LEFT, padx=5)
    
    # Helper methods for transmission type handling
    def _get_transmission_type_value(self, combo_value):
        """Extract numeric transmission type from dropdown text"""
        if not combo_value:
            return 255
        # Extract number before the first space/dash
        return int(combo_value.split(' ')[0])
    
    def _set_transmission_type_combo(self, var, value):
        """Set transmission type combo to match numeric value"""
        transmission_map = {
            1: "1 - Synchronous (every SYNC)",
            2: "2 - Synchronous (every 2nd SYNC)",
            10: "10 - Synchronous (every 10th SYNC)",
            50: "50 - Synchronous (every 50th SYNC)",
            100: "100 - Synchronous (every 100th SYNC)",
            254: "254 - Manufacturer-specific async",
            255: "255 - Event-driven/async"
        }
        var.set(transmission_map.get(value, "255 - Event-driven/async"))
    
    # PDO event handlers (placeholder implementations)
    def _on_rpdo_selected(self, event=None):
        """Handle RPDO selection change"""
        # TODO: Load selected RPDO configuration
        pass
    
    def _on_tpdo_selected(self, event=None):
        """Handle TPDO selection change"""
        # TODO: Load selected TPDO configuration
        pass
    
    def _load_rpdo_config(self):
        """Load RPDO configuration from device"""
        try:
            # Get selected RPDO number (1-4)
            pdo_num = int(self.rpdo_number_var.get())
            
            # Check if we're connected
            if not self.app.running or not self.app.bus:
                self._log_message("❌ ERROR: CAN not connected")
                return
            
            # Calculate object indices for this RPDO
            comm_index = 0x1400 + (pdo_num - 1)  # 0x1400-0x1403 for RPDO 1-4
            map_index = 0x1600 + (pdo_num - 1)   # 0x1600-0x1603 for RPDO 1-4 mapping
            
            self._log_message(f"📥 Loading RPDO {pdo_num} configuration...")
            self._log_message(f"📄 Communication object: 0x{comm_index:04X}")
            self._log_message(f"📄 Mapping object: 0x{map_index:04X}")
            
            # Store the PDO being loaded for response handling
            self.loading_pdo = {
                'type': 'RPDO',
                'number': pdo_num,
                'comm_index': comm_index,
                'map_index': map_index,
                'step': 'comm_cob_id'  # Track which parameter we're reading
            }
            
            # Start the loading sequence by reading COB-ID
            self._request_sdo_read(comm_index, 0x01, f"RPDO {pdo_num} COB-ID", for_pdo_loading=True)
            
        except Exception as e:
            self._log_message(f"❌ ERROR: Failed to load RPDO configuration: {e}")
    
    def _save_rpdo_config(self):
        """Save RPDO configuration to device"""
        # TODO: Implement RPDO configuration saving via SDO
        pass
    
    def _add_rpdo_mapping(self):
        """Add object mapping to RPDO"""
        # TODO: Implement mapping addition
        pass
    
    def _remove_rpdo_mapping(self):
        """Remove object mapping from RPDO"""
        # TODO: Implement mapping removal
        pass
    
    def _load_tpdo_config(self):
        """Load TPDO configuration from device"""
        try:
            # Get selected TPDO number (1-4)
            pdo_num = int(self.tpdo_number_var.get())
            
            # Check if we're connected
            if not self.app.running or not self.app.bus:
                self._log_message("❌ ERROR: CAN not connected")
                return
            
            # Calculate object indices for this TPDO
            comm_index = 0x1800 + (pdo_num - 1)  # 0x1800-0x1803 for TPDO 1-4
            map_index = 0x1A00 + (pdo_num - 1)   # 0x1A00-0x1A03 for TPDO 1-4 mapping
            
            self._log_message(f"📥 Loading TPDO {pdo_num} configuration...")
            self._log_message(f"📄 Communication object: 0x{comm_index:04X}")
            self._log_message(f"📄 Mapping object: 0x{map_index:04X}")
            
            # Store the PDO being loaded for response handling
            self.loading_pdo = {
                'type': 'TPDO',
                'number': pdo_num,
                'comm_index': comm_index,
                'map_index': map_index,
                'step': 'comm_cob_id'  # Track which parameter we're reading
            }
            
            # Start the loading sequence by reading COB-ID
            self._request_sdo_read(comm_index, 0x01, f"TPDO {pdo_num} COB-ID", for_pdo_loading=True)
            
        except Exception as e:
            self._log_message(f"❌ ERROR: Failed to load TPDO configuration: {e}")
    
    def _request_sdo_read(self, index, sub_index, description="", for_pdo_loading=False):
        """Send an SDO read request"""
        try:
            node_id = int(self.node_id_var.get())
            if node_id < 1 or node_id > 127:
                raise Exception("Invalid node ID")
            
            # Create SDO upload (read) request
            tx_id = 0x600 + node_id
            rx_id = 0x580 + node_id
            
            sdo_data = [
                0x40,  # Command (SDO upload initiate)
                index & 0xFF,        # Index low byte
                (index >> 8) & 0xFF, # Index high byte  
                sub_index,           # Sub-index
                0x00, 0x00, 0x00, 0x00  # Unused for upload initiate
            ]
            
            # Send SDO request
            import can
            msg = can.Message(arbitration_id=tx_id, data=sdo_data, is_extended_id=False)
            self.app.bus.send(msg)
            
            # Only track as regular request if not for PDO loading
            if not for_pdo_loading:
                # Store pending request for response matching
                request = PendingSDORequest(
                    node_id=node_id,
                    index=index, 
                    sub_index=sub_index,
                    is_write=False,
                    timestamp=time.time()
                )
                self.pending_requests[rx_id] = request
                
                # Start timeout timer if not already running
                if not self.timeout_timer:
                    self.timeout_timer = self.app.root.after(100, self._check_sdo_timeouts)
            
            self._log_message(f"📤 SDO READ: {description} - Node {node_id} 0x{index:04X}:{sub_index:02X}")
            self._log_message(f"    TX: 0x{tx_id:03X} → {bytes(sdo_data).hex().upper()}")
            
        except Exception as e:
            self._log_message(f"❌ ERROR: SDO read request failed: {e}")
            # Clear loading state on error
            if hasattr(self, 'loading_pdo'):
                delattr(self, 'loading_pdo')
    
    def _continue_tpdo_loading(self, index, sub_index, value):
        """Continue TPDO loading sequence based on response"""
        if not hasattr(self, 'loading_pdo') or self.loading_pdo['type'] != 'TPDO':
            return
            
        pdo_info = self.loading_pdo
        step = pdo_info['step']
        pdo_num = pdo_info['number']
        
        try:
            if step == 'comm_cob_id' and index == pdo_info['comm_index'] and sub_index == 0x01:
                # Process COB-ID response
                cob_id = value & 0x7FF  # Mask out valid bit
                self.tpdo_cob_var.set(f"0x{cob_id:03X}")
                self._log_message(f"📄 TPDO {pdo_num} COB-ID: 0x{cob_id:03X}")
                
                # Next: read transmission type
                pdo_info['step'] = 'comm_trans_type'
                self._request_sdo_read(pdo_info['comm_index'], 0x02, f"TPDO {pdo_num} transmission type", for_pdo_loading=True)
                
            elif step == 'comm_trans_type' and index == pdo_info['comm_index'] and sub_index == 0x02:
                # Process transmission type response
                self._set_transmission_type_combo(self.tpdo_trans_var, value)
                self._log_message(f"📄 TPDO {pdo_num} transmission type: {value}")
                
                # Next: read event timer
                pdo_info['step'] = 'comm_event_timer'
                self._request_sdo_read(pdo_info['comm_index'], 0x05, f"TPDO {pdo_num} event timer", for_pdo_loading=True)
                
            elif step == 'comm_event_timer' and index == pdo_info['comm_index'] and sub_index == 0x05:
                # Process event timer response
                self.tpdo_timer_var.set(str(value))
                self._log_message(f"📄 TPDO {pdo_num} event timer: {value} ms")
                
                # Next: read mapping count
                pdo_info['step'] = 'map_count'
                self._request_sdo_read(pdo_info['map_index'], 0x00, f"TPDO {pdo_num} mapping count", for_pdo_loading=True)
                
            elif step == 'map_count' and index == pdo_info['map_index'] and sub_index == 0x00:
                # Process mapping count response
                self._log_message(f"📄 TPDO {pdo_num} has {value} mapped objects")
                
                # Clear existing mappings in UI
                self.tpdo_mapping_tree.delete(*self.tpdo_mapping_tree.get_children())
                
                # Start reading mapping entries (always read all 8 slots)
                pdo_info['step'] = 'map_entries'
                pdo_info['map_count'] = value
                pdo_info['current_slot'] = 1
                
                # Always read slot 1 (will show unused if value is 0)
                self._request_sdo_read(pdo_info['map_index'], 1, f"TPDO {pdo_num} mapping slot 1", for_pdo_loading=True)
                    
            elif step == 'map_entries' and index == pdo_info['map_index']:
                # Process mapping entry response
                slot = pdo_info['current_slot']
                
                self._log_message(f"📄 TPDO Slot {slot} raw value: 0x{value:08X}")
                
                if value != 0:  # Non-zero mapping
                    # Decode 32-bit mapping value
                    obj_index = (value >> 16) & 0xFFFF
                    obj_sub_index = (value >> 8) & 0xFF
                    bit_length = value & 0xFF
                    
                    # Get object description from EDS
                    description = self._get_object_description(obj_index, obj_sub_index)
                    
                    # Add to mapping table
                    self.tpdo_mapping_tree.insert('', 'end', values=(
                        slot, 
                        f"0x{obj_index:04X}", 
                        f"0x{obj_sub_index:02X}",
                        bit_length, 
                        description
                    ))
                    
                    self._log_message(f"📄 Slot {slot}: 0x{obj_index:04X}:{obj_sub_index:02X} ({bit_length} bits) - {description}")
                    
                    # Check for inconsistency with mapping count
                    if slot > pdo_info['map_count']:
                        self._log_message(f"⚠️  WARNING: Slot {slot} has data but mapping count is {pdo_info['map_count']} - possible stale configuration")
                else:
                    # Empty/unused mapping slot
                    self.tpdo_mapping_tree.insert('', 'end', values=(
                        slot, 
                        "-", 
                        "-",
                        "-", 
                        "(unused)"
                    ))
                    
                    self._log_message(f"📄 Slot {slot}: (unused)")
                
                # Continue with next slot or finish
                pdo_info['current_slot'] += 1
                if pdo_info['current_slot'] <= 8:  # Always read all 8 slots
                    next_slot = pdo_info['current_slot']
                    self._request_sdo_read(pdo_info['map_index'], next_slot, f"TPDO {pdo_num} mapping slot {next_slot}", for_pdo_loading=True)
                else:
                    # Finished reading all mappings
                    self._finish_tpdo_loading()
                    
        except Exception as e:
            self._log_message(f"❌ ERROR: Failed to process TPDO loading step {step}: {e}")
            self._finish_tpdo_loading()
    
    def _finish_tpdo_loading(self):
        """Finish TPDO loading sequence"""
        if hasattr(self, 'loading_pdo'):
            pdo_num = self.loading_pdo['number']
            self._log_message(f"✅ TPDO {pdo_num} configuration loaded successfully")
            delattr(self, 'loading_pdo')
    
    def _continue_rpdo_loading(self, index, sub_index, value):
        """Continue RPDO loading sequence based on response"""
        if not hasattr(self, 'loading_pdo') or self.loading_pdo['type'] != 'RPDO':
            return
            
        pdo_info = self.loading_pdo
        step = pdo_info['step']
        pdo_num = pdo_info['number']
        
        try:
            if step == 'comm_cob_id' and index == pdo_info['comm_index'] and sub_index == 0x01:
                # Process COB-ID response
                cob_id = value & 0x7FF  # Mask out valid bit
                self.rpdo_cob_var.set(f"0x{cob_id:03X}")
                self._log_message(f"📄 RPDO {pdo_num} COB-ID: 0x{cob_id:03X} (raw value: 0x{value:08X})")
                self._log_message(f"📄 UI updated: rpdo_cob_var set to {self.rpdo_cob_var.get()}")
                
                # Next: read transmission type
                pdo_info['step'] = 'comm_trans_type'
                self._request_sdo_read(pdo_info['comm_index'], 0x02, f"RPDO {pdo_num} transmission type", for_pdo_loading=True)
                
            elif step == 'comm_trans_type' and index == pdo_info['comm_index'] and sub_index == 0x02:
                # Process transmission type response
                self._set_transmission_type_combo(self.rpdo_trans_var, value)
                self._log_message(f"📄 RPDO {pdo_num} transmission type: {value}")
                self._log_message(f"📄 UI updated: rpdo_trans_var set to {self.rpdo_trans_var.get()}")
                
                # Next: read mapping count (RPDOs don't have event timer)
                pdo_info['step'] = 'map_count'
                self._request_sdo_read(pdo_info['map_index'], 0x00, f"RPDO {pdo_num} mapping count", for_pdo_loading=True)
                
            elif step == 'map_count' and index == pdo_info['map_index'] and sub_index == 0x00:
                # Process mapping count response
                self._log_message(f"📄 RPDO {pdo_num} mapping count: {value} (0x{value:02X})")
                self._log_message(f"📄 Note: Reading all 8 slots regardless of count to check for stale data")
                
                # Clear existing mappings in UI
                self.rpdo_mapping_tree.delete(*self.rpdo_mapping_tree.get_children())
                
                # Start reading mapping entries (always read all 8 slots)
                pdo_info['step'] = 'map_entries'
                pdo_info['map_count'] = value
                pdo_info['current_slot'] = 1
                
                # Always read slot 1 (will show unused if value is 0)
                self._request_sdo_read(pdo_info['map_index'], 1, f"RPDO {pdo_num} mapping slot 1", for_pdo_loading=True)
                    
            elif step == 'map_entries' and index == pdo_info['map_index']:
                # Process mapping entry response
                slot = pdo_info['current_slot']
                
                self._log_message(f"📄 RPDO Slot {slot} raw value: 0x{value:08X}")
                
                if value != 0:  # Non-zero mapping
                    # Decode 32-bit mapping value
                    obj_index = (value >> 16) & 0xFFFF
                    obj_sub_index = (value >> 8) & 0xFF
                    bit_length = value & 0xFF
                    
                    # Get object description from EDS
                    description = self._get_object_description(obj_index, obj_sub_index)
                    
                    # Add to mapping table
                    self.rpdo_mapping_tree.insert('', 'end', values=(
                        slot, 
                        f"0x{obj_index:04X}", 
                        f"0x{obj_sub_index:02X}",
                        bit_length, 
                        description
                    ))
                    
                    self._log_message(f"📄 Slot {slot}: 0x{obj_index:04X}:{obj_sub_index:02X} ({bit_length} bits) - {description}")
                    
                    # Check for inconsistency with mapping count
                    if slot > pdo_info['map_count']:
                        self._log_message(f"⚠️  WARNING: Slot {slot} has data but mapping count is {pdo_info['map_count']} - possible stale configuration")
                else:
                    # Empty/unused mapping slot
                    self.rpdo_mapping_tree.insert('', 'end', values=(
                        slot, 
                        "-", 
                        "-",
                        "-", 
                        "(unused)"
                    ))
                    
                    self._log_message(f"📄 Slot {slot}: (unused)")
                
                # Continue with next slot or finish
                pdo_info['current_slot'] += 1
                if pdo_info['current_slot'] <= 8:  # Always read all 8 slots
                    next_slot = pdo_info['current_slot']
                    self._request_sdo_read(pdo_info['map_index'], next_slot, f"RPDO {pdo_num} mapping slot {next_slot}", for_pdo_loading=True)
                else:
                    # Finished reading all mappings
                    self._finish_rpdo_loading()
                    
        except Exception as e:
            self._log_message(f"❌ ERROR: Failed to process RPDO loading step {step}: {e}")
            self._finish_rpdo_loading()
    
    def _finish_rpdo_loading(self):
        """Finish RPDO loading sequence"""
        if hasattr(self, 'loading_pdo'):
            pdo_num = self.loading_pdo['number']
            self._log_message(f"✅ RPDO {pdo_num} configuration loaded successfully")
            delattr(self, 'loading_pdo')
    
    def _finish_pdo_loading(self):
        """Finish PDO loading sequence (generic for both TPDO and RPDO)"""
        if hasattr(self, 'loading_pdo'):
            pdo_type = self.loading_pdo['type']
            if pdo_type == 'TPDO':
                self._finish_tpdo_loading()
            elif pdo_type == 'RPDO':
                self._finish_rpdo_loading()
    
    def _get_object_description(self, index, sub_index):
        """Get object description from EDS file"""
        try:
            obj = self.eds_parser.get_object(index, sub_index)
            if obj:
                return obj.name
            else:
                # Try to get main object name if sub-index not found
                main_name = self.eds_parser.get_main_object_name(index)
                if main_name:
                    return f"{main_name} (sub {sub_index})"
                else:
                    return f"Object_{index:04X}_{sub_index:02X}"
        except:
            return f"Unknown_{index:04X}_{sub_index:02X}"
    
    def _save_tpdo_config(self):
        """Save TPDO configuration to device"""
        # TODO: Implement TPDO configuration saving via SDO
        pass
    
    def _add_tpdo_mapping(self):
        """Add object mapping to TPDO"""
        # TODO: Implement mapping addition
        pass
    
    def _remove_tpdo_mapping(self):
        """Remove object mapping from TPDO"""
        # TODO: Implement mapping removal
        pass

    def _browse_eds_file(self):
        """Browse for and load a new EDS file"""
        file_path = filedialog.askopenfilename(
            title="Select EDS File",
            filetypes=[("EDS Files", "*.eds"), ("All Files", "*.*")]
        )
        
        if file_path:
            try:
                self.eds_parser = EDSParser(file_path)
                self._log_message(f"✅ Loaded new EDS file: {file_path}")
                self._log_message(f"📁 Objects loaded: {len(self.eds_parser.object_dictionary)}")
                
                # Recreate widgets with new EDS data
                for widget in self.tab_frame.winfo_children():
                    widget.destroy()
                self.create_widgets()
                
            except Exception as e:
                messagebox.showerror("EDS Load Error", f"Failed to load EDS file:\n{e}")
    
    def _populate_object_tree(self, filter_text: str = ""):
        """Populate the object tree with EDS objects"""
        if not self.eds_parser:
            return
        
        # Clear existing items
        for item in self.object_tree.get_children():
            self.object_tree.delete(item)
        
        # Get objects to display - handle main objects and sub-index objects separately
        objects_to_display = {}
        
        # Get all sub-index objects (including standalone objects parsed as sub-index 0)
        all_sub_index_objects = self.eds_parser.get_all_objects()
        
        # Group sub-index objects by their main index
        sub_index_groups = {}
        for obj in all_sub_index_objects:
            if obj.index not in sub_index_groups:
                sub_index_groups[obj.index] = []
            sub_index_groups[obj.index].append(obj)
        
        # Add all objects (both standalone and with multiple sub-indices)
        for index, sub_objects in sub_index_groups.items():
            main_info = self.eds_parser.main_objects.get(index)
            objects_to_display[index] = {
                'type': 'with_subs',
                'main_info': main_info,
                'sub_objects': sub_objects
            }
        
        # Apply filter if provided
        if filter_text:
            filter_text = filter_text.lower()
            filtered_objects = {}
            
            for index, obj_info in objects_to_display.items():
                matches = False
                
                # Check main object name
                if obj_info['main_info'] and filter_text in obj_info['main_info'].name.lower():
                    matches = True
                
                # Check sub-object names and indices
                if not matches:
                    for sub_obj in obj_info['sub_objects']:
                        if (filter_text in sub_obj.name.lower() or 
                            filter_text in f"{sub_obj.index:04x}" or
                            filter_text in f"{sub_obj.index:04x}:{sub_obj.sub_index:02x}"):
                            matches = True
                            break
                
                # Check index match
                if not matches and filter_text in f"{index:04x}":
                    matches = True
                
                if matches:
                    filtered_objects[index] = obj_info
            
            objects_to_display = filtered_objects
        
        # Process objects for display
        for index in sorted(objects_to_display.keys()):
            obj_info = objects_to_display[index]
            
            if obj_info['type'] == 'with_subs':
                # Object with sub-indices
                sub_objects = obj_info['sub_objects']
                sub_objects.sort(key=lambda x: x.sub_index)
                
                if len(sub_objects) == 1 and sub_objects[0].sub_index == 0:
                    # Single sub-index 0 object - display as single entry
                    obj = sub_objects[0]
                    main_text = f"0x{index:04X} - {obj.name}"
                    data_type_name = DataTypeConverter.get_data_type_name(obj.data_type)
                    
                    self.object_tree.insert('', 'end', text=main_text,
                                           values=(data_type_name, obj.access_type),
                                           tags=(f"{obj.index:04X}:{obj.sub_index:02X}",))
                else:
                    # Multiple sub-indices - create tree structure
                    main_object_name = obj_info['main_info'].name if obj_info['main_info'] else f"Object_{index:04X}"
                    main_text = f"0x{index:04X} - {main_object_name}"
                    
                    # Create parent entry
                    main_item = self.object_tree.insert('', 'end', text=main_text,
                                                      values=("", ""),
                                                      tags=())
                    
                    # Add all sub-indices as children
                    for obj in sub_objects:
                        sub_text = f"[{obj.sub_index:02X}] {obj.name}"
                        data_type_name = DataTypeConverter.get_data_type_name(obj.data_type)
                        
                        self.object_tree.insert(main_item, 'end', text=sub_text,
                                               values=(data_type_name, obj.access_type),
                                               tags=(f"{obj.index:04X}:{obj.sub_index:02X}",))
        
        # Expand all main items
        for item in self.object_tree.get_children():
            self.object_tree.item(item, open=True)
    
    def _on_search_changed(self, event=None):
        """Handle search text changes"""
        search_text = self.search_var.get()
        self._populate_object_tree(search_text)
    
    def _on_object_selected(self, event=None):
        """Handle object selection in tree"""
        selection = self.object_tree.selection()
        if not selection:
            return
        
        # Get the tags which contain the index:sub_index
        item = selection[0]
        tags = self.object_tree.item(item, 'tags')
        if not tags:
            return
        
        try:
            # Parse index:sub_index from tag
            index_str, sub_index_str = tags[0].split(':')
            index = int(index_str, 16)
            sub_index = int(sub_index_str, 16)
            
            # Get object from EDS
            obj = self.eds_parser.get_object(index, sub_index)
            if obj:
                self.selected_object = obj
                self._update_object_info(obj)
            
        except (ValueError, IndexError) as e:
            print(f"Error parsing object selection: {e}")
    
    def _update_object_info(self, obj: ObjectDictionaryEntry):
        """Update the object information display"""
        self.index_var.set(f"0x{obj.index:04X}")
        self.sub_index_var.set(f"0x{obj.sub_index:02X}")
        self.obj_name_var.set(obj.name)
        
        data_type_name = DataTypeConverter.get_data_type_name(obj.data_type)
        self.obj_type_var.set(data_type_name)
        self.obj_access_var.set(obj.access_type.upper())
        
        # Update range information
        range_info = ""
        if obj.min_value is not None and obj.max_value is not None:
            range_info = f"Range: {obj.min_value} - {obj.max_value}"
        elif obj.min_value is not None:
            range_info = f"Min: {obj.min_value}"
        elif obj.max_value is not None:
            range_info = f"Max: {obj.max_value}"
        
        if obj.default_value is not None:
            if range_info:
                range_info += f", Default: {obj.default_value}"
            else:
                range_info = f"Default: {obj.default_value}"
        
        self.range_info_var.set(range_info)
        
        # Clear current value and reset write value to hex prefix
        self.current_value_var.set("")
        self.write_value_var.set("0x")
        
        # Update CAN preview when object changes
        self._update_can_preview()
    
    def _read_object(self):
        """Read the selected object via SDO"""
        if not self.selected_object:
            messagebox.showwarning("No Selection", "Please select an object to read.")
            return
        
        if not self.app.running or not self.app.bus:
            messagebox.showerror("Not Connected", "Please connect to CAN bus first.")
            return
        
        # Check if readable (allow 'ro', 'rw', and 'const' access types)
        access_type = self.selected_object.access_type.lower()
        if not ('r' in access_type or 'const' in access_type):
            messagebox.showwarning("Read Error", f"Selected object is write-only (access: {access_type}).")
            return
        
        try:
            node_id = int(self.node_id_var.get())
            if node_id < 1 or node_id > 127:
                raise ValueError("Node ID must be between 1 and 127")
        except ValueError as e:
            messagebox.showerror("Invalid Node ID", str(e))
            return
        
        # Send SDO upload initiate
        self._send_sdo_upload(node_id, self.selected_object.index, self.selected_object.sub_index)
    
    def _write_object(self):
        """Write to the selected object via SDO"""
        if not self.selected_object:
            messagebox.showwarning("No Selection", "Please select an object to write.")
            return
        
        if not self.app.running or not self.app.bus:
            messagebox.showerror("Not Connected", "Please connect to CAN bus first.")
            return
        
        # Check if writable (allow 'wo', 'rw' access types)
        access_type = self.selected_object.access_type.lower()
        if 'w' not in access_type:
            messagebox.showwarning("Write Error", f"Selected object is read-only (access: {access_type}).")
            return
        
        value_str = self.write_value_var.get().strip()
        if not value_str:
            messagebox.showwarning("No Value", "Please enter a value to write.")
            return
        
        try:
            node_id = int(self.node_id_var.get())
            if node_id < 1 or node_id > 127:
                raise ValueError("Node ID must be between 1 and 127")
        except ValueError as e:
            messagebox.showerror("Invalid Node ID", str(e))
            return
        
        # Parse and validate value
        try:
            # Convert string to appropriate type based on data type
            if self.selected_object.data_type in [CANopenDataTypes.REAL32.value, CANopenDataTypes.REAL64.value]:
                # Handle floating point values
                value = float(value_str)
            elif self.selected_object.data_type in [CANopenDataTypes.VISIBLE_STRING.value, CANopenDataTypes.OCTET_STRING.value]:
                # Handle string values - remove "0x" prefix if present for strings
                if value_str.startswith('0x') or value_str.startswith('0X'):
                    # For strings, if user enters hex, treat as string literal
                    value = value_str
                else:
                    value = value_str
            elif value_str.startswith('0x') or value_str.startswith('0X'):
                # Handle hexadecimal values
                value = int(value_str, 16)
            else:
                # Handle decimal values
                try:
                    value = int(value_str)
                except ValueError:
                    # If not a valid integer, treat as string for string data types
                    if self.selected_object.data_type in [CANopenDataTypes.VISIBLE_STRING.value, CANopenDataTypes.OCTET_STRING.value]:
                        value = value_str
                    else:
                        raise
            
            # Check range (only for numeric types)
            if isinstance(value, (int, float)):
                if self.selected_object.min_value is not None and value < self.selected_object.min_value:
                    messagebox.showerror("Value Error", f"Value {value} is below minimum {self.selected_object.min_value}")
                    return
                
                if self.selected_object.max_value is not None and value > self.selected_object.max_value:
                    messagebox.showerror("Value Error", f"Value {value} is above maximum {self.selected_object.max_value}")
                    return
            
            # Debug: Log what we're trying to encode
            self._log_message(f"🔧 DEBUG: Encoding value={value} (type={type(value)}) as data_type=0x{self.selected_object.data_type:04X}")
            
            # Encode value
            encoded_data = DataTypeConverter.encode_value(value, self.selected_object.data_type)
            
            # Send SDO download initiate
            self._send_sdo_download(node_id, self.selected_object.index, self.selected_object.sub_index, encoded_data)
            
        except ValueError as e:
            messagebox.showerror("Invalid Value", f"Cannot parse value '{value_str}': {e}")
    
    def _send_sdo_upload(self, node_id: int, index: int, sub_index: int):
        """Send SDO upload initiate message"""
        try:
            # Create SDO upload initiate message
            cmd = 0x40  # Upload initiate
            data = bytes([
                cmd,                    # Command specifier
                index & 0xFF,          # Index low byte
                (index >> 8) & 0xFF,   # Index high byte
                sub_index,             # Sub-index
                0, 0, 0, 0             # Reserved bytes
            ])
            
            tx_id = 0x600 + node_id
            rx_id = 0x580 + node_id
            
            # Store pending request
            request = PendingSDORequest(
                node_id=node_id,
                index=index,
                sub_index=sub_index,
                is_write=False,
                timestamp=time.time()
            )
            self.pending_requests[rx_id] = request
            
            # Preview the message before sending
            obj_name = self.selected_object.name if self.selected_object else "Unknown"
            self._log_message(f"📤 READ REQUEST: Node {node_id} - 0x{index:04X}:{sub_index:02X} ({obj_name})")
            self._log_message(f"    📋 PREVIEW: CAN ID 0x{tx_id:03X} → [{' '.join(f'{b:02X}' for b in data)}]")
            self._log_message(f"    📋 BREAKDOWN: Cmd=0x{data[0]:02X} Index=0x{data[2]:02X}{data[1]:02X} Sub=0x{data[3]:02X}")
            
            # Send message
            msg = can.Message(arbitration_id=tx_id, data=data, is_extended_id=False)
            self.app.bus.send(msg)
            
            self._log_message(f"    ✅ SENT: Upload request transmitted")
            
            # Start timeout timer if not already running
            if not self.timeout_timer:
                self.timeout_timer = self.app.root.after(100, self._check_sdo_timeouts)
            
        except Exception as e:
            self._log_message(f"❌ ERROR: Failed to send read request: {e}")
    
    def _send_sdo_download(self, node_id: int, index: int, sub_index: int, data: bytes):
        """Send SDO download initiate message"""
        try:
            if len(data) <= 4:
                # Expedited transfer
                cmd = 0x23  # Download initiate, expedited
                if len(data) < 4:
                    cmd |= ((4 - len(data)) << 2)  # Size indicated
                    cmd |= 0x01  # Size indicated bit
                
                # Build CAN data manually to avoid struct issues
                can_data = bytes([
                    cmd,                    # Command specifier
                    index & 0xFF,          # Index low byte
                    (index >> 8) & 0xFF,   # Index high byte
                    sub_index              # Sub-index
                ]) + data + b'\x00' * (4 - len(data))  # Data padded to 4 bytes
            else:
                # Segmented transfer (not implemented)
                raise NotImplementedError("Segmented SDO transfers not supported")
            
            tx_id = 0x600 + node_id
            rx_id = 0x580 + node_id
            
            # Store pending request
            request = PendingSDORequest(
                node_id=node_id,
                index=index,
                sub_index=sub_index,
                is_write=True,
                timestamp=time.time(),
                data_sent=data
            )
            self.pending_requests[rx_id] = request
            
            # Send message
            msg = can.Message(arbitration_id=tx_id, data=can_data, is_extended_id=False)
            self.app.bus.send(msg)
            
            # Log the request
            obj_name = self.selected_object.name if self.selected_object else "Unknown"
            value_display = data.hex().upper() if len(data) <= 4 else f"{data[:4].hex().upper()}..."
            self._log_message(f"📤 WRITE: Node {node_id} - 0x{index:04X}:{sub_index:02X} ({obj_name}) = {value_display}")
            self._log_message(f"    TX: 0x{tx_id:03X} → {can_data.hex().upper()}")
            
            # Start timeout timer if not already running
            if not self.timeout_timer:
                self.timeout_timer = self.app.root.after(100, self._check_sdo_timeouts)
            
        except Exception as e:
            self._log_message(f"❌ ERROR: Failed to send write request: {e}")
    
    def _clear_log(self):
        """Clear the communication log"""
        self.sdo_log.delete(1.0, tk.END)
    
    def _log_message(self, message: str):
        """Add a message to the communication log"""
        timestamp = time.strftime("%H:%M:%S")
        self.sdo_log.insert(tk.END, f"[{timestamp}] {message}\n")
        self.sdo_log.see(tk.END)
    
    def _on_value_key_press(self, event):
        """Handle key press in value entry field"""
        # Prevent deletion of "0x" prefix
        current_value = self.write_value_var.get()
        cursor_pos = self.write_entry.index(tk.INSERT)
        
        # If trying to delete and cursor is at position 0 or 1, and we have "0x", prevent it
        if event.keysym in ['BackSpace', 'Delete']:
            if current_value.startswith("0x") and cursor_pos <= 2:
                if cursor_pos == 0 or (cursor_pos == 1 and event.keysym == 'BackSpace'):
                    return "break"  # Prevent the deletion
        
        # If we're at the start and trying to type, make sure "0x" stays
        if cursor_pos == 0 and event.char.isprintable() and not current_value.startswith("0x"):
            self.write_value_var.set("0x" + current_value)
            self.write_entry.icursor(2)  # Move cursor after "0x"
            return "break"
    
    def _on_value_focus_in(self, event):
        """Handle focus in event for value entry field"""
        current_value = self.write_value_var.get()
        
        # If field is empty or doesn't start with "0x", set it to "0x"
        if not current_value or not current_value.startswith("0x"):
            self.write_value_var.set("0x")
            self.write_entry.icursor(2)  # Position cursor after "0x"
    
    def _update_can_preview(self, *args):
        """Update the CAN message preview based on current inputs"""
        if not self.selected_object:
            self.can_preview_var.set("Select an object first...")
            return
        
        try:
            # Get current inputs
            node_id = int(self.node_id_var.get()) if self.node_id_var.get().isdigit() else 1
            value_str = self.write_value_var.get().strip()
            
            if not value_str or value_str == "0x":
                self.can_preview_var.set("Enter a value to see CAN preview...")
                return
            
            # Parse the value
            try:
                if self.selected_object.data_type in [CANopenDataTypes.REAL32.value, CANopenDataTypes.REAL64.value]:
                    value = float(value_str)
                elif self.selected_object.data_type in [CANopenDataTypes.VISIBLE_STRING.value, CANopenDataTypes.OCTET_STRING.value]:
                    value = value_str
                elif value_str.startswith('0x') or value_str.startswith('0X'):
                    value = int(value_str, 16)
                else:
                    try:
                        value = int(value_str)
                    except ValueError:
                        if self.selected_object.data_type in [CANopenDataTypes.VISIBLE_STRING.value, CANopenDataTypes.OCTET_STRING.value]:
                            value = value_str
                        else:
                            raise
            except ValueError:
                self.can_preview_var.set(f"Invalid value: {value_str}")
                return
            
            # Encode the value
            try:
                encoded_data = DataTypeConverter.encode_value(value, self.selected_object.data_type)
            except ValueError as e:
                self.can_preview_var.set(f"Encoding error: {str(e)}")
                return
            
            # Build SDO message preview
            if len(encoded_data) <= 4:
                # Expedited transfer
                cmd = 0x23  # Download initiate, expedited
                if len(encoded_data) < 4:
                    cmd |= ((4 - len(encoded_data)) << 2)  # Size indicated
                    cmd |= 0x01  # Size indicated bit
                
                # Build the CAN message
                tx_id = 0x600 + node_id
                can_data = bytes([
                    cmd,                                    # Command specifier
                    self.selected_object.index & 0xFF,     # Index low byte
                    (self.selected_object.index >> 8) & 0xFF,  # Index high byte
                    self.selected_object.sub_index         # Sub-index
                ]) + encoded_data + b'\x00' * (4 - len(encoded_data))
                
                # Format the preview
                data_hex = ' '.join(f'{b:02X}' for b in can_data)
                data_type_name = DataTypeConverter.get_data_type_name(self.selected_object.data_type)
                
                preview = f"ID:0x{tx_id:03X} → [{data_hex}] ({data_type_name}: {value})"
                
                # Add breakdown on hover or in tooltip style
                cmd_desc = f"Cmd:0x{cmd:02X}"
                index_desc = f"Idx:0x{self.selected_object.index:04X}"
                sub_desc = f"Sub:0x{self.selected_object.sub_index:02X}"
                data_desc = f"Data:[{' '.join(f'{b:02X}' for b in encoded_data)}]"
                
                self.can_preview_var.set(f"{preview} | {cmd_desc} {index_desc} {sub_desc} {data_desc}")
            else:
                self.can_preview_var.set("Segmented transfer (not supported)")
                
        except Exception as e:
            self.can_preview_var.set(f"Preview error: {str(e)}")
    
    def on_can_message_received(self, msg):
        """Process incoming CAN messages for SDO responses"""
        rx_id = msg.arbitration_id
        data = list(msg.data)
        
        # Check if this is an SDO response (0x580 + node ID)
        if (rx_id & 0xFF80) != 0x580:
            return
        
        if len(data) < 4:
            return
        
        node_id = rx_id & 0x7F
        cmd = data[0]
        
        # Check for abort first
        if cmd == 0x80:
            self._handle_sdo_abort(rx_id, data, node_id)
            return
        
        # Check if this is a regular SDO response we're waiting for
        if rx_id in self.pending_requests:
            self._handle_regular_sdo_response(rx_id, data)
            return
        
        # Check if this is a PDO loading response
        if hasattr(self, 'loading_pdo') and node_id == self.current_node_id:
            self._handle_pdo_loading_response(data)
            return
    
    def _handle_sdo_abort(self, rx_id, data, node_id):
        """Handle SDO abort messages"""
        # Check if this was a regular SDO request
        request = self.pending_requests.pop(rx_id, None)
        if request:
            response_time = time.time() - request.timestamp
            timestamp_info = f" ({response_time:.3f}s)"
        else:
            timestamp_info = ""
        
        if len(data) >= 8:
            abort_code = struct.unpack('<L', bytes(data[4:8]))[0]
            # Try to get a meaningful error name
            error_name = "UNKNOWN_ERROR"
            for abort in SDOAbortCode:
                if abort.value == abort_code:
                    error_name = abort.name.replace('_', ' ')
                    break
            
            self._log_message(f"📥 ABORT: 0x{abort_code:08X} - {error_name}{timestamp_info}")
        else:
            self._log_message(f"📥 ABORT: Invalid abort message{timestamp_info}")
        
        self._log_message(f"    RX: 0x{rx_id:03X} ← {bytes(data).hex().upper()}")
        
        # If this was a PDO loading abort, clean up
        if hasattr(self, 'loading_pdo') and node_id == self.current_node_id:
            self._log_message(f"❌ PDO loading aborted")
            self._finish_pdo_loading()
    
    def _handle_regular_sdo_response(self, rx_id, data):
        """Handle regular SDO responses for manual read/write operations"""
        request = self.pending_requests.pop(rx_id)
        response_time = time.time() - request.timestamp
        cmd = data[0]
        
        # Process successful response
        if request.is_write:
            # Write response
            if (cmd & 0xE0) == 0x60:  # Download initiate response
                self._log_message(f"📥 WRITE OK: Success ({response_time:.3f}s)")
            else:
                self._log_message(f"📥 WRITE RESPONSE: Unexpected format ({response_time:.3f}s)")
        else:
            # Read response
            if (cmd & 0xE0) == 0x40:  # Upload initiate response
                if cmd & 0x02:  # Expedited transfer
                    size_indicated = cmd & 0x01
                    if size_indicated:
                        data_size = 4 - ((cmd >> 2) & 0x03)
                    else:
                        data_size = 4
                    
                    raw_data = bytes(data[4:4+data_size])
                    
                    # Decode the value for display
                    if self.selected_object and request.index == self.selected_object.index and request.sub_index == self.selected_object.sub_index:
                        try:
                            decoded_value = DataTypeConverter.decode_value(raw_data, self.selected_object.data_type)
                            
                            # Update current value display
                            if isinstance(decoded_value, float):
                                value_display = f"{decoded_value:.6g}"
                            else:
                                value_display = str(decoded_value)
                            
                            self.current_value_var.set(value_display)
                            
                            # Show both raw and decoded in log
                            raw_display = raw_data.hex().upper()
                            self._log_message(f"📥 READ OK: {decoded_value} (0x{raw_display}) ({response_time:.3f}s)")
                        except Exception as e:
                            raw_display = raw_data.hex().upper()
                            self._log_message(f"📥 READ OK: 0x{raw_display} (decode error: {e}) ({response_time:.3f}s)")
                    else:
                        raw_display = raw_data.hex().upper()
                        self._log_message(f"📥 READ OK: 0x{raw_display} ({response_time:.3f}s)")
                else:
                    self._log_message(f"📥 READ RESPONSE: Segmented transfer not supported ({response_time:.3f}s)")
            else:
                self._log_message(f"📥 READ RESPONSE: Unexpected format ({response_time:.3f}s)")
        
        self._log_message(f"    RX: 0x{rx_id:03X} ← {bytes(data).hex().upper()}")
    
    def _handle_pdo_loading_response(self, data):
        """Handle SDO responses during PDO loading operations"""
        cmd = data[0]
        
        # Check for successful read response
        if (cmd & 0xE0) == 0x40:  # Upload initiate response
            if cmd & 0x02:  # Expedited transfer
                size_indicated = cmd & 0x01
                if size_indicated:
                    data_size = 4 - ((cmd >> 2) & 0x03)
                else:
                    data_size = 4
                
                # Extract index and sub-index from response
                index = struct.unpack('<H', bytes(data[1:3]))[0]
                sub_index = data[3]
                
                # Extract value data
                raw_data = bytes(data[4:4+data_size])
                
                # Convert raw data to integer value
                if data_size == 1:
                    value = struct.unpack('<B', raw_data)[0]
                elif data_size == 2:
                    value = struct.unpack('<H', raw_data)[0]
                elif data_size == 4:
                    value = struct.unpack('<L', raw_data)[0]
                else:
                    # Fallback - convert as little endian integer
                    value = int.from_bytes(raw_data, byteorder='little')
                
                # Continue PDO loading sequence based on type
                if self.loading_pdo['type'] == 'TPDO':
                    self._continue_tpdo_loading(index, sub_index, value)
                elif self.loading_pdo['type'] == 'RPDO':
                    self._continue_rpdo_loading(index, sub_index, value)
                
            else:
                self._log_message(f"📥 PDO LOADING: Segmented transfer not supported")
                self._finish_pdo_loading()
        else:
            self._log_message(f"📥 PDO LOADING: Unexpected response format")
            self._finish_pdo_loading()
    
    def _check_sdo_timeouts(self):
        """Check for and handle SDO timeouts"""
        current_time = time.time()
        timed_out_requests = []
        
        for rx_id, request in self.pending_requests.items():
            if current_time - request.timestamp > self.sdo_timeout_seconds:
                timed_out_requests.append((rx_id, request))
        
        # Handle timed out requests
        for rx_id, request in timed_out_requests:
            self.pending_requests.pop(rx_id, None)
            operation = "WRITE" if request.is_write else "READ"
            self._log_message(f"⏱️ TIMEOUT: {operation} Node {request.node_id} 0x{request.index:04X}:{request.sub_index:02X} (>{self.sdo_timeout_seconds:.1f}s)")
        
        # Schedule next timeout check if we still have pending requests
        if self.pending_requests:
            self.timeout_timer = self.app.root.after(100, self._check_sdo_timeouts)  # Check every 100ms
        else:
            self.timeout_timer = None

    def _on_timeout_changed(self, *args):
        """Handle timeout setting changes"""
        try:
            self.sdo_timeout_seconds = float(self.timeout_var.get())
            if self.sdo_timeout_seconds < 0.1:
                self.sdo_timeout_seconds = 0.1
            elif self.sdo_timeout_seconds > 10.0:
                self.sdo_timeout_seconds = 10.0
        except ValueError:
            self.sdo_timeout_seconds = 1.0  # Default fallback

    def _send_nmt_command(self):
        """Send NMT (Network Management) command"""
        try:
            # Get selected NMT command and target node
            selected_command = self.nmt_state_combo.get()
            target_node_str = self.nmt_node_var.get().strip()
            
            if not target_node_str:
                self._log_message("❌ ERROR: Target node ID required")
                return
            
            try:
                target_node = int(target_node_str)
                if target_node < 1 or target_node > 127:
                    self._log_message("❌ ERROR: Target node ID must be between 1 and 127")
                    return
            except ValueError:
                self._log_message("❌ ERROR: Invalid target node ID")
                return
            
            # Map NMT commands to CANopen command codes
            nmt_commands = {
                "Start Remote Node": 0x01,
                "Stop Remote Node": 0x02,
                "Enter Pre-operational": 0x80,
                "Reset Node": 0x81,
                "Reset Communication": 0x82
            }
            
            if selected_command not in nmt_commands:
                self._log_message(f"❌ ERROR: Unknown NMT command: {selected_command}")
                return
            
            command_code = nmt_commands[selected_command]
            
            # Check CAN connection
            if not self.app.running or not self.app.bus:
                self._log_message("❌ ERROR: CAN not connected")
                return
            
            # Create NMT message: ID 0x000, data = [command_code, target_node]
            nmt_data = [command_code, target_node]
            
            try:
                import can
                msg = can.Message(arbitration_id=0x000, data=nmt_data, is_extended_id=False)
                self.app.bus.send(msg)
                
                # Log the sent command
                self._log_message(f"📤 NMT: {selected_command} → Node {target_node}")
                self._log_message(f"    TX: 0x000 → {bytes(nmt_data).hex().upper()}")
                
            except Exception as e:
                self._log_message(f"❌ ERROR: Failed to send NMT command: {e}")
                
        except Exception as e:
            self._log_message(f"❌ ERROR: NMT command failed: {e}")

    def cleanup(self):
        """Cleanup when tab is destroyed"""
        # Cancel timeout timer
        if self.timeout_timer:
            self.app.root.after_cancel(self.timeout_timer)
            self.timeout_timer = None
        # Clear any pending requests
        self.pending_requests.clear()