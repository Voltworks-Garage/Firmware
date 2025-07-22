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
        
        return msg
    
    def _accumulate_mux_signals(self, msg: CANMessage, decoded_signals: Dict[str, dict], multiplex_value: Optional[int]):
        """Accumulate signals from multiplexed messages for complete view"""
        if not decoded_signals:
            return
            
        # Update accumulated signals with new values
        for signal_name, signal_data in decoded_signals.items():
            # Skip the multiplex signal itself (it's just "Mode X")
            if 'Multiplex' in signal_name:
                continue
                
            # Store the signal with current timestamp and sorting info for freshness tracking
            msg.accumulated_mux_signals[signal_name] = {
                'value': signal_data['value'],
                'timestamp': time.time(),
                'mux_value': signal_data['multiplex_value'],
                'byte_pos': signal_data['byte_pos'],
                'bit_pos': signal_data['bit_pos']
            }
    
    def get_display_signals(self, msg: CANMessage) -> Dict[str, str]:
        """Get signals to display - for multiplexed messages, show accumulated signals"""
        if not msg.decoded_signals:
            return {}
            
        # Check if this is a multiplexed message with accumulated signals
        if msg.accumulated_mux_signals:
            current_time = time.time()
            display_signals = {}
            
            # Add multiplex mode indicator
            if msg.last_mux_value is not None:
                display_signals['MultiPlex'] = f"Mode {msg.last_mux_value}"
            
            # Show accumulated signals (mark stale ones) in sorted order
            sorted_signals = self._sort_mux_signals(msg.accumulated_mux_signals)
            
            for signal_name, signal_info in sorted_signals.items():
                age = current_time - signal_info['timestamp']
                value = signal_info['value']
                
                # Mark signals older than 5 seconds as stale
                if age > 5.0:
                    value += " (stale)"
                
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
        """Sort multiplexed signals by mux order first, then byte order"""
        def signal_sort_key(item):
            signal_name = item[0]
            signal_info = item[1]
            
            # Get sorting parameters from signal definition
            byte_pos = signal_info.get('byte_pos', 999)  # Default to high number if no byte pos
            bit_pos = signal_info.get('bit_pos', 999)    # Default to high number if no bit pos
            mux_value = signal_info.get('mux_value', 999)  # Default to high number if no mux value
            
            # Sort by: mux_value first, then byte_pos, then bit_pos, then signal name
            return (mux_value if mux_value is not None else 999, byte_pos, bit_pos, signal_name)
        
        sorted_items = sorted(accumulated_signals.items(), key=signal_sort_key)
        return dict(sorted_items)
    
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