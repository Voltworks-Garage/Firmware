"""
Plugin System
=============

This package contains optional plugins for the CAN tool:
- isotp_tab: ISO-TP communication functionality for commandService interaction
"""

# Use lazy imports to avoid GUI dependencies at module level
def get_isotp_tab():
    """Get ISOTPTab class - lazy import to avoid tkinter dependency"""
    from plugins.isotp_tab import ISOTPTab
    return ISOTPTab

__all__ = ['get_isotp_tab']