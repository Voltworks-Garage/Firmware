# CAN Tool Plugins - Claude Development Guide

## Plugin Architecture

The CAN Tool uses a modular plugin system that allows extending functionality through loadable tabs. All plugins inherit from `BaseTab` and integrate seamlessly with the main application.

## Available Plugins

### ISO-TP Plugin (`isotp_tab.py`)
**Purpose:** CommandService communication with microcontrollers (BMS, MCU, Dash)
**Status:** Disabled by default (user-enabled via File > Plugins menu)
**Dependencies:** Standard library only

**Key Features:**
- Target ECU selection (BMS, MCU, Dash)
- Command parameter handling
- ISO-TP message formatting
- Response logging and analysis
- Device configuration parsing

### CANopen SDO Plugin (`canopen_sdo_tab.py`)
**Purpose:** Service Data Object read/write operations using EDS files
**Status:** Enabled by default
**Dependencies:** `canopen` library (optional)

**Key Features:**
- EDS file parsing and object dictionary management
- SDO read/write operations with proper protocol handling
- Object browser with search functionality
- Data type conversion and validation
- Real-time communication logging

## Plugin Development Guidelines

### Creating a New Plugin

#### 1. Plugin Class Structure
```python
"""
New Plugin Template
==================

Brief description of plugin functionality and purpose.
"""

import tkinter as tk
from tkinter import ttk
from typing import Optional

# Import base class with dual import pattern
try:
    from ..gui.base_tab import BaseTab
except ImportError:
    from can_tool.gui.base_tab import BaseTab


class NewPlugin(BaseTab):
    """New plugin for specific functionality"""
    
    @property
    def tab_name(self) -> str:
        return "Plugin Name"
    
    @property 
    def tab_description(self) -> str:
        return "Brief description of plugin functionality"
    
    def create_widgets(self):
        """Create the plugin user interface"""
        # Implementation here
        pass
    
    def on_can_connected(self):
        """Called when CAN bus connection is established"""
        pass
    
    def on_can_disconnected(self):
        """Called when CAN bus connection is lost"""
        pass
    
    def on_can_message_received(self, msg):
        """Called when CAN message is received"""
        pass
    
    def on_dbf_file_changed(self):
        """Called when DBF file is reloaded"""
        pass
    
    def cleanup(self):
        """Clean up resources before plugin unload"""
        pass
```

#### 2. Register Plugin in Configuration
Add to `../config.py`:
```python
DEFAULT_CONFIG = {
    "plugins": {
        "new_plugin": {
            "enabled": False,  # or True for default enabled
            "description": "Brief plugin description"
        }
    }
}

def _get_new_plugin():
    try:
        from .plugins.new_plugin import NewPlugin
    except ImportError:
        from can_tool.plugins.new_plugin import NewPlugin
    return NewPlugin

PLUGIN_REGISTRY = {
    "new_plugin": _get_new_plugin
}
```

#### 3. Plugin Lifecycle Methods

**Required Methods:**
- `tab_name` (property) - Display name for the tab
- `tab_description` (property) - Brief description
- `create_widgets()` - Build the user interface

**Optional Methods:**
- `initialize()` - Called after plugin creation
- `on_can_connected()` - CAN bus connection established
- `on_can_disconnected()` - CAN bus disconnected
- `on_can_message_received(msg)` - New CAN message received
- `on_dbf_file_changed()` - DBF file was reloaded
- `cleanup()` - Resource cleanup before unload

### Plugin Development Best Practices

#### Error Handling
```python
def some_plugin_operation(self):
    try:
        # Plugin operation
        result = self.perform_operation()
        self.app.log("✅ Operation completed successfully")
    except Exception as e:
        error_msg = f"Plugin error: {e}"
        self.app.log(f"❌ {error_msg}")
        # Don't crash the main application
        import traceback
        traceback.print_exc()
```

#### Resource Management
```python
def cleanup(self):
    """Always implement proper cleanup"""
    try:
        # Cancel any pending timers
        if hasattr(self, 'update_timer') and self.update_timer:
            self.app.root.after_cancel(self.update_timer)
        
        # Close connections
        if hasattr(self, 'connection') and self.connection:
            self.connection.close()
        
        # Clear references
        self.cached_data = None
        
    except Exception as e:
        print(f"Error during plugin cleanup: {e}")
```

#### CAN Message Processing
```python
def on_can_message_received(self, msg):
    """Handle received CAN messages efficiently"""
    try:
        # Filter messages relevant to this plugin
        if msg.arbitration_id not in self.monitored_ids:
            return
        
        # Process message without blocking
        self.process_message_async(msg)
        
    except Exception as e:
        # Don't let plugin errors affect main application
        print(f"Plugin message processing error: {e}")

def process_message_async(self, msg):
    """Process message in a non-blocking way"""
    # Use after_idle for GUI updates
    self.app.root.after_idle(lambda: self.update_display(msg))
```

#### GUI Integration
```python
def create_widgets(self):
    """Create plugin GUI following application patterns"""
    # Main plugin frame
    main_frame = ttk.LabelFrame(self.tab_frame, text="Plugin Controls")
    main_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
    
    # Input controls
    input_frame = ttk.Frame(main_frame)
    input_frame.pack(fill=tk.X, padx=5, pady=5)
    
    # Status display
    status_frame = ttk.LabelFrame(main_frame, text="Status")
    status_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
    
    # Use consistent button styling
    ttk.Button(input_frame, text="Execute", command=self.execute_command).pack(side=tk.LEFT, padx=5)
```

### Plugin Dependencies

#### Optional Dependencies
```python
# Handle optional dependencies gracefully
try:
    import specialized_library
    LIBRARY_AVAILABLE = True
except ImportError:
    LIBRARY_AVAILABLE = False
    print("📦 specialized_library not available. Install with: pip install specialized_library")

def create_widgets(self):
    if not LIBRARY_AVAILABLE:
        # Show informative message instead of full interface
        info_label = ttk.Label(self.tab_frame, 
            text="This plugin requires 'specialized_library'\nInstall with: pip install specialized_library")
        info_label.pack(expand=True)
        return
    
    # Create full interface
    self.create_full_interface()
```

#### Configuration Files
```python
def load_plugin_config(self):
    """Load plugin-specific configuration"""
    try:
        # Navigate to firmware root for config files
        current_dir = os.path.dirname(__file__)
        firmware_root = os.path.dirname(os.path.dirname(os.path.dirname(current_dir)))
        config_path = os.path.join(firmware_root, "config", "plugin_config.ini")
        
        if os.path.exists(config_path):
            # Load configuration
            pass
        else:
            self.app.log("⚠️  Plugin config file not found, using defaults")
    except Exception as e:
        self.app.log(f"❌ Error loading plugin config: {e}")
```

### Testing Plugin Development

#### Unit Testing
```python
# Create test file: tests/test_new_plugin.py
import unittest
import tkinter as tk
from can_tool.plugins.new_plugin import NewPlugin
from can_tool.gui.main_app import CANApp

class TestNewPlugin(unittest.TestCase):
    def setUp(self):
        self.root = tk.Tk()
        self.app = CANApp(self.root, "test_dbf.dbf")
        self.plugin = NewPlugin(None, self.app)
    
    def test_plugin_initialization(self):
        self.plugin.initialize()
        self.assertEqual(self.plugin.tab_name, "Expected Name")
    
    def tearDown(self):
        self.plugin.cleanup()
        self.root.destroy()
```

#### Integration Testing
```python
def test_plugin_with_main_app():
    """Test plugin integration with main application"""
    # Test plugin loading
    # Test CAN message handling
    # Test cleanup
    pass
```

### Plugin Deployment

#### Runtime Loading/Unloading
Plugins can be dynamically loaded and unloaded through the File > Plugins menu. The main application handles:
- Plugin instantiation
- Tab creation and removal
- Event notification
- Resource cleanup

#### Configuration Management
Plugin enable/disable state is managed in the configuration system:
```python
# Enable plugin
config.set("plugins.new_plugin.enabled", True)

# Check if plugin is enabled
if config.is_plugin_enabled("new_plugin"):
    # Load plugin
    pass
```

## Common Plugin Patterns

### Device Communication Plugin
- Implement target device selection
- Handle command/response protocols
- Provide response logging
- Support device configuration files

### Protocol Plugin
- Parse protocol-specific messages
- Implement encoding/decoding functions
- Provide protocol state management
- Support protocol configuration

### Analysis Plugin
- Monitor specific message types
- Implement data analysis algorithms
- Provide visualization components
- Export analysis results

## Plugin Debugging

### Logging Integration
```python
def debug_log(self, message):
    """Plugin-specific logging"""
    self.app.log(f"🔌 [{self.tab_name}] {message}")

def error_log(self, message):
    """Plugin error logging"""
    self.app.log(f"❌ [{self.tab_name}] ERROR: {message}")
```

### Development Tools
- Use `print()` statements for development debugging
- Leverage main application's console logging
- Implement plugin-specific status displays
- Use exception handling to prevent crashes