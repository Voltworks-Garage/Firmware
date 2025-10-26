#!/usr/bin/env python3
"""
ESP32 CAN Decoder Generator
Generates platform-agnostic CAN decoder files from dbc.json
No PIC-specific dependencies - works with ESP32 TWAI driver
"""

import json
import os
import sys

def extract_bits_code(start_bit, num_bits):
    """Generate C code to extract bits from CAN data array"""
    byte_pos = start_bit // 8
    bit_offset = start_bit % 8

    if num_bits <= (8 - bit_offset) and num_bits <= 8:
        # Fits in single byte
        mask = (1 << num_bits) - 1
        return f"(data[{byte_pos}] >> {bit_offset}) & 0x{mask:02X}"
    elif num_bits <= 16:
        # Spans up to 2 bytes
        return f"((data[{byte_pos}] >> {bit_offset}) | (data[{byte_pos+1}] << {8-bit_offset})) & 0x{((1 << num_bits) - 1):04X}"
    else:
        # For larger values, use helper function
        return f"CAN_ExtractBits(data, {start_bit}, {num_bits})"

def generate_esp32_decoder(output_dir="./generated"):
    """Generate ESP32-compatible decoder (hardcoded for 'dash' node)"""

    node_name = "dash"  # Hardcoded for now

    # Create output directory
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Load DBC JSON
    try:
        with open('dbc.json') as f:
            data = json.load(f)
    except Exception as e:
        print(f"Error loading dbc.json: {e}")
        sys.exit(1)

    # Find the target node
    target_node = None
    for node in data["NODE"]:
        if node["name"].lower() == node_name.lower():
            target_node = node
            break

    if not target_node:
        print(f"Node '{node_name}' not found in dbc.json")
        sys.exit(1)

    print(f"Generating ESP32 decoder for node: {node_name}")

    hfile_path = f"{output_dir}/{node_name.lower()}_can_decoder.h"
    cfile_path = f"{output_dir}/{node_name.lower()}_can_decoder.cpp"

    with open(hfile_path, 'w') as h, open(cfile_path, 'w') as c:
        # Write header file
        guard = f"{node_name.upper()}_CAN_DECODER_H"
        h.write(f"#ifndef {guard}\n")
        h.write(f"#define {guard}\n\n")
        h.write("#include <Arduino.h>\n")
        h.write("#include \"driver/twai.h\"\n\n")
        h.write("// Auto-generated CAN decoder for ESP32\n")
        h.write(f"// Node: {node_name}\n\n")

        # Write C file header
        c.write(f"#include \"{node_name.lower()}_can_decoder.h\"\n\n")
        c.write("// Auto-generated CAN decoder implementation\n\n")

        # Helper function for extracting bits
        h.write("// Helper function to extract bits from CAN data\n")
        h.write("uint32_t CAN_ExtractBits(const uint8_t* data, uint16_t startBit, uint8_t numBits);\n")
        h.write("float CAN_ExtractFloat(const uint8_t* data, uint16_t startBit, uint8_t numBits, float scale, float offset);\n\n")

        c.write("uint32_t CAN_ExtractBits(const uint8_t* data, uint16_t startBit, uint8_t numBits) {\n")
        c.write("  uint32_t value = 0;\n")
        c.write("  for (uint8_t i = 0; i < numBits; i++) {\n")
        c.write("    uint16_t bitPos = startBit + i;\n")
        c.write("    uint8_t bytePos = bitPos / 8;\n")
        c.write("    uint8_t bitOffset = bitPos % 8;\n")
        c.write("    if (data[bytePos] & (1 << bitOffset)) {\n")
        c.write("      value |= (1 << i);\n")
        c.write("    }\n")
        c.write("  }\n")
        c.write("  return value;\n")
        c.write("}\n\n")

        c.write("float CAN_ExtractFloat(const uint8_t* data, uint16_t startBit, uint8_t numBits, float scale, float offset) {\n")
        c.write("  uint32_t raw = CAN_ExtractBits(data, startBit, numBits);\n")
        c.write("  return (raw * scale) + offset;\n")
        c.write("}\n\n")

        # Process all nodes to find messages this node consumes
        message_id_map = {}

        for node in data["NODE"]:
            for msg in node["messages"]:
                msg_id = int(msg["id"], 16)
                msg_name = f"{node['name']}_{msg['name']}"

                # Check if this node consumes this message
                is_sender = (node["name"] == node_name)
                is_consumer = False

                if "consumers" in msg:
                    is_consumer = node_name in msg["consumers"]

                # Only generate decoders for messages this node receives
                if not is_sender or is_consumer:
                    message_id_map[msg_id] = {
                        "name": msg_name,
                        "node": node["name"],
                        "msg": msg,
                        "signals": msg["signals"]
                    }

        # Generate message ID defines
        h.write("// CAN Message IDs\n")
        for msg_id, info in sorted(message_id_map.items()):
            define_name = f"CAN_ID_{info['name'].upper()}"
            h.write(f"#define {define_name:50s} 0x{msg_id:03X}\n")
        h.write("\n")

        # Generate structures for decoded messages
        h.write("// Decoded message structures\n")
        for msg_id, info in sorted(message_id_map.items()):
            struct_name = f"{info['name']}_T"
            h.write(f"typedef struct {{\n")
            h.write(f"  bool valid;  // Set to true after successful decode\n")
            h.write(f"  uint32_t timestamp_ms;  // Timestamp of last update\n")

            # Check for multiplex
            has_multiplex = any('multiplex' in sig for sig in info['signals'])
            if has_multiplex:
                h.write(f"  uint16_t multiplex;  // Multiplex value\n")

            # Add signal fields
            for sig in info['signals']:
                if sig['name'].lower() == 'multiplex':
                    continue

                sig_name = sig['name']
                sig_len = sig['length']

                # Determine type
                if sig_len == 1:
                    sig_type = "bool"
                elif sig_len <= 8:
                    sig_type = "uint8_t"
                elif sig_len <= 16:
                    sig_type = "uint16_t"
                elif sig_len <= 32:
                    sig_type = "uint32_t"
                else:
                    sig_type = "uint64_t"

                # Use float if scale/offset applied
                if sig['scale'] != 1.0 or sig['offset'] != 0:
                    sig_type = "float"

                units = sig.get('units', '')
                units_comment = f"  // {units}" if units else ""
                h.write(f"  {sig_type:12s} {sig_name};{units_comment}\n")

            h.write(f"}} {struct_name};\n\n")

        # Generate decoder function declarations
        h.write("// Decoder functions\n")
        for msg_id, info in sorted(message_id_map.items()):
            func_name = f"CAN_Decode_{info['name']}"
            struct_name = f"{info['name']}_T"
            h.write(f"void {func_name}(const twai_message_t* msg, {struct_name}* out);\n")
        h.write("\n")

        # Generate decoder function implementations
        for msg_id, info in sorted(message_id_map.items()):
            func_name = f"CAN_Decode_{info['name']}"
            struct_name = f"{info['name']}_T"

            c.write(f"void {func_name}(const twai_message_t* msg, {struct_name}* out) {{\n")
            c.write(f"  if (msg == NULL || out == NULL) return;\n")
            c.write(f"  if (msg->identifier != 0x{msg_id:03X}) return;\n\n")
            c.write(f"  const uint8_t* data = msg->data;\n")
            c.write(f"  out->valid = true;\n")
            c.write(f"  out->timestamp_ms = millis();\n\n")

            # Decode signals
            bit_offset = 0
            for sig in info['signals']:
                sig_name = sig['name']
                sig_len = sig['length']
                sig_scale = sig['scale']
                sig_offset = sig['offset']

                if sig_name.lower() == 'multiplex':
                    c.write(f"  out->multiplex = {extract_bits_code(bit_offset, sig_len)};\n\n")
                else:
                    if sig_scale != 1.0 or sig_offset != 0:
                        c.write(f"  out->{sig_name} = CAN_ExtractFloat(data, {bit_offset}, {sig_len}, {sig_scale}, {sig_offset});\n")
                    else:
                        if sig_len == 1:
                            c.write(f"  out->{sig_name} = ({extract_bits_code(bit_offset, sig_len)}) ? true : false;\n")
                        else:
                            c.write(f"  out->{sig_name} = {extract_bits_code(bit_offset, sig_len)};\n")

                bit_offset += sig_len

            c.write(f"}}\n\n")

        # Close header guard
        h.write(f"#endif // {guard}\n")

    print(f"Generated: {hfile_path}")
    print(f"Generated: {cfile_path}")

if __name__ == "__main__":
    generate_esp32_decoder()
