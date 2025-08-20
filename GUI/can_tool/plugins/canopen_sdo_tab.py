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


class EDSParser:
    """Parser for EDS (Electronic Data Sheet) files"""
    
    def __init__(self, eds_file_path: str):
        self.eds_file_path = eds_file_path
        self.object_dictionary: Dict[Tuple[int, int], ObjectDictionaryEntry] = {}
        self.device_info: Dict[str, Any] = {}
        self.file_info: Dict[str, Any] = {}
        self.vendor_name = "Unknown"
        self.product_name = "Unknown"
        self._parse_eds_file()
    
    def _parse_eds_file(self):
        """Parse the EDS file and build object dictionary"""
        try:
            config = configparser.ConfigParser()
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
                    else:
                        # Main index entry like "1018"
                        index = int(section_name, 16)
                        sub_index = 0
                    
                    # Parse the object entry
                    entry = self._parse_object_entry(config[section_name], index, sub_index)
                    if entry:
                        self.object_dictionary[(index, sub_index)] = entry
                        
                except ValueError:
                    # Not a hex number, skip
                    continue
                    
        except Exception as e:
            print(f"Error parsing EDS file {eds_file_path}: {e}")
    
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
        """Create the CANopen SDO interface"""
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
        
        # Device info
        device_text = f"{self.eds_parser.vendor_name} - {self.eds_parser.product_name}"
        ttk.Label(node_frame, text=device_text, font=("Arial", 9, "italic")).pack(side=tk.LEFT)
        
        # Object selection frame
        obj_frame = ttk.LabelFrame(ops_frame, text="Selected Object")
        obj_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Index and sub-index
        index_frame = ttk.Frame(obj_frame)
        index_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(index_frame, text="Index:").pack(side=tk.LEFT)
        self.index_var = tk.StringVar()
        self.index_entry = ttk.Entry(index_frame, textvariable=self.index_var, width=8)
        self.index_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(index_frame, text="Sub:").pack(side=tk.LEFT)
        self.sub_index_var = tk.StringVar()
        self.sub_index_entry = ttk.Entry(index_frame, textvariable=self.sub_index_var, width=4)
        self.sub_index_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        # Object info
        info_frame = ttk.Frame(obj_frame)
        info_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(info_frame, text="Name:").pack(side=tk.LEFT)
        self.obj_name_var = tk.StringVar()
        ttk.Label(info_frame, textvariable=self.obj_name_var, font=("Arial", 9, "bold")).pack(side=tk.LEFT, padx=(5, 10))
        
        type_frame = ttk.Frame(obj_frame)
        type_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(type_frame, text="Type:").pack(side=tk.LEFT)
        self.obj_type_var = tk.StringVar()
        ttk.Label(type_frame, textvariable=self.obj_type_var).pack(side=tk.LEFT, padx=(5, 10))
        
        ttk.Label(type_frame, text="Access:").pack(side=tk.LEFT)
        self.obj_access_var = tk.StringVar()
        ttk.Label(type_frame, textvariable=self.obj_access_var).pack(side=tk.LEFT, padx=(5, 10))
        
        # Value operations frame
        value_frame = ttk.LabelFrame(ops_frame, text="Value Operations")
        value_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Read operations
        read_frame = ttk.Frame(value_frame)
        read_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Button(read_frame, text="Read Value", command=self._read_object).pack(side=tk.LEFT)
        ttk.Label(read_frame, text="Current:").pack(side=tk.LEFT, padx=(10, 5))
        self.current_value_var = tk.StringVar()
        ttk.Label(read_frame, textvariable=self.current_value_var, 
                 font=("Courier", 9), background="white", relief="sunken").pack(side=tk.LEFT, padx=(0, 5))
        
        # Write operations
        write_frame = ttk.Frame(value_frame)
        write_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(write_frame, text="New Value:").pack(side=tk.LEFT)
        self.write_value_var = tk.StringVar(value="0x")
        self.write_entry = ttk.Entry(write_frame, textvariable=self.write_value_var, width=15)
        self.write_entry.pack(side=tk.LEFT, padx=(5, 10))
        
        # Bind events to handle hex input formatting
        self.write_entry.bind('<KeyPress>', self._on_value_key_press)
        self.write_entry.bind('<FocusIn>', self._on_value_focus_in)
        self.write_value_var.trace('w', self._update_can_preview)  # Live update on value change
        
        ttk.Button(write_frame, text="Write Value", command=self._write_object).pack(side=tk.LEFT)
        
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
        
        # Get all objects sorted by index
        all_objects = self.eds_parser.get_all_objects()
        
        # Apply filter if provided
        if filter_text:
            filter_text = filter_text.lower()
            filtered_objects = []
            for obj in all_objects:
                if (filter_text in obj.name.lower() or 
                    filter_text in f"{obj.index:04x}" or
                    filter_text in f"{obj.index:04x}:{obj.sub_index:02x}"):
                    filtered_objects.append(obj)
            all_objects = filtered_objects
        
        # Group by main index
        current_main_index = None
        main_item = None
        
        for obj in all_objects:
            if obj.index != current_main_index:
                # Create new main index item
                current_main_index = obj.index
                main_text = f"0x{obj.index:04X}"
                if obj.sub_index == 0:
                    main_text += f" - {obj.name}"
                
                data_type_name = DataTypeConverter.get_data_type_name(obj.data_type)
                
                main_item = self.object_tree.insert('', 'end', text=main_text,
                                                  values=(data_type_name, obj.access_type),
                                                  tags=(f"{obj.index:04X}:{obj.sub_index:02X}",))
            
            # Add sub-index if not 0
            if obj.sub_index != 0 and main_item:
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
        
        # Check if readable
        if 'r' not in self.selected_object.access_type:
            messagebox.showwarning("Read Error", "Selected object is write-only.")
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
        
        # Check if writable
        if 'w' not in self.selected_object.access_type:
            messagebox.showwarning("Write Error", "Selected object is read-only.")
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
        
        # Check if this is an SDO response we're waiting for
        if rx_id not in self.pending_requests:
            return
        
        if len(data) < 4:
            return
        
        request = self.pending_requests.pop(rx_id)
        response_time = time.time() - request.timestamp
        
        cmd = data[0]
        
        # Check for abort
        if cmd == 0x80:
            if len(data) >= 8:
                abort_code = struct.unpack('<L', bytes(data[4:8]))[0]
                # Try to get a meaningful error name
                error_name = "UNKNOWN_ERROR"
                for abort in SDOAbortCode:
                    if abort.value == abort_code:
                        error_name = abort.name.replace('_', ' ')
                        break
                
                self._log_message(f"📥 ABORT: 0x{abort_code:08X} - {error_name} ({response_time:.3f}s)")
            else:
                self._log_message(f"📥 ABORT: Invalid abort message ({response_time:.3f}s)")
            
            self._log_message(f"    RX: 0x{rx_id:03X} ← {bytes(data).hex().upper()}")
            return
        
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
    
    def cleanup(self):
        """Cleanup when tab is destroyed"""
        # Clear any pending requests
        self.pending_requests.clear()