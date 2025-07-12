"""
ISO-TP Tab Plugin
================

This plugin provides ISO-TP communication functionality for interacting with
commandService.c modules running on microcontrollers (BMS, MCU, Dash).

Features:
- Command selection by target device
- Parameter input for different command types
- ISO-TP message transmission with single-frame support
- Response handling and logging
- Communication log with formatted responses
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import can
import struct
import os
from typing import Dict, Optional

# Import base class - handle both relative and absolute imports
try:
    from ..gui.base_tab import BaseTab
    from ..core.config_parser import ConfigParser
except ImportError:
    from can_tool.gui.base_tab import BaseTab
    from can_tool.core.config_parser import ConfigParser


class ISOTPTab(BaseTab):
    """ISO-TP communication tab for commandService interaction"""
    
    @property
    def tab_name(self) -> str:
        return "ISO-TP"
    
    @property 
    def tab_description(self) -> str:
        return "ISO-TP communication for commandService interaction with microcontrollers"
    
    def create_widgets(self):
        """Create the ISO-TP interface for commandService interaction"""
        isotp_frame = self.tab_frame
        
        # Initialize config parser
        # Navigate from GUI/can_tool/plugins/isotp_tab.py to Firmware directory
        current_dir = os.path.dirname(__file__)  # plugins/
        can_tool_dir = os.path.dirname(current_dir)  # can_tool/
        gui_dir = os.path.dirname(can_tool_dir)  # GUI/
        firmware_root = os.path.dirname(gui_dir)  # Firmware/
        
        print(f"🔧 Config parser firmware root: {firmware_root}")
        self.config_parser = ConfigParser(firmware_root)
        self.config_parser.load_all_configs()
        
        print(f"🔧 Loaded {len(self.config_parser.device_configs)} device configs in ISO-TP tab")
        
        # ISO-TP Message Type definitions
        self.isotp_message_types = {
            "ISO-TP_SLEEP": 0x0A,
            "ISO-TP_RESET": 0x0B,
            "ISO-TP_IO_CONTROL": 0x0C,
            "ISO-TP_TESTER_PRESENT": 0x0D
        }
        
        # Command type definitions (from commandService_config.h)
        self.command_types = {
            "CMD_TYPE_SET_DIGITAL_OUT": 0x01,
            "CMD_TYPE_GET_DIGITAL_IN": 0x02,
            "CMD_TYPE_SET_PWM_OUT": 0x03,
            "CMD_TYPE_GET_ANALOG_IN": 0x04,
            "CMD_TYPE_GET_VOLTAGE": 0x05,
            "CMD_TYPE_GET_CURRENT": 0x06,
            "CMD_TYPE_CUSTOM": 0xFF
        }
        
        # Initialize with empty commands - will be populated based on selected IDs
        self.current_device_config = None
        self.available_commands = {}
        
        # Command selection frame
        cmd_frame = ttk.LabelFrame(isotp_frame, text="Command Selection")
        cmd_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Transmission ID selection (from DBF file)
        tx_frame = ttk.Frame(cmd_frame)
        tx_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(tx_frame, text="TX ID:").pack(side=tk.LEFT)
        self.isotp_target_var = tk.StringVar()
        self.target_combo = ttk.Combobox(tx_frame, textvariable=self.isotp_target_var, 
                                        state="readonly", width=20)
        self.target_combo.pack(side=tk.LEFT, padx=(5, 20))
        
        # Response ID selection (from DBF file)
        ttk.Label(tx_frame, text="RX ID:").pack(side=tk.LEFT)
        self.isotp_response_var = tk.StringVar()
        self.response_combo = ttk.Combobox(tx_frame, textvariable=self.isotp_response_var, 
                                          state="readonly", width=20)
        self.response_combo.pack(side=tk.LEFT, padx=(5, 20))
        
        # Populate both dropdowns with message IDs from DBF parser
        self.populate_message_ids()
        
        # Bind ID selection changes to update device config
        self.target_combo.bind("<<ComboboxSelected>>", self.on_id_selection_changed)
        self.response_combo.bind("<<ComboboxSelected>>", self.on_id_selection_changed)
        
        # ISO-TP Message Type, Command Type, and Command ID selection (on separate lines for better layout)
        msg_type_frame = ttk.Frame(cmd_frame)
        msg_type_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(msg_type_frame, text="Message Type:").pack(side=tk.LEFT)
        self.isotp_msg_type_var = tk.StringVar()
        self.msg_type_combo = ttk.Combobox(msg_type_frame, textvariable=self.isotp_msg_type_var, 
                                          state="readonly", width=20)
        self.msg_type_combo.config(values=list(self.isotp_message_types.keys()))
        self.msg_type_combo.set("ISO-TP_IO_CONTROL")  # Default selection
        self.msg_type_combo.pack(side=tk.LEFT, padx=(5, 20))
        self.msg_type_combo.bind("<<ComboboxSelected>>", self.on_message_type_change)
        
        self.cmd_type_frame = ttk.Frame(cmd_frame)
        self.cmd_type_frame.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(self.cmd_type_frame, text="Command Type:").pack(side=tk.LEFT)
        self.isotp_cmd_type_var = tk.StringVar()
        self.cmd_type_combo = ttk.Combobox(self.cmd_type_frame, textvariable=self.isotp_cmd_type_var, 
                                          state="readonly", width=25)
        self.cmd_type_combo.pack(side=tk.LEFT, padx=(5, 20))
        self.cmd_type_combo.bind("<<ComboboxSelected>>", self.on_command_type_change)
        
        self.cmd_frame_inner = ttk.Frame(cmd_frame)
        self.cmd_frame_inner.pack(fill=tk.X, padx=5, pady=2)
        
        ttk.Label(self.cmd_frame_inner, text="Command:").pack(side=tk.LEFT)
        self.isotp_cmd_var = tk.StringVar()
        self.isotp_cmd_combo = ttk.Combobox(self.cmd_frame_inner, textvariable=self.isotp_cmd_var, 
                                           state="readonly", width=30)
        self.isotp_cmd_combo.pack(side=tk.LEFT, padx=(5, 20))
        self.isotp_cmd_combo.bind("<<ComboboxSelected>>", self.on_isotp_command_change)

        # Initialize device configuration based on default selection
        self.on_id_selection_changed()
        
        # Initialize conditional UI visibility
        self.on_message_type_change()  # Set initial state
        
        # Parameters frame
        self.isotp_params_frame = ttk.LabelFrame(isotp_frame, text="Command Parameters")
        self.isotp_params_frame.pack(fill=tk.X, padx=5, pady=5)
        
        # Control buttons
        control_frame = ttk.Frame(isotp_frame)
        control_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Button(control_frame, text="Send Command", command=self.send_isotp_command).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Clear Log", command=self.clear_isotp_log).pack(side=tk.LEFT, padx=5)
        
        # Response/Log frame
        log_frame = ttk.LabelFrame(isotp_frame, text="ISO-TP Communication Log")
        log_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.isotp_log = scrolledtext.ScrolledText(log_frame, wrap=tk.WORD, height=10)
        self.isotp_log.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

    def populate_message_ids(self):
        """Populate both TX and RX message ID dropdowns from DBF parser"""
        print(f"🔧 populate_message_ids called")
        if hasattr(self.app, 'dbf_parser') and self.app.dbf_parser.messages:
            print(f"🔧 Using DBF parser with {len(self.app.dbf_parser.messages)} messages")
            # Create list of message ID options with format: "0x123 - MessageName"
            message_options = []
            for msg_id, msg_info in sorted(self.app.dbf_parser.messages.items()):
                option = f"0x{msg_id:03X} - {msg_info['name']}"
                message_options.append(option)
            
            # Populate TX ID dropdown
            self.target_combo.config(values=message_options)
            if message_options:
                self.target_combo.set(message_options[0])
            
            # Populate RX ID dropdown (same options, different selection)
            self.response_combo.config(values=message_options)
            if len(message_options) > 1:
                self.response_combo.set(message_options[1])  # Default to second message for response
            elif message_options:
                self.response_combo.set(message_options[0])
        else:
            print(f"🔧 Using config parser fallback")
            # Generate options from loaded device configs
            tx_options = []
            rx_options = []
            
            for device_name, config in self.config_parser.device_configs.items():
                tx_options.append(f"0x{config.tx_id:03X} - {device_name}_TX")
                rx_options.append(f"0x{config.rx_id:03X} - {device_name}_RX")
            
            print(f"🔧 Generated {len(tx_options)} TX options from config: {tx_options}")
            
            # Fallback if no configs loaded
            if not tx_options:
                print(f"🔧 No configs loaded, using hardcoded fallback")
                tx_options = ["0x7A1 - BMS_TX", "0x7A3 - MCU_TX", "0x7A5 - Dash_TX"]
                rx_options = ["0x7A2 - BMS_RX", "0x7A4 - MCU_RX", "0x7A6 - Dash_RX"]
            
            self.target_combo.config(values=tx_options)
            if tx_options:
                self.target_combo.set(tx_options[0])
                print(f"🔧 Set TX combo to: {tx_options[0]}")
            
            self.response_combo.config(values=rx_options)
            if rx_options:
                self.response_combo.set(rx_options[0])
                print(f"🔧 Set RX combo to: {rx_options[0]}")
    
    def get_selected_message_id(self):
        """Extract message ID from selected TX dropdown option"""
        selection = self.isotp_target_var.get()
        if selection:
            try:
                # Extract hex ID from "0x123 - MessageName" format
                hex_part = selection.split(" - ")[0]
                return int(hex_part, 16)
            except (ValueError, IndexError):
                pass
        return None
    
    def get_selected_response_id(self):
        """Extract message ID from selected RX dropdown option"""
        selection = self.isotp_response_var.get()
        if selection:
            try:
                # Extract hex ID from "0x123 - MessageName" format
                hex_part = selection.split(" - ")[0]
                return int(hex_part, 16)
            except (ValueError, IndexError):
                pass
        return None
    
    def on_message_type_change(self, event=None):
        """Handle message type selection changes - show/hide command type and command ID based on selection"""
        msg_type_name = self.isotp_msg_type_var.get()
        
        if msg_type_name == "ISO-TP_IO_CONTROL":
            # Show command type and command ID frames for IO_CONTROL
            self.cmd_type_frame.pack(fill=tk.X, padx=5, pady=2)
            self.cmd_frame_inner.pack(fill=tk.X, padx=5, pady=2)
        else:
            # Hide command type and command ID frames for other message types
            self.cmd_type_frame.pack_forget()
            self.cmd_frame_inner.pack_forget()
            
            # Also clear parameters frame since no commands are available
            if hasattr(self, 'isotp_params_frame'):
                for widget in self.isotp_params_frame.winfo_children():
                    widget.destroy()
    
    def on_id_selection_changed(self, event=None):
        """Called when TX or RX ID selection changes - update device config and commands"""
        tx_id = self.get_selected_message_id()
        rx_id = self.get_selected_response_id()
        
        if tx_id is None or rx_id is None:
            return
            
        # Find device config for these IDs
        device_name = self.config_parser.get_device_for_ids(tx_id, rx_id)
        
        if device_name:
            self.current_device_config = self.config_parser.get_config_for_device(device_name)
            self.available_commands = self.config_parser.get_commands_for_device(device_name)
            
            # Update command type dropdown with available types for this device
            available_types = set()
            for cmd_def in self.available_commands.values():
                available_types.add(cmd_def.cmd_type)
            
            available_type_names = [t.replace('CMD_TYPE_', '') for t in available_types]
            self.cmd_type_combo.config(values=available_type_names)
            
            if available_type_names:
                self.cmd_type_combo.set(available_type_names[0])
                self.on_command_type_change()
                
            print(f"🔧 Device config loaded: {device_name} (TX=0x{tx_id:03X}, RX=0x{rx_id:03X})")
        else:
            # No specific config found - clear dropdowns
            self.current_device_config = None
            self.available_commands = {}
            self.cmd_type_combo.config(values=[])
            self.isotp_cmd_combo.config(values=[])
            print(f"⚠️  No device config found for TX=0x{tx_id:03X}, RX=0x{rx_id:03X}")
    
    def on_command_type_change(self, event=None):
        """Called when command type selection changes - update command dropdown"""
        if not self.available_commands:
            return
            
        selected_type = self.isotp_cmd_type_var.get()
        if not selected_type:
            return
            
        # Add CMD_TYPE_ prefix for matching
        full_type_name = f"CMD_TYPE_{selected_type}"
        
        # Filter commands by selected type
        matching_commands = []
        for cmd_name, cmd_def in self.available_commands.items():
            if cmd_def.cmd_type == full_type_name:
                matching_commands.append(cmd_name)
        
        # Update command dropdown
        self.isotp_cmd_combo.config(values=matching_commands)
        if matching_commands:
            self.isotp_cmd_combo.set(matching_commands[0])
            self.on_isotp_command_change()

    def on_isotp_command_change(self, event=None):
        """Update parameter inputs when command changes"""
        # Safety check - return if params frame doesn't exist yet
        if not hasattr(self, 'isotp_params_frame'):
            return
            
        # Clear existing parameter widgets
        for widget in self.isotp_params_frame.winfo_children():
            widget.destroy()
        
        command = self.isotp_cmd_var.get()
        
        # Find command info from available commands
        if not command or command not in self.available_commands:
            return
            
        cmd_def = self.available_commands[command]
        params = cmd_def.params
        
        self.isotp_param_vars = {}
        
        if not params:
            ttk.Label(self.isotp_params_frame, text="No parameters required").pack(pady=5)
        else:
            param_frame = ttk.Frame(self.isotp_params_frame)
            param_frame.pack(fill=tk.X, padx=5, pady=5)
            
            for i, param in enumerate(params):
                display_name = param.replace('_', ' ').title()
                ttk.Label(param_frame, text=f"{display_name}:").grid(row=i, column=0, sticky="w", padx=5, pady=2)
                
                var = tk.StringVar()
                self.isotp_param_vars[param] = var
                
                if param == "state":
                    # Boolean dropdown for state parameters
                    combo = ttk.Combobox(param_frame, textvariable=var, values=["0 (Off)", "1 (On)"], 
                                        state="readonly", width=10)
                    combo.set("0 (Off)")
                elif param in ["duty_cycle", "brightness"]:
                    # Scale for PWM values
                    scale = tk.Scale(param_frame, from_=0, to=100, orient=tk.HORIZONTAL, variable=var)
                    scale.grid(row=i, column=1, sticky="ew", padx=5, pady=2)
                    continue
                elif param == "io_index":
                    # Numeric entry for IO index
                    combo = ttk.Entry(param_frame, textvariable=var, width=10)
                    var.set("0")  # Default value
                elif param.endswith("_id"):
                    # Dropdown for ID selection
                    combo = ttk.Combobox(param_frame, textvariable=var, values=["0", "1", "2", "3"], 
                                        state="readonly", width=10)
                    combo.set("0")
                else:
                    # Default entry widget
                    combo = ttk.Entry(param_frame, textvariable=var, width=15)
                    var.set("0")  # Default value
                
                combo.grid(row=i, column=1, sticky="ew", padx=5, pady=2)
            
            param_frame.grid_columnconfigure(1, weight=1)

    def send_isotp_command(self):
        """Send an ISO-TP command to the target device"""
        target_msg_id = self.get_selected_message_id()
        msg_type_name = self.isotp_msg_type_var.get()
        
        if not target_msg_id or not msg_type_name:
            messagebox.showwarning("Invalid Selection", "Please select a message ID and message type.")
            return
        
        if not self.app.running or not self.app.bus:
            messagebox.showerror("Not Connected", "Please connect to CAN bus first.")
            return
        
        # Get message type value
        msg_type = self.isotp_message_types.get(msg_type_name)
        if msg_type is None:
            messagebox.showerror("Invalid Message Type", "Selected message type not found.")
            return
        
        # Build payload based on message type
        if msg_type_name == "ISO-TP_IO_CONTROL":
            # IO_CONTROL requires command type and command ID
            command = self.isotp_cmd_var.get()
            cmd_type_name = self.isotp_cmd_type_var.get()
            
            if not command or not cmd_type_name:
                messagebox.showwarning("Invalid Selection", "Please select command type and command for IO_CONTROL.")
                return
            
            # Get command type value
            full_type_name = f"CMD_TYPE_{cmd_type_name}"
            cmd_type = self.command_types.get(full_type_name)
            if cmd_type is None:
                messagebox.showerror("Invalid Command Type", "Selected command type not found.")
                return
            
            # Find command info from available commands
            if command not in self.available_commands:
                messagebox.showerror("Invalid Command", "Selected command not found.")
                return
            
            cmd_def = self.available_commands[command]
            cmd_id = cmd_def.cmd_id
            params = cmd_def.params
            
            # Build command payload: byte 0 = message type, byte 1 = command type, byte 2 = command ID
            payload = [msg_type, cmd_type, cmd_id]
        else:
            # Other message types (SLEEP, RESET, TESTER_PRESENT) only need message type
            payload = [msg_type]
            params = []
            command = msg_type_name  # Use message type as command name for logging
            cmd_type_name = ""
            cmd_id = None
        
        # Add parameters
        for param in params:
            if param not in self.isotp_param_vars:
                continue
            
            value_str = self.isotp_param_vars[param].get()
            try:
                if param == "state":
                    # Extract numeric value from "0 (Off)" or "1 (On)"
                    value = int(value_str.split()[0])
                elif param in ["duty_cycle", "brightness"]:
                    # Convert percentage to 0-255 range
                    value = int(float(value_str) * 255 / 100)
                else:
                    value = int(value_str)
                
                payload.append(value & 0xFF)  # Ensure single byte
            except ValueError:
                messagebox.showerror("Invalid Parameter", f"Invalid value for {param}: {value_str}")
                return
        
        # Use selected message ID as transmission ID
        tx_id = target_msg_id
        
        # Send as single frame ISO-TP (for simplicity, assuming payload <= 7 bytes)
        if len(payload) <= 7:
            # Single frame: [PCI | Data...]
            pci = len(payload)  # Single frame PCI = length
            can_data = [pci] + payload + [0] * (8 - len(payload) - 1)  # Pad to 8 bytes
            
            try:
                msg = can.Message(
                    arbitration_id=tx_id,
                    data=can_data,
                    is_extended_id=False
                )
                self.app.bus.send(msg)
                
                # Log the sent command
                param_str = ""
                if hasattr(self, 'isotp_param_vars'):
                    param_values = [f"{k}={v.get()}" for k, v in self.isotp_param_vars.items()]
                    param_str = f" ({', '.join(param_values)})" if param_values else ""
                
                target_name = self.isotp_target_var.get().split(" - ")[1] if " - " in self.isotp_target_var.get() else f"0x{tx_id:03X}"
                
                if msg_type_name == "ISO-TP_IO_CONTROL":
                    self.isotp_log.insert(tk.END, f"📤 SENT: {target_name} - {msg_type_name} - {cmd_type_name} - {command}{param_str}\n")
                    self.isotp_log.insert(tk.END, f"    TX ID: 0x{tx_id:03X}, Payload: MsgType=0x{msg_type:02X}, CmdType=0x{cmd_type:02X}, CmdID=0x{cmd_id:02X}, Data: {' '.join(f'{b:02X}' for b in can_data)}\n")
                else:
                    self.isotp_log.insert(tk.END, f"📤 SENT: {target_name} - {command}\n")
                    self.isotp_log.insert(tk.END, f"    TX ID: 0x{tx_id:03X}, Payload: MsgType=0x{msg_type:02X}, Data: {' '.join(f'{b:02X}' for b in can_data)}\n")
                self.isotp_log.see(tk.END)
                
            except Exception as e:
                self.isotp_log.insert(tk.END, f"❌ ERROR: Failed to send command: {e}\n")
                self.isotp_log.see(tk.END)
        else:
            messagebox.showerror("Command Too Long", "Multi-frame ISO-TP not yet implemented.")

    def clear_isotp_log(self):
        """Clear the ISO-TP communication log"""
        self.isotp_log.delete(1.0, tk.END)
    
    def on_dbf_file_changed(self):
        """Called when DBF file is reloaded - refresh both TX and RX message ID dropdowns"""
        if hasattr(self, 'target_combo') and hasattr(self, 'response_combo'):
            self.populate_message_ids()

    def on_can_message_received(self, msg):
        """Check if received message is an ISO-TP response and log it"""
        msg_id = msg.arbitration_id
        data = list(msg.data)
        
        if len(data) == 0:
            return
        
        # Filter by selected response ID
        selected_response_id = self.get_selected_response_id()
        if selected_response_id is not None and msg_id != selected_response_id:
            return  # Ignore messages that don't match the selected response ID
        
        # Check if this looks like an ISO-TP message (first byte has PCI pattern)
        pci = data[0] & 0xF0  # Protocol Control Information
        length = data[0] & 0x0F  # For single frame, this is the data length
        
        # Only process if it looks like ISO-TP (single frame or first frame)
        if pci not in [0x00, 0x10]:  # Not single frame or first frame
            return
        
        if pci == 0x00:  # Single frame
            if length == 0 or length > 7:
                return
            
            # Extract payload
            payload = data[1:1+length]
            
            if len(payload) == 0:
                return
            
            # First byte should be response code
            response_code = payload[0]
            response_data = payload[1:] if len(payload) > 1 else []
            
            # Format response based on response code
            if response_code == 0x00:  # CMD_SUCCESS
                status = "✅ SUCCESS"
                if response_data:
                    # Try to interpret response data based on length
                    if len(response_data) == 1:
                        # Single byte (digital input, etc.)
                        value = response_data[0]
                        data_str = f" - Value: {value}"
                    elif len(response_data) == 2:
                        # 16-bit value (analog input)
                        value = (response_data[1] << 8) | response_data[0]
                        data_str = f" - Value: {value}"
                    elif len(response_data) == 4:
                        # 32-bit float (voltage, current)
                        value = struct.unpack('<f', bytes(response_data))[0]
                        data_str = f" - Value: {value:.3f}"
                    else:
                        # Raw hex data
                        data_str = f" - Data: {' '.join(f'{b:02X}' for b in response_data)}"
                else:
                    data_str = ""
            else:
                # Error response
                error_names = {
                    0x01: "UNKNOWN_COMMAND",
                    0x02: "INVALID_LENGTH", 
                    0x03: "INVALID_PARAM",
                    0x04: "PERMISSION_DENIED",
                    0x05: "SYSTEM_BUSY"
                }
                error_name = error_names.get(response_code, f"ERROR_{response_code:02X}")
                status = f"❌ {error_name}"
                data_str = ""
            
            # Find message name from DBF if available
            msg_name = "Unknown"
            if hasattr(self.app, 'dbf_parser') and msg_id in self.app.dbf_parser.messages:
                msg_name = self.app.dbf_parser.messages[msg_id]['name']
            
            # Log the response
            self.isotp_log.insert(tk.END, f"📥 RECEIVED: {msg_name} (0x{msg_id:03X}) - {status}{data_str}\n")
            self.isotp_log.insert(tk.END, f"    RX ID: 0x{msg_id:03X}, Data: {' '.join(f'{b:02X}' for b in data)}\n\n")
            self.isotp_log.see(tk.END)
            
        elif pci == 0x10:  # First frame (multi-frame)
            # Find message name from DBF if available
            msg_name = "Unknown"
            if hasattr(self.app, 'dbf_parser') and msg_id in self.app.dbf_parser.messages:
                msg_name = self.app.dbf_parser.messages[msg_id]['name']
            
            # TODO: Implement multi-frame support
            self.isotp_log.insert(tk.END, f"📥 RECEIVED: {msg_name} (0x{msg_id:03X}) - Multi-frame response (not yet supported)\n")
            self.isotp_log.insert(tk.END, f"    RX ID: 0x{msg_id:03X}, Data: {' '.join(f'{b:02X}' for b in data)}\n\n")
            self.isotp_log.see(tk.END)