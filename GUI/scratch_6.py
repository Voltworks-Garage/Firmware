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
    
    def __post_init__(self):
        if self.signal_item_ids is None:
            self.signal_item_ids = {}

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
        
        if msg_id in self.messages:
            # Update existing message
            msg = self.messages[msg_id]
            msg.dlc = dlc
            msg.data = data
            msg.count += 1
            msg.last_time = now
            msg.decoded_signals = decoded_signals
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
            self.messages[msg_id] = msg
        
        return msg
    
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
        
        # Bind events
        self.tree.bind("<Double-1>", self._on_double_click)
        self.tree.bind("<Button-1>", self._on_single_click)
    
    def pack(self, **kwargs):
        """Pack the tree view"""
        self.tree.pack(**kwargs)
    
    def update_message_display(self, msg: CANMessage):
        """Update the display for a single message"""
        # Format the data
        msg_hex_id = f"{msg.msg_id:X}"
        data_str = " ".join(f"{b:02X}" for b in msg.data)
        
        # Calculate cycle time if we have previous timing
        cycle_str = "-"
        if hasattr(msg, '_prev_time') and msg._prev_time is not None:
            cycle_ms = (msg.last_time - msg._prev_time) * 1000
            cycle_str = f"{cycle_ms:.1f} ms"
        msg._prev_time = msg.last_time
        
        if msg.tree_item_id is None:
            # Create new tree item
            expand_indicator = "▶" if msg.decoded_signals else ""
            msg.tree_item_id = self.tree.insert("", tk.END, 
                                               text=expand_indicator,
                                               values=(msg_hex_id, msg.name, msg.dlc, data_str, msg.count, cycle_str))
        else:
            # Update existing tree item
            expand_indicator = "▼" if msg.is_expanded else ("▶" if msg.decoded_signals else "")
            self.tree.item(msg.tree_item_id,
                          text=expand_indicator,
                          values=(msg_hex_id, msg.name, msg.dlc, data_str, msg.count, cycle_str))
        
        # Handle signal children (only update values if expanded)
        if msg.is_expanded and msg.decoded_signals:
            self._update_signal_children(msg)
    
    def _ensure_signal_children(self, msg: CANMessage):
        """Ensure signal children exist for this message (create only if needed)"""
        if not msg.decoded_signals:
            return
            
        for signal_name, signal_value in msg.decoded_signals.items():
            if signal_name not in msg.signal_item_ids:
                # Create new signal child only if it doesn't exist
                signal_item = self.tree.insert(msg.tree_item_id, tk.END, text="",
                                             values=("", f"  {signal_name}", "", signal_value, "", ""))
                msg.signal_item_ids[signal_name] = signal_item
            else:
                # Update existing signal child value
                self.tree.item(msg.signal_item_ids[signal_name],
                             values=("", f"  {signal_name}", "", signal_value, "", ""))
    
    def _update_signal_children(self, msg: CANMessage):
        """Update signal children values (only if they exist and message is expanded)"""
        if not msg.is_expanded or not msg.decoded_signals:
            return
            
        for signal_name, signal_value in msg.decoded_signals.items():
            if signal_name in msg.signal_item_ids:
                # Update existing signal child value
                self.tree.item(msg.signal_item_ids[signal_name],
                             values=("", f"  {signal_name}", "", signal_value, "", ""))
    
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
                    self._ensure_signal_children(msg)
                    self.tree.item(tree_item_id, text="▼", open=True)
                else:
                    # Just close the tree item, don't delete children
                    self.tree.item(tree_item_id, text="▶", open=False)
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
                    
                    # Detect multiplexor signal (typically named "MultiPlex", "Mux", etc.)
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
        
        # Second pass: decode all other signals
        for signal in msg_def['signals']:
            if signal['is_multiplexor']:
                continue  # Already handled above
                
            try:
                value = self.extract_signal_value(signal, data)
                
                # For multiplexed messages, create descriptive signal names
                signal_name = signal['name']
                if msg_def['is_multiplexed'] and multiplex_value is not None:
                    # Handle cell voltages and temperatures with proper indexing
                    if 'cell' in signal['name'] and 'voltage' in signal['name']:
                        cell_num = int(signal['name'].split('_')[1])
                        absolute_cell = (multiplex_value * 4) + cell_num
                        signal_name = f"Cell_{absolute_cell:02d}_voltage"
                    elif 'temp' in signal['name']:
                        temp_num = int(signal['name'].split('_')[1])
                        absolute_temp = (multiplex_value * 4) + temp_num
                        signal_name = f"Temp_{absolute_temp:02d}"
                    else:
                        # For other multiplexed signals, just add the mode prefix
                        signal_name = f"M{multiplex_value}_{signal['name']}"
                
                if signal['type'] == 'B':
                    decoded['signals'][signal_name] = 'True' if value else 'False'
                else:
                    unit_str = f" {signal['unit']}" if signal['unit'] else ''
                    if signal['factor'] == 1.0 and signal['offset'] == 0.0:
                        decoded['signals'][signal_name] = f"{int(value)}{unit_str}"
                    else:
                        # Use higher precision for voltage/current measurements
                        precision = 3 if 'voltage' in signal['name'].lower() or 'current' in signal['name'].lower() else 2
                        decoded['signals'][signal_name] = f"{value:.{precision}f}{unit_str}"
            except Exception:
                decoded['signals'][signal.get('name', 'unknown')] = 'Error'
        
        return decoded

class CANApp:
    def __init__(self, root):
        self.root = root
        self.root.title("PCAN Tool with CAN Decoder")
        self.bus = None
        self.running = False
        self.tx_tasks = {}
        self.console_rx_enabled = tk.BooleanVar(value=False)
        self.show_decoded = tk.BooleanVar(value=True)
        self.available_channels = []
        
        # Initialize components
        dbf_path = r"C:\REPOS\Voltworks_Garage\Firmware\CAN\emoto.dbf"
        dbf_parser = BusmasterDBFParser(dbf_path)
        self.message_manager = CANMessageManager(dbf_parser)
        
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

        # Main content frame using simple horizontal layout
        main_frame = ttk.Frame(self.root)
        main_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)

        # Console frame (left side)
        console_frame = ttk.LabelFrame(main_frame, text="Console Log")
        console_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=(0, 5))
        self.console = scrolledtext.ScrolledText(console_frame, wrap=tk.WORD, height=10)
        self.console.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # Table frame (right side)
        table_frame = ttk.LabelFrame(main_frame, text="Live RX Messages")
        table_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True, padx=(5, 0))
        
        # Create the table view component
        self.table_view = CANTableView(table_frame, self.message_manager)
        self.table_view.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        self.create_tx_section()

    def scan_devices(self):
        try:
            configs = can.detect_available_configs()
            self.available_channels = [cfg['channel'] for cfg in configs if cfg.get('interface') == 'pcan']
            self.device_combo['values'] = self.available_channels
            if self.available_channels:
                self.device_combo.current(0)
                self.log(f"🔍 Found devices: {', '.join(self.available_channels)}")
            else:
                self.log("⚠️  No PCAN USB devices found.")
        except Exception as e:
            self.log(f"❌ Error scanning devices: {e}")

    def create_tx_section(self):
        tx_frame = ttk.LabelFrame(self.root, text="TX Message Scheduler")
        tx_frame.pack(fill=tk.X, padx=10, pady=5)

        ttk.Label(tx_frame, text="ID (hex):").grid(row=0, column=0, padx=5, pady=2)
        self.tx_id_var = tk.StringVar()
        ttk.Entry(tx_frame, textvariable=self.tx_id_var, width=10).grid(row=0, column=1, padx=5, pady=2)

        ttk.Label(tx_frame, text="Data (hex bytes):").grid(row=0, column=2, padx=5, pady=2)
        self.tx_data_var = tk.StringVar()
        ttk.Entry(tx_frame, textvariable=self.tx_data_var, width=40).grid(row=0, column=3, padx=5, pady=2)

        ttk.Label(tx_frame, text="Cycle (ms):").grid(row=0, column=4, padx=5, pady=2)
        self.tx_cycle_var = tk.StringVar()
        ttk.Entry(tx_frame, textvariable=self.tx_cycle_var, width=6).grid(row=0, column=5, padx=5, pady=2)

        ttk.Button(tx_frame, text="Add TX", command=self.add_tx_row).grid(row=0, column=6, padx=5, pady=2)

        self.tx_table = ttk.Treeview(tx_frame, columns=("ID", "Data", "Cycle", "Status", "Control"), show="headings", height=5)
        for col, w in [("ID", 80), ("Data", 300), ("Cycle", 80), ("Status", 60), ("Control", 70)]:
            self.tx_table.heading(col, text=col)
            self.tx_table.column(col, width=w)
        self.tx_table.grid(row=1, column=0, columnspan=7, sticky="nsew", padx=5, pady=5)
        self.tx_table.bind("<Button-1>", self.handle_tx_click)

        self.delete_tx_btn = ttk.Button(tx_frame, text="Delete Selected", command=self.delete_selected_tx)
        self.delete_tx_btn.grid(row=2, column=0, columnspan=7, sticky="e", padx=5, pady=(0, 5))

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

        for task in self.tx_tasks.values():
            task["running"] = False
            if task.get("timer"):
                task["timer"].cancel()
        for row_id in self.tx_tasks:
            self.tx_table.item(row_id, values=(self.tx_tasks[row_id]["id"], self.tx_tasks[row_id]["data"],
                                               self.tx_tasks[row_id]["cycle"], "Stopped", "Start"))

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
        
        # Update message through the manager
        can_msg = self.message_manager.update_message(msg_id, msg.dlc, msg.data)
        
        # Update the display
        self.table_view.update_message_display(can_msg)
        
        # Console logging
        if self.console_rx_enabled.get():
            msg_hex_id = f"{msg_id:X}"
            data_str = " ".join(f"{b:02X}" for b in msg.data)
            console_msg = f"⬇️  RX ID: 0x{msg_hex_id} ({can_msg.name})  DLC: {msg.dlc}  Data: {data_str}"
            
            if can_msg.decoded_signals and self.show_decoded.get():
                signal_str = ", ".join([f"{name}: {value}" for name, value in can_msg.decoded_signals.items()])
                console_msg += f"\n    Decoded: {signal_str}"
            
            self.log(console_msg)

    def clear_rx_table(self):
        self.message_manager.clear_all()
        self.table_view.clear_all()

    def toggle_decoded_view(self):
        pass


    def add_tx_row(self):
        try:
            tx_id = self.tx_id_var.get().strip()
            tx_data = self.tx_data_var.get().strip()
            tx_cycle = int(self.tx_cycle_var.get().strip())
            int(tx_id, 16)
            bytes(int(b, 16) for b in tx_data.split())
        except Exception:
            messagebox.showerror("Invalid Input", "Please check ID, Data, and Cycle format.")
            return

        item_id = self.tx_table.insert("", tk.END, values=(tx_id, tx_data, tx_cycle, "Stopped", "Start"))
        self.tx_tasks[item_id] = {"id": tx_id, "data": tx_data, "cycle": tx_cycle, "running": False, "timer": None}

    def handle_tx_click(self, event):
        region = self.tx_table.identify("region", event.x, event.y)
        column = self.tx_table.identify_column(event.x)
        row_id = self.tx_table.identify_row(event.y)

        if region == "cell" and column == "#5" and row_id:
            task = self.tx_tasks.get(row_id)
            if not task:
                return
            if task["running"]:
                self.stop_tx_task(row_id)
            else:
                self.start_tx_task(row_id)

    def start_tx_task(self, row_id):
        task = self.tx_tasks[row_id]

        def send():
            if not self.running:
                return
            try:
                msg = can.Message(
                    arbitration_id=int(task["id"], 16),
                    data=bytes(int(b, 16) for b in task["data"].split()),
                    is_extended_id=False
                )
                self.bus.send(msg)
                self.log(f"⬆️  [TX] ID: 0x{msg.arbitration_id:X} Data: {' '.join(format(b, '02X') for b in msg.data)}")
            except Exception as e:
                self.log(f"❌ TX error: {e}")
                self.stop_tx_task(row_id)

        if task["cycle"] == 0:
            send()
            return

        task["running"] = True
        self.tx_table.item(row_id, values=(task["id"], task["data"], task["cycle"], "Running", "Stop"))
        send()

        def loop():
            if not self.running or not task["running"]:
                return
            send()
            task["timer"] = threading.Timer(task["cycle"] / 1000.0, loop)
            task["timer"].daemon = True
            task["timer"].start()

        loop()

    def stop_tx_task(self, row_id):
        task = self.tx_tasks[row_id]
        task["running"] = False
        if task.get("timer"):
            task["timer"].cancel()
            task["timer"] = None
        self.tx_table.item(row_id, values=(task["id"], task["data"], task["cycle"], "Stopped", "Start"))

    def delete_selected_tx(self):
        selected = self.tx_table.selection()
        for row_id in selected:
            task = self.tx_tasks.get(row_id)
            if task:
                task["running"] = False
                if task.get("timer"):
                    task["timer"].cancel()
            self.tx_table.delete(row_id)
            self.tx_tasks.pop(row_id, None)

if __name__ == "__main__":
    root = tk.Tk()
    app = CANApp(root)
    root.mainloop()
