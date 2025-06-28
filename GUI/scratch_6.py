import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import can
import threading
import time

class CANApp:
    def __init__(self, root):
        self.root = root
        self.root.title("PCAN Interface")
        self.root.geometry("1000x650")

        self.bus = None
        self.running = False
        self.receive_thread = None
        self.rx_table_data = {}
        self.console_rx_enabled = tk.BooleanVar(value=False)  # default: OFF

        self.create_widgets()

    def create_widgets(self):

        # Use PanedWindow for resizable console + RX table
        paned = ttk.PanedWindow(self.root, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)

        # RX Table Frame (left side)
        table_frame = ttk.Frame(paned)
        ttk.Label(table_frame, text="Live RX Messages").pack(anchor=tk.W)

        self.rx_table = ttk.Treeview(table_frame, columns=("ID", "DLC", "Data", "Count", "Cycle"), show="headings")
        self.rx_table.heading("ID", text="ID")
        self.rx_table.heading("DLC", text="DLC")
        self.rx_table.heading("Data", text="Data")
        self.rx_table.heading("Count", text="Count")
        self.rx_table.heading("Cycle", text="Cycle")

        self.rx_table.column("ID", width=50)
        self.rx_table.column("DLC", width=20)
        self.rx_table.column("Data", width=200)
        self.rx_table.column("Count", width=50)
        self.rx_table.column("Cycle", width=50)

        self.rx_table.pack(fill=tk.BOTH, expand=True)
        paned.add(table_frame, weight=1)  # left pane (larger by default)

        # Console Frame (right side)
        console_frame = ttk.Frame(paned)
        ttk.Label(console_frame, text="Console Log").pack(anchor=tk.W)
        self.console = scrolledtext.ScrolledText(console_frame, wrap=tk.WORD, height=10)
        self.console.pack(fill=tk.BOTH, expand=True)
        paned.add(console_frame, weight=2)  # right pane

        # TX Message Table Frame
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

        # Treeview for TX rows
        self.tx_table = ttk.Treeview(tx_frame, columns=("ID", "Data", "Cycle", "Status", "Control"), show="headings",
                                     height=5)
        for col, w in [("ID", 50), ("Data", 200), ("Cycle", 50), ("Status", 50), ("Control", 50)]:
            self.tx_table.heading(col, text=col)
            self.tx_table.column(col, width=w)

        self.tx_table.grid(row=1, column=0, columnspan=7, sticky="nsew", padx=5, pady=5)

        ttk.Button(tx_frame, text="Delete Selected", command=self.delete_selected_tx).grid(
            row=2, column=0, columnspan=7, sticky="e", padx=5, pady=(0, 5)
        )

        # Store tasks and timers per row
        self.tx_tasks = {}

        self.tx_table.bind("<Button-1>", self.handle_tx_click)

        # Table + Console clear buttons
        button_frame = ttk.Frame(self.root)
        button_frame.pack(fill=tk.X, padx=10)
        ttk.Button(button_frame, text="Clear Table", command=self.clear_table).pack(side=tk.RIGHT, padx=5)
        ttk.Button(button_frame, text="Clear Console", command=self.clear_console).pack(side=tk.RIGHT)
        ttk.Checkbutton(button_frame, text="Log RX to Console", variable=self.console_rx_enabled).pack(side=tk.LEFT,
                                                                                                       padx=5)

        # CAN connection controls
        control_frame = ttk.Frame(self.root)
        control_frame.pack(fill=tk.X, padx=10, pady=5)

        ttk.Label(control_frame, text="Channel:").grid(row=0, column=0, padx=5, pady=5)
        self.channel_var = tk.StringVar()
        self.channel_dropdown = ttk.Combobox(control_frame, textvariable=self.channel_var, state="readonly")
        self.channel_dropdown['values'] = ["PCAN_USBBUS1", "PCAN_USBBUS2", "PCAN_USBBUS3"]
        self.channel_dropdown.current(0)
        self.channel_dropdown.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(control_frame, text="Baudrate:").grid(row=0, column=2, padx=5, pady=5)
        self.baud_var = tk.StringVar()
        self.baud_dropdown = ttk.Combobox(control_frame, textvariable=self.baud_var, state="readonly")
        self.baud_dropdown['values'] = ["1M", "500k", "250k", "125k", "100k", "50k", "20k", "10k"]
        self.baud_dropdown.current(1)
        self.baud_dropdown.grid(row=0, column=3, padx=5, pady=5)

        self.connect_button = ttk.Button(control_frame, text="Connect", command=self.connect)
        self.connect_button.grid(row=0, column=4, padx=5, pady=5)

        self.disconnect_button = ttk.Button(control_frame, text="Disconnect", command=self.disconnect, state=tk.DISABLED)
        self.disconnect_button.grid(row=0, column=5, padx=5, pady=5)

        # CAN message sender
        send_frame = ttk.LabelFrame(self.root, text="Send CAN Message")
        send_frame.pack(fill=tk.X, padx=10, pady=5)

        ttk.Label(send_frame, text="ID (hex):").grid(row=0, column=0, padx=5, pady=5)
        self.send_id_var = tk.StringVar()
        self.send_id_entry = ttk.Entry(send_frame, textvariable=self.send_id_var, width=10)
        self.send_id_entry.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(send_frame, text="Data (hex bytes):").grid(row=0, column=2, padx=5, pady=5)
        self.send_data_var = tk.StringVar()
        self.send_data_entry = ttk.Entry(send_frame, textvariable=self.send_data_var, width=50)
        self.send_data_entry.grid(row=0, column=3, padx=5, pady=5)

        self.send_button = ttk.Button(send_frame, text="Send", command=self.send_message, state=tk.DISABLED)
        self.send_button.grid(row=0, column=4, padx=5, pady=5)

    def log(self, text):
        self.console.insert(tk.END, text + "\n")
        self.console.see(tk.END)

    def clear_console(self):
        self.console.delete('1.0', tk.END)

    def clear_table(self):
        for item in self.rx_table.get_children():
            self.rx_table.delete(item)
        self.rx_table_data.clear()

    def baudrate_to_bitrate(self, baud_str):
        mapping = {
            "1M": 1000000,
            "500k": 500000,
            "250k": 250000,
            "125k": 125000,
            "100k": 100000,
            "50k": 50000,
            "20k": 20000,
            "10k": 10000
        }
        return mapping.get(baud_str)

    def connect(self):
        channel = self.channel_var.get()
        baud = self.baud_var.get()
        bitrate = self.baudrate_to_bitrate(baud)

        if not channel or not bitrate:
            messagebox.showwarning("Missing Info", "Please select both channel and baudrate.")
            return

        self.log(f"Attempting to connect to {channel} at {baud}...")

        try:
            self.bus = can.interface.Bus(channel=channel, bustype='pcan', bitrate=bitrate)
            self.log("✅ Connection successful.")
            self.connect_button.config(state=tk.DISABLED)
            self.disconnect_button.config(state=tk.NORMAL)
            self.send_button.config(state=tk.NORMAL)
            self.running = True
            self.receive_thread = threading.Thread(target=self.receive_loop, daemon=True)
            self.receive_thread.start()
        except Exception as e:
            self.log(f"❌ Failed to connect: {e}")

    def disconnect(self):
        self.running = False
        # Stop all active TX tasks
        for task in self.tx_tasks.values():
            task["running"] = False
            if task.get("timer"):
                task["timer"].cancel()
                task["timer"] = None
        for row_id in self.tx_tasks:
            self.tx_table.item(row_id, values=(
                self.tx_tasks[row_id]["id"],
                self.tx_tasks[row_id]["data"],
                self.tx_tasks[row_id]["cycle"],
                "Stopped",
                "Start"
            ))
        if self.bus:
            try:
                self.bus.shutdown()
                self.log("🔌 Disconnected successfully.")
            except Exception as e:
                self.log(f"⚠️ Error during disconnect: {e}")
            finally:
                self.bus = None
                self.connect_button.config(state=tk.NORMAL)
                self.disconnect_button.config(state=tk.DISABLED)
                self.send_button.config(state=tk.DISABLED)

    def receive_loop(self):
        while self.running:
            try:
                msg = self.bus.recv(timeout=1)
                if msg:
                    self.root.after(0, self.handle_rx_message, msg)
            except Exception as e:
                self.log(f"❌ Receive error: {e}")
                break

    def handle_rx_message(self, msg):
        now = time.time()

        if msg.is_error_frame:
            msg_id = 0xFFFFFFFF  # unique ID for error frames
            msg_hex_id = "ERROR"
            dlc = "ERR"
            data_str = "<Error Frame>"
        else:
            msg_id = msg.arbitration_id
            msg_hex_id = f"{msg_id:X}"
            dlc = msg.dlc
            data_str = " ".join(f"{b:02X}" for b in msg.data)

        # Log to console
        if self.console_rx_enabled.get():
            if msg.is_error_frame:
                self.log("⚠️  ERROR FRAME received.")
            else:
                self.log(f"⬇️  RX ID: 0x{msg_hex_id}  DLC: {dlc}  Data: {data_str}")

        # Lookup or initialize data
        prev = self.rx_table_data.get(msg_id, {})
        count = prev.get("count", 0) + 1
        last_time = prev.get("last_time", None)

        if last_time is not None:
            cycle_ms = (now - last_time) * 1000
            cycle_str = f"{cycle_ms:.1f} ms"
        else:
            cycle_str = "-"

        # Update or insert in the table
        if "item_id" in prev:
            self.rx_table.item(prev["item_id"], values=(msg_hex_id, dlc, data_str, count, cycle_str))
        else:
            item_id = self.rx_table.insert("", tk.END, values=(msg_hex_id, dlc, data_str, count, cycle_str))
            prev["item_id"] = item_id

        # Save state
        self.rx_table_data[msg_id] = {
            "item_id": prev["item_id"],
            "count": count,
            "last_time": now
        }

    def send_message(self):
        if not self.bus:
            messagebox.showwarning("Not Connected", "Connect to a CAN bus first.")
            return

        try:
            msg_id = int(self.send_id_var.get(), 16)
            data_str = self.send_data_var.get().strip().split()
            data = bytes(int(b, 16) for b in data_str)
            msg = can.Message(arbitration_id=msg_id, data=data, is_extended_id=False)
            self.bus.send(msg)
            self.log(f"⬆️  TX ID: 0x{msg.arbitration_id:X}  Data: {' '.join(format(b, '02X') for b in data)}")
        except ValueError:
            messagebox.showerror("Invalid Input", "Ensure ID is hex (e.g., 123) and data is space-separated hex bytes (e.g., AA BB CC).")
        except can.CanError as e:
            self.log(f"❌ Send error: {e}")

    def add_tx_row(self):
        tx_id = self.tx_id_var.get().strip()
        tx_data = self.tx_data_var.get().strip()
        tx_cycle = self.tx_cycle_var.get().strip()

        if not tx_id or not tx_data:
            messagebox.showerror("Missing Info", "ID and Data are required.")
            return

        try:
            int(tx_id, 16)
            bytes(int(b, 16) for b in tx_data.split())
            int(tx_cycle)
        except ValueError:
            messagebox.showerror("Invalid Format", "Check hex formatting and cycle time.")
            return

        item_id = self.tx_table.insert("", tk.END, values=(tx_id, tx_data, tx_cycle, "Stopped", "Start"))

        # Store TX task state
        self.tx_tasks[item_id] = {
            "id": tx_id,
            "data": tx_data,
            "cycle": int(tx_cycle),
            "running": False,
            "timer": None
        }

        # Bind click for Start/Stop toggle
        self.tx_table.tag_bind(item_id, sequence="<Button-1>",
                               callback=lambda e, iid=item_id: self.handle_tx_click(iid))

    def send_tx_row(self, row_id):
        values = self.tx_table.item(row_id)["values"]
        tx_id, tx_data, tx_cycle, _ = values

        try:
            msg_id = int(tx_id, 16)
            data = bytes(int(b, 16) for b in tx_data.split())
            cycle = int(tx_cycle)
        except ValueError:
            self.log("⚠️ Invalid TX row.")
            return

        def send_once():
            if self.bus:
                try:
                    msg = can.Message(arbitration_id=msg_id, data=data, is_extended_id=False)
                    self.bus.send(msg)
                    self.log(f"⬆️  [TX] ID: 0x{msg.arbitration_id:X} Data: {' '.join(format(b, '02X') for b in data)}")
                except Exception as e:
                    self.log(f"❌ TX error: {e}")

        if cycle <= 0:
            send_once()
        else:
            def loop_send():
                if not self.running:
                    return
                send_once()
                # schedule next send
                timer = threading.Timer(cycle / 1000.0, loop_send)
                timer.daemon = True
                timer.start()

            loop_send()

    def handle_tx_click(self, event):
        region = self.tx_table.identify("region", event.x, event.y)
        column = self.tx_table.identify_column(event.x)
        row_id = self.tx_table.identify_row(event.y)

        if region != "cell" or column != "#5" or not row_id:
            return

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
            if not self.running or not task["running"]:
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
                return

            # Schedule again
            task["timer"] = threading.Timer(task["cycle"] / 1000.0, send)
            task["timer"].daemon = True
            task["timer"].start()

        # One-shot
        if task["cycle"] == 0:
            send()
            return

        # Repeating
        task["running"] = True
        self.tx_table.item(row_id, values=(task["id"], task["data"], task["cycle"], "Running", "Stop"))
        send()

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
            # Stop any active timer
            task = self.tx_tasks.get(row_id)
            if task:
                task["running"] = False
                if task.get("timer"):
                    task["timer"].cancel()
            # Remove from tree and dict
            self.tx_table.delete(row_id)
            self.tx_tasks.pop(row_id, None)


if __name__ == "__main__":
    root = tk.Tk()
    app = CANApp(root)
    root.mainloop()
