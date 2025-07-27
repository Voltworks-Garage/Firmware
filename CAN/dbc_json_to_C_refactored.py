# -*- coding: utf-8 -*-
"""
DBC JSON to C Code Generator - Refactored Version
Originally created on Sun Nov 13 18:12:47 2016 by kid group
Refactored for better readability and maintainability

Key Features:
- Generates setter functions for messages sent by each node
- Generates getter functions for messages consumed by each node
- Supports self-consumption: nodes can read their own messages if listed as consumers
- Handles multiplexed messages with automatic mux cycling
- Clean separation of concerns with focused functions
"""

import json
import os
import sys
from typing import Dict, List, Tuple, Any, Optional


def load_dbc_data(filename: str = 'dbc.json') -> Dict[str, Any]:
    """Load and validate DBC JSON data."""
    try:
        with open(filename) as data_file:
            data = json.load(data_file)
        print("CAN DBC file successfully found.\n")
        return data
    except FileNotFoundError:
        print(f"Error: {filename} not found")
        sys.exit(1)
    except json.JSONDecodeError:
        print("DBC JSON error found, press enter to quit.")
        input()
        sys.exit(1)


def create_output_directory(directory: str = "./generated") -> None:
    """Create output directory if it doesn't exist."""
    if not os.path.exists(directory):
        os.makedirs(directory)


def create_output_files(node_name: str) -> Tuple[Any, Any]:
    """Create and return file handles for .h and .c files."""
    hfile = f"generated/{node_name.lower()}_dbc.h"
    cfile = f"generated/{node_name.lower()}_dbc.c"
    dot_h = open(hfile, 'w')
    dot_c = open(cfile, 'w')
    return dot_h, dot_c


def write_file_headers(dot_h: Any, dot_c: Any, node_name: str) -> None:
    """Write header guards and includes to files."""
    # Header file guards and includes
    dot_h.write(f"#ifndef {node_name}_DBC_H\n")
    dot_h.write(f"#define {node_name}_DBC_H\n\n")
    dot_h.write("#include <stdint.h>\n")
    
    # C file includes
    dot_c.write(f"#include \"{node_name}_dbc.h\"\n")
    dot_c.write("#include \"CAN.h\"\n")
    dot_c.write("#include \"utils.h\"\n")


def write_node_enum(dot_h: Any, nodes: List[Dict[str, Any]]) -> None:
    """Write the CAN nodes enumeration."""
    dot_h.write("typedef enum{\n")
    for node in nodes:
        dot_h.write(f"    {node['name']},\n")
    dot_h.write("} CAN_nodes_E;\n\n")


def write_section_header(dot_h: Any, dot_c: Any, node_name: str) -> None:
    """Write section header comments for a node."""
    header = f"/**********************************************************\n * {node_name} NODE MESSAGES\n */\n"
    dot_h.write(header)
    dot_c.write(header)


def should_include_message(message: Dict[str, Any], message_node_idx: int, current_node_idx: int, target_node_name: str) -> bool:
    """Determine if a message should be included for the target node."""
    consumers = message.get("consumers")
    
    # Always include messages from the current node
    if message_node_idx == current_node_idx:
        return True
    
    # Include if no consumers specified or target node is in consumers
    if not consumers or target_node_name in consumers:
        return True
    
    return False


def should_generate_getters(message: Dict[str, Any], message_node_idx: int, current_node_idx: int, current_node_name: str) -> bool:
    """Determine if getter functions should be generated for this message."""
    consumers = message.get("consumers")
    
    # Generate getters for messages from other nodes that we consume
    if message_node_idx != current_node_idx:
        if not consumers or current_node_name in consumers:
            return True
    
    # Generate getters for our own messages if we're listed as a consumer
    if message_node_idx == current_node_idx:
        if consumers and current_node_name in consumers:
            return True
    
    return False


def calculate_signal_offsets(signals: List[Dict[str, Any]]) -> Tuple[int, Optional[str], Dict[int, List[Tuple[int, Dict[str, Any]]]]]:
    """Calculate bit offsets for signals, handling multiplex logic."""
    multiplex_signal = None
    mux_groups = {}
    non_mux_signals = []
    
    # Find multiplex signal and group signals
    for i, signal in enumerate(signals):
        if signal["name"].lower() == "multiplex":
            multiplex_signal = signal["name"]
            non_mux_signals.append((i, signal))
        elif signal.get("multiplex") is not None:
            mux_val = signal["multiplex"]
            if mux_val not in mux_groups:
                mux_groups[mux_val] = []
            mux_groups[mux_val].append((i, signal))
        else:
            non_mux_signals.append((i, signal))
    
    # Calculate offsets for non-mux signals first
    offset = 0
    for i, signal in non_mux_signals:
        signal["bitOffset"] = offset
        offset += signal["length"]
    
    # Calculate shared offsets for mux groups
    if mux_groups:
        mux_start_offset = offset
        max_offset = mux_start_offset
        
        for mux_val, signal_list in mux_groups.items():
            mux_offset = mux_start_offset
            for i, signal in signal_list:
                signal["bitOffset"] = mux_offset
                mux_offset += signal["length"]
            max_offset = max(max_offset, mux_offset)
        
        offset = max_offset
    
    return offset, multiplex_signal, mux_groups


def write_signal_defines(dot_c: Any, message_id: str, signal: Dict[str, Any], signal_name_suffix: str = "") -> None:
    """Write signal range and offset defines."""
    signal_define_name = f"{signal_name_suffix}_{signal['name'].upper()}" if signal_name_suffix else signal['name'].upper()
    dot_c.write(f"#define {message_id.upper()}_{signal_define_name}_RANGE {signal['length']}\n")
    dot_c.write(f"#define {message_id.upper()}_{signal_define_name}_OFFSET {signal['bitOffset']}\n")


def determine_signal_datatype(signal: Dict[str, Any]) -> Tuple[str, str]:
    """Determine appropriate data types for a signal."""
    units = signal["units"]
    length = signal["length"]
    
    if units in ["V", "A", "degC", "%"]:
        datatype = "float"
    elif length > 16:
        datatype = "uint32_t"
    else:
        datatype = "uint16_t"
    
    internal_datatype = "uint32_t" if length > 16 else "uint16_t"
    return datatype, internal_datatype


def generate_bit_manipulation_code(signal: Dict[str, Any], payload_target: str, accessor: str) -> List[str]:
    """Generate bit manipulation code for setting signal values."""
    bit_offset = signal["bitOffset"]
    bit_length = signal["length"]
    word = bit_offset // 16
    shift = bit_offset % 16
    
    code_lines = []
    
    if shift + bit_length <= 16:
        # Single word operation
        mask = ((1 << bit_length) - 1) << shift
        code_lines.append(f"\t{payload_target}{accessor}word{word} &= ~0x{mask:04X};")
        code_lines.append(f"\t{payload_target}{accessor}word{word} |= (data_scaled << {shift}) & 0x{mask:04X};")
    else:
        # Split across two words
        bits_first = 16 - shift
        bits_second = bit_length - bits_first
        low_mask = ((1 << bits_first) - 1) << shift
        high_mask = (1 << bits_second) - 1
        
        code_lines.append(f"\t{payload_target}{accessor}word{word} &= ~0x{low_mask:04X};")
        code_lines.append(f"\t{payload_target}{accessor}word{word} |= (data_scaled << {shift}) & 0x{low_mask:04X};")
        code_lines.append(f"\t{payload_target}{accessor}word{word + 1} &= ~0x{high_mask:04X};")
        code_lines.append(f"\t{payload_target}{accessor}word{word + 1} |= (data_scaled >> {bits_first}) & 0x{high_mask:04X};")
    
    return code_lines


def write_setter_function(dot_h: Any, dot_c: Any, message_id: str, signal: Dict[str, Any], 
                         function_name_suffix: str, multiplex_signal: Optional[str]) -> None:
    """Write a setter function for a signal."""
    signal_name = signal["name"]
    datatype, internal_datatype = determine_signal_datatype(signal)
    
    # Function declaration
    dot_h.write(f"void {message_id}_{function_name_suffix}_set({datatype} {signal_name});\n")
    
    # Function definition
    dot_c.write(f"void {message_id}_{function_name_suffix}_set({datatype} {signal_name}){{\n")
    
    # Data scaling
    if datatype == "float":
        dot_c.write(f"\t{internal_datatype} data_scaled = ({internal_datatype})(({signal_name} - {signal['offset']}) / {signal['scale']} + 0.5f);\n")
    else:
        dot_c.write(f"\t{internal_datatype} data_scaled = ({signal_name} - {signal['offset']}) / {signal['scale']};\n")
    
    # Determine payload target
    if signal.get("multiplex") is not None and multiplex_signal:
        mux_value = signal["multiplex"]
        payload_target = f"{message_id}_payloads[{mux_value}]"
        accessor = "."
    else:
        if multiplex_signal:
            payload_target = f"{message_id}.payload"
        else:
            payload_target = f"{message_id}.payload"
        accessor = "->"
    
    # Write bit manipulation code
    bit_code = generate_bit_manipulation_code(signal, payload_target, accessor)
    for line in bit_code:
        dot_c.write(line + "\n")
    
    dot_c.write("}\n")


def write_getter_function(dot_h: Any, dot_c: Any, message_id: str, signal: Dict[str, Any], 
                         function_name_suffix: str, signal_define_name: str, node_name: str, message_name: str,
                         is_multiplexed: bool = False, multiplex_value: Optional[int] = None, 
                         is_consumer: bool = True, is_producer: bool = False) -> None:
    """Write a getter function for a signal."""
    signal_name = signal["name"]
    units = signal["units"]
    
    datatype = "float" if units in ["V", "A", "degC"] else "uint16_t"
    
    dot_h.write(f"{datatype} {message_id}_{function_name_suffix}_get(void);\n")
    dot_c.write(f"{datatype} {message_id}_{function_name_suffix}_get(void){{\n")
    
    # For consumer nodes, add data freshness checking
    if is_consumer and not is_producer and is_multiplexed:
        dot_c.write(f"\t// Check for fresh data and update payload arrays if needed\n")
        dot_c.write(f"\tif (*{message_id}.canMessageStatus) {{\n")
        dot_c.write(f"\t\t// Fresh data received - determine which mux payload to update\n")
        dot_c.write(f"\t\tuint16_t mux_value = get_bits((size_t*){message_id}.payload, ")
        dot_c.write(f"{message_id.upper()}_MULTIPLEX_OFFSET, {message_id.upper()}_MULTIPLEX_RANGE);\n")  
        dot_c.write(f"\t\t// Copy fresh payload data to appropriate mux payload array\n")
        dot_c.write(f"\t\tif (mux_value < {message_id.upper()}_NUM_MUX_VALUES) {{\n")
        dot_c.write(f"\t\t\t// Copy the entire payload structure to the appropriate mux array\n")
        dot_c.write(f"\t\t\t{message_id}_payloads[mux_value] = *{message_id}.payload;\n")
        dot_c.write(f"\t\t}}\n")
        dot_c.write(f"\t}}\n")
        dot_c.write(f"\t\n")
    
    # Determine the correct payload source
    if is_multiplexed and multiplex_value is not None:
        # For multiplexed signals, read from specific payload array
        payload_source = f"&{message_id}_payloads[{multiplex_value}]"
    elif is_multiplexed and signal["name"].lower() == "multiplex":
        # For multiplex signal itself, read from main payload (current message)
        payload_source = f"{message_id}.payload"
    else:
        # For non-multiplexed messages, use main payload
        payload_source = f"{message_id}.payload"
    
    dot_c.write(f"\tuint16_t data = get_bits((size_t*){payload_source}, ")
    dot_c.write(f"{message_id.upper()}_{signal_define_name}_OFFSET, ")
    dot_c.write(f"{message_id.upper()}_{signal_define_name}_RANGE);\n")
    dot_c.write(f"\treturn (data * {signal['scale']}) + {signal['offset']};\n}}\n")


def process_message_signals(dot_h: Any, dot_c: Any, node: Dict[str, Any], message: Dict[str, Any], 
                           current_node_idx: int, node_idx: int, current_node_name: str) -> None:
    """Process all signals for a message."""
    signals = message["signals"]
    node_name = node["name"]
    message_name = message["name"]
    message_id = f"CAN_{node_name}_{message_name}"
    
    print(f"\t{message_name}")
    
    # Calculate signal offsets
    total_offset, multiplex_signal, _ = calculate_signal_offsets(signals)
    
    # Write signal defines
    for signal in signals:
        if multiplex_signal and signal["name"].lower() == "multiplex":
            write_signal_defines(dot_c, message_id, signal)
        elif signal.get("multiplex") is not None and multiplex_signal:
            mux_value = signal["multiplex"]
            write_signal_defines(dot_c, message_id, signal, f"M{mux_value}")
        else:
            write_signal_defines(dot_c, message_id, signal)
        print(f"\t\t{signal['name']}")
    
    # Check for data overflow
    is_multiplexed = multiplex_signal is not None
    if total_offset > 64 and not is_multiplexed:
        print(f"ERROR: too much data in {message_name}. Press any key to quit and try again.")
        input()
        sys.exit(1)
    elif is_multiplexed:
        print(f"  Note: {message_name} is multiplexed - signals will share bit positions based on mux value")
    
    dot_c.write("\n")
    
    # Determine what functions to generate
    generate_setters = (node_idx == current_node_idx)
    generate_getters = should_generate_getters(message, node_idx, current_node_idx, current_node_name)
    
    # Generate setter functions for our node's messages
    if generate_setters:
        for signal in signals:
            if multiplex_signal and signal["name"].lower() == "multiplex":
                continue  # Skip multiplex signal itself
            
            function_name_suffix = signal["name"]
            if signal.get("multiplex") is not None and multiplex_signal:
                mux_value = signal["multiplex"]
                function_name_suffix = f"M{mux_value}_{signal['name']}"
            
            write_setter_function(dot_h, dot_c, message_id, signal, function_name_suffix, multiplex_signal)
    
    # Generate getter functions when needed
    if generate_getters:
        # Generate NUM_MUX_VALUES define for multiplexed messages consumed by this node
        if multiplex_signal and node_idx != current_node_idx:
            max_mux_value = max((signal.get("multiplex", -1) for signal in signals 
                               if signal.get("multiplex") is not None), default=0)
            num_mux_groups = max_mux_value + 1
            dot_h.write(f"#define {message_id.upper()}_NUM_MUX_VALUES {num_mux_groups}\n")
        
        dot_h.write(f"uint8_t {message_id}_checkDataIsFresh(void);\n")
        dot_c.write(f"uint8_t {message_id}_checkDataIsFresh(void){{\n")
        dot_c.write(f"\treturn CAN_checkDataIsFresh(&{message_id});\n}}\n")
        
        for signal in signals:
            function_name_suffix = signal["name"]
            signal_define_name = signal["name"].upper()
            mux_value = None
            
            if signal.get("multiplex") is not None and multiplex_signal:
                mux_value = signal["multiplex"]
                function_name_suffix = f"M{mux_value}_{signal['name']}"
                signal_define_name = f"M{mux_value}_{signal['name'].upper()}"
            
            # Determine if this is a producer or consumer relationship
            is_producer = (node_idx == current_node_idx)
            is_consumer = not is_producer or (is_producer and current_node_name in message.get("consumers", []))
            
            write_getter_function(dot_h, dot_c, message_id, signal, function_name_suffix, 
                                signal_define_name, node_name, message_name,
                                is_multiplexed=(multiplex_signal is not None), 
                                multiplex_value=mux_value,
                                is_consumer=is_consumer,
                                is_producer=is_producer)
        
        dot_h.write("\n")
        dot_c.write("\n")


def setup_message_payload(dot_c: Any, message_id: str, message: Dict[str, Any]) -> str:
    """Setup message payload structure and return payload initialization string."""
    signals = message["signals"]
    
    # Check for multiplex
    has_multiplex = any(signal.get("multiplex") is not None for signal in signals)
    multiplex_signal_found = any(signal["name"].lower() == "multiplex" for signal in signals)
    
    if has_multiplex and multiplex_signal_found:
        # Multiplexed message - create payload array
        max_mux_value = max((signal.get("multiplex", -1) for signal in signals 
                           if signal.get("multiplex") is not None), default=0)
        num_mux_groups = max_mux_value + 1
        
        dot_c.write(f"static CAN_payload_S {message_id}_payloads[{num_mux_groups}] __attribute__((aligned(sizeof(CAN_payload_S))));\n")
        dot_c.write(f"static uint8_t {message_id}_mux = 0;\n")
        
        return ".payload = 0"
    else:
        # Non-multiplexed message
        dot_c.write(f"static CAN_payload_S {message_id}_payload __attribute__((aligned(sizeof(CAN_payload_S))));\n")
        return f".payload = &{message_id}_payload"


def setup_tx_message_payload(dot_c: Any, message_id: str, message: Dict[str, Any]) -> str:
    """Setup message payload structure for TX messages and return payload initialization string."""
    signals = message["signals"]
    
    # Check for multiplex
    has_multiplex = any(signal.get("multiplex") is not None for signal in signals)
    multiplex_signal_found = any(signal["name"].lower() == "multiplex" for signal in signals)
    
    if has_multiplex and multiplex_signal_found:
        # Multiplexed message - create payload array
        max_mux_value = max((signal.get("multiplex", -1) for signal in signals 
                           if signal.get("multiplex") is not None), default=0)
        num_mux_groups = max_mux_value + 1
        
        dot_c.write(f"static CAN_payload_S {message_id}_payloads[{num_mux_groups}] __attribute__((aligned(sizeof(CAN_payload_S))));\n")
        dot_c.write(f"static uint8_t {message_id}_mux = 0;\n")
        payload_init = ".payload = 0"
    else:
        # Non-multiplexed message
        dot_c.write(f"static CAN_payload_S {message_id}_payload __attribute__((aligned(sizeof(CAN_payload_S))));\n")
        payload_init = f".payload = &{message_id}_payload"
    
    # Generate static status variable for TX messages
    dot_c.write(f"static volatile uint8_t {message_id}_status = 0;\n")
    
    return payload_init


def write_message_structure(dot_c: Any, _: Any, message_id: str, message: Dict[str, Any], payload_init: str, is_tx: bool = False) -> None:
    """Write the CAN message structure definition."""
    message_id_hex = hex(message["id"])
    can_xid = message.get("x_id", 0)
    
    # Write message ID define
    dot_c.write(f"#define {message_id}_ID {message_id_hex}\n\n")
    
    # Set canMessageStatus based on whether this is a TX or RX message
    if is_tx:
        # TX message - point to the static status variable
        status_init = f".canMessageStatus = &{message_id}_status"
    else:
        # RX message - initialize to 0 (will be set by CAN driver)
        status_init = ".canMessageStatus = 0"
    
    # Write message structure
    dot_c.write(f"static CAN_message_S {message_id}={{\n")
    dot_c.write(f"\t.canID = {message_id}_ID,\n")
    dot_c.write(f"\t.canXID = {can_xid},\n")
    dot_c.write(f"\t.dlc = 8,\n")
    dot_c.write(f"\t{payload_init},\n")
    dot_c.write(f"\t{status_init}\n}};\n\n")


def write_send_functions(dot_h: Any, dot_c: Any, node: Dict[str, Any], message: Dict[str, Any], is_self_consumed: bool = False) -> None:
    """Write send functions for a message."""
    node_name = node["name"]
    message_name = message["name"]
    message_id = f"CAN_{node_name}_{message_name}"
    signals = message["signals"]
    
    # DLC setter function
    dot_h.write(f"void CAN_{node_name}_{message_name}_dlc_set(uint8_t dlc);\n\n\n")
    dot_c.write(f"void CAN_{node_name}_{message_name}_dlc_set(uint8_t dlc){{\n")
    dot_c.write(f"\tCAN_{node_name}_{message_name}.dlc = dlc;\n}}\n")
    
    # Send function
    dot_h.write(f"void CAN_{node_name}_{message_name}_send(void);\n\n\n")
    
    # Check if multiplexed
    has_multiplex = any(signal.get("multiplex") is not None for signal in signals)
    multiplex_signal_found = any(signal["name"].lower() == "multiplex" for signal in signals)
    
    if has_multiplex and multiplex_signal_found:
        # Multiplexed message - auto-cycle through mux values
        max_mux_value = max((signal.get("multiplex", -1) for signal in signals 
                           if signal.get("multiplex") is not None), default=0)
        num_mux_groups = max_mux_value + 1
        
        dot_h.write(f"#define {message_id.upper()}_NUM_MUX_VALUES {num_mux_groups}\n")
        
        dot_c.write(f"void CAN_{node_name}_{message_name}_send(void){{\n")
        dot_c.write(f"\t// Update message status for self-consumption\n")
        dot_c.write(f"\t*CAN_{node_name}_{message_name}.canMessageStatus = 1;\n")
        dot_c.write(f"\t// Auto-select current mux payload\n")
        dot_c.write(f"\tCAN_{node_name}_{message_name}.payload = &CAN_{node_name}_{message_name}_payloads[CAN_{node_name}_{message_name}_mux];\n")
        dot_c.write(f"\t// Send the message\n")
        dot_c.write(f"\tCAN_write(CAN_{node_name}_{message_name});\n")
        dot_c.write(f"\t// Increment mux counter for next time\n")
        dot_c.write(f"\tCAN_{node_name}_{message_name}_mux++;\n")
        dot_c.write(f"\tif (CAN_{node_name}_{message_name}_mux >= {message_id.upper()}_NUM_MUX_VALUES) {{\n")
        dot_c.write(f"\t\tCAN_{node_name}_{message_name}_mux = 0;\n")
        dot_c.write(f"\t}}\n}}\n\n")
    else:
        # Non-multiplexed message
        dot_c.write(f"void CAN_{node_name}_{message_name}_send(void){{\n")
        dot_c.write(f"\t// Update message status for self-consumption\n")
        dot_c.write(f"\t*CAN_{node_name}_{message_name}.canMessageStatus = 1;\n")
        dot_c.write(f"\tCAN_write(CAN_{node_name}_{message_name});\n}}\n\n")


def process_node_messages(dot_h: Any, dot_c: Any, nodes: List[Dict[str, Any]], current_node_idx: int) -> Dict[str, List[str]]:
    """Process all messages for all nodes, generating appropriate code."""
    send_message_dict = {}
    current_node_name = nodes[current_node_idx]["name"]
    
    for node_idx, node in enumerate(nodes):
        node_name = node["name"]
        messages = node["messages"]
        
        write_section_header(dot_h, dot_c, node_name)
        print(f"Node {node_name} has {len(messages)} messages")
        
        for message in messages:
            message_name = message["name"]
            message_freq = message.get("freq")
            message_id = f"CAN_{node_name}_{message_name}"
            
            # Check if we should include this message
            if not should_include_message(message, node_idx, current_node_idx, current_node_name):
                continue
            
            # Write frequency interval define
            if message_freq:
                dot_h.write(f"#define CAN_{node_name}_{message_name}_interval() {message_freq}\n")
            
            # Setup message payload and structure
            if node_idx == current_node_idx:
                # TX message - use special TX setup with status variable
                payload_init = setup_tx_message_payload(dot_c, message_id, message)
                is_tx = True
            else:
                # For consumer nodes, check if they need payload arrays for multiplexed messages
                generate_getters = should_generate_getters(message, node_idx, current_node_idx, current_node_name)
                if generate_getters:
                    signals = message["signals"]
                    has_multiplex = any(signal.get("multiplex") is not None for signal in signals)
                    multiplex_signal_found = any(signal["name"].lower() == "multiplex" for signal in signals)
                    
                    if has_multiplex and multiplex_signal_found:
                        # Consumer needs payload arrays for multiplexed message
                        payload_init = setup_message_payload(dot_c, message_id, message)
                    else:
                        payload_init = ".payload = 0"
                else:
                    payload_init = ".payload = 0"
                is_tx = False
            
            write_message_structure(dot_c, dot_h, message_id, message, payload_init, is_tx)
            
            # checkDataIsFresh is now generated in process_message_signals when getters are needed
            
            # Process all signals in this message
            process_message_signals(dot_h, dot_c, node, message, current_node_idx, node_idx, current_node_name)
            
            # Generate send functions for our node's messages
            if node_idx == current_node_idx:
                is_self_consumed = should_generate_getters(message, node_idx, current_node_idx, current_node_name)
                write_send_functions(dot_h, dot_c, node, message, is_self_consumed)
                
                # Track messages by frequency for frequency-based send functions
                if message_freq:
                    freq_key = str(message_freq)
                    if freq_key not in send_message_dict:
                        send_message_dict[freq_key] = []
                    send_message_dict[freq_key].append(f"CAN_{node_name}_{message_name}_send")
    
    return send_message_dict


def write_initialization_function(dot_c: Any, nodes: List[Dict[str, Any]], current_node_idx: int) -> None:
    """Write the CAN DBC initialization function."""
    dot_c.write("void CAN_DBC_init(void) {\n")
    current_node_name = nodes[current_node_idx]["name"]
    
    # Initialize multiplexed message payloads for current node
    current_node = nodes[current_node_idx]
    for message in current_node["messages"]:
        message_name = message["name"]
        message_id = f"CAN_{current_node['name']}_{message_name}"
        signals = message["signals"]
        
        # Check if multiplexed
        has_multiplex = any(signal.get("multiplex") is not None for signal in signals)
        multiplex_signal_found = any(signal["name"].lower() == "multiplex" for signal in signals)
        
        if has_multiplex and multiplex_signal_found:
            dot_c.write(f"\t// Initialize multiplexed message: {message_name}\n")
            dot_c.write(f"\t{message_id}.payload = &{message_id}_payloads[0];\n")
            
            # Pre-set mux values in each payload
            max_mux_value = max((signal.get("multiplex", -1) for signal in signals 
                               if signal.get("multiplex") is not None), default=0)
            num_mux_groups = max_mux_value + 1
            
            # Find multiplex signal for bit manipulation
            for signal in signals:
                if signal["name"].lower() == "multiplex":
                    bit_offset = signal["bitOffset"]
                    bit_length = signal["length"]
                    word = bit_offset // 16
                    shift = bit_offset % 16
                    
                    # Pre-set mux value in each payload
                    for mux_val in range(num_mux_groups):
                        dot_c.write(f"\t// Pre-set mux value {mux_val} in payload {mux_val}\n")
                        bit_code = generate_bit_manipulation_code(
                            signal, f"{message_id}_payloads[{mux_val}]", ".")
                        for line in bit_code:
                            # Modify the line to set the mux value instead of data_scaled
                            modified_line = line.replace("data_scaled", str(mux_val))
                            dot_c.write(modified_line + "\n")
                    break
    
    # Configure mailboxes for received messages
    for node_idx, node in enumerate(nodes):
        if node_idx == current_node_idx:
            continue
            
        for message in node["messages"]:
            # Check if we should include this message
            if not should_include_message(message, node_idx, current_node_idx, current_node_name):
                continue
                
            message_id = f"CAN_{node['name']}_{message['name']}"
            dot_c.write(f"\tCAN_configureMailbox(&{message_id});\n")
    
    dot_c.write("}\n")


def write_frequency_send_functions(dot_h: Any, dot_c: Any, send_message_dict: Dict[str, List[str]]) -> None:
    """Write frequency-based send functions."""
    for freq, messages in send_message_dict.items():
        dot_h.write(f"void CAN_send_{freq}ms(void);\n")
        dot_c.write(f"\nvoid CAN_send_{freq}ms(void){{\n")
        for message_func in messages:
            dot_c.write(f"\t{message_func}();\n")
        dot_c.write("}\n")


def write_file_footers(dot_h: Any, node_name: str) -> None:
    """Write file footers and close header guards."""
    dot_h.write(f"\n\n#endif /*{node_name}_DBC_H*/\n")


def process_single_node(nodes: List[Dict[str, Any]], node_idx: int) -> None:
    """Process a single node and generate its DBC files."""
    node = nodes[node_idx]
    node_name = node["name"]
    
    print(f"Generating dbc.h and dbc.c for {node_name}")
    
    # Create output files
    dot_h, dot_c = create_output_files(node_name)
    
    try:
        # Write file headers
        write_file_headers(dot_h, dot_c, node_name)
        
        # Write node enumeration
        write_node_enum(dot_h, nodes)
        
        # Process all messages
        send_message_dict = process_node_messages(dot_h, dot_c, nodes, node_idx)
        
        # Write initialization function
        dot_h.write("void CAN_DBC_init();\n\n")
        write_initialization_function(dot_c, nodes, node_idx)
        
        # Write frequency-based send functions
        write_frequency_send_functions(dot_h, dot_c, send_message_dict)
        
        # Write file footers
        write_file_footers(dot_h, node_name)
        
    finally:
        dot_h.close()
        dot_c.close()


def main() -> None:
    """Main function to orchestrate the DBC to C conversion process."""
    # Setup
    create_output_directory()
    
    # Load data
    data = load_dbc_data()
    nodes = data["NODE"]
    
    # Process each node
    for node_idx in range(len(nodes)):
        process_single_node(nodes, node_idx)
    
    print("DBC files successfully generated! Press enter to quit")
    input()


if __name__ == "__main__":
    main()