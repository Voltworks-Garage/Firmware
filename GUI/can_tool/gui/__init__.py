"""
GUI Components
==============

This package contains the main GUI application and plugin system:
- main_app: Main CAN application window
- base_tab: Base class for tab plugins
"""

from .base_tab import BaseTab
from .main_app import CANApp

__all__ = ['BaseTab', 'CANApp']