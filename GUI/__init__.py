"""
CAN Tool - Modular CAN Bus Analysis Tool
=========================================

A modular tool for CAN bus message analysis with support for:
- Real-time CAN message capture and display
- DBF file parsing and signal decoding
- Message transmission scheduling
- Extensible plugin system

Core modules:
- core.can_message: CAN message data structures and management
- core.dbf_parser: DBF file parsing functionality
- core.table_view: GUI table view for message display
- gui.main_app: Main application GUI
- plugins: Extensible plugin system for additional functionality

Usage:
    # Run as standalone application
    python -m can_tool.main
    
    # Or import and embed in other applications
    from can_tool import create_standalone_app
    root, app = create_standalone_app()
    root.mainloop()
"""

__version__ = "1.0.0"
__author__ = "Voltworks Garage"

# Public API exports - use lazy imports to avoid GUI dependencies
from config import Config, default_config
from core import CANMessage, CANMessageManager, BusmasterDBFParser

# Lazy imports for GUI components (only import when needed)
def main():
    """Main entry point - lazy import to avoid tkinter dependency"""
    from main import main as _main
    return _main()

def create_standalone_app(custom_config=None):
    """Create standalone app - lazy import to avoid tkinter dependency"""
    from main import create_standalone_app as _create_app
    return _create_app(custom_config)

def get_base_tab():
    """Get BaseTab class - lazy import to avoid tkinter dependency"""
    from gui.base_tab import BaseTab
    return BaseTab

def get_can_table_view():
    """Get CANTableView class - lazy import to avoid tkinter dependency"""
    from core import CANTableView
    return CANTableView

__all__ = [
    'main', 
    'create_standalone_app',
    'Config', 
    'default_config',
    'CANMessage', 
    'CANMessageManager', 
    'BusmasterDBFParser',
    'get_base_tab',
    'get_can_table_view'
]