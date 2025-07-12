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
    
    def _accumulate_mux_signals(self, msg: CANMessage, decoded_signals: Dict[str, str], multiplex_value: Optional[int]):
        """Accumulate signals from multiplexed messages for complete view"""
        if not decoded_signals:
            return
            
        # Update accumulated signals with new values
        for signal_name, signal_value in decoded_signals.items():
            # Skip the multiplex signal itself (it's just "Mode X")
            if 'MultiPlex' in signal_name:
                continue
                
            # Store the signal with current timestamp for freshness tracking
            msg.accumulated_mux_signals[signal_name] = {
                'value': signal_value,
                'timestamp': time.time(),
                'mux_value': multiplex_value
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
            # Non-multiplexed message - return current signals
            return msg.decoded_signals
    
    def _sort_mux_signals(self, accumulated_signals: Dict[str, Dict]) -> Dict[str, Dict]:
        """Sort multiplexed signals for better organization (Cell_01, Cell_02, etc.)"""
        def signal_sort_key(item):
            signal_name = item[0]
            # Extract number for sorting (Cell_01_voltage -> 1, Temp_05 -> 5)
            try:
                if 'Cell_' in signal_name:
                    return (0, int(signal_name.split('_')[1]))  # Cells first
                elif 'Temp_' in signal_name:
                    return (1, int(signal_name.split('_')[1]))  # Temps second
                else:
                    return (2, signal_name)  # Other signals last
            except (ValueError, IndexError):
                return (3, signal_name)  # Fallback for unparseable names
        
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