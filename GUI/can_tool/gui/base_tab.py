"""
Base Tab Plugin System
======================

This module provides the base class for tab plugins in the CAN tool.
All tab plugins should inherit from BaseTab to ensure consistent interface.
"""

import tkinter as tk
from tkinter import ttk
from abc import ABC, abstractmethod
from typing import Optional


class BaseTab(ABC):
    """
    Abstract base class for tab plugins.
    
    All tab plugins should inherit from this class and implement the required methods.
    This ensures a consistent interface and enables/disables functionality cleanly.
    """
    
    def __init__(self, parent_notebook: ttk.Notebook, app_instance):
        """
        Initialize the tab plugin.
        
        Args:
            parent_notebook: The ttk.Notebook widget to add this tab to
            app_instance: Reference to the main application instance
        """
        self.parent_notebook = parent_notebook
        self.app = app_instance
        self.tab_frame: Optional[ttk.Frame] = None
        self.tab_index: Optional[int] = None
        self.is_enabled = True
    
    @property
    @abstractmethod
    def tab_name(self) -> str:
        """Return the display name for this tab"""
        pass
    
    @property
    @abstractmethod
    def tab_description(self) -> str:
        """Return a description of this tab's functionality"""
        pass
    
    @abstractmethod
    def create_widgets(self):
        """Create the widgets for this tab. Called when the tab is enabled."""
        pass
    
    def initialize(self):
        """
        Initialize the tab by creating the frame and widgets.
        Called when the plugin is loaded and enabled.
        """
        if self.is_enabled and self.tab_frame is None:
            # Create the tab frame
            self.tab_frame = ttk.Frame(self.parent_notebook)
            
            # Add to notebook
            self.parent_notebook.add(self.tab_frame, text=self.tab_name)
            self.tab_index = len(self.parent_notebook.tabs()) - 1
            
            # Create widgets
            self.create_widgets()
    
    def enable(self):
        """Enable this tab plugin"""
        if not self.is_enabled:
            self.is_enabled = True
            self.initialize()
    
    def disable(self):
        """Disable this tab plugin by removing it from the notebook"""
        if self.is_enabled and self.tab_frame is not None:
            self.is_enabled = False
            
            # Remove from notebook
            self.parent_notebook.forget(self.tab_frame)
            
            # Clean up
            self.tab_frame.destroy()
            self.tab_frame = None
            self.tab_index = None
    
    def on_can_message_received(self, msg):
        """
        Called when a CAN message is received.
        Override this method if the tab needs to process incoming messages.
        
        Args:
            msg: The CAN message object
        """
        pass
    
    def on_can_connected(self):
        """
        Called when CAN bus connection is established.
        Override this method if the tab needs to respond to connection events.
        """
        pass
    
    def on_can_disconnected(self):
        """
        Called when CAN bus connection is closed.
        Override this method if the tab needs to respond to disconnection events.
        """
        pass
    
    def on_dbf_file_changed(self):
        """
        Called when the DBF file is reloaded or changed.
        Override this method if the tab needs to respond to DBF file changes.
        """
        pass
    
    def cleanup(self):
        """
        Cleanup resources when the tab is being destroyed.
        Override this method to clean up any resources (timers, threads, etc.).
        """
        pass