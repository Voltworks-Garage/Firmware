import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import can
import threading
import time

class CANApp:
    def __init__(self, root):
        self.root = root
        self.root.title("PCAN Tool")
        self.bus = None
        self.running = False
        self.rx_table_data = {}
        self.tx_tasks = {}
        self.console_rx_enabled = tk.BooleanVar(value=False)
        self.available_channels = []

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
        ttk.Button(control_frame, text="Clear RX Table", command=lambda: self.rx_table.delete(*self.rx_table.get_children())).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(control_frame, text="Log RX to Console", variable=self.console_rx_enabled).pack(side=tk.LEFT, padx=5)

        paned = ttk.PanedWindow(self.root, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)

        console_frame = ttk.Frame(paned)
        ttk.Label(console_frame, text="Console Log").pack(anchor=tk.W)
        self.console = scrolledtext.ScrolledText(console_frame, wrap=tk.WORD, height=10)
        self.console.pack(fill=tk.BOTH, expand=True)
        paned.add(console_frame, weight=1)

        table_frame = ttk.Frame(paned)
        ttk.Label(table_frame, text="Live RX Messages").pack(anchor=tk.W)
        self.rx_table = ttk.Treeview(table_frame, columns=("ID", "DLC", "Data", "Count", "Cycle"), show="headings")
        for col, w in [("ID", 80), ("DLC", 50), ("Data", 300), ("Count", 60), ("Cycle", 100)]:
            self.rx_table.heading(col, text=col)
            self.rx_table.column(col, width=w)
        self.rx_table.pack(fill=tk.BOTH, expand=True)
        paned.add(table_frame, weight=2)

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
        now = time.time()
        msg_id = msg.arbitration_id if not msg.is_error_frame else 0xFFFFFFFF
        msg_hex_id = f"{msg_id:X}" if not msg.is_error_frame else "ERROR"
        dlc = msg.dlc if not msg.is_error_frame else "ERR"
        data_str = " ".join(f"{b:02X}" for b in msg.data) if not msg.is_error_frame else "<Error Frame>"

        if self.console_rx_enabled.get():
            self.log("⚠️  ERROR FRAME received." if msg.is_error_frame else f"⬇️  RX ID: 0x{msg_hex_id}  DLC: {dlc}  Data: {data_str}")

        prev = self.rx_table_data.get(msg_id, {})
        count = prev.get("count", 0) + 1
        last_time = prev.get("last_time")
        cycle_str = f"{(now - last_time) * 1000:.1f} ms" if last_time else "-"

        if "item_id" in prev:
            self.rx_table.item(prev["item_id"], values=(msg_hex_id, dlc, data_str, count, cycle_str))
        else:
            item_id = self.rx_table.insert("", tk.END, values=(msg_hex_id, dlc, data_str, count, cycle_str))
            prev["item_id"] = item_id

        self.rx_table_data[msg_id] = {"item_id": prev["item_id"], "count": count, "last_time": now}

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
