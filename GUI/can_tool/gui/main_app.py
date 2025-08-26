"""
Main CAN Application
===================

This module provides the main GUI application for the CAN tool.
It handles CAN bus connection, message reception/transmission, and provides
a plugin-based tabbed interface for additional functionality.
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog
import can
import threading
import time
import os
from typing import List, Dict, Any, Optional

# Import core components - handle both relative and absolute imports
try:
    from ..core import CANMessageManager, BusmasterDBFParser
    from ..core.table_view import CANTableView
    from .base_tab import BaseTab
except ImportError:
    from can_tool.core import CANMessageManager, BusmasterDBFParser
    from can_tool.core.table_view import CANTableView
    from can_tool.gui.base_tab import BaseTab


class CANApp:
    """Main CAN application with core functionality and plugin support"""
    
    def __init__(self, root, dbf_path: str, plugins: Optional[List[BaseTab]] = None):
        self.root = root
        self.root.title("PCAN Tool with CAN Decoder")
        self.bus = None
        self.running = False
        self.tx_messages = {}
        self.console_rx_enabled = tk.BooleanVar(value=False)
        self.show_decoded = tk.BooleanVar(value=True)
        self.available_channels = []
        self.plugins = plugins or []
        
        # Initialize components
        self.dbf_parser = BusmasterDBFParser(dbf_path)
        self.message_manager = CANMessageManager(self.dbf_parser)

        # GUI refresh throttling (10Hz = 100ms)
        self.gui_refresh_rate_ms = 100
        self.pending_gui_updates = set()  # Track which messages need GUI updates
        self.gui_update_timer = None
        
        # Bus status monitoring (5Hz = 200ms)
        self.bus_status_timer = None
        self.last_bus_state = None
        
        self.create_widgets()
        self.initialize_plugins()
        
        # Update menu state after plugins are initialized
        if hasattr(self, 'isotp_enabled_var'):
            self.update_isotp_menu_state()

    def initialize_plugins(self):
        """Initialize all plugins"""
        for plugin in self.plugins:
            try:
                plugin.initialize()
            except Exception as e:
                print(f"Error initializing plugin {plugin.tab_name}: {e}")

    def create_widgets(self):
        """Create the main application widgets"""
        # Create menu bar
        self.create_menu_bar()
        
        # Control frame
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
        ttk.Button(control_frame, text="Wake Bus", command=self.send_wake_message).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Clear Console", command=lambda: self.console.delete("1.0", tk.END)).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Clear RX Table", command=self.clear_rx_table).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(control_frame, text="Log RX to Console", variable=self.console_rx_enabled).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(control_frame, text="Show Decoded", variable=self.show_decoded, command=self.toggle_decoded_view).pack(side=tk.LEFT, padx=5)

        # Main horizontal paned window (left panel + console)
        main_paned = ttk.PanedWindow(self.root, orient=tk.HORIZONTAL)
        main_paned.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)

        # Left panel - vertical paned window for RX and TX
        left_paned = ttk.PanedWindow(main_paned, orient=tk.VERTICAL)
        main_paned.add(left_paned, weight=2)

        # RX Messages frame
        rx_frame = ttk.LabelFrame(left_paned, text="Received Messages")
        left_paned.add(rx_frame, weight=1)

        # Create table view
        self.table_view = CANTableView(rx_frame, self.message_manager)
        self.table_view.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # TX Messages frame with tabbed interface
        tx_frame = ttk.LabelFrame(left_paned, text="Message Transmission")
        left_paned.add(tx_frame, weight=1)
        
        # Create notebook for tabs
        self.tx_notebook = ttk.Notebook(tx_frame)
        self.tx_notebook.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Create TX tabs
        self.create_tx_tabs()

        # Console frame
        console_frame = ttk.LabelFrame(main_paned, text="Console")
        main_paned.add(console_frame, weight=1)

        self.console = scrolledtext.ScrolledText(console_frame, wrap=tk.WORD, height=15)
        self.console.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # Scan devices at startup
        self.scan_devices()

    def create_menu_bar(self):
        """Create the menu bar with File menu"""
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        # File menu
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        
        # DBF submenu
        file_menu.add_command(label="Load DBF File...", command=self.load_dbf_file)
        file_menu.add_separator()
        
        # Plugin submenu
        plugin_menu = tk.Menu(file_menu, tearoff=0)
        file_menu.add_cascade(label="Plugins", menu=plugin_menu)
        
        # ISO-TP plugin toggle
        self.isotp_enabled_var = tk.BooleanVar()
        self.update_isotp_menu_state()
        plugin_menu.add_checkbutton(
            label="ISO-TP Plugin", 
            variable=self.isotp_enabled_var,
            command=self.toggle_isotp_plugin
        )
        
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.root.quit)
        
        # Help menu
        help_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="About", command=self.show_about)

    def load_dbf_file(self):
        """Load a new DBF file"""
        filename = filedialog.askopenfilename(
            title="Select DBF File",
            filetypes=[
                ("DBF files", "*.dbf"),
                ("All files", "*.*")
            ],
            initialdir=os.path.dirname(self.dbf_parser.dbf_path) if hasattr(self.dbf_parser, 'dbf_path') and self.dbf_parser.dbf_path else "."
        )
        
        if filename:
            try:
                # Create new DBF parser with selected file
                new_dbf_parser = BusmasterDBFParser(filename)
                
                # Update the parser and message manager
                self.dbf_parser = new_dbf_parser
                self.message_manager = CANMessageManager(self.dbf_parser)
                
                # Clear existing messages
                self.clear_rx_table()
                
                # Log the change
                self.log(f"📁 Loaded DBF file: {os.path.basename(filename)}")
                self.log(f"   Found {len(self.dbf_parser.messages)} message definitions")
                
                messagebox.showinfo("DBF Loaded", f"Successfully loaded {os.path.basename(filename)}\nFound {len(self.dbf_parser.messages)} message definitions")
                
                # Notify all plugins about DBF file change
                for plugin in self.plugins:
                    if hasattr(plugin, 'on_dbf_file_changed'):
                        try:
                            plugin.on_dbf_file_changed()
                        except Exception as plugin_error:
                            self.log(f"⚠️  Plugin {plugin.tab_name} error on DBF change: {plugin_error}")
                
            except Exception as e:
                error_msg = f"Failed to load DBF file: {e}"
                self.log(f"❌ {error_msg}")
                messagebox.showerror("Error Loading DBF", error_msg)

    def update_isotp_menu_state(self):
        """Update the ISO-TP menu checkbox state based on current plugins"""
        # Check if ISO-TP plugin is currently loaded
        isotp_loaded = any(plugin.tab_name == "ISO-TP" for plugin in self.plugins)
        self.isotp_enabled_var.set(isotp_loaded)

    def toggle_isotp_plugin(self):
        """Toggle the ISO-TP plugin on/off"""
        is_enabled = self.isotp_enabled_var.get()
        
        if is_enabled:
            # Load ISO-TP plugin
            try:
                # Import the plugin class
                try:
                    from ..plugins.isotp_tab import ISOTPTab
                except ImportError:
                    from can_tool.plugins.isotp_tab import ISOTPTab
                
                # Check if it's already loaded
                if not any(plugin.tab_name == "ISO-TP" for plugin in self.plugins):
                    # Create and initialize the plugin
                    isotp_plugin = ISOTPTab(self.tx_notebook, self)
                    isotp_plugin.initialize()
                    self.plugins.append(isotp_plugin)
                    
                    self.log("🔌 ISO-TP plugin loaded")
                    messagebox.showinfo("Plugin Loaded", "ISO-TP plugin has been loaded successfully")
                
            except Exception as e:
                error_msg = f"Failed to load ISO-TP plugin: {e}"
                self.log(f"❌ {error_msg}")
                messagebox.showerror("Plugin Error", error_msg)
                self.isotp_enabled_var.set(False)  # Reset checkbox
                
        else:
            # Unload ISO-TP plugin
            try:
                # Find and remove the ISO-TP plugin
                isotp_plugins = [p for p in self.plugins if p.tab_name == "ISO-TP"]
                
                for plugin in isotp_plugins:
                    try:
                        plugin.cleanup()
                        plugin.disable()
                        self.plugins.remove(plugin)
                    except Exception as e:
                        print(f"Error cleaning up plugin: {e}")
                
                self.log("🔌 ISO-TP plugin unloaded")
                messagebox.showinfo("Plugin Unloaded", "ISO-TP plugin has been unloaded")
                
            except Exception as e:
                error_msg = f"Failed to unload ISO-TP plugin: {e}"
                self.log(f"❌ {error_msg}")
                messagebox.showerror("Plugin Error", error_msg)

    def show_about(self):
        """Show about dialog"""
        about_text = """CAN Tool - Modular CAN Bus Analysis

Version: 1.0.0
Author: Voltworks Garage

Features:
• Real-time CAN message capture and display
• DBF file parsing and signal decoding  
• Message transmission scheduling
• Extensible plugin system
• Cross-platform support

Core Components:
• CAN message processing
• DBF parser for signal definitions
• Configurable plugin system

Plugins:
• ISO-TP communication (optional)
"""
        messagebox.showinfo("About CAN Tool", about_text)

    def create_tx_tabs(self):
        """Create the tabbed interface for message transmission"""
        # Tab 1: CAN Messages (core functionality)
        self.tx_can_frame = ttk.Frame(self.tx_notebook)
        self.tx_notebook.add(self.tx_can_frame, text="CAN Messages")
        
        # Set up the TX functionality in the CAN Messages tab
        self.tx_main_frame = self.tx_can_frame  # Point to CAN tab for compatibility
        self.create_tx_section()

    def create_tx_section(self):
        """Create the TX message transmission section"""
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
        header_frame.pack(fill=tk.X, padx=5, pady=(0,2))
        header_frame.grid_columnconfigure(3, weight=1)  # Data column should stretch

        ttk.Label(header_frame, text="▼", anchor="center", relief="solid", borderwidth=1, width=5).grid(row=0, column=0, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="ID", anchor="center", relief="solid", borderwidth=1, width=10).grid(row=0, column=1, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Name", anchor="center", relief="solid", borderwidth=1, width=18).grid(row=0, column=2, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Data", anchor="center", relief="solid", borderwidth=1, width=35).grid(row=0, column=3, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Cycle", anchor="center", relief="solid", borderwidth=1, width=10).grid(row=0, column=4, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Status", anchor="center", relief="solid", borderwidth=1, width=11).grid(row=0, column=5, sticky="ew", padx=1, ipady=2)
        ttk.Label(header_frame, text="Actions", anchor="center", relief="solid", borderwidth=1, width=20).grid(row=0, column=6, sticky="ew", padx=(5, 25), ipady=2)  # Scrollbar compensation

        # TX messages container with scrolling
        self.tx_canvas = tk.Canvas(tx_frame, height=200, bg="white")
        self.tx_scrollbar = ttk.Scrollbar(tx_frame, orient="vertical", command=self.tx_canvas.yview)
        self.tx_scroll_frame = ttk.Frame(self.tx_canvas)

        self.tx_scroll_frame.bind("<Configure>", lambda e: self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all")))
        self.tx_canvas_window = self.tx_canvas.create_window((0, 0), window=self.tx_scroll_frame, anchor="nw")
        self.tx_canvas.configure(yscrollcommand=self.tx_scrollbar.set)
        
        # Configure the scroll frame to stretch with canvas width
        def configure_scroll_frame(event):
            # Update the scroll frame width to match canvas width
            canvas_width = event.width
            self.tx_canvas.itemconfig(self.tx_canvas_window, width=canvas_width)
        
        self.tx_canvas.bind("<Configure>", configure_scroll_frame)

        self.tx_canvas.pack(side="left", fill="both", expand=True, padx=5, pady=5)
        self.tx_scrollbar.pack(side="right", fill="y", pady=5)

        # Enable mouse wheel scrolling
        def on_mousewheel(event):
            self.tx_canvas.yview_scroll(int(-1*(event.delta/120)), "units")

        # Store the mousewheel function for use by TX message rows
        self.on_mousewheel = on_mousewheel

        self.bind_mousewheel_to_widget(self.tx_scroll_frame)
        self.tx_canvas.bind("<MouseWheel>", on_mousewheel)
    
    def bind_mousewheel_to_widget(self, widget):
        """Bind mouse wheel scrolling to a widget and all its children"""
        if hasattr(self, 'on_mousewheel'):
            widget.bind("<MouseWheel>", self.on_mousewheel)
            for child in widget.winfo_children():
                self.bind_mousewheel_to_widget(child)

    def scan_devices(self):
        """Scan for available PCAN devices"""
        def scan_in_thread(scan_btn):
            try:
                scan_btn.config(text="Scanning...", state="disabled")
                channels = []
                for i in range(1, 17):  # PCAN_USBBUS1 to PCAN_USBBUS16
                    try:
                        channel = f"PCAN_USBBUS{i}"
                        # Try to get channel status
                        temp_bus = can.interface.Bus(channel=channel, bustype='pcan', bitrate=500000, receive_own_messages=False)
                        temp_bus.shutdown()
                        channels.append(channel)
                    except:
                        pass
                self.root.after(0, lambda: self._scan_complete(channels, scan_btn))
            except Exception as e:
                self.root.after(0, lambda: self._scan_error(str(e), scan_btn))

        scan_btn = None
        for widget in self.root.winfo_children():
            if isinstance(widget, ttk.Frame):
                for child in widget.winfo_children():
                    if isinstance(child, ttk.Button) and child.cget("text") == "Scan Devices":
                        scan_btn = child
                        break
        
        if scan_btn:
            thread = threading.Thread(target=scan_in_thread, args=(scan_btn,), daemon=True)
            thread.start()

    def _scan_complete(self, channels, scan_btn):
        """Called when device scan completes"""
        self.available_channels = channels
        self.device_combo.config(values=channels)
        if channels:
            self.device_combo.set(channels[0])
            self.log(f"✅ Found {len(channels)} PCAN device(s): {', '.join(channels)}")
        else:
            self.log("⚠️  No PCAN devices found.")
        if scan_btn:
            scan_btn.config(text="Scan Devices", state="normal")
    
    def _scan_error(self, error_msg, scan_btn):
        """Called when scan encounters an error"""
        self.log(f"❌ Error scanning devices: {error_msg}")
        if scan_btn:
            scan_btn.config(text="Scan Devices", state="normal")

    def toggle_decoded_view(self):
        """Toggle the decoded signal display"""
        # Force refresh of all displayed messages
        for msg_id in self.message_manager.messages:
            self.pending_gui_updates.add(msg_id)
        self._schedule_gui_update()

    def connect(self):
        """Connect to CAN bus"""
        channel = self.device_var.get()
        baud = self.baud_var.get()

        if not channel:
            messagebox.showerror("No Device", "Please select a device from the list.")
            return

        try:
            self.bus = can.interface.Bus(channel=channel, bustype='pcan', bitrate=int(baud))
            self.running = True
            
            # Set bitrate for bus utilization calculations
            self.message_manager.set_bitrate(int(baud))
            
            self.rx_thread = threading.Thread(target=self.read_messages, daemon=True)
            self.rx_thread.start()
            self.log(f"✅ Connected to {channel} at {baud} bps.")
            
            # Start bus status monitoring
            self._start_bus_status_monitoring()
            
            # Notify plugins of connection
            for plugin in self.plugins:
                try:
                    plugin.on_can_connected()
                except Exception as e:
                    print(f"Error notifying plugin {plugin.tab_name} of connection: {e}")
                    
        except Exception as e:
            self.log(f"❌ Connection failed: {e}")

    def disconnect(self):
        """Disconnect from CAN bus"""
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
        
        # Stop bus status monitoring
        self._stop_bus_status_monitoring()

        # Stop all TX messages
        for msg_id in list(self.tx_messages.keys()):
            self.stop_tx_message(msg_id)
            
        # Notify plugins of disconnection
        for plugin in self.plugins:
            try:
                plugin.on_can_disconnected()
            except Exception as e:
                print(f"Error notifying plugin {plugin.tab_name} of disconnection: {e}")

    def read_messages(self):
        """Read CAN messages in a separate thread"""
        message_batch = []
        last_batch_time = time.time()
        
        while self.running and self.bus:
            try:
                # Read messages with very short timeout to prevent buffer overflow
                msg = self.bus.recv(0.001)  # 1ms timeout
                if msg:
                    message_batch.append(msg)
                    
                # Process batch when we have messages and either:
                # - batch is full (10 messages), or 
                # - 10ms have passed since last batch
                current_time = time.time()
                if message_batch and (len(message_batch) >= 10 or 
                                    (current_time - last_batch_time) >= 0.01):
                    # Send batch to GUI thread
                    self.root.after_idle(self.handle_rx_message_batch, message_batch.copy())
                    message_batch.clear()
                    last_batch_time = current_time
                    
            except Exception as e:
                error_msg = f"❌ RX error: {e}"
                self.root.after(0, lambda msg=error_msg: self.log(msg))

    def handle_rx_message(self, msg):
        """Handle received CAN message"""
        if msg.is_error_frame:
            if self.console_rx_enabled.get():
                self.log("⚠️  ERROR FRAME received.")
            return

        msg_id = msg.arbitration_id
        
        # Notify plugins of received message
        for plugin in self.plugins:
            try:
                plugin.on_can_message_received(msg)
            except Exception as e:
                print(f"Error notifying plugin {plugin.tab_name} of message: {e}")
        
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
    
    def handle_rx_message_batch(self, messages):
        """Handle a batch of received CAN messages for better performance"""
        for msg in messages:
            self.handle_rx_message(msg)
    
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
        """Clear all received messages"""
        self.message_manager.clear_all()
        self.table_view.clear_all()

    def log(self, message):
        """Log a message to the console"""
        self.console.insert(tk.END, message + "\n")
        self.console.see(tk.END)

    # TX Message functionality (simplified for this demo)
    def add_tx_row(self):
        """Add a basic TX message row"""
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
        
        # Center the dialog
        dialog.update_idletasks()
        x = (dialog.winfo_screenwidth() // 2) - (dialog.winfo_width() // 2)
        y = (dialog.winfo_screenheight() // 2) - (dialog.winfo_height() // 2)
        dialog.geometry(f"+{x}+{y}")
        
        # Create listbox with scrollbar
        list_frame = ttk.Frame(dialog)
        list_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        scrollbar = ttk.Scrollbar(list_frame)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        
        listbox = tk.Listbox(list_frame, yscrollcommand=scrollbar.set)
        listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.config(command=listbox.yview)
        
        # Populate listbox with messages
        for msg_id, msg_info in sorted(self.dbf_parser.messages.items()):
            listbox.insert(tk.END, f"0x{msg_id:03X} - {msg_info['name']} (DLC: {msg_info['dlc']})")
        
        # Button frame
        btn_frame = ttk.Frame(dialog)
        btn_frame.pack(fill=tk.X, padx=10, pady=(0, 10))
        
        def on_select():
            selection = listbox.curselection()
            if selection:
                # Get selected message info
                idx = selection[0]
                msg_id = sorted(self.dbf_parser.messages.keys())[idx]
                msg_info = self.dbf_parser.messages[msg_id]
                
                # Create DBF-based TX message row
                self._create_dbf_message_row(msg_id, msg_info)
                dialog.destroy()
            else:
                messagebox.showwarning("No Selection", "Please select a message.")
        
        ttk.Button(btn_frame, text="Add Message", command=on_select).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="Cancel", command=dialog.destroy).pack(side=tk.LEFT, padx=5)
        
        # Bind double-click to select
        listbox.bind("<Double-Button-1>", lambda e: on_select())
    
    def stop_tx_message(self, msg_id):
        """Stop a TX message"""
        if msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[msg_id]
        
        if not msg_info["running"]:
            return  # Already stopped
        
        # Stop the timer if it exists
        if msg_info["timer"]:
            self.root.after_cancel(msg_info["timer"])
            msg_info["timer"] = None
        
        # Update state
        msg_info["running"] = False
        
        # Update UI
        msg_info["widgets"]["status"].config(text="Stopped", foreground="red")
        msg_info["widgets"]["start_btn"].config(state="normal")
        msg_info["widgets"]["stop_btn"].config(state="disabled")
        
        self.log(f"⏹️ Stopped TX message: {msg_id}")
    
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
        
        def send_message():
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
                
                # Schedule next transmission
                if tx_cycle > 0 and msg_info["running"]:
                    msg_info["timer"] = self.root.after(tx_cycle, send_message)
                else:
                    # One-shot message - stop after sending
                    self.stop_tx_message(msg_id)
                    
            except Exception as e:
                self.log(f"❌ TX Error: {e}")
                self.stop_tx_message(msg_id)
        
        # Start sending
        send_message()
    
    def delete_tx_message(self, msg_id):
        """Delete a TX message"""
        if msg_id not in self.tx_messages:
            return
        
        # Stop the message first
        self.stop_tx_message(msg_id)
        
        # Remove the UI elements
        msg_info = self.tx_messages[msg_id]
        msg_info["widgets"]["frame"].destroy()
        
        # Remove from tracking
        del self.tx_messages[msg_id]
        
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))
        
        self.log(f"🗑️ Deleted TX message: {msg_id}")
    
    def _toggle_signal_expansion(self, tx_msg_id, expand_var):
        """Toggle signal expansion for a DBF message"""
        if tx_msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[tx_msg_id]
        if msg_info["type"] != "dbf":
            return
            
        # Toggle expansion state
        msg_info["expanded"] = not msg_info["expanded"]
        expand_var.set(msg_info["expanded"])
        
        # Update button text
        expand_btn = msg_info["widgets"]["expand_btn"]
        expand_btn.config(text="▲" if msg_info["expanded"] else "▼")
        
        if msg_info["expanded"]:
            self._create_signal_widgets(tx_msg_id)
        else:
            self._destroy_signal_widgets(tx_msg_id)
            
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))
    
    def _create_signal_widgets(self, tx_msg_id):
        """Create signal input widgets for a DBF message"""
        msg_info = self.tx_messages[tx_msg_id]
        msg_id = msg_info["msg_id"]
        
        # Get signal definitions from DBF parser
        if msg_id not in self.dbf_parser.messages:
            return
            
        signals = self.dbf_parser.messages[msg_id]["signals"]
        if not signals:
            return
            
        # Create signal expansion frame
        signal_frame = ttk.Frame(msg_info["widgets"]["frame"])
        signal_frame.grid(row=1, column=0, columnspan=7, sticky="ew", padx=20, pady=2)
        signal_frame.grid_columnconfigure(1, weight=1)
        
        msg_info["signal_widgets"]["signal_frame"] = signal_frame
        
        # Create signal input widgets
        for i, signal in enumerate(signals):
            signal_name = signal['name']
            
            # Signal name label
            name_label = ttk.Label(signal_frame, text=f"{signal_name}:", width=20, anchor="w")
            name_label.grid(row=i, column=0, sticky="w", padx=(5, 10), pady=1)
            
            # Signal value input
            if signal['type'] == 'B':  # Boolean signal
                var = tk.BooleanVar()
                widget = ttk.Checkbutton(signal_frame, variable=var)
                widget.grid(row=i, column=1, sticky="w", padx=5, pady=1)
            else:  # Numeric signal
                var = tk.StringVar(value="0")
                widget = ttk.Entry(signal_frame, textvariable=var, width=12)
                widget.grid(row=i, column=1, sticky="w", padx=5, pady=1)
                
                # Add validation for numeric ranges
                widget.bind('<KeyRelease>', lambda e, s=signal, v=var: self._validate_signal_value(s, v))
            
            # Signal unit label
            unit_text = signal.get('unit', '')
            if unit_text:
                unit_label = ttk.Label(signal_frame, text=unit_text, width=8, anchor="w")
                unit_label.grid(row=i, column=2, sticky="w", padx=5, pady=1)
            
            # Store signal widgets and variables
            msg_info["signal_widgets"][signal_name] = {
                "name_label": name_label,
                "value_widget": widget,
                "value_var": var,
                "signal_def": signal
            }
            msg_info["signal_values"][signal_name] = var
            
            # Bind value changes to update the data field
            if signal['type'] == 'B':
                var.trace('w', lambda *args, t=tx_msg_id: self._update_data_from_signals(t))
            else:
                var.trace('w', lambda *args, t=tx_msg_id: self._update_data_from_signals(t))
    
    def _destroy_signal_widgets(self, tx_msg_id):
        """Remove signal input widgets for a DBF message"""
        msg_info = self.tx_messages[tx_msg_id]
        
        # Destroy signal frame and all child widgets
        if "signal_frame" in msg_info["signal_widgets"]:
            msg_info["signal_widgets"]["signal_frame"].destroy()
        
        # Clear signal widget tracking
        msg_info["signal_widgets"].clear()
        msg_info["signal_values"].clear()
    
    def _validate_signal_value(self, signal, var):
        """Validate signal value against min/max constraints"""
        try:
            value = float(var.get())
            
            # Calculate physical min/max from raw min/max
            min_physical = signal['min_val'] * signal['factor'] + signal['offset']
            max_physical = signal['max_val'] * signal['factor'] + signal['offset']
            
            # Clamp to valid range
            if value < min_physical:
                var.set(str(min_physical))
            elif value > max_physical:
                var.set(str(max_physical))
                
        except ValueError:
            # Invalid number - reset to 0
            var.set("0")
    
    def _update_data_from_signals(self, tx_msg_id):
        """Update the data field from signal values"""
        if tx_msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[tx_msg_id]
        if not msg_info["expanded"] or not msg_info["signal_values"]:
            return
            
        msg_id = msg_info["msg_id"]
        
        # Collect signal values
        signal_values = {}
        for signal_name, var in msg_info["signal_values"].items():
            try:
                if isinstance(var, tk.BooleanVar):
                    signal_values[signal_name] = var.get()
                else:
                    signal_values[signal_name] = float(var.get())
            except (ValueError, tk.TclError):
                signal_values[signal_name] = 0
        
        # Encode message from signals
        data_bytes = self.dbf_parser.encode_message_from_signals(msg_id, signal_values)
        
        if data_bytes:
            # Update data field
            data_hex = ' '.join(f'{b:02X}' for b in data_bytes)
            msg_info["widgets"]["data_var"].set(data_hex)
    
    def _create_tx_message_row(self, tx_id="", tx_data="", tx_cycle=""):
        """Create a new TX message row with editable fields"""
        # Generate unique ID for this TX message
        msg_id = f"tx_{len(self.tx_messages)}"
        
        # Create message row frame
        msg_frame = ttk.Frame(self.tx_scroll_frame)
        msg_frame.pack(fill=tk.X, pady=1)
        
        # Configure columns to match header alignment
        msg_frame.grid_columnconfigure(0, weight=0, minsize=25)   # Expand button column (empty for manual)
        msg_frame.grid_columnconfigure(1, weight=0, minsize=65)   # ID column
        msg_frame.grid_columnconfigure(2, weight=0, minsize=120)  # Name column
        msg_frame.grid_columnconfigure(3, weight=1, minsize=100)  # Data column (expandable)
        msg_frame.grid_columnconfigure(4, weight=0, minsize=65)   # Cycle column
        msg_frame.grid_columnconfigure(5, weight=0, minsize=75)   # Status column
        msg_frame.grid_columnconfigure(6, weight=0, minsize=135)  # Actions column
        
        # Empty space for expand button column (manual messages don't expand)
        ttk.Label(msg_frame, text="", width=3).grid(row=0, column=0, sticky="ew", padx=1)
        
        # Create editable widgets for this message
        id_var = tk.StringVar(value=tx_id)
        id_entry = ttk.Entry(msg_frame, textvariable=id_var, justify="center", width=10)
        id_entry.grid(row=0, column=1, sticky="ew", padx=1)
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
        
        # Name field (empty for manual messages since they're not from DBF)
        name_var = tk.StringVar(value="")
        name_label = ttk.Label(msg_frame, text="", anchor="center", relief="sunken")
        name_label.grid(row=0, column=2, sticky="ew", padx=1)
        
        data_var = tk.StringVar(value=tx_data)
        data_entry = ttk.Entry(msg_frame, textvariable=data_var)
        data_entry.grid(row=0, column=3, sticky="ew", padx=1)
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
        cycle_entry.grid(row=0, column=4, sticky="ew", padx=1)
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
        status_label.grid(row=0, column=5, sticky="ew", padx=1)
        
        # Create button frame for start/stop/delete
        button_frame = ttk.Frame(msg_frame)
        button_frame.grid(row=0, column=6, sticky="ew", padx=1)
        
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
            "type": "manual",
            "widgets": {
                "frame": msg_frame,
                "id_var": id_var,
                "name_var": name_var,
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
    
    def _create_dbf_message_row(self, msg_id, msg_info):
        """Create a DBF-based TX message row"""
        # Generate unique ID for this TX message
        tx_msg_id = f"dbf_{msg_id:03X}_{len(self.tx_messages)}"
        
        # Create message row frame
        msg_frame = ttk.Frame(self.tx_scroll_frame)
        msg_frame.pack(fill=tk.X, pady=1)
        
        # Configure columns to match header alignment
        msg_frame.grid_columnconfigure(0, weight=0, minsize=25)   # Expand button column
        msg_frame.grid_columnconfigure(1, weight=0, minsize=65)   # ID column
        msg_frame.grid_columnconfigure(2, weight=0, minsize=120)  # Name column
        msg_frame.grid_columnconfigure(3, weight=1, minsize=100)  # Data column (expandable)
        msg_frame.grid_columnconfigure(4, weight=0, minsize=65)   # Cycle column
        msg_frame.grid_columnconfigure(5, weight=0, minsize=75)   # Status column
        msg_frame.grid_columnconfigure(6, weight=0, minsize=135)  # Actions column
        
        # Expand/collapse button for signals (moved to leftmost position)
        expand_var = tk.BooleanVar(value=False)
        expand_btn = ttk.Button(msg_frame, text="▼", width=3, 
                               command=lambda: self._toggle_signal_expansion(tx_msg_id, expand_var))
        expand_btn.grid(row=0, column=0, sticky="ew", padx=1)
        
        # ID field (read-only for DBF messages)
        id_var = tk.StringVar(value=f"{msg_id:03X}")
        id_label = ttk.Label(msg_frame, text=f"0x{msg_id:03X}", anchor="center", relief="sunken")
        id_label.grid(row=0, column=1, sticky="ew", padx=1)
        
        # Message name field
        name_var = tk.StringVar(value=msg_info.get('name', ''))
        name_label = ttk.Label(msg_frame, text=msg_info.get('name', ''), anchor="center", relief="sunken")
        name_label.grid(row=0, column=2, sticky="ew", padx=1)
        
        # Data field (initially zeros)
        data_var = tk.StringVar(value="00 " * msg_info['dlc'])
        data_entry = ttk.Entry(msg_frame, textvariable=data_var)
        data_entry.grid(row=0, column=3, sticky="ew", padx=1)
        
        # Cycle field
        cycle_var = tk.StringVar(value="100")
        cycle_entry = ttk.Entry(msg_frame, textvariable=cycle_var, justify="center", width=8)
        cycle_entry.grid(row=0, column=4, sticky="ew", padx=1)
        
        status_label = ttk.Label(msg_frame, text="Stopped", anchor="center", relief="sunken", width=10)
        status_label.grid(row=0, column=5, sticky="ew", padx=1)
        
        # Create button frame for start/stop/delete
        button_frame = ttk.Frame(msg_frame)
        button_frame.grid(row=0, column=6, sticky="ew", padx=1)
        
        start_btn = ttk.Button(button_frame, text="Start", width=6, 
                              command=lambda: self.start_tx_message(tx_msg_id))
        start_btn.pack(side=tk.LEFT, padx=1)
        
        stop_btn = ttk.Button(button_frame, text="Stop", width=6, state="disabled",
                             command=lambda: self.stop_tx_message(tx_msg_id))
        stop_btn.pack(side=tk.LEFT, padx=1)
        
        delete_btn = ttk.Button(button_frame, text="Del", width=4,
                               command=lambda: self.delete_tx_message(tx_msg_id))
        delete_btn.pack(side=tk.LEFT, padx=1)
        
        # Store message info and widgets
        self.tx_messages[tx_msg_id] = {
            "running": False,
            "timer": None,
            "type": "dbf",
            "msg_id": msg_id,
            "msg_info": msg_info,
            "widgets": {
                "frame": msg_frame,
                "id_var": id_var,
                "name_var": name_var,
                "data_var": data_var,
                "cycle_var": cycle_var,
                "status": status_label,
                "start_btn": start_btn,
                "stop_btn": stop_btn,
                "expand_btn": expand_btn,
                "expand_var": expand_var
            },
            "signal_widgets": {},
            "signal_values": {},
            "expanded": False
        }
        
        # Bind mouse wheel scrolling to all widgets in this message row
        self.bind_mousewheel_to_widget(msg_frame)
        
        # Update scroll region
        self.tx_canvas.configure(scrollregion=self.tx_canvas.bbox("all"))
        
        self.log(f"➕ Added DBF message: 0x{msg_id:03X} - {msg_info['name']}")
    
    def start_dbf_tx_message(self, tx_msg_id):
        """Start transmitting a DBF-based message"""
        if tx_msg_id not in self.tx_messages:
            return
            
        msg_info = self.tx_messages[tx_msg_id]
        
        try:
            tx_data = msg_info["widgets"]["data_var"].get().strip()
            tx_cycle_str = msg_info["widgets"]["cycle_var"].get().strip()
            
            # Validate inputs
            if not tx_data:
                messagebox.showerror("Invalid Input", "Data cannot be empty.")
                return
            if not tx_cycle_str:
                messagebox.showerror("Invalid Input", "Cycle cannot be empty.")
                return
                
            tx_data_bytes = bytes(int(b, 16) for b in tx_data.split())
            tx_cycle = int(tx_cycle_str)
            msg_id = msg_info["msg_id"]
            
        except ValueError as e:
            messagebox.showerror("Invalid Input", f"Please check format: {e}")
            return
            
        # Log the start action
        if tx_cycle == 0:
            self.log(f"🚀 Starting one-shot DBF TX: {msg_info['msg_info']['name']} (0x{msg_id:X})")
        else:
            self.log(f"🚀 Starting periodic DBF TX: {msg_info['msg_info']['name']} (0x{msg_id:X}), Cycle: {tx_cycle}ms")
        
        # Update UI
        msg_info["widgets"]["status"].config(text="Running", foreground="green")
        msg_info["widgets"]["start_btn"].config(state="disabled")
        msg_info["widgets"]["stop_btn"].config(state="normal")
        msg_info["running"] = True
        
        def send_dbf_message():
            if not self.running or not msg_info["running"]:
                return
            try:
                # Re-read data each time in case user changed it while running
                current_data = msg_info["widgets"]["data_var"].get().strip()
                
                msg = can.Message(
                    arbitration_id=msg_id,
                    data=bytes(int(b, 16) for b in current_data.split()),
                    is_extended_id=False
                )
                self.bus.send(msg)
                
                # Schedule next transmission
                if tx_cycle > 0 and msg_info["running"]:
                    msg_info["timer"] = self.root.after(tx_cycle, send_dbf_message)
                else:
                    # One-shot message - stop after sending
                    self.stop_tx_message(tx_msg_id)
                    
            except Exception as e:
                self.log(f"❌ DBF TX Error: {e}")
                self.stop_tx_message(tx_msg_id)
        
        # Start sending
        send_dbf_message()
    
    def send_wake_message(self):
        """Send a wake message to address 0x000 with no payload"""
        was_connected = self.running and self.bus is not None
        
        # If not connected, try to connect first
        if not was_connected:
            if not self.device_var.get():
                messagebox.showerror("No Device", "Please scan and select a CAN device first.")
                return
                
            self.log("🌅 WAKE: Auto-connecting to send wake message...")
            self.connect()
            
            # Check if connection was successful
            if not self.running or not self.bus:
                messagebox.showerror("Connection Failed", "Could not connect to CAN bus for wake message.")
                return
        
        try:
            # Create wake message: ID 0x000, no data (DLC = 0)
            msg = can.Message(
                arbitration_id=0x000,
                data=[],  # Empty data
                is_extended_id=False
            )
            self.bus.send(msg)
            
            # Log the wake message
            self.log("🌅 WAKE: Sent wake message to 0x000 (DLC=0)")
            
            # If we auto-connected, disconnect after sending wake message
            if not was_connected:
                self.log("🌅 WAKE: Auto-disconnecting after wake message")
                # Use a short delay to ensure message is sent before disconnecting
                self.root.after(100, self.disconnect)
            
        except Exception as e:
            self.log(f"❌ WAKE ERROR: Failed to send wake message: {e}")
            messagebox.showerror("Wake Error", f"Failed to send wake message: {e}")
            
            # If we auto-connected and failed, still disconnect
            if not was_connected:
                self.disconnect()
    
    def _start_bus_status_monitoring(self):
        """Start monitoring bus status"""
        if self.bus_status_timer is None and self.bus:
            self._update_bus_status()
    
    def _stop_bus_status_monitoring(self):
        """Stop monitoring bus status"""
        if self.bus_status_timer is not None:
            self.root.after_cancel(self.bus_status_timer)
            self.bus_status_timer = None
        self.last_bus_state = None
        # Reset status display to unknown
        self.table_view.update_bus_status_display(None)
    
    def _update_bus_status(self):
        """Update bus status from CAN interface"""
        if not self.running or not self.bus:
            return
        
        try:
            # Get current bus state
            current_state = self.bus.state
            
            # Only update display if state changed
            if current_state != self.last_bus_state:
                self.table_view.update_bus_status_display(current_state)
                self.last_bus_state = current_state
                
            # Schedule next update (200ms = 5Hz)
            self.bus_status_timer = self.root.after(200, self._update_bus_status)
            
        except Exception as e:
            # Some CAN interfaces might not support state queries
            # Log once and stop monitoring to avoid spam
            if self.last_bus_state is not None:  # Only log if we were monitoring
                self.log(f"⚠️  Bus status monitoring disabled: {e}")
            self.last_bus_state = None
            self.bus_status_timer = None