"""
DBF Parser
==========

This module provides functionality to parse Busmaster DBF files for CAN signal definitions.
The BusmasterDBFParser class can decode CAN messages based on signal definitions from DBF files.
"""

import os


class BusmasterDBFParser:
    """Parser for Busmaster DBF files containing CAN message and signal definitions"""
    
    def __init__(self, dbf_path):
        """Initialize parser and load DBF file"""
        self.dbf_path = dbf_path
        self.messages = {}
        self.parse_dbf(dbf_path)
    
    def parse_dbf(self, dbf_path):
        """Parse a DBF file and extract message and signal definitions"""
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
        """Extract a signal value from CAN message data bytes"""
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
        """Decode a CAN message using signal definitions from the DBF file"""
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