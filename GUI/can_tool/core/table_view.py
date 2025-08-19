"""
CAN Table View
==============

This module provides the GUI table view component for displaying CAN messages.
The CANTableView class handles the tree view UI logic for displaying messages and signals.
"""

import tkinter as tk
from tkinter import ttk
from typing import Dict

# Import types - use try/except for both relative and absolute imports
try:
    from .can_message import CANMessage, CANMessageManager
except ImportError:
    from can_tool.core.can_message import CANMessage, CANMessageManager


class CANTableView:
    """Handles the tree view UI logic for CAN messages"""
    
    def __init__(self, parent_widget, message_manager: CANMessageManager):
        self.message_manager = message_manager
        
        # Create the tree view
        self.tree = ttk.Treeview(parent_widget, 
                                columns=("ID", "Name", "DLC", "Data", "Count", "Cycle", "Bus%"), 
                                show="tree headings")
        
        # Configure columns
        self.tree.heading("#0", text="", anchor="w")
        self.tree.column("#0", width=20, minwidth=20, stretch=False)
        
        for col, w in [("ID", 80), ("Name", 120), ("DLC", 50), ("Data", 200), ("Count", 60), ("Cycle", 80), ("Bus%", 60)]:
            self.tree.heading(col, text=col)
            self.tree.column(col, width=w)
        
        # Create bus utilization display frame
        self.bus_util_frame = ttk.Frame(parent_widget)
        self.bus_util_frame.pack(fill=tk.X, padx=5, pady=2)
        
        self.bus_util_label = ttk.Label(self.bus_util_frame, text="Bus Utilization: 0.0%", 
                                       font=("TkDefaultFont", 9, "bold"))
        self.bus_util_label.pack(side=tk.LEFT)
        
        self.bus_details_label = ttk.Label(self.bus_util_frame, text="(0 active messages)", 
                                          font=("TkDefaultFont", 8))
        self.bus_details_label.pack(side=tk.LEFT, padx=(10, 0))
        
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
        
        # Calculate individual message bus utilization
        bus_util_str = "-"
        msg_rates = self.message_manager.bus_utilization_data.get('message_rates', {})
        if msg.msg_id in msg_rates:
            rate_data = msg_rates[msg.msg_id]
            bitrate = self.message_manager.bus_utilization_data['bitrate']
            if bitrate > 0:
                utilization = (rate_data['bits_per_second'] / bitrate) * 100
                bus_util_str = f"{utilization:.2f}%"
        
        if msg.tree_item_id is None:
            # Create new tree item
            msg.tree_item_id = self.tree.insert("", tk.END, 
                                               values=(msg_hex_id, msg.name, msg.dlc, data_str, msg.count, cycle_str, bus_util_str),
                                               open=msg.is_expanded)
            msg.dummy_item_id = self.tree.insert(msg.tree_item_id, tk.END, text="", values=("", "  Dummy", "", "", "", "", ""))
        else:
            # Update existing tree item
            self.tree.item(msg.tree_item_id,
                          values=(msg_hex_id, msg.name, msg.dlc, data_str, msg.count, cycle_str, bus_util_str),
                          open=msg.is_expanded)
        
        # Update overall bus utilization display
        self.update_bus_utilization_display()
        
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
            
        # Check if we have new signals that require re-ordering
        current_signal_names = set(display_signals.keys())
        existing_signal_names = set(msg.signal_item_ids.keys())
        
        if current_signal_names != existing_signal_names:
            # New signals detected - clear and recreate all in proper order
            for signal_item_id in list(msg.signal_item_ids.values()):
                try:
                    self.tree.delete(signal_item_id)
                except tk.TclError:
                    pass  # Item already deleted
            msg.signal_item_ids.clear()
            
            # Re-create all signal children in sorted order
            for signal_name, signal_value in display_signals.items():
                signal_item = self.tree.insert(msg.tree_item_id, tk.END, text="",
                                             values=("", f"  {signal_name}", "", signal_value, "", "", ""))
                msg.signal_item_ids[signal_name] = signal_item
        else:
            # No new signals - just update existing values
            for signal_name, signal_value in display_signals.items():
                if signal_name in msg.signal_item_ids:
                    try:
                        self.tree.item(msg.signal_item_ids[signal_name],
                                     values=("", f"  {signal_name}", "", signal_value, "", "", ""))
                    except tk.TclError:
                        # Signal item was deleted, remove from tracking and recreate
                        del msg.signal_item_ids[signal_name]
                        signal_item = self.tree.insert(msg.tree_item_id, tk.END, text="",
                                                     values=("", f"  {signal_name}", "", signal_value, "", "", ""))
                        msg.signal_item_ids[signal_name] = signal_item
    
    def _update_signal_children(self, msg: CANMessage, display_signals: Dict[str, str]):
        """Update signal children values (only if they exist and message is expanded)"""
        if not msg.is_expanded or not display_signals:
            return

        if msg.dummy_item_id is not None:
            # Remove dummy item if it exists (used to ensure children are created)
            self.tree.delete(msg.dummy_item_id)
            msg.dummy_item_id = None

        # Ensure all signals have tree items in correct sorted order
        self._ensure_signal_children(msg, display_signals)
    
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
    
    def update_bus_utilization_display(self):
        """Update the bus utilization display"""
        bus_data = self.message_manager.get_bus_utilization()
        
        utilization_text = f"Bus Utilization: {bus_data['utilization_percent']:.1f}%"
        if bus_data['utilization_percent'] > 80:
            # High utilization - could be a warning color but we'll keep it simple
            utilization_text += " (HIGH)"
        
        details_text = f"({bus_data['active_message_count']} active messages, {bus_data['bitrate']/1000:.0f}k bps)"
        
        self.bus_util_label.config(text=utilization_text)
        self.bus_details_label.config(text=details_text)
    
    def clear_all(self):
        """Clear all items from the tree"""
        self.tree.delete(*self.tree.get_children())
        self.bus_util_label.config(text="Bus Utilization: 0.0%")
        self.bus_details_label.config(text="(0 active messages)")