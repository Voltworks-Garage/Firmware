# CAN Tool Core - Claude Development Guide

## Module Architecture

The can_tool package is structured as a modular CAN bus analysis application with clear separation of concerns:

```
can_tool/
├── main.py             # Application entry point and initialization
├── config.py           # Configuration management and plugin loading
├── core/               # Core business logic
│   ├── __init__.py     # Core module exports
│   ├── can_message.py  # CAN message data structures and management
│   ├── dbf_parser.py   # Busmaster DBF file parsing
│   ├── table_view.py   # GUI table components for message display
│   └── config_parser.py # Device configuration parsing
├── gui/                # User interface components
│   ├── __init__.py     # GUI module exports
│   ├── main_app.py     # Main application window (1331 lines)
│   └── base_tab.py     # Base class for plugin tabs
└── plugins/            # Loadable plugin modules
    ├── __init__.py     # Plugin module exports
    ├── isotp_tab.py    # ISO-TP communication plugin
    └── canopen_sdo_tab.py # CANopen SDO operations plugin
```

## Core Components

### Configuration Management (`config.py`)

**Key Features:**
- Plugin registry with lazy loading
- Cross-platform path handling
- Default configuration management
- Runtime plugin enable/disable

**Important Functions:**
- `load_plugins(config, parent_notebook, app_instance)` - Load enabled plugins
- `Config.get(key, default)` - Get configuration values with dot notation
- `Config.get_enabled_plugins()` - Return list of active plugins

**Configuration Structure:**
```python
DEFAULT_CONFIG = {
    "dbf_path": "../CAN/emoto.dbf",
    "plugins": {
        "isotp_tab": {"enabled": False},
        "canopen_sdo_tab": {"enabled": True}
    },
    "gui": {
        "refresh_rate_ms": 100,
        "window_title": "CAN Tool - Modular CAN Bus Analysis"
    }
}
```

### Main Application (`main.py`)

**Key Functions:**
- `main()` - Primary entry point with error handling
- `create_standalone_app(custom_config)` - For embedding in other applications
- Plugin initialization and cleanup
- Window configuration and startup logging

**Startup Sequence:**
1. Create Tkinter root window
2. Load configuration
3. Validate DBF file existence
4. Create CANApp instance
5. Load and initialize plugins
6. Start main event loop

### GUI Framework (`gui/main_app.py`)

**Core Responsibilities:**
- CAN device scanning and connection management
- Real-time message reception with batching (10ms/10 messages)
- Message transmission with periodic scheduling
- DBF-based signal decoding and encoding
- Plugin lifecycle management

**Performance Optimizations:**
- GUI updates throttled to 10 Hz to prevent UI freezing
- Message batching for high-speed CAN traffic
- Selective table updates for changed messages only
- Background device scanning with threading

**Key Methods:**
- `connect()` / `disconnect()` - CAN bus connection management
- `handle_rx_message(msg)` - Process incoming CAN messages
- `start_tx_message(msg_id)` / `stop_tx_message(msg_id)` - TX message control
- `load_dbf_file()` - Runtime DBF file loading

## Development Guidelines

### Adding New Core Features

#### CAN Message Processing
```python
# Always use message batching for performance
def handle_rx_message_batch(self, messages):
    for msg in messages:
        # Update message manager immediately (for accurate timing)
        can_msg = self.message_manager.update_message(msg.arbitration_id, msg.dlc, msg.data)
        
        # Queue GUI update (throttled)
        self.pending_gui_updates.add(msg.arbitration_id)
        self._schedule_gui_update()
```

#### DBF Integration
```python
# Always validate DBF structure before processing
try:
    new_dbf_parser = BusmasterDBFParser(filename)
    self.dbf_parser = new_dbf_parser
    self.message_manager = CANMessageManager(self.dbf_parser)
    self.log(f"📁 Loaded DBF file: {os.path.basename(filename)}")
except Exception as e:
    self.log(f"❌ Failed to load DBF file: {e}")
```

#### Threading Protocol
- Use `threading.Thread(daemon=True)` for background operations
- Always use `self.root.after()` to update GUI from worker threads
- Implement proper cleanup in `disconnect()` method

### Error Handling Standards

**User-Friendly Messages:**
```python
# Use emoji indicators for visual clarity
self.log("✅ Connected to PCAN_USBBUS1 at 500000 bps")
self.log("❌ Connection failed: Device not found")
self.log("⚠️  Warning: DBF file not found")
self.log("🚀 Starting periodic TX: ID 0x123")
```

**Exception Handling:**
```python
try:
    # CAN operation
    self.bus.send(msg)
except Exception as e:
    error_msg = f"TX Error: {e}"
    self.log(f"❌ {error_msg}")
    messagebox.showerror("Transmission Error", error_msg)
```

### Configuration Protocol

**Adding New Configuration Options:**
1. Add to `DEFAULT_CONFIG` in `config.py`
2. Create getter method in `Config` class
3. Update documentation in `CLAUDE.md`
4. Add validation if required

**Plugin Configuration:**
```python
# Enable/disable plugins at runtime
config.set("plugins.new_plugin.enabled", True)
enabled_plugins = config.get_enabled_plugins()
```

### Import Handling

**Always use dual import pattern for compatibility:**
```python
try:
    from .core import CANMessageManager, BusmasterDBFParser
    from .gui.base_tab import BaseTab
except ImportError:
    from can_tool.core import CANMessageManager, BusmasterDBFParser
    from can_tool.gui.base_tab import BaseTab
```

## Testing Integration

### Core Component Testing
- Test DBF parsing with various file formats
- Validate message encoding/decoding accuracy
- Check threading synchronization
- Verify plugin loading/unloading

### GUI Testing Protocol
- Test table rendering performance with high message rates
- Verify scrolling and resizing behavior
- Check memory usage during long-running sessions
- Validate user input handling and validation

## Performance Considerations

### Memory Management
- Clear old messages when memory usage exceeds threshold
- Proper cleanup of threading resources
- Plugin resource management in cleanup methods

### GUI Responsiveness
- Batch message processing (10ms intervals or 10 messages)
- Throttle GUI updates to 10 Hz maximum
- Use `after_idle()` for non-critical updates

### CAN Communication Optimization
- Use short timeouts (1ms) for message reception
- Implement proper buffer management
- Handle device disconnection gracefully

## Common Issues and Solutions

### Plugin Loading Errors
```python
# Always provide fallback error handling
try:
    plugin_instance = plugin_class(parent_notebook, app_instance)
    plugins.append(plugin_instance)
except Exception as e:
    print(f"❌ Failed to load plugin {plugin_name}: {e}")
    # Continue without the plugin
```

### Threading Issues
- Never update GUI directly from worker threads
- Use `self.root.after()` for thread-safe GUI updates
- Implement proper thread cleanup on application exit

### Memory Leaks
- Cancel all `after()` callbacks in cleanup
- Close CAN bus connections properly
- Clear message caches periodically