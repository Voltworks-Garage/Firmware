"""
GUI Components
==============

This package contains the main GUI application and plugin system:
- main_app: Main CAN application window
- base_tab: Base class for tab plugins
"""

from gui.base_tab import BaseTab
from gui.main_app import CANApp

__all__ = ['BaseTab', 'CANApp']