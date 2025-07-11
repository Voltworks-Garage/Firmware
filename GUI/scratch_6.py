import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import can
import threading
import time
import os
try:
    from dataclasses import dataclass
except ImportError:
    # Fallback for Python < 3.7
    def dataclass(cls):
        return cls
from typing import Dict, Optional

@dataclass
class CANMessage:
    """Data class representing a single CAN message and its state"""
    msg_id: int
    name: str
    dlc: int
    data: bytes
    count: int
    last_time: float
    decoded_signals: Optional[Dict[str, str]] = None
    is_expanded: bool = False
    tree_item_id: Optional[str] = None
    signal_item_ids: Optional[Dict[str, str]] = None
    # For multiplexed messages - accumulate all received signals
    accumulated_mux_signals: Optional[Dict[str, str]] = None
    last_mux_value: Optional[int] = None
    
    def __post_init__(self):
        if self.signal_item_ids is None:
            self.signal_item_ids = {}
        if self.accumulated_mux_signals is None:
            self.accumulated_mux_signals = {}

class CANMessageManager:
    """Manages CAN message storage, decoding, and expansion state"""
    
    def __init__(self, dbf_parser: 'BusmasterDBFParser'):
        self.dbf_parser = dbf_parser
        self.messages: Dict[int, CANMessage] = {}
    
    def update_message(self, msg_id: int, dlc: int, data: bytes) -> CANMessage:
        """Update or create a CAN message"""
        now = time.time()
        
        # Decode the message
        decoded = self.dbf_parser.decode_message(msg_id, data)
        msg_name = decoded['name'] if decoded else "Unknown"
        decoded_signals = decoded['signals'] if decoded else None
        is_multiplexed = decoded.get('is_multiplexed', False) if decoded else False
        multiplex_value = decoded.get('multiplex_value') if decoded else None
        
        if msg_id in self.messages:
            # Update existing message
            msg = self.messages[msg_id]
            
            # Calculate cycle time from actual message intervals
            if hasattr(msg, '_prev_msg_time') and msg._prev_msg_time is not None:
                cycle_ms = (now - msg._prev_msg_time) * 1000
                msg.cycle_time_str = f"{cycle_ms:.1f} ms"
            else:
                msg.cycle_time_str = "-"
            
            msg._prev_msg_time = now
            msg.dlc = dlc
            msg.data = data
            msg.count += 1
            msg.last_time = now
            msg.decoded_signals = decoded_signals
            msg.last_mux_value = multiplex_value
            
            # For multiplexed messages, accumulate all received signals
            if is_multiplexed and decoded_signals:
                self._accumulate_mux_signals(msg, decoded_signals, multiplex_value)
                
        else:
            # Create new message
            msg = CANMessage(
                msg_id=msg_id,
                name=msg_name,
                dlc=dlc,
                data=data,
                count=1,
                last_time=now,
                decoded_signals=decoded_signals
            )
            msg.cycle_time_str = "-"
            msg._prev_msg_time = now
            msg.last_mux_value = multiplex_value
            self.messages[msg_id] = msg
            
            # For multiplexed messages, initialize accumulation
            if is_multiplexed and decoded_signals:
                self._accumulate_mux_signals(msg, decoded_signals, multiplex_value)
        
        return msg
    
    def _accumulate_mux_signals(self, msg: CANMessage, decoded_signals: Dict[str, str], multiplex_value: Optional[int]):
        """Accumulate signals from multiplexed messages for complete view"""
        if not decoded_signals:
            return
            
        # Update accumulated signals with new values
        for signal_name, signal_value in decoded_signals.items():
            # Skip the multiplex signal itself (it's just "Mode X")
            if 'MultiPlex' in signal_name:
                continue
                
            # Store the signal with current timestamp for freshness tracking
            msg.accumulated_mux_signals[signal_name] = {
                'value': signal_value,
                'timestamp': time.time(),
                'mux_value': multiplex_value
            }
    
    def get_display_signals(self, msg: CANMessage) -> Dict[str, str]:
        """Get signals to display - for multiplexed messages, show accumulated signals"""
        if not msg.decoded_signals:
            return {}
            
        # Check if this is a multiplexed message with accumulated signals
        if msg.accumulated_mux_signals:
            current_time = time.time()
            display_signals = {}
            
            # Add multiplex mode indicator
            if msg.last_mux_value is not None:
                display_signals['MultiPlex'] = f"Mode {msg.last_mux_value}"
            
            # Show accumulated signals (mark stale ones) in sorted order
            sorted_signals = self._sort_mux_signals(msg.accumulated_mux_signals)
            
            for signal_name, signal_info in sorted_signals.items():
                age = current_time - signal_info['timestamp']
                value = signal_info['value']
                
                # Mark signals older than 5 seconds as stale
                if age > 5.0:
                    value += " (stale)"
                
                display_signals[signal_name] = value
            
            return display_signals
        else:
            # Non-multiplexed message - return current signals
            return msg.decoded_signals
    
    def _sort_mux_signals(self, accumulated_signals: Dict[str, Dict]) -> Dict[str, Dict]:
        """Sort multiplexed signals for better organization (Cell_01, Cell_02, etc.)"""
        def signal_sort_key(item):
            signal_name = item[0]
            # Extract number for sorting (Cell_01_voltage -> 1, Temp_05 -> 5)
            try:
                if 'Cell_' in signal_name:
                    return (0, int(signal_name.split('_')[1]))  # Cells first
                elif 'Temp_' in signal_name:
                    return (1, int(signal_name.split('_')[1]))  # Temps second
                else:
                    return (2, signal_name)  # Other signals last
            except (ValueError, IndexError):
                return (3, signal_name)  # Fallback for unparseable names
        
        sorted_items = sorted(accumulated_signals.items(), key=signal_sort_key)
        return dict(sorted_items)
    
    def toggle_expansion(self, msg_id: int) -> bool:
        """Toggle expansion state of a message. Returns new expansion state."""
        if msg_id not in self.messages:
            return False
        
        msg = self.messages[msg_id]
        if not msg.decoded_signals:
            return False
        
        msg.is_expanded = not msg.is_expanded
        
        # Keep signal_item_ids intact so we can reuse children
        
        return msg.is_expanded
    
    def get_message(self, msg_id: int) -> Optional[CANMessage]:
        """Get a message by ID"""
        return self.messages.get(msg_id)
    
    def clear_all(self):
        """Clear all messages"""
        self.messages.clear()

class CANTableView:
    """Handles the tree view UI logic for CAN messages"""
    
    def __init__(self, parent_widget, message_manager: CANMessageManager):
        self.message_manager = message_manager
        
        # Create the tree view
        self.tree = ttk.Treeview(parent_widget, 
                                columns=("ID", "Name", "DLC", "Data", "Count", "Cycle"), 
                                show="tree headings")
        
        # Configure columns
        self.tree.heading("#0", text="", anchor="w")
        self.tree.column("#0", width=20, minwidth=20, stretch=False)
        
        for col, w in [("ID", 80), ("Name", 120), ("DLC", 50), ("Data", 200), ("Count", 60), ("Cycle", 80)]:
            self.tree.heading(col, text=col)
            self.tree.column(col, width=w)
        
        # Bind events (only single-click on tree column)
        self.tree.bind("<Button-1>", self._on_single_click)
    
    def pack(self, **kwargs):
        """Pack the tree view"""
        self.tree.pack(**kwargs)
    
    def update_message_display(self, msg: CANMessage):
        """Update the display for a single message"""
        # Format the data
        msg_hex_id = f"{msg.msg_id:X}"
        data_str = " ".join(f"{b:02X}" for b in msg.data)
        
        # Get cycle time from message (calculated in real-time)
        cycle_str = getattr(msg, 'cycle_time_str', "-")
        
        if msg.tree_item_id is None:
            # Create new tree item
            msg.tree_item_id = self.tree.insert("", tk.END, 
                                               values=(msg_hex_id, msg.name, msg.dlc, data_str, msg.count, cycle_str),
                                               open=msg.is_expanded)
            msg.dummy_item_id = self.tree.insert(msg.tree_item_id, tk.END, text="", values=("", "  Dummy", "", "", "", ""))
        else:
            # Update existing tree item
            self.tree.item(msg.tree_item_id,
                          values=(msg_hex_id, msg.name, msg.dlc, data_str, msg.count, cycle_str),
                          open=msg.is_expanded)
        
        # Handle signal children (only update values if expanded)
        # Use display signals which handles multiplexed signal accumulation
        display_signals = self.message_manager.get_display_signals(msg)
        if msg.is_expanded and display_signals:
            self._update_signal_children(msg, display_signals)
        else:
            pass
    
    def _ensure_signal_children(self, msg: CANMessage, display_signals: Dict[str, str] = None):
        """Ensure signal children exist for this message (create only if needed)"""
        if display_signals is None:
            display_signals = self.message_manager.get_display_signals(msg)
            
        if not display_signals:
            return
            
        for signal_name, signal_value in display_signals.items():
            if signal_name not in msg.signal_item_ids:
                # Create new signal child only if it doesn't exist
                signal_item = self.tree.insert(msg.tree_item_id, tk.END, text="",
                                             values=("", f"  {signal_name}", "", signal_value, "", ""))
                msg.signal_item_ids[signal_name] = signal_item
            else:
                # Update existing signal child value
                self.tree.item(msg.signal_item_ids[signal_name],
                             values=("", f"  {signal_name}", "", signal_value, "", ""))
    
    def _update_signal_children(self, msg: CANMessage, display_signals: Dict[str, str]):
        """Update signal children values (only if they exist and message is expanded)"""
        if not msg.is_expanded or not display_signals:
            return

        if msg.dummy_item_id is not None:
            # Remove dummy item if it exists (used to ensure children are created)
            self.tree.delete(msg.dummy_item_id)
            msg.dummy_item_id = None

        # First, ensure all signals have tree items
        self._ensure_signal_children(msg, display_signals)

        # Then update all signal values
        for signal_name, signal_value in display_signals.items():
            if signal_name in msg.signal_item_ids:
                # Update existing signal child value
                try:
                    self.tree.item(msg.signal_item_ids[signal_name],
                                 values=("", f"  {signal_name}", "", signal_value, "", ""))
                except tk.TclError:
                    # Signal item was deleted, remove from tracking and recreate
                    print(f"  ERROR: Signal item {signal_name} was deleted, recreating")
                    del msg.signal_item_ids[signal_name]
                    signal_item = self.tree.insert(msg.tree_item_id, tk.END, text="",
                                                 values=("", f"  {signal_name}", "", signal_value, "", ""))
                    msg.signal_item_ids[signal_name] = signal_item
    
    def _clear_signal_children(self, msg: CANMessage):
        """Remove all signal children (used only when clearing entire table)"""
        for signal_item_id in msg.signal_item_ids.values():
            self.tree.delete(signal_item_id)
        msg.signal_item_ids.clear()
    
    def _on_double_click(self, event):
        """Handle double-click events"""
        item_id = self.tree.identify_row(event.y)
        if item_id:
            self._toggle_message_expansion(item_id)
    
    def _on_single_click(self, event):
        """Handle single-click events on tree column"""
        region = self.tree.identify("region", event.x, event.y)
        if region == "tree":
            item_id = self.tree.identify_row(event.y)
            if item_id:
                self._toggle_message_expansion(item_id)
    
    def _toggle_message_expansion(self, tree_item_id: str):
        """Toggle expansion for a message based on tree item ID"""
        # Find the message with this tree item ID
        for msg_id, msg in self.message_manager.messages.items():
            if msg.tree_item_id == tree_item_id:
                is_expanded = self.message_manager.toggle_expansion(msg_id)
                if is_expanded:
                    # Ensure children exist, then open
                    display_signals = self.message_manager.get_display_signals(msg)
                    self._ensure_signal_children(msg, display_signals)
                    print("DEBUG: Expanded message", msg_id)
                else:
                    # Just close the tree item, don't delete children
                    print("DEBUG: Collapsed message", msg_id)
                break
    
    def clear_all(self):
        """Clear all items from the tree"""
        self.tree.delete(*self.tree.get_children())

class BusmasterDBFParser:
    def __init__(self, dbf_path):
        self.messages = {}
        self.parse_dbf(dbf_path)
    
    def parse_dbf(self, dbf_path):
        if not os.path.exists(dbf_path):
            print(f"ERROR: DBF file not found: {dbf_path}")
            return
        
        with open(dbf_path, 'r') as f:
            lines = f.readlines()
        
        current_msg = None
        for line in lines:
            line = line.strip()
            if line.startswith('[START_MSG]'):
                parts = line[11:].split(',')
                if len(parts) >= 3:
                    name = parts[0]
                    try:
                        msg_id = int(parts[1])
                        dlc = int(parts[2])
                        current_msg = {
                            'name': name,
                            'id': msg_id,
                            'dlc': dlc,
                            'signals': [],
                            'multiplex_signal': None,
                            'is_multiplexed': False
                        }
                        self.messages[msg_id] = current_msg
                    except ValueError:
                        pass
            elif line.startswith('[START_SIGNALS]') and current_msg:
                parts = line[15:].split(',')
                if len(parts) >= 10:
                    signal = {
                        'name': parts[0].strip(),
                        'length': int(parts[1]),
                        'byte_pos': int(parts[2]),
                        'bit_pos': float(parts[3]),
                        'type': parts[4],
                        'max_val': int(parts[5]),
                        'min_val': int(parts[6]),
                        'default': int(parts[7]),
                        'offset': float(parts[8]),
                        'factor': float(parts[9]),
                        'unit': parts[10] if len(parts) > 10 else '',
                        'is_multiplexor': False,
                        'multiplex_value': None
                    }
                    
                    # Check for multiplex notation in the DBF (M0, M1, etc. or just 'm' for multiplexor)
                    multiplex_notation = parts[11] if len(parts) > 11 else ''
                    
                    if multiplex_notation.lower() == 'm':
                        # This is the multiplexor signal itself
                        signal['is_multiplexor'] = True
                        current_msg['multiplex_signal'] = signal['name']
                        current_msg['is_multiplexed'] = True
                    elif multiplex_notation.startswith('M') and len(multiplex_notation) > 1:
                        # This is a multiplexed signal (M0, M1, M2, etc.)
                        try:
                            mux_value = int(multiplex_notation[1:])  # Extract number after 'M'
                            signal['multiplex_value'] = mux_value
                            current_msg['is_multiplexed'] = True
                        except ValueError:
                            pass
                    
                    # Also detect multiplexor signal by name (fallback)
                    if signal['name'].lower() in ['multiplex', 'mux', 'multiplexor']:
                        signal['is_multiplexor'] = True
                        current_msg['multiplex_signal'] = signal['name']
                        current_msg['is_multiplexed'] = True
                    
                    current_msg['signals'].append(signal)
            elif line.startswith('[END_MSG]'):
                current_msg = None
    
    def extract_signal_value(self, signal, data):
        if len(data) < signal['byte_pos']:
            return 0
        
        byte_idx = signal['byte_pos'] - 1
        bit_start = int(signal['bit_pos'])
        bit_length = signal['length']
        
        value = 0
        bits_extracted = 0
        
        while bits_extracted < bit_length and byte_idx < len(data):
            byte_val = data[byte_idx]
            bits_in_byte = min(8 - bit_start, bit_length - bits_extracted)
            mask = (1 << bits_in_byte) - 1
            extracted_bits = (byte_val >> bit_start) & mask
            value |= extracted_bits << bits_extracted
            
            bits_extracted += bits_in_byte
            byte_idx += 1
            bit_start = 0
        
        if signal['type'] == 'B':
            return bool(value)
        
        scaled_value = value * signal['factor'] + signal['offset']
        return scaled_value
    
    def decode_message(self, msg_id, data):
        if msg_id not in self.messages:
            return None
        
        msg_def = self.messages[msg_id]
        decoded = {
            'name': msg_def['name'],
            'signals': {},
            'is_multiplexed': msg_def['is_multiplexed'],
            'multiplex_value': None
        }
        
        # First pass: extract multiplexor value if message is multiplexed
        multiplex_value = None
        if msg_def['is_multiplexed']:
            for signal in msg_def['signals']:
                if signal['is_multiplexor']:
                    try:
                        multiplex_value = int(self.extract_signal_value(signal, data))
                        decoded['multiplex_value'] = multiplex_value
                        decoded['signals'][signal['name']] = f"Mode {multiplex_value}"
                    except Exception:
                        decoded['signals'][signal['name']] = 'Error'
                    break
        
        # Second pass: decode signals that match the current multiplex value
        for signal in msg_def['signals']:
            if signal['is_multiplexor']:
                continue  # Already handled above
            
            # For multiplexed messages, only decode signals that match current mux value
            if msg_def['is_multiplexed'] and multiplex_value is not None:
                # Skip signals that don't match current mux value
                if signal.get('multiplex_value') is not None and signal['multiplex_value'] != multiplex_value:
                    continue
                # Skip signals that have no mux value (they shouldn't exist in pure mux messages)
                if signal.get('multiplex_value') is None:
                    continue
                
            try:
                value = self.extract_signal_value(signal, data)
                
                # For multiplexed messages, create descriptive signal names
                signal_name = signal['name']
                if msg_def['is_multiplexed'] and multiplex_value is not None:
                    signal_name = self._generate_mux_signal_name(signal['name'], multiplex_value)
                
                # Format the value
                formatted_value = self._format_signal_value(signal, value)
                decoded['signals'][signal_name] = formatted_value
                
            except Exception:
                decoded['signals'][signal.get('name', 'unknown')] = 'Error'
        
        return decoded
    
    def _generate_mux_signal_name(self, signal_name, multiplex_value):
        """Generate proper signal names for multiplexed signals"""
        # Handle cell voltages - signal name already has correct number (1-24)
        if 'cell' in signal_name and 'voltage' in signal_name:
            try:
                cell_num = int(signal_name.split('_')[1])
                return f"Cell_{cell_num:02d}_voltage"
            except (ValueError, IndexError):
                return f"M{multiplex_value}_{signal_name}"
        
        # Handle temperatures - signal name already has correct number (1-24)
        elif 'temp' in signal_name:
            try:
                temp_num = int(signal_name.split('_')[1])
                return f"Temp_{temp_num:02d}"
            except (ValueError, IndexError):
                return f"M{multiplex_value}_{signal_name}"
        
        # For other multiplexed signals, use standard prefix
        else:
            return f"M{multiplex_value}_{signal_name}"
    
    def _format_signal_value(self, signal, value):
        """Format signal value with appropriate precision and units"""
        if signal['type'] == 'B':
            return 'True' if value else 'False'
        else:
            unit_str = f" {signal['unit']}" if signal['unit'] else ''
            if signal['factor'] == 1.0 and signal['offset'] == 0.0:
                return f"{int(value)}{unit_str}"
            else:
                # Use higher precision for voltage/current measurements
                precision = 3 if 'voltage' in signal['name'].lower() or 'current' in signal['name'].lower() else 2
                return f"{value:.{precision}f}{unit_str}"

class CANApp:
    def __init__(self, root):
        self.root = root
        self.root.title("PCAN Tool with CAN Decoder")
        self.bus = None
        self.running = False
        self.tx_messages = {}
        self.console_rx_enabled = tk.BooleanVar(value=False)
        self.show_decoded = tk.BooleanVar(value=True)
        self.available_channels = []
        
        # Initialize components
        dbf_path = r"C:\REPOS\Voltworks_Garage\Firmware\CAN\emoto.dbf"
        self.dbf_parser = BusmasterDBFParser(dbf_path)
        self.message_manager = CANMessageManager(self.dbf_parser)

        # GUI refresh throttling (10Hz = 100ms)
        self.gui_refresh_rate_ms = 100
        self.pending_gui_updates = set()  # Track which messages need GUI updates
        self.gui_update_timer = None
        
        self.create_widgets()

    def create_widgets(self):
        control_frame = ttk.Frame(self.root)
        control_frame.pack(fill=tk.X, padx=10, pady=5)

        ttk.Button(control_frame, text="Scan Devices", command=self.scan_devices).pack(side=tk.LEFT, padx=5)

        self.device_var = tk.StringVar()
        self.device_combo = ttk.Combobox(control_frame, textvariable=self.device_var, width=20, state="readonly")
        self.device_combo.pack(side=tk.LEFT, padx=5)

        self.baud_var = tk.StringVar(value="500000")
        ttk.Label(control_frame, text="Baudrate:").pack(side=tk.LEFT, padx=5)
        self.baud_combo = ttk.Combobox(control_frame, textvariable=self.baud_var, values=["125000", "250000", "500000", "1000000"], width=10, state="readonly")
        self.baud_combo.pack(side=tk.LEFT, padx=5)

        ttk.Button(control_frame, text="Connect", command=self.connect).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Disconnect", command=self.disconnect).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Clear Console", command=lambda: self.console.delete("1.0", tk.END)).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Clear RX Table", command=self.clear_rx_table).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(control_frame, text="Log RX to Console", variable=self.console_rx_enabled).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(control_frame, text="Show Decoded", variable=self.show_decoded, command=self.toggle_decoded_view).pack(side=tk.LEFT, padx=5)

        # Main horizontal paned window (left panel + console)
        main_paned = ttk.PanedWindow(self.root, orient=tk.HORIZONTAL)
        main_paned.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)

        # Left panel - vertical paned window for RX and TX
        left_paned = ttk.PanedWindow(main_paned, orient=tk.VERTICAL)
        main_paned.add(left_paned, weight=2)  # Takes 2/3 of horizontal space

        # RX Messages frame (top of left panel)
        rx_frame = ttk.LabelFrame(left_paned, text="Live RX Messages")
        left_paned.add(rx_frame, weight=2)  # Takes 2/3 of vertical space
        
        # Create the table view component
        self.table_view = CANTableView(rx_frame, self.message_manager)
        self.table_view.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # TX Messages frame (bottom of left panel)
        self.tx_main_frame = ttk.LabelFrame(left_paned, text="TX Message Scheduler")
        left_paned.add(self.tx_main_frame, weight=1)  # Takes 1/3 of vertical space
        
        self.create_tx_section()

        # Console frame (right side, full height)
        console_frame = ttk.LabelFrame(main_paned, text="Console Log")
        main_paned.add(console_frame, weight=1)  # Takes 1/3 of horizontal space
        self.console = scrolledtext.ScrolledText(console_frame, wrap=tk.WORD)
        self.console.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

    def scan_devices(self):
        # Disable scan button and show progress
        scan_btn = None
        for widget in self.root.winfo_children():
            if isinstance(widget, ttk.Frame):
                for child in widget.winfo_children():
                    if isinstance(child, ttk.Button) and 'scan' in child.cget('text').lower():
                        scan_btn = child
                        break
        
        if scan_btn:
            scan_btn.config(text="Scanning...", state="disabled")
        
        self.log("🔍 Scanning for PCAN devices...")
        
        # Run scan in background thread to avoid blocking GUI
        def scan_thread():
            try:
                configs = can.detect_available_configs()
                channels = [cfg['channel'] for cfg in configs if cfg.get('interface') == 'pcan']
                
                # Update GUI from main thread
                self.root.after(0, self._scan_complete, channels, scan_btn)
            except Exception as e:
                self.root.after(0, self._scan_error, str(e), scan_btn)
        
        threading.Thread(target=scan_thread, daemon=True).start()
    
    def _scan_complete(self, channels, scan_btn):
        """Called when scan completes successfully"""
        self.available_channels = channels
        self.device_combo['values'] = self.available_channels
        
        if self.available_channels:
            self.device_combo.current(0)
            self.log(f"✅ Found {len(channels)} PCAN device(s): {', '.join(channels)}")
        else:
            self.log("⚠️  No PCAN USB devices found.")
        
        if scan_btn:
            scan_btn.config(text="Scan Devices", state="normal")
    
    def _scan_error(self, error_msg, scan_btn):
        """Called when scan encounters an error"""
        self.log(f"❌ Error scanning devices: {error_msg}")
        if scan_btn:
            scan_btn.config(text="Scan Devices", state="normal")

    def create_tx_section(self):
        # Use the pre-created TX frame from the layout
        tx_frame = self.tx_main_frame

        # Input row
        input_frame = ttk.Frame(tx_frame)
        input_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(input_frame, text="ID (hex):").grid(row=0, column=0, padx=5, pady=2)
        self.tx_id_var = tk.StringVar()
        ttk.Entry(input_frame, textvariable=self.tx_id_var, width=10).grid(row=0, column=1, padx=5, pady=2)

        ttk.Label(input_frame, text="Data (hex bytes):").grid(row=0, column=2, padx=5, pady=2)
        self.tx_data_var = tk.StringVar()
        ttk.Entry(input_frame, textvariable=self.tx_data_var, width=40).grid(row=0, column=3, padx=5, pady=2)

        ttk.Label(input_frame, text="Cycle (ms):").grid(row=0, column=4, padx=5, pady=2)
        self.tx_cycle_var = tk.StringVar()
        ttk.Entry(input_frame, textvariable=self.tx_cycle_var, width=6).grid(row=0, column=5, padx=5, pady=2)

        ttk.Button(input_frame, text="Add TX", command=self.add_tx_row).grid(row=0, column=6, padx=5, pady=2)
        ttk.Button(input_frame, text="Add Message", command=self.add_dbf_message).grid(row=0, column=7, padx=5, pady=2)

        # Header row with consistent column configuration
        header_frame = ttk.Frame(tx_frame)
        header_frame.pack(fill=tk.X, padx=(5, 25), pady=(0, 5))  # Extra right padding for scrollbar
        
        # Configure columns for consistent alignment
        header_frame.grid_columnconfigure(0, weight=0, minsize=75)   # ID column
        header_frame.grid_columnconfigure(1, weight=1, minsize=280)  # Data column (expandable)
        header_frame.grid_columnconfigure(2, weight=0, minsize=65)   # Cycle column
        header_frame.grid_columnconfigure(3, weight=0, minsize=75)   # Status column
        header_frame.grid_columnconfigure(4, weight=0, minsize=135)  # Actions column
        
        ttk.Label(header_frame, text="ID", anchor="center", relief="solid", borderwidth=1, width=10).grid(row=0, column=0, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Data", anchor="center", relief="solid", borderwidth=1, width=35).grid(row=0, column=1, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Cycle", anchor="center", relief="solid", borderwidth=1, width=8).grid(row=0, column=2, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Status", anchor="center", relief="solid", borderwidth=1, width=10).grid(row=0, column=3, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Actions", anchor="center", relief="solid", borderwidth=1, width=21).grid(row=0, column=4, sticky="ew", padx=1, ipady=2)

        # Scrollable frame for TX messages
        self.tx_canvas = tk.Canvas(tx_frame)
        self.tx_scrollbar = ttk.Scrollbar(tx_frame, orient="vertical", command=self.tx_canvas.yview)
        self.tx_scroll_frame = ttk.Frame(self.tx_canvas)
        
        def configure_scroll_frame(event):
            # Update scroll region
            self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))
        
        def configure_canvas(event):
            # Force scroll frame to match canvas width for proper column alignment
            canvas_width = self.tx_canvas.winfo_width()
            if canvas_width > 1:  # Avoid setting width when canvas is not realized
                self.tx_canvas.itemconfig(self.tx_canvas_window, width=canvas_width)
        
        self.tx_scroll_frame.bind("<Configure>", configure_scroll_frame)
        self.tx_canvas.bind("<Configure>", configure_canvas)
        
        self.tx_canvas_window = self.tx_canvas.create_window((0, 0), window=self.tx_scroll_frame, anchor="nw")
        self.tx_canvas.configure(yscrollcommand=self.tx_scrollbar.set)
        
        # Configure scroll frame columns to match header (ensures proper alignment)
        self.tx_scroll_frame.grid_columnconfigure(0, weight=0, minsize=75)   # ID column
        self.tx_scroll_frame.grid_columnconfigure(1, weight=1, minsize=280)  # Data column (expandable)
        self.tx_scroll_frame.grid_columnconfigure(2, weight=0, minsize=65)   # Cycle column
        self.tx_scroll_frame.grid_columnconfigure(3, weight=0, minsize=75)   # Status column
        self.tx_scroll_frame.grid_columnconfigure(4, weight=0, minsize=135)  # Actions column
        
        self.tx_canvas.pack(side="left", fill="both", expand=True, padx=5)
        self.tx_scrollbar.pack(side="right", fill="y")
        
        # Add mouse wheel scrolling
        def on_mousewheel(event):
            self.tx_canvas.yview_scroll(int(-1*(event.delta/120)), "units")
        
        def bind_mousewheel_to_widget(widget):
            """Bind mouse wheel scrolling to a widget so it propagates to canvas"""
            widget.bind("<MouseWheel>", on_mousewheel)
            # Also bind to all children recursively
            for child in widget.winfo_children():
                bind_mousewheel_to_widget(child)
        
        self.tx_canvas.bind("<MouseWheel>", on_mousewheel)
        self.tx_scroll_frame.bind("<MouseWheel>", on_mousewheel)
        
        # Store the binding function for use when creating message rows
        self.bind_mousewheel_to_widget = bind_mousewheel_to_widget
        

    def log(self, message):
        self.console.insert(tk.END, message + "\n")
        self.console.see(tk.END)

    def connect(self):
        channel = self.device_var.get()
        baud = self.baud_var.get()

        if not channel:
            messagebox.showerror("No Device", "Please select a device from the list.")
            return

        try:
            self.bus = can.interface.Bus(channel=channel, bustype='pcan', bitrate=int(baud))
            self.running = True
            self.rx_thread = threading.Thread(target=self.read_messages, daemon=True)
            self.rx_thread.start()
            self.log(f"✅ Connected to {channel} at {baud} bps.")
        except Exception as e:
            self.log(f"❌ Connection failed: {e}")

    def disconnect(self):
        self.running = False
        if self.bus:
            self.bus.shutdown()
            self.bus = None
            self.log("🔌 Disconnected.")

        # Cancel any pending GUI updates
        if self.gui_update_timer is not None:
            self.root.after_cancel(self.gui_update_timer)
            self.gui_update_timer = None
        self.pending_gui_updates.clear()

        # Stop all TX messages
        for msg_id in list(self.tx_messages.keys()):
            self.stop_tx_message(msg_id)

    def read_messages(self):
        while self.running and self.bus:
            try:
                msg = self.bus.recv(0.1)
                if msg:
                    self.root.after(0, self.handle_rx_message, msg)
            except Exception as e:
                self.root.after(0, lambda: self.log(f"❌ RX error: {e}"))

    def handle_rx_message(self, msg):
        if msg.is_error_frame:
            if self.console_rx_enabled.get():
                self.log("⚠️  ERROR FRAME received.")
            return

        msg_id = msg.arbitration_id
        
        # Update message data immediately (for accurate counting and timing)
        can_msg = self.message_manager.update_message(msg_id, msg.dlc, msg.data)
        
        # Queue this message for GUI update (throttled)
        self.pending_gui_updates.add(msg_id)
        self._schedule_gui_update()
        
        # Console logging (immediate, not throttled)
        if self.console_rx_enabled.get():
            msg_hex_id = f"{msg_id:X}"
            data_str = " ".join(f"{b:02X}" for b in msg.data)
            console_msg = f"⬇️  RX ID: 0x{msg_hex_id} ({can_msg.name})  DLC: {msg.dlc}  Data: {data_str}"
            
            if can_msg.decoded_signals and self.show_decoded.get():
                # For console logging, show only current frame's signals (not accumulated)
                signal_str = ", ".join([f"{name}: {value}" for name, value in can_msg.decoded_signals.items()])
                console_msg += f"\n    Decoded: {signal_str}"
            
            self.log(console_msg)
    
    def _schedule_gui_update(self):
        """Schedule a GUI update if one isn't already pending"""
        if self.gui_update_timer is None:
            self.gui_update_timer = self.root.after(self.gui_refresh_rate_ms, self._perform_gui_updates)
    
    def _perform_gui_updates(self):
        """Update GUI for all pending messages (called at 10Hz)"""
        # Update all messages that have pending changes
        for msg_id in list(self.pending_gui_updates):
            can_msg = self.message_manager.get_message(msg_id)
            if can_msg:
                self.table_view.update_message_display(can_msg)
        
        # Clear pending updates and reset timer
        self.pending_gui_updates.clear()
        self.gui_update_timer = None

    def clear_rx_table(self):
        self.message_manager.clear_all()
        self.table_view.clear_all()

    def toggle_decoded_view(self):
        pass


    def add_tx_row(self):
        tx_id = self.tx_id_var.get().strip()
        tx_data = self.tx_data_var.get().strip()
        tx_cycle_str = self.tx_cycle_var.get().strip()
        
        # If all fields are empty, create a blank message
        if not tx_id and not tx_data and not tx_cycle_str:
            self._create_tx_message_row("", "", "")
        else:
            # Validate non-empty inputs
            try:
                if tx_id:
                    int(tx_id, 16)
                if tx_data:
                    bytes(int(b, 16) for b in tx_data.split())
                if tx_cycle_str:
                    int(tx_cycle_str)
            except Exception:
                messagebox.showerror("Invalid Input", "Please check ID, Data, and Cycle format.")
                return

            self._create_tx_message_row(tx_id, tx_data, tx_cycle_str)
        
        # Clear input fields
        self.tx_id_var.set("")
        self.tx_data_var.set("")
        self.tx_cycle_var.set("")

    def _create_tx_message_row(self, tx_id="", tx_data="", tx_cycle=""):
        """Create a new TX message row with editable fields"""
        # Generate unique ID for this TX message
        msg_id = f"tx_{len(self.tx_messages)}"
        
        # Create message row frame
        msg_frame = ttk.Frame(self.tx_scroll_frame)
        msg_frame.pack(fill=tk.X, pady=1)
        
        # Configure columns to match header alignment
        msg_frame.grid_columnconfigure(0, weight=0, minsize=75)   # ID column
        msg_frame.grid_columnconfigure(1, weight=1, minsize=280)  # Data column (expandable)
        msg_frame.grid_columnconfigure(2, weight=0, minsize=65)   # Cycle column
        msg_frame.grid_columnconfigure(3, weight=0, minsize=75)   # Status column
        msg_frame.grid_columnconfigure(4, weight=0, minsize=135)  # Actions column
        
        # Create editable widgets for this message
        id_var = tk.StringVar(value=tx_id)
        id_entry = ttk.Entry(msg_frame, textvariable=id_var, justify="center", width=10)
        id_entry.grid(row=0, column=0, sticky="ew", padx=1)
        if not tx_id:  # Add placeholder for empty fields
            id_entry.insert(0, "e.g. 123")
            id_entry.config(foreground="gray")
            def on_id_focus_in(event):
                if id_entry.get() == "e.g. 123":
                    id_entry.delete(0, tk.END)
                    id_entry.config(foreground="black")
            def on_id_focus_out(event):
                if not id_entry.get():
                    id_entry.insert(0, "e.g. 123")
                    id_entry.config(foreground="gray")
            id_entry.bind("<FocusIn>", on_id_focus_in)
            id_entry.bind("<FocusOut>", on_id_focus_out)
        
        data_var = tk.StringVar(value=tx_data)
        data_entry = ttk.Entry(msg_frame, textvariable=data_var, width=35)
        data_entry.grid(row=0, column=1, sticky="ew", padx=1)
        if not tx_data:  # Add placeholder for empty fields
            data_entry.insert(0, "e.g. 01 02 03 04 05 06 07 08")
            data_entry.config(foreground="gray")
            def on_data_focus_in(event):
                if data_entry.get() == "e.g. 01 02 03 04 05 06 07 08":
                    data_entry.delete(0, tk.END)
                    data_entry.config(foreground="black")
            def on_data_focus_out(event):
                if not data_entry.get():
                    data_entry.insert(0, "e.g. 01 02 03 04 05 06 07 08")
                    data_entry.config(foreground="gray")
            data_entry.bind("<FocusIn>", on_data_focus_in)
            data_entry.bind("<FocusOut>", on_data_focus_out)
        
        cycle_var = tk.StringVar(value=tx_cycle)
        cycle_entry = ttk.Entry(msg_frame, textvariable=cycle_var, justify="center", width=8)
        cycle_entry.grid(row=0, column=2, sticky="ew", padx=1)
        if not tx_cycle:  # Add placeholder for empty fields
            cycle_entry.insert(0, "e.g. 100")
            cycle_entry.config(foreground="gray")
            def on_cycle_focus_in(event):
                if cycle_entry.get() == "e.g. 100":
                    cycle_entry.delete(0, tk.END)
                    cycle_entry.config(foreground="black")
            def on_cycle_focus_out(event):
                if not cycle_entry.get():
                    cycle_entry.insert(0, "e.g. 100")
                    cycle_entry.config(foreground="gray")
            cycle_entry.bind("<FocusIn>", on_cycle_focus_in)
            cycle_entry.bind("<FocusOut>", on_cycle_focus_out)
        
        status_label = ttk.Label(msg_frame, text="Stopped", anchor="center", relief="sunken", width=10)
        status_label.grid(row=0, column=3, sticky="ew", padx=1)
        
        # Create button frame for start/stop/delete
        button_frame = ttk.Frame(msg_frame)
        button_frame.grid(row=0, column=4, sticky="ew", padx=1)
        
        start_btn = ttk.Button(button_frame, text="Start", width=6, 
                              command=lambda: self.start_tx_message(msg_id))
        start_btn.pack(side=tk.LEFT, padx=1)
        
        stop_btn = ttk.Button(button_frame, text="Stop", width=6, state="disabled",
                             command=lambda: self.stop_tx_message(msg_id))
        stop_btn.pack(side=tk.LEFT, padx=1)
        
        delete_btn = ttk.Button(button_frame, text="Del", width=4,
                               command=lambda: self.delete_tx_message(msg_id))
        delete_btn.pack(side=tk.LEFT, padx=1)
        
        # Store message info and widgets
        self.tx_messages[msg_id] = {
            "running": False,
            "timer": None,
            "widgets": {
                "frame": msg_frame,
                "id_var": id_var,
                "data_var": data_var,
                "cycle_var": cycle_var,
                "status": status_label,
                "start_btn": start_btn,
                "stop_btn": stop_btn
            }
        }
        
        # Bind mouse wheel scrolling to all widgets in this message row
        self.bind_mousewheel_to_widget(msg_frame)
        
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))

    def start_tx_message(self, msg_id):
        """Start transmitting a specific message"""
        if msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[msg_id]
        
        if not self.running or not self.bus:
            messagebox.showerror("Not Connected", "Please connect to CAN bus first.")
            return
            
        if msg_info["running"]:
            return  # Already running
        
        # Check if this is a DBF message and delegate to the DBF handler
        if msg_info.get("type") == "dbf":
            self.start_dbf_tx_message(msg_id)
            return
        
        # Handle regular TX messages
        try:
            tx_id = msg_info["widgets"]["id_var"].get().strip()
            tx_data = msg_info["widgets"]["data_var"].get().strip()
            tx_cycle_str = msg_info["widgets"]["cycle_var"].get().strip()
            
            # Handle placeholder text
            if tx_id.startswith("e.g."):
                tx_id = ""
            if tx_data.startswith("e.g."):
                tx_data = ""
            if tx_cycle_str.startswith("e.g."):
                tx_cycle_str = ""
            
            # Validate inputs
            if not tx_id:
                messagebox.showerror("Invalid Input", "ID cannot be empty.")
                return
            if not tx_data:
                messagebox.showerror("Invalid Input", "Data cannot be empty.")
                return
            if not tx_cycle_str:
                messagebox.showerror("Invalid Input", "Cycle cannot be empty.")
                return
                
            tx_id_int = int(tx_id, 16)
            tx_data_bytes = bytes(int(b, 16) for b in tx_data.split())
            tx_cycle = int(tx_cycle_str)
            
        except ValueError as e:
            messagebox.showerror("Invalid Input", f"Please check format: {e}")
            return
            
        # Log the start action
        if tx_cycle == 0:
            self.log(f"🚀 Starting one-shot TX: ID 0x{tx_id_int:X}, Data: {tx_data}")
        else:
            self.log(f"🚀 Starting periodic TX: ID 0x{tx_id_int:X}, Cycle: {tx_cycle}ms, Data: {tx_data}")
        
        # Update UI
        msg_info["widgets"]["status"].config(text="Running", foreground="green")
        msg_info["widgets"]["start_btn"].config(state="disabled")
        msg_info["widgets"]["stop_btn"].config(state="normal")
        msg_info["running"] = True
        
        def send_message(log_tx=False):
            if not self.running or not msg_info["running"]:
                return
            try:
                # Re-read values each time in case user changed them while running
                current_id = msg_info["widgets"]["id_var"].get().strip()
                current_data = msg_info["widgets"]["data_var"].get().strip()
                
                # Handle placeholder text
                if current_id.startswith("e.g."):
                    current_id = tx_id  # Use validated value from start
                if current_data.startswith("e.g."):
                    current_data = tx_data  # Use validated value from start
                
                msg = can.Message(
                    arbitration_id=int(current_id, 16),
                    data=bytes(int(b, 16) for b in current_data.split()),
                    is_extended_id=False
                )
                self.bus.send(msg)
                
                # Only log TX details for one-shot or first transmission
                if log_tx:
                    self.log(f"⬆️  [TX] ID: 0x{msg.arbitration_id:X} Data: {' '.join(format(b, '02X') for b in msg.data)}")
                    
            except Exception as e:
                self.log(f"❌ TX error: {e}")
                self.stop_tx_message(msg_id)
                return

        # Send immediately
        send_message(log_tx=(tx_cycle == 0))  # Log details for one-shot messages
        
        # Handle cycle time 0 (one-shot) - auto-stop after sending
        if tx_cycle == 0:
            self.stop_tx_message(msg_id)
            return
        
        # Schedule recurring sends for periodic messages
        def schedule_next():
            if not self.running or not msg_info["running"]:
                return
            send_message(log_tx=False)  # Don't log repetitive sends
            # Re-read cycle time in case user changed it
            try:
                current_cycle = int(msg_info["widgets"]["cycle_var"].get().strip())
                if current_cycle > 0:
                    msg_info["timer"] = threading.Timer(current_cycle / 1000.0, schedule_next)
                    msg_info["timer"].daemon = True
                    msg_info["timer"].start()
                else:
                    # If cycle becomes 0, stop transmission
                    self.stop_tx_message(msg_id)
            except ValueError:
                # If cycle becomes invalid, stop transmission
                self.stop_tx_message(msg_id)
        
        msg_info["timer"] = threading.Timer(tx_cycle / 1000.0, schedule_next)
        msg_info["timer"].daemon = True
        msg_info["timer"].start()

    def stop_tx_message(self, msg_id):
        """Stop transmitting a specific message"""
        if msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[msg_id]
        
        # Only log if it was actually running
        if msg_info["running"]:
            # Get message identifier for logging
            if msg_info.get("type") == "dbf":
                msg_name = msg_info["msg_info"]["name"]
                msg_identifier = f"0x{msg_info['msg_id']:X} ({msg_name})"
            else:
                tx_id = msg_info["widgets"]["id_var"].get().strip()
                msg_identifier = f"0x{tx_id}"
            
            self.log(f"⏹️  Stopped TX: {msg_identifier}")
        
        # Update UI
        msg_info["widgets"]["status"].config(text="Stopped", foreground="black")
        msg_info["widgets"]["start_btn"].config(state="normal")
        msg_info["widgets"]["stop_btn"].config(state="disabled")
        msg_info["running"] = False
        
        # Cancel timer
        if msg_info["timer"]:
            msg_info["timer"].cancel()
            msg_info["timer"] = None

    def delete_tx_message(self, msg_id):
        """Delete a TX message"""
        if msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[msg_id]
        
        # Get message identifier for logging before deletion
        if msg_info.get("type") == "dbf":
            msg_name = msg_info["msg_info"]["name"]
            msg_identifier = f"0x{msg_info['msg_id']:X} ({msg_name})"
        else:
            tx_id = msg_info["widgets"]["id_var"].get().strip()
            msg_identifier = f"0x{tx_id}" if tx_id else "Empty message"
        
        # Stop transmission if running
        self.stop_tx_message(msg_id)
        
        # Log the deletion
        self.log(f"🗑️  Deleted TX: {msg_identifier}")
        
        # Remove widgets
        msg_info["widgets"]["frame"].destroy()
        
        # Also remove signals frame if it exists (for DBF messages)
        if "signals_frame" in msg_info["widgets"]:
            msg_info["widgets"]["signals_frame"].destroy()
        
        # Remove from storage
        del self.tx_messages[msg_id]
        
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))

    def add_dbf_message(self):
        """Show dialog to select a message from the DBF file"""
        if not self.dbf_parser.messages:
            messagebox.showinfo("No Messages", "No messages found in DBF file.")
            return
        
        # Create selection dialog
        dialog = tk.Toplevel(self.root)
        dialog.title("Select CAN Message")
        dialog.geometry("500x400")
        dialog.transient(self.root)
        dialog.grab_set()
        
        # Center dialog on parent
        dialog.update_idletasks()
        x = (dialog.winfo_screenwidth() // 2) - (dialog.winfo_width() // 2)
        y = (dialog.winfo_screenheight() // 2) - (dialog.winfo_height() // 2)
        dialog.geometry(f"+{x}+{y}")
        
        ttk.Label(dialog, text="Select a message to add to TX scheduler:").pack(pady=10)
        
        # Create listbox with scrollbar
        frame = ttk.Frame(dialog)
        frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        listbox = tk.Listbox(frame)
        scrollbar = ttk.Scrollbar(frame, orient="vertical", command=listbox.yview)
        listbox.configure(yscrollcommand=scrollbar.set)
        
        listbox.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
        # Populate with messages from DBF
        for msg_id, msg_info in self.dbf_parser.messages.items():
            msg_name = msg_info.get('name', 'Unknown')
            msg_text = f"0x{msg_id:X} - {msg_name}"
            listbox.insert(tk.END, msg_text)
        
        # Button frame
        btn_frame = ttk.Frame(dialog)
        btn_frame.pack(pady=10)
        
        selected_msg = None
        
        def on_add():
            nonlocal selected_msg
            selection = listbox.curselection()
            if not selection:
                messagebox.showwarning("No Selection", "Please select a message.")
                return
            
            # Get the selected message ID
            msg_ids = list(self.dbf_parser.messages.keys())
            selected_msg = msg_ids[selection[0]]
            dialog.destroy()
        
        def on_cancel():
            dialog.destroy()
        
        ttk.Button(btn_frame, text="Add", command=on_add).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="Cancel", command=on_cancel).pack(side=tk.LEFT, padx=5)
        
        # Wait for dialog to close
        dialog.wait_window()
        
        if selected_msg is not None:
            self._create_dbf_message_row(selected_msg)

    def _create_dbf_message_row(self, msg_id):
        """Create a TX message row for a DBF message with expandable signals"""
        msg_info = self.dbf_parser.messages[msg_id]
        msg_name = msg_info.get('name', 'Unknown')
        
        # Generate unique ID for this TX message
        tx_msg_id = f"tx_{len(self.tx_messages)}"
        
        # Create message row frame
        msg_frame = ttk.Frame(self.tx_scroll_frame)
        msg_frame.pack(fill=tk.X, pady=1)
        
        # Configure columns to match header alignment
        msg_frame.grid_columnconfigure(0, weight=0, minsize=75)   # ID column
        msg_frame.grid_columnconfigure(1, weight=1, minsize=280)  # Data column (expandable)
        msg_frame.grid_columnconfigure(2, weight=0, minsize=65)   # Cycle column
        msg_frame.grid_columnconfigure(3, weight=0, minsize=75)   # Status column
        msg_frame.grid_columnconfigure(4, weight=0, minsize=135)  # Actions column
        
        # Create main row widgets
        id_var = tk.StringVar(value=f"{msg_id:X}")
        id_entry = ttk.Entry(msg_frame, textvariable=id_var, justify="center", state="readonly", width=10)
        id_entry.grid(row=0, column=0, sticky="ew", padx=1)
        
        # Data column shows message name with expand/collapse button
        data_frame = ttk.Frame(msg_frame)
        data_frame.grid(row=0, column=1, sticky="ew", padx=1)
        
        expand_var = tk.BooleanVar()
        expand_btn = ttk.Checkbutton(data_frame, text="▶", variable=expand_var, width=3,
                                    command=lambda: self._toggle_dbf_signals(tx_msg_id))
        expand_btn.pack(side=tk.LEFT)
        
        name_label = ttk.Label(data_frame, text=msg_name)
        name_label.pack(side=tk.LEFT, padx=(5, 0))
        
        cycle_var = tk.StringVar(value="100")
        cycle_entry = ttk.Entry(msg_frame, textvariable=cycle_var, justify="center", width=8)
        cycle_entry.grid(row=0, column=2, sticky="ew", padx=1)
        
        status_label = ttk.Label(msg_frame, text="Stopped", anchor="center", relief="sunken", width=10)
        status_label.grid(row=0, column=3, sticky="ew", padx=1)
        
        # Create button frame for start/stop/delete
        button_frame = ttk.Frame(msg_frame)
        button_frame.grid(row=0, column=4, sticky="ew", padx=1)
        
        start_btn = ttk.Button(button_frame, text="Start", width=6, 
                              command=lambda: self.start_dbf_tx_message(tx_msg_id))
        start_btn.pack(side=tk.LEFT, padx=1)
        
        stop_btn = ttk.Button(button_frame, text="Stop", width=6, state="disabled",
                             command=lambda: self.stop_tx_message(tx_msg_id))
        stop_btn.pack(side=tk.LEFT, padx=1)
        
        delete_btn = ttk.Button(button_frame, text="Del", width=4,
                               command=lambda: self.delete_tx_message(tx_msg_id))
        delete_btn.pack(side=tk.LEFT, padx=1)
        
        # Create signal editing frame (initially hidden)
        signals_frame = ttk.Frame(self.tx_scroll_frame)
        
        # Store message info and widgets
        self.tx_messages[tx_msg_id] = {
            "running": False,
            "timer": None,
            "type": "dbf",
            "msg_id": msg_id,
            "msg_info": msg_info,
            "signals": {},  # Will store signal values
            "widgets": {
                "frame": msg_frame,
                "signals_frame": signals_frame,
                "id_var": id_var,
                "cycle_var": cycle_var,
                "status": status_label,
                "start_btn": start_btn,
                "stop_btn": stop_btn,
                "expand_var": expand_var,
                "expand_btn": expand_btn
            }
        }
        
        # Initialize signal values to defaults
        for signal in msg_info.get('signals', []):
            signal_name = signal['name']
            self.tx_messages[tx_msg_id]["signals"][signal_name] = 0
        
        # Bind mouse wheel scrolling to all widgets in this message row
        self.bind_mousewheel_to_widget(msg_frame)
        
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))

    def _toggle_dbf_signals(self, tx_msg_id):
        """Toggle the display of signal editing widgets for a DBF message"""
        if tx_msg_id not in self.tx_messages:
            return
            
        msg_data = self.tx_messages[tx_msg_id]
        expand_var = msg_data["widgets"]["expand_var"]
        signals_frame = msg_data["widgets"]["signals_frame"]
        expand_btn = msg_data["widgets"]["expand_btn"]
        
        if expand_var.get():
            # Expand - show signals
            expand_btn.config(text="▼")
            self._create_signal_widgets(tx_msg_id)
            signals_frame.pack(fill=tk.X, padx=20, pady=2, after=msg_data["widgets"]["frame"])
        else:
            # Collapse - hide signals
            expand_btn.config(text="▶")
            signals_frame.pack_forget()
            # Clear signal widgets
            for widget in signals_frame.winfo_children():
                widget.destroy()
        
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))

    def _create_signal_widgets(self, tx_msg_id):
        """Create signal editing widgets for a DBF message"""
        msg_data = self.tx_messages[tx_msg_id]
        signals_frame = msg_data["widgets"]["signals_frame"]
        msg_info = msg_data["msg_info"]
        
        # Create header for signals
        header_frame = ttk.Frame(signals_frame)
        header_frame.pack(fill=tk.X, pady=2)
        
        ttk.Label(header_frame, text="Signal", width=20, relief="ridge").pack(side=tk.LEFT, padx=1)
        ttk.Label(header_frame, text="Value", width=15, relief="ridge").pack(side=tk.LEFT, padx=1)
        ttk.Label(header_frame, text="Unit", width=10, relief="ridge").pack(side=tk.LEFT, padx=1)
        ttk.Label(header_frame, text="Range", width=20, relief="ridge").pack(side=tk.LEFT, padx=1)
        
        # Create signal editing rows
        for signal in msg_info.get('signals', []):
            signal_name = signal['name']
            signal_frame = ttk.Frame(signals_frame)
            signal_frame.pack(fill=tk.X, pady=1)
            
            # Signal name
            ttk.Label(signal_frame, text=signal_name, width=20, anchor="w").pack(side=tk.LEFT, padx=1)
            
            # Signal value entry
            signal_var = tk.StringVar(value=str(msg_data["signals"].get(signal_name, 0)))
            signal_entry = ttk.Entry(signal_frame, textvariable=signal_var, width=15, justify="center")
            signal_entry.pack(side=tk.LEFT, padx=1)
            
            # Update signal value when changed
            def on_signal_change(var=signal_var, name=signal_name):
                try:
                    value = float(var.get())
                    msg_data["signals"][name] = value
                except ValueError:
                    pass
            
            signal_var.trace("w", lambda *args, var=signal_var, name=signal_name: on_signal_change(var, name))
            
            # Signal unit
            unit = signal.get('unit', '')
            ttk.Label(signal_frame, text=unit, width=10, anchor="center").pack(side=tk.LEFT, padx=1)
            
            # Signal range
            min_val = signal.get('min', 0)
            max_val = signal.get('max', 0)
            range_text = f"{min_val} to {max_val}"
            ttk.Label(signal_frame, text=range_text, width=20, anchor="center").pack(side=tk.LEFT, padx=1)
            
            # Store signal widget reference
            if "signal_widgets" not in msg_data["widgets"]:
                msg_data["widgets"]["signal_widgets"] = {}
            msg_data["widgets"]["signal_widgets"][signal_name] = signal_var
        
        # Bind mouse wheel scrolling to all signal widgets
        self.bind_mousewheel_to_widget(signals_frame)

    def start_dbf_tx_message(self, tx_msg_id):
        """Start transmitting a DBF message with signal encoding"""
        if tx_msg_id not in self.tx_messages:
            return
            
        msg_data = self.tx_messages[tx_msg_id]
        
        if not self.running or not self.bus:
            messagebox.showerror("Not Connected", "Please connect to CAN bus first.")
            return
            
        if msg_data["running"]:
            return  # Already running
        
        # Get cycle time
        try:
            tx_cycle_str = msg_data["widgets"]["cycle_var"].get().strip()
            tx_cycle = int(tx_cycle_str)
        except ValueError:
            messagebox.showerror("Invalid Input", "Cycle time must be a number.")
            return
        
        # Log the start action
        msg_name = msg_data["msg_info"]["name"]
        msg_id = msg_data["msg_id"]
        if tx_cycle == 0:
            self.log(f"🚀 Starting one-shot TX: 0x{msg_id:X} ({msg_name})")
        else:
            self.log(f"🚀 Starting periodic TX: 0x{msg_id:X} ({msg_name}), Cycle: {tx_cycle}ms")
            
        # Update UI
        msg_data["widgets"]["status"].config(text="Running", foreground="green")
        msg_data["widgets"]["start_btn"].config(state="disabled")
        msg_data["widgets"]["stop_btn"].config(state="normal")
        msg_data["running"] = True
        
        def send_message(log_tx=False):
            if not self.running or not msg_data["running"]:
                return
            try:
                # Encode signals into CAN message data
                can_data = self._encode_dbf_signals(tx_msg_id)
                
                msg = can.Message(
                    arbitration_id=msg_data["msg_id"],
                    data=can_data,
                    is_extended_id=False
                )
                self.bus.send(msg)
                
                # Only log TX details for one-shot messages
                if log_tx:
                    signals_str = ", ".join([f"{name}: {value}" for name, value in msg_data["signals"].items()])
                    self.log(f"⬆️  [TX] ID: 0x{msg.arbitration_id:X} ({msg_data['msg_info']['name']}) Data: {' '.join(format(b, '02X') for b in msg.data)}")
                    if signals_str:
                        self.log(f"    Signals: {signals_str}")
                    
            except Exception as e:
                self.log(f"❌ TX error: {e}")
                self.stop_tx_message(tx_msg_id)
                return

        # Send immediately
        send_message(log_tx=(tx_cycle == 0))  # Log details for one-shot messages
        
        # Handle cycle time 0 (one-shot) - auto-stop after sending
        if tx_cycle == 0:
            self.stop_tx_message(tx_msg_id)
            return
        
        # Schedule recurring sends for periodic messages
        def schedule_next():
            if not self.running or not msg_data["running"]:
                return
            send_message(log_tx=False)  # Don't log repetitive sends
            # Re-read cycle time in case user changed it
            try:
                current_cycle = int(msg_data["widgets"]["cycle_var"].get().strip())
                if current_cycle > 0:
                    msg_data["timer"] = threading.Timer(current_cycle / 1000.0, schedule_next)
                    msg_data["timer"].daemon = True
                    msg_data["timer"].start()
                else:
                    # If cycle becomes 0, stop transmission
                    self.stop_tx_message(tx_msg_id)
            except ValueError:
                # If cycle becomes invalid, stop transmission
                self.stop_tx_message(tx_msg_id)
        
        msg_data["timer"] = threading.Timer(tx_cycle / 1000.0, schedule_next)
        msg_data["timer"].daemon = True
        msg_data["timer"].start()

    def _encode_dbf_signals(self, tx_msg_id):
        """Encode signal values into CAN message data bytes"""
        msg_data = self.tx_messages[tx_msg_id]
        msg_info = msg_data["msg_info"]
        
        # Initialize 8 bytes to zero
        data = bytearray(8)
        
        # Encode each signal
        for signal in msg_info.get('signals', []):
            signal_name = signal['name']
            value = msg_data["signals"].get(signal_name, 0)
            
            # Get signal properties
            start_bit = signal.get('start_bit', 0)
            length = signal.get('length', 1)
            factor = signal.get('factor', 1.0)
            offset = signal.get('offset', 0.0)
            
            # Apply scaling: raw_value = (value - offset) / factor
            raw_value = int((value - offset) / factor)
            
            # Clamp to signal bit range
            max_raw = (1 << length) - 1
            raw_value = max(0, min(raw_value, max_raw))
            
            # Pack into data bytes (assuming little-endian bit ordering)
            byte_offset = start_bit // 8
            bit_offset = start_bit % 8
            
            # Simple bit packing for signals that fit in byte boundaries
            if bit_offset == 0 and length == 8:
                data[byte_offset] = raw_value
            elif bit_offset == 0 and length == 16 and byte_offset < 7:
                data[byte_offset] = raw_value & 0xFF
                data[byte_offset + 1] = (raw_value >> 8) & 0xFF
            else:
                # More complex bit manipulation for non-byte-aligned signals
                for i in range(length):
                    bit_pos = start_bit + i
                    byte_idx = bit_pos // 8
                    bit_idx = bit_pos % 8
                    
                    if byte_idx < 8 and (raw_value >> i) & 1:
                        data[byte_idx] |= (1 << bit_idx)
        
        return bytes(data)


if __name__ == "__main__":
    root = tk.Tk()
    app = CANApp(root)
    root.mainloop()
