"""
Core CAN Tool Components
========================

This package contains the core functionality for CAN message processing:
- can_message: Message data structures and management
- dbf_parser: DBF file parsing for signal definitions
- table_view: GUI components for message display
"""

# Core non-GUI imports
from core.can_message import CANMessage, CANMessageManager
from core.dbf_parser import BusmasterDBFParser

# Lazy import for GUI component
def get_table_view():
    """Get CANTableView class - lazy import to avoid tkinter dependency"""
    from core.table_view import CANTableView
    return CANTableView

# For backwards compatibility, provide CANTableView if tkinter is available
try:
    from core.table_view import CANTableView
    __all__ = ['CANMessage', 'CANMessageManager', 'BusmasterDBFParser', 'CANTableView']
except ImportError:
    # tkinter not available, only export non-GUI components
    __all__ = ['CANMessage', 'CANMessageManager', 'BusmasterDBFParser', 'get_table_view']