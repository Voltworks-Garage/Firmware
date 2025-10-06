"""
Signal Graphing Window
======================

This module provides a real-time graphing window for plotting CAN signal values over time.
Features multiple y-axes with different colors for each signal, signal selection interface,
and configurable time ranges.
"""

import tkinter as tk
from tkinter import ttk, messagebox
import time
import threading
from collections import defaultdict, deque
from typing import Dict, List, Optional, Tuple, Any
import colorsys

# Handle matplotlib import with fallback
try:
    import matplotlib
    matplotlib.use('TkAgg')  # Use TkAgg backend for Tkinter integration
    import matplotlib.pyplot as plt
    from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
    from matplotlib.figure import Figure
    from matplotlib.animation import FuncAnimation
    import matplotlib.dates as mdates
    from datetime import datetime
    MATPLOTLIB_AVAILABLE = True
except ImportError:
    MATPLOTLIB_AVAILABLE = False
    print("⚠️  Matplotlib not available. Install with: pip install matplotlib")


class SignalData:
    """Container for signal data points"""
    
    def __init__(self, signal_name: str, message_name: str, units: str = "", color: str = "blue"):
        self.signal_name = signal_name
        self.message_name = message_name
        self.full_name = f"{message_name}.{signal_name}"
        self.units = units
        self.color = color
        self.timestamps = deque(maxlen=1000)  # Store up to 1000 points
        self.values = deque(maxlen=1000)
        self.y_axis = None  # Will store the matplotlib axis
        
    def add_data_point(self, timestamp: float, value: float):
        """Add a new data point"""
        self.timestamps.append(timestamp)
        self.values.append(value)
    
    def get_recent_data(self, time_window: float = 60.0) -> Tuple[List[float], List[float]]:
        """Get data points within the specified time window"""
        current_time = time.time()
        cutoff_time = current_time - time_window
        
        recent_times = []
        recent_values = []
        
        for t, v in zip(self.timestamps, self.values):
            if t >= cutoff_time:
                recent_times.append(t)
                recent_values.append(v)
        
        return recent_times, recent_values


class GraphingWindow:
    """Real-time signal graphing window"""
    
    def __init__(self, parent_app):
        """Initialize the graphing window"""
        self.parent_app = parent_app
        self.window = None
        self.figure = None
        self.canvas = None
        self.animation = None
        self.signal_data = {}  # Dict[str, SignalData]
        self.colors = self._generate_color_palette()
        self.color_index = 0
        self.time_window = 60.0  # Default 60 seconds
        self.update_interval = 100  # Update every 100ms
        self.is_running = False
        self.legend_needs_update = True  # Flag to track when legend needs updating
        
        if not MATPLOTLIB_AVAILABLE:
            messagebox.showerror(
                "Matplotlib Required", 
                "Matplotlib is required for graphing functionality.\nPlease install with: pip install matplotlib"
            )
            return
            
        self._create_window()
    
    def _generate_color_palette(self) -> List[str]:
        """Generate a palette of distinct colors for signals"""
        colors = []
        num_colors = 20  # Generate 20 distinct colors
        
        for i in range(num_colors):
            hue = i / num_colors
            saturation = 0.8
            value = 0.9
            rgb = colorsys.hsv_to_rgb(hue, saturation, value)
            hex_color = '#{:02x}{:02x}{:02x}'.format(
                int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255)
            )
            colors.append(hex_color)
        
        return colors
    
    def _get_next_color(self) -> str:
        """Get the next color from the palette"""
        color = self.colors[self.color_index % len(self.colors)]
        self.color_index += 1
        return color
    
    def _create_window(self):
        """Create the graphing window UI"""
        self.window = tk.Toplevel(self.parent_app.root)
        self.window.title("CAN Signal Grapher")
        self.window.geometry("1200x800")
        
        # Handle window close
        self.window.protocol("WM_DELETE_WINDOW", self.on_window_close)
        
        # Create main frames
        self._create_control_frame()
        self._create_graph_frame()
        self._create_signal_list_frame()
        
        # Start the update loop
        self.is_running = True
        self._start_animation()
    
    def _create_control_frame(self):
        """Create the control panel"""
        control_frame = ttk.LabelFrame(self.window, text="Graph Controls")
        control_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Time window control
        ttk.Label(control_frame, text="Time Window (seconds):").pack(side=tk.LEFT, padx=5)
        self.time_window_var = tk.StringVar(value=str(int(self.time_window)))
        time_window_combo = ttk.Combobox(
            control_frame, 
            textvariable=self.time_window_var,
            values=["10", "30", "60", "120", "300"],
            width=8,
            state="readonly"
        )
        time_window_combo.pack(side=tk.LEFT, padx=5)
        time_window_combo.bind("<<ComboboxSelected>>", self.on_time_window_changed)
        
        # Update rate control
        ttk.Label(control_frame, text="Update Rate (ms):").pack(side=tk.LEFT, padx=5)
        self.update_rate_var = tk.StringVar(value=str(self.update_interval))
        update_rate_combo = ttk.Combobox(
            control_frame,
            textvariable=self.update_rate_var,
            values=["50", "100", "200", "500"],
            width=8,
            state="readonly"
        )
        update_rate_combo.pack(side=tk.LEFT, padx=5)
        update_rate_combo.bind("<<ComboboxSelected>>", self.on_update_rate_changed)
        
        # Control buttons
        ttk.Button(control_frame, text="Clear All", command=self.clear_all_signals).pack(side=tk.RIGHT, padx=5)
        ttk.Button(control_frame, text="Add Signal", command=self.show_signal_selection).pack(side=tk.RIGHT, padx=5)
    
    def _create_graph_frame(self):
        """Create the matplotlib graph frame"""
        graph_frame = ttk.LabelFrame(self.window, text="Signal Graph")
        graph_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Create matplotlib figure
        self.figure = Figure(figsize=(12, 6), dpi=100)
        self.figure.patch.set_facecolor('white')
        
        # Create initial empty axis
        self.main_axis = self.figure.add_subplot(111)
        self.main_axis.set_xlabel('Time (seconds ago)')
        self.main_axis.set_ylabel('No signals selected')
        self.main_axis.grid(True, alpha=0.3)
        
        # Create canvas
        self.canvas = FigureCanvasTkAgg(self.figure, master=graph_frame)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(fill=tk.BOTH, expand=True)
        
        # Add navigation toolbar
        toolbar_frame = ttk.Frame(graph_frame)
        toolbar_frame.pack(fill=tk.X)
        toolbar = NavigationToolbar2Tk(self.canvas, toolbar_frame)
        toolbar.update()
    
    def _create_signal_list_frame(self):
        """Create the signal list display frame"""
        list_frame = ttk.LabelFrame(self.window, text="Active Signals")
        list_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Create treeview for signal list
        columns = ('signal', 'message', 'units', 'current_value', 'color')
        self.signal_tree = ttk.Treeview(list_frame, columns=columns, show='headings', height=4)
        
        # Define column headings
        self.signal_tree.heading('signal', text='Signal Name')
        self.signal_tree.heading('message', text='Message')
        self.signal_tree.heading('units', text='Units')
        self.signal_tree.heading('current_value', text='Current Value')
        self.signal_tree.heading('color', text='Color')
        
        # Configure column widths
        self.signal_tree.column('signal', width=150)
        self.signal_tree.column('message', width=150)
        self.signal_tree.column('units', width=80)
        self.signal_tree.column('current_value', width=100)
        self.signal_tree.column('color', width=80)
        
        self.signal_tree.pack(fill=tk.X, padx=5, pady=5)
        
        # Add context menu for removing signals
        self.signal_tree.bind("<Button-3>", self.show_signal_context_menu)  # Right click
    
    def _start_animation(self):
        """Start the matplotlib animation for real-time updates"""
        if self.animation is not None:
            self.animation.event_source.stop()
        
        self.animation = FuncAnimation(
            self.figure,
            self._update_plot,
            interval=self.update_interval,
            blit=False,  # Keep False for multi-axis plots
            cache_frame_data=False
        )
    
    def _update_plot(self, frame):
        """Update the plot with current data"""
        if not self.is_running or not self.signal_data:
            return

        # Clear all axes
        self.figure.clear()

        if not self.signal_data:
            # No signals to plot
            ax = self.figure.add_subplot(111)
            ax.set_xlabel('Time (seconds ago)')
            ax.set_ylabel('No signals selected')
            ax.grid(True, alpha=0.3)
            ax.text(0.5, 0.5, 'No signals selected\nClick "Add Signal" to start',
                   transform=ax.transAxes, ha='center', va='center',
                   fontsize=14, alpha=0.7)
            return

        # Create axes for each signal
        num_signals = len(self.signal_data)
        current_time = time.time()

        # Create main axis for first signal
        signal_names = list(self.signal_data.keys())
        main_signal = self.signal_data[signal_names[0]]

        ax1 = self.figure.add_subplot(111)
        ax1.set_xlabel('Time (seconds ago)')

        # Plot first signal
        times, values = main_signal.get_recent_data(self.time_window)
        if times and values:
            # Convert absolute times to seconds ago
            time_offsets = [current_time - t for t in times]
            time_offsets.reverse()  # Reverse so most recent is at 0
            values_list = list(values)
            values_list.reverse()

            line1 = ax1.plot(time_offsets, values_list, color=main_signal.color,
                           label=main_signal.full_name, linewidth=2)
            ax1.set_ylabel(f'{main_signal.signal_name} ({main_signal.units})',
                          color=main_signal.color)
            ax1.tick_params(axis='y', labelcolor=main_signal.color)

            # Update current value in tree
            current_value = values_list[-1] if values_list else "N/A"
            self._update_signal_tree_value(main_signal.full_name, current_value)

        # Add additional signals on separate y-axes
        axes = [ax1]
        for i, signal_name in enumerate(signal_names[1:], 1):
            signal = self.signal_data[signal_name]
            times, values = signal.get_recent_data(self.time_window)

            if times and values:
                # Create new y-axis
                if i == 1:
                    ax_new = ax1.twinx()  # Right side
                else:
                    ax_new = ax1.twinx()
                    # Offset additional axes
                    ax_new.spines['right'].set_position(('outward', 60 * (i-1)))

                # Convert times and plot
                time_offsets = [current_time - t for t in times]
                time_offsets.reverse()
                values_list = list(values)
                values_list.reverse()

                ax_new.plot(time_offsets, values_list, color=signal.color,
                           label=signal.full_name, linewidth=2)
                ax_new.set_ylabel(f'{signal.signal_name} ({signal.units})',
                                 color=signal.color)
                ax_new.tick_params(axis='y', labelcolor=signal.color)

                axes.append(ax_new)

                # Update current value in tree
                current_value = values_list[-1] if values_list else "N/A"
                self._update_signal_tree_value(signal.full_name, current_value)

        # Set x-axis limits and labels
        ax1.set_xlim(self.time_window, 0)  # Most recent at right (0)
        ax1.grid(True, alpha=0.3)
        ax1.invert_xaxis()  # So time flows left to right (past to present)

        # Add legend only when needed (when signals are added/removed)
        if self.legend_needs_update:
            lines = []
            labels = []
            for ax in axes:
                ax_lines, ax_labels = ax.get_legend_handles_labels()
                lines.extend(ax_lines)
                labels.extend(ax_labels)

            if lines:
                ax1.legend(lines, labels, loc='upper left')
            self.legend_needs_update = False
        
    
    def show_signal_selection(self):
        """Show signal selection dialog"""
        if not self.parent_app.message_manager.messages:
            messagebox.showinfo("No Messages", "No CAN messages available. Connect to CAN bus and receive some messages first.")
            return
        
        # Create selection dialog
        dialog = tk.Toplevel(self.window)
        dialog.title("Select Signal to Graph")
        dialog.geometry("600x500")
        dialog.transient(self.window)
        dialog.grab_set()
        
        # Center the dialog
        dialog.update_idletasks()
        x = (dialog.winfo_screenwidth() // 2) - (dialog.winfo_width() // 2)
        y = (dialog.winfo_screenheight() // 2) - (dialog.winfo_height() // 2)
        dialog.geometry(f"+{x}+{y}")
        
        # Create treeview for message/signal selection
        tree_frame = ttk.Frame(dialog)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Add scrollbars
        tree_scroll_y = ttk.Scrollbar(tree_frame)
        tree_scroll_y.pack(side=tk.RIGHT, fill=tk.Y)
        
        tree_scroll_x = ttk.Scrollbar(tree_frame, orient=tk.HORIZONTAL)
        tree_scroll_x.pack(side=tk.BOTTOM, fill=tk.X)
        
        # Create treeview with columns
        columns = ('current_value', 'units', 'status', 'full_name')
        signal_tree = ttk.Treeview(tree_frame, 
                                  columns=columns,
                                  show='tree headings',
                                  yscrollcommand=tree_scroll_y.set,
                                  xscrollcommand=tree_scroll_x.set)
        signal_tree.pack(fill=tk.BOTH, expand=True)
        
        tree_scroll_y.config(command=signal_tree.yview)
        tree_scroll_x.config(command=signal_tree.xview)
        
        # Debug info
        total_messages = len(self.parent_app.message_manager.messages)
        messages_with_signals = 0
        total_signals = 0
        
        # Populate tree with messages and signals
        for msg_id, can_msg in self.parent_app.message_manager.messages.items():
            # Check if message has decoded signals (current frame or accumulated)
            has_signals = (can_msg.decoded_signals and len(can_msg.decoded_signals) > 0) or \
                         (hasattr(can_msg, 'accumulated_mux_signals') and 
                          can_msg.accumulated_mux_signals and len(can_msg.accumulated_mux_signals) > 0)
            
            if has_signals:
                messages_with_signals += 1
                # Add message node
                msg_node = signal_tree.insert('', 'end', text=can_msg.name, 
                                             values=("Message", "", "", ""))
                
                # Combine current signals and accumulated multiplexed signals
                all_signals = {}
                if can_msg.decoded_signals:
                    all_signals.update(can_msg.decoded_signals)
                if hasattr(can_msg, 'accumulated_mux_signals') and can_msg.accumulated_mux_signals:
                    all_signals.update(can_msg.accumulated_mux_signals)
                
                # Add signal nodes
                for signal_name, signal_value in all_signals.items():
                    total_signals += 1
                    # Get signal info from DBF
                    signal_info = self._get_signal_info(msg_id, signal_name)
                    units = ''
                    if signal_info:
                        # Try different possible keys for units
                        units = signal_info.get('unit', signal_info.get('units', ''))
                    
                    # Extract actual value if it's a dictionary or complex structure
                    display_value = self._extract_display_value(signal_value)
                    
                    full_signal_name = f"{can_msg.name}.{signal_name}"
                    already_added = full_signal_name in self.signal_data
                    status = "✓ Added" if already_added else "Available"
                    
                    signal_tree.insert(msg_node, 'end', text=signal_name,
                                     values=(display_value, units, status, full_signal_name))
        
        # Add info message if no signals found
        if total_signals == 0:
            info_node = signal_tree.insert('', 'end', text="No signals available", 
                                         values=("", "", "", ""))
            signal_tree.insert(info_node, 'end', text=f"Total messages: {total_messages}",
                             values=("", "", "", ""))
            signal_tree.insert(info_node, 'end', text="Connect to CAN bus and receive messages with decoded signals",
                             values=("", "", "", ""))
        
        # Expand all nodes
        for item in signal_tree.get_children():
            signal_tree.item(item, open=True)
        
        # Configure columns
        signal_tree.heading('#0', text='Name')
        signal_tree.heading('current_value', text='Current Value')  
        signal_tree.heading('units', text='Units')
        signal_tree.heading('status', text='Status')
        
        signal_tree.column('#0', width=200)
        signal_tree.column('current_value', width=120)
        signal_tree.column('units', width=80)
        signal_tree.column('status', width=100)
        signal_tree.column('full_name', width=0, stretch=False)  # Hidden column for data
        
        # Add debug info to dialog title
        dialog.title(f"Select Signal to Graph ({total_signals} signals from {messages_with_signals}/{total_messages} messages)")
        
        # Status frame
        status_frame = ttk.Frame(dialog)
        status_frame.pack(fill=tk.X, padx=10, pady=5)
        
        if total_signals > 0:
            status_text = f"Found {total_signals} signals in {messages_with_signals} messages. Select a signal and click 'Add Signal' or double-click."
        else:
            status_text = "No decoded signals available. Connect to CAN bus and receive messages with signal definitions."
        
        status_label = ttk.Label(status_frame, text=status_text, wraplength=500)
        status_label.pack(pady=5)
        
        # Button frame
        btn_frame = ttk.Frame(dialog)
        btn_frame.pack(fill=tk.X, padx=10, pady=(0, 10))
        
        def on_add_signal():
            selection = signal_tree.selection()
            if not selection:
                messagebox.showwarning("No Selection", "Please select a signal to add.")
                return
            
            item = selection[0]
            item_text = signal_tree.item(item)['text']
            values = signal_tree.item(item)['values']
            
            # Check if it's a signal (has full_signal_name in values)
            if len(values) >= 4 and values[3]:  # Has full_signal_name
                full_signal_name = values[3]
                if full_signal_name not in self.signal_data:
                    self.add_signal(full_signal_name)
                    # Update status in dialog
                    signal_tree.item(item, values=(values[0], values[1], "✓ Added", values[3]))
                    self.parent_app.log(f"📊 Added signal to graph: {full_signal_name}")
                    # Don't close dialog so user can add more signals
                else:
                    messagebox.showinfo("Already Added", f"Signal '{full_signal_name}' is already being graphed.")
            else:
                messagebox.showinfo("Invalid Selection", "Please select a signal (not a message) to add to the graph.")
        
        # Make buttons more prominent
        ttk.Button(btn_frame, text="Add Selected Signal", command=on_add_signal, width=20).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="Close", command=dialog.destroy, width=10).pack(side=tk.RIGHT, padx=5)
        
        # Bind double-click to add
        signal_tree.bind("<Double-Button-1>", lambda e: on_add_signal())
        
        # Select first signal if available
        if total_signals > 0:
            # Find first signal (not message) and select it
            for item in signal_tree.get_children():
                for child in signal_tree.get_children(item):
                    if signal_tree.item(child)['values'] and len(signal_tree.item(child)['values']) >= 4:
                        signal_tree.selection_set(child)
                        signal_tree.focus(child)
                        break
                if signal_tree.selection():
                    break
    
    def _extract_display_value(self, signal_value) -> str:
        """Extract display value from signal data (handle dictionaries, etc.)"""
        if isinstance(signal_value, dict):
            # If it's a dictionary, look for common value keys
            if 'value' in signal_value:
                return str(signal_value['value'])
            elif 'current' in signal_value:
                return str(signal_value['current'])
            elif 'data' in signal_value:
                return str(signal_value['data'])
            else:
                # If no obvious value key, return the first numeric value found
                for key, value in signal_value.items():
                    if isinstance(value, (int, float)):
                        return str(value)
                # Fallback: return string representation of dict
                return str(signal_value)
        elif isinstance(signal_value, (list, tuple)):
            # If it's a list/tuple, return the first element or length
            if len(signal_value) > 0:
                return str(signal_value[0])
            else:
                return "[]"
        else:
            # For simple values (int, float, string), return as string
            return str(signal_value)
    
    
    def _get_signal_info(self, msg_id: int, signal_name: str) -> Optional[Dict]:
        """Get signal information from DBF parser"""
        if msg_id in self.parent_app.dbf_parser.messages:
            msg_info = self.parent_app.dbf_parser.messages[msg_id]
            for signal in msg_info.get('signals', []):
                if signal['name'] == signal_name:
                    return signal
        return None
    
    def add_signal(self, full_signal_name: str):
        """Add a signal to the graph"""
        try:
            # Parse message and signal names
            parts = full_signal_name.split('.', 1)
            if len(parts) != 2:
                messagebox.showerror("Invalid Signal", "Signal name must be in format 'Message.Signal'")
                return
            
            message_name, signal_name = parts
            
            # Find message ID by name
            msg_id = None
            for mid, can_msg in self.parent_app.message_manager.messages.items():
                if can_msg.name == message_name:
                    msg_id = mid
                    break
            
            if msg_id is None:
                messagebox.showerror("Message Not Found", f"Message '{message_name}' not found.")
                return
            
            # Get signal info for units
            signal_info = self._get_signal_info(msg_id, signal_name)
            units = signal_info.get('unit', '') if signal_info else ''
            
            # Create signal data container
            color = self._get_next_color()
            signal_data = SignalData(signal_name, message_name, units, color)
            
            # Add to tracking
            self.signal_data[full_signal_name] = signal_data

            # Add to signal tree display
            self._add_signal_to_tree(signal_data)

            # Mark legend for update
            self.legend_needs_update = True
            
            self.parent_app.log(f"📊 Added signal to graph: {full_signal_name}")
            
        except Exception as e:
            messagebox.showerror("Error Adding Signal", f"Failed to add signal: {e}")
            self.parent_app.log(f"❌ Error adding signal to graph: {e}")
    
    def _add_signal_to_tree(self, signal_data: SignalData):
        """Add signal to the display tree"""
        self.signal_tree.insert('', 'end', 
                               values=(signal_data.signal_name,
                                      signal_data.message_name, 
                                      signal_data.units,
                                      "N/A",
                                      signal_data.color),
                               tags=(signal_data.full_name,))
    
    def _update_signal_tree_value(self, full_signal_name: str, value: Any):
        """Update the current value display in the signal tree"""
        for item in self.signal_tree.get_children():
            if self.signal_tree.item(item)['tags']:
                if self.signal_tree.item(item)['tags'][0] == full_signal_name:
                    current_values = list(self.signal_tree.item(item)['values'])
                    current_values[3] = f"{value:.3f}" if isinstance(value, (int, float)) else str(value)
                    self.signal_tree.item(item, values=current_values)
                    break
    
    def remove_signal(self, full_signal_name: str):
        """Remove a signal from the graph"""
        if full_signal_name in self.signal_data:
            del self.signal_data[full_signal_name]

            # Remove from tree display
            for item in self.signal_tree.get_children():
                if self.signal_tree.item(item)['tags']:
                    if self.signal_tree.item(item)['tags'][0] == full_signal_name:
                        self.signal_tree.delete(item)
                        break

            # Mark legend for update
            self.legend_needs_update = True

            self.parent_app.log(f"📊 Removed signal from graph: {full_signal_name}")
    
    def clear_all_signals(self):
        """Clear all signals from the graph"""
        if self.signal_data:
            result = messagebox.askyesno("Clear All Signals", "Are you sure you want to remove all signals from the graph?")
            if result:
                self.signal_data.clear()
                for item in self.signal_tree.get_children():
                    self.signal_tree.delete(item)

                # Mark legend for update
                self.legend_needs_update = True

                self.parent_app.log("📊 Cleared all signals from graph")
    
    def show_signal_context_menu(self, event):
        """Show context menu for signal removal"""
        item = self.signal_tree.identify_row(event.y)
        if item:
            self.signal_tree.selection_set(item)
            tags = self.signal_tree.item(item)['tags']
            if tags:
                full_signal_name = tags[0]
                
                # Create context menu
                context_menu = tk.Menu(self.window, tearoff=0)
                context_menu.add_command(label=f"Remove '{full_signal_name}'", 
                                       command=lambda: self.remove_signal(full_signal_name))
                
                try:
                    context_menu.tk_popup(event.x_root, event.y_root)
                finally:
                    context_menu.grab_release()
    
    def on_time_window_changed(self, event=None):
        """Handle time window change"""
        try:
            new_time_window = float(self.time_window_var.get())
            self.time_window = new_time_window
            self.parent_app.log(f"📊 Graph time window changed to {new_time_window}s")
        except ValueError:
            self.time_window_var.set(str(int(self.time_window)))
    
    def on_update_rate_changed(self, event=None):
        """Handle update rate change"""
        try:
            new_update_interval = int(self.update_rate_var.get())
            self.update_interval = new_update_interval
            
            # Restart animation with new interval
            self._start_animation()
            
            self.parent_app.log(f"📊 Graph update rate changed to {new_update_interval}ms")
        except ValueError:
            self.update_rate_var.set(str(self.update_interval))
    
    def on_can_message_received(self, msg_id: int, can_msg):
        """Called when a CAN message is received - update signal data"""
        if not self.is_running:
            return

        # Check if any tracked signals are in this message
        all_signals = {}
        if can_msg.decoded_signals:
            all_signals.update(can_msg.decoded_signals)
        if hasattr(can_msg, 'accumulated_mux_signals') and can_msg.accumulated_mux_signals:
            all_signals.update(can_msg.accumulated_mux_signals)

        if all_signals:
            current_time = time.time()

            for signal_name, signal_value in all_signals.items():
                full_signal_name = f"{can_msg.name}.{signal_name}"

                if full_signal_name in self.signal_data:
                    # Get the raw numeric value directly from the decoded signal
                    if isinstance(signal_value, dict) and 'raw_value' in signal_value:
                        numeric_value = signal_value['raw_value']
                        if isinstance(numeric_value, (int, float)):
                            self.signal_data[full_signal_name].add_data_point(current_time, float(numeric_value))
    
    def on_window_close(self):
        """Handle window close event"""
        self.is_running = False
        
        if self.animation is not None:
            self.animation.event_source.stop()
            self.animation = None
        
        if self.window:
            self.window.destroy()
            self.window = None
        
        self.parent_app.log("📊 Signal graphing window closed")