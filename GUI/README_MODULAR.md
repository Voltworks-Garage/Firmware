# Modular CAN Tool

A modular CAN bus analysis tool with plugin support, extracted from the original monolithic `scratch_6.py`.

## 🏗️ Architecture

```
can_tool/
├── __init__.py              # Public API with lazy imports
├── main.py                  # Main entry point
├── config.py                # Configuration and plugin management
├── core/                    # Core CAN functionality (no GUI dependencies)
│   ├── __init__.py
│   ├── can_message.py       # CANMessage, CANMessageManager
│   ├── dbf_parser.py        # BusmasterDBFParser
│   └── table_view.py        # CANTableView (GUI component)
├── gui/                     # GUI components
│   ├── __init__.py
│   ├── main_app.py          # Main CANApp class
│   └── base_tab.py          # BaseTab plugin interface
└── plugins/                 # Optional plugins
    ├── __init__.py
    └── isotp_tab.py         # ISO-TP functionality
```

## ✨ Key Features

### **Clean Separation of Concerns**
- **Core modules**: Pure CAN processing logic (works without GUI)
- **GUI modules**: User interface components 
- **Plugins**: Optional functionality that can be enabled/disabled

### **Modular Plugin System**
- ISO-TP functionality is now a **completely optional plugin**
- **Runtime Loading**: Plugins can be loaded/unloaded while application is running
- Easy to add new tabs/features as plugins
- Configuration-driven plugin loading

### **User-Friendly Interface**
- **Menu Bar**: File menu with DBF loading and plugin management
- **Dynamic DBF Loading**: Switch CAN databases at runtime via File > Load DBF File...
- **Plugin Toggle**: Enable/disable ISO-TP plugin from File > Plugins menu
- **Cross-platform**: File dialogs work on Windows, Linux, macOS

### **Flexible Usage**
- Use as standalone application
- Embed in other applications  
- Use only core components for headless processing
- Custom configurations and plugin combinations

## 🚀 Usage

### **Standalone Application**
```bash
# Run the full application
python -m can_tool.main
```

### **Menu Operations**
```
File Menu:
├── Load DBF File...        # Switch CAN database files at runtime
├── ────────────────
├── Plugins
│   └── ☐ ISO-TP Plugin    # Toggle ISO-TP functionality on/off
├── ────────────────
└── Exit                    # Close application

Help Menu:
└── About                   # Application information
```

### **Embed in Other Applications**
```python
from can_tool import create_standalone_app

# Create with default config
root, app = create_standalone_app()
root.mainloop()

# Create with custom config
custom_config = {
    "plugins": {"isotp_tab": {"enabled": False}},  # Disable ISO-TP
    "gui": {"window_title": "My Custom CAN Tool"}
}
root, app = create_standalone_app(custom_config)
root.mainloop()
```

### **Core Components Only**
```python
from can_tool.core import CANMessageManager, BusmasterDBFParser

# Use for headless CAN processing
dbf_parser = BusmasterDBFParser("path/to/candb.dbf")
msg_manager = CANMessageManager(dbf_parser)

# Process CAN messages
can_msg = msg_manager.update_message(0x123, 8, data_bytes)
print(f"Decoded: {can_msg.decoded_signals}")
```

## 🔌 Plugin Development

### **Create Custom Plugin**
```python
from can_tool.gui.base_tab import BaseTab

class MyCustomTab(BaseTab):
    @property
    def tab_name(self):
        return "My Feature"
    
    @property
    def tab_description(self):
        return "Custom functionality"
    
    def create_widgets(self):
        # Create your UI widgets here
        import tkinter as tk
        from tkinter import ttk
        
        label = ttk.Label(self.tab_frame, text="Hello from custom plugin!")
        label.pack(pady=20)
    
    def on_can_message_received(self, msg):
        # Process incoming CAN messages
        print(f"Custom plugin received: 0x{msg.arbitration_id:X}")
```

### **Plugin Lifecycle Methods**
- `create_widgets()`: Build your UI (required)
- `on_can_message_received(msg)`: Process incoming CAN messages
- `on_can_connected()`: Handle CAN connection events
- `on_can_disconnected()`: Handle CAN disconnection events  
- `cleanup()`: Clean up resources when plugin is destroyed

## 🔧 Configuration

### **Default Configuration**
```python
{
    "dbf_path": "../../CAN/emoto.dbf",  # Cross-platform relative path
    "plugins": {
        "isotp_tab": {"enabled": False}  # ISO-TP DISABLED by default - only loads when selected
    },
    "gui": {
        "refresh_rate_ms": 100,
        "window_title": "CAN Tool - Modular CAN Bus Analysis"
    }
}
```

### **Cross-Platform Path Support**
The tool uses forward slashes in paths, which work on both Windows and Linux:
- **Default**: `../../CAN/emoto.dbf` (relative to GUI directory)
- **Custom**: Use forward slashes in your custom paths
- **Examples**: 
  - `"myfiles/custom.dbf"` 
  - `"/home/user/can/database.dbf"`
  - `"C:/REPOS/project/candb.dbf"` (Windows with forward slashes)

### **Enable ISO-TP Plugin (Disabled by Default)**
```python
from can_tool.config import Config

# Method 1: Enable via configuration
config = Config({
    "plugins": {
        "isotp_tab": {"enabled": True}  # Enable ISO-TP at startup
    }
})

# Method 2: Enable via menu (Recommended)
# Run the application and use File > Plugins > ISO-TP Plugin checkbox
```

## 📦 Benefits of Modular Structure

### **Before (Monolithic)**
- 2000+ lines in single file
- Tight coupling between CAN core and ISO-TP
- Hard to test individual components
- GUI required even for simple CAN processing

### **After (Modular)**
- **Separation**: Core CAN (500 lines) + GUI (300 lines) + ISO-TP Plugin (400 lines)
- **Optional GUI**: Core components work without tkinter
- **Plugin System**: ISO-TP can be completely disabled
- **Testable**: Each module can be tested independently
- **Extensible**: Easy to add new features as plugins

## 🧪 Testing

```bash
# Test core functionality (no GUI required)
python3 -c "from can_tool.core import CANMessage; print('✅ Core works')"

# Test with examples
python example_usage.py

# Test syntax compilation
python3 -m py_compile can_tool/core/can_message.py
python3 -m py_compile can_tool/plugins/isotp_tab.py
```

## 🎯 Migration from Original

**Old way:**
```python
# Had to import everything, including ISO-TP
from scratch_6 import CANApp  # 2000+ lines with ISO-TP embedded
```

**New way:**
```python
# Use only what you need
from can_tool.core import CANMessageManager  # Just CAN processing
from can_tool import create_standalone_app    # Full GUI with plugins
```

## 🔮 Future Extensions

The modular architecture makes it easy to add:
- **J1939 Plugin**: For heavy vehicle protocols
- **UDS Plugin**: For diagnostic services  
- **CAN FD Plugin**: For CAN with Flexible Data-Rate
- **Recording Plugin**: For message capture/replay
- **Analysis Plugin**: For bus load analysis

Each plugin can be developed independently and enabled/disabled as needed!

---

**🎉 The CAN tool is now truly modular with ISO-TP as an optional plugin!**