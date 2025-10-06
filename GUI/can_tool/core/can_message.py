"""
CAN Message Management
======================

This module provides data structures and management classes for CAN messages:
- CANMessage: Data class representing a single CAN message and its state
- CANMessageManager: Manages message storage, decoding, and expansion state
"""

import time
from typing import Dict, Optional

try:
    from dataclasses import dataclass
except ImportError:
    # Fallback for Python < 3.7
    def dataclass(cls):
        return cls


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
    # For multiplexed messages - accumulate all received signals
    accumulated_mux_signals: Optional[Dict[str, str]] = None
    last_mux_value: Optional[int] = None
    
    def __post_init__(self):
        if self.signal_item_ids is None:
            self.signal_item_ids = {}
        if self.accumulated_mux_signals is None:
            self.accumulated_mux_signals = {}


class CANMessageManager:
    """Manages CAN message storage, decoding, and expansion state"""
    
    def __init__(self, dbf_parser):
        """Initialize with a DBF parser instance"""
        self.dbf_parser = dbf_parser
        self.messages: Dict[int, CANMessage] = {}
        self.bus_utilization_data = {
            'total_bits_per_second': 0,
            'bitrate': 500000,  # Default bitrate
            'utilization_percent': 0.0,
            'last_calculation_time': time.time(),
            'message_rates': {}  # msg_id -> bits/second
        }
    
    def update_message(self, msg_id: int, dlc: int, data: bytes) -> CANMessage:
        """Update or create a CAN message"""
        now = time.time()
        
        # Decode the message
        decoded = self.dbf_parser.decode_message(msg_id, data)
        msg_name = decoded['name'] if decoded else "Unknown"
        decoded_signals = decoded['signals'] if decoded else None
        is_multiplexed = decoded.get('is_multiplexed', False) if decoded else False
        multiplex_value = decoded.get('multiplex_value') if decoded else None
        
        if msg_id in self.messages:
            # Update existing message
            msg = self.messages[msg_id]
            
            # Calculate cycle time from actual message intervals
            if hasattr(msg, '_prev_msg_time') and msg._prev_msg_time is not None:
                cycle_ms = (now - msg._prev_msg_time) * 1000
                msg.cycle_time_str = f"{cycle_ms:.1f} ms"
            else:
                msg.cycle_time_str = "-"
            
            msg._prev_msg_time = now
            msg.dlc = dlc
            msg.data = data
            msg.count += 1
            msg.last_time = now
            msg.decoded_signals = decoded_signals
            msg.last_mux_value = multiplex_value
            
            # For multiplexed messages, accumulate all received signals
            if is_multiplexed and decoded_signals:
                self._accumulate_mux_signals(msg, decoded_signals, multiplex_value)
                
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
            msg.cycle_time_str = "-"
            msg._prev_msg_time = now
            msg.last_mux_value = multiplex_value
            self.messages[msg_id] = msg
            
            # For multiplexed messages, initialize accumulation
            if is_multiplexed and decoded_signals:
                self._accumulate_mux_signals(msg, decoded_signals, multiplex_value)
        
        # Trigger bus utilization calculation periodically
        if now - self.bus_utilization_data['last_calculation_time'] > 1.0:
            self._calculate_bus_utilization()
        
        return msg
    
    def _accumulate_mux_signals(self, msg: CANMessage, decoded_signals: Dict[str, dict], multiplex_value: Optional[int]):
        """Accumulate signals from multiplexed messages for complete view"""
        if not decoded_signals:
            return
            
        # Get signal order from DBF file for proper sorting
        dbf_signal_order = {}
        if msg.msg_id in self.dbf_parser.messages:
            msg_def = self.dbf_parser.messages[msg.msg_id]
            for i, signal in enumerate(msg_def['signals']):
                dbf_signal_order[signal['name']] = i
            
        # Update accumulated signals with new values
        for signal_name, signal_data in decoded_signals.items():
            # Store the signal with current timestamp and sorting info for freshness tracking
            msg.accumulated_mux_signals[signal_name] = {
                'value': signal_data['value'],
                'raw_value': signal_data.get('raw_value'),  # Include raw value for graphing
                'units': signal_data.get('units', ''),  # Include units for future use
                'timestamp': time.time(),
                'mux_value': signal_data['multiplex_value'],
                'byte_pos': signal_data['byte_pos'],
                'bit_pos': signal_data['bit_pos'],
                'dbf_order': dbf_signal_order.get(signal_name, 999)
            }
    
    def get_display_signals(self, msg: CANMessage) -> Dict[str, str]:
        """Get signals to display - for multiplexed messages, show accumulated signals"""
        if not msg.decoded_signals:
            return {}
            
        # Check if this is a multiplexed message with accumulated signals
        if msg.accumulated_mux_signals:
            current_time = time.time()
            display_signals = {}
            
            # Show accumulated signals (mark stale ones) in sorted order
            sorted_signals = self._sort_mux_signals(msg.accumulated_mux_signals)
            
            for signal_name, signal_info in sorted_signals.items():
                age = current_time - signal_info['timestamp']
                value = signal_info['value']
                
                display_signals[signal_name] = value
            
            return display_signals
        else:
            # Non-multiplexed message - extract values from signal dict structure
            display_signals = {}
            for signal_name, signal_data in msg.decoded_signals.items():
                if isinstance(signal_data, dict):
                    display_signals[signal_name] = signal_data['value']
                else:
                    display_signals[signal_name] = signal_data
            return display_signals
    
    def _sort_mux_signals(self, accumulated_signals: Dict[str, Dict]) -> Dict[str, Dict]:
        """Sort multiplexed signals by DBF file order"""
        def signal_sort_key(item):
            signal_name = item[0]
            signal_info = item[1]
            
            # Use DBF file order for sorting
            dbf_order = signal_info.get('dbf_order', 999)
            
            # Sort by: DBF order first, then signal name as fallback
            return (dbf_order, signal_name)
        
        sorted_items = sorted(accumulated_signals.items(), key=signal_sort_key)
        sorted_dict = dict(sorted_items)
        return sorted_dict
    
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
        self.bus_utilization_data['message_rates'].clear()
        self.bus_utilization_data['total_bits_per_second'] = 0
        self.bus_utilization_data['utilization_percent'] = 0.0
    
    def set_bitrate(self, bitrate: int):
        """Set the bus bitrate for utilization calculations"""
        self.bus_utilization_data['bitrate'] = bitrate
        self._calculate_bus_utilization()
    
    def _calculate_can_frame_bits(self, dlc: int) -> int:
        """Calculate the number of bits for a CAN frame including overhead"""
        # CAN 2.0 frame structure:
        # SOF (1) + ID (11) + RTR (1) + IDE (1) + r0 (1) + DLC (4) + Data (0-64) + CRC (15) + CRC_DEL (1) + ACK (1) + ACK_DEL (1) + EOF (7) + IFS (3)
        # Total overhead: 47 bits + data bits
        data_bits = dlc * 8
        total_bits = 47 + data_bits
        
        # Add bit stuffing overhead (approximately 20% worst case)
        stuffing_overhead = int(total_bits * 0.2)
        return total_bits + stuffing_overhead
    
    def _calculate_bus_utilization(self):
        """Calculate current bus utilization percentage"""
        now = time.time()
        
        # Calculate message rates and total bits per second
        total_bits_per_second = 0
        
        for msg_id, msg in self.messages.items():
            if hasattr(msg, '_prev_msg_time') and msg._prev_msg_time is not None and msg.count > 1:
                # Calculate frequency from cycle time
                if hasattr(msg, 'cycle_time_str') and msg.cycle_time_str != "-":
                    try:
                        cycle_ms = float(msg.cycle_time_str.replace(' ms', ''))
                        if cycle_ms > 0:
                            frequency_hz = 1000.0 / cycle_ms
                            frame_bits = self._calculate_can_frame_bits(msg.dlc)
                            bits_per_second = frequency_hz * frame_bits
                            
                            self.bus_utilization_data['message_rates'][msg_id] = {
                                'frequency_hz': frequency_hz,
                                'frame_bits': frame_bits,
                                'bits_per_second': bits_per_second
                            }
                            total_bits_per_second += bits_per_second
                    except (ValueError, AttributeError):
                        pass
        
        self.bus_utilization_data['total_bits_per_second'] = total_bits_per_second
        
        # Calculate utilization percentage
        bitrate = self.bus_utilization_data['bitrate']
        if bitrate > 0:
            utilization = (total_bits_per_second / bitrate) * 100
            self.bus_utilization_data['utilization_percent'] = min(utilization, 100.0)
        else:
            self.bus_utilization_data['utilization_percent'] = 0.0
        
        self.bus_utilization_data['last_calculation_time'] = now
    
    def get_bus_utilization(self) -> dict:
        """Get current bus utilization data"""
        # Recalculate if it's been more than 1 second
        now = time.time()
        if now - self.bus_utilization_data['last_calculation_time'] > 1.0:
            self._calculate_bus_utilization()
        
        return {
            'utilization_percent': self.bus_utilization_data['utilization_percent'],
            'total_bits_per_second': self.bus_utilization_data['total_bits_per_second'],
            'bitrate': self.bus_utilization_data['bitrate'],
            'message_count': len([msg for msg in self.messages.values() if msg.count > 0]),
            'active_message_count': len(self.bus_utilization_data['message_rates'])
        }