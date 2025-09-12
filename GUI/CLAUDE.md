# CAN Tool GUI - Claude Development Guide

## Project Overview

The CAN Tool is a modular Python GUI application for CAN bus analysis and communication, specifically designed for Voltworks Garage embedded systems development. It provides real-time CAN message capture, DBF-based signal decoding, message transmission, and extensible plugin architecture.

## Architecture

```
GUI/
├── can_tool/           # Main application package
│   ├── main.py         # Entry point and application initialization
│   ├── config.py       # Configuration management and plugin loading
│   ├── core/           # Core functionality (DBF parsing, message handling)
│   ├── gui/            # GUI components and main application window
│   └── plugins/        # Loadable plugin modules
├── tests/              # Comprehensive test suite (20+ test files)
├── Legacy/             # Legacy E-MOTO GUI components
└── run_can_tool.py     # Launcher script with path setup
```

## Key Features

- **Real-time CAN Communication**: PCAN device support with configurable baud rates
- **DBF Integration**: Busmaster DBF file parsing for signal definitions and decoding
- **Message Transmission**: Manual and DBF-based message creation with signal-level control
- **Plugin System**: Modular architecture supporting ISO-TP and CANopen plugins
- **Comprehensive Testing**: Full test suite covering core functionality and GUI components

## Development Setup

### Prerequisites
```bash
pip install python-can>=4.0.0
# Optional for CANopen plugin:
pip install canopen
```

### Running the Application
```bash
# Method 1: Direct execution
python run_can_tool.py

# Method 2: Windows batch launcher
CAN_TOOL.bat

# Method 3: Module execution
python -m can_tool.main
```

### Running Tests
```bash
cd tests/
python run_all_tests.py
```

## Configuration

Default configuration in `can_tool/config.py`:
- **DBF Path**: `../CAN/emoto.dbf`
- **ISO-TP Plugin**: Disabled by default
- **CANopen Plugin**: Enabled by default
- **GUI Refresh Rate**: 100ms (10 Hz)

## Development Guidelines

### Code Standards
- Follow Python PEP 8 style guidelines
- Use type hints for function parameters and return values
- Add docstrings for all public methods and classes
- Handle exceptions gracefully with user-friendly error messages

### GUI Development
- Use Tkinter with ttk widgets for consistent styling
- Implement proper threading for CAN operations to prevent UI blocking
- Use emoji indicators in logging for visual clarity (✅, ❌, ⚠️, 🚀, etc.)
- Ensure responsive design with proper widget resizing

### CAN Communication
- Always validate CAN message formats before transmission
- Use message batching for high-speed CAN traffic processing
- Implement proper error handling for device connection/disconnection
- Support both manual and DBF-based message creation

### Plugin Development
- Inherit from `BaseTab` class for consistent plugin interface
- Implement proper cleanup methods for resource management
- Use lazy loading for plugin dependencies
- Provide clear error messages for missing dependencies

## Testing Protocol

### Test Categories
- **Core Tests**: DBF parsing, message handling, configuration
- **GUI Tests**: User interface components, table rendering, scrolling
- **Integration Tests**: Full application workflow, plugin interaction
- **Plugin Tests**: Individual plugin functionality and integration

### Adding New Tests
1. Create test file in `tests/` directory
2. Follow naming convention: `test_[feature_name].py`
3. Include both positive and negative test cases
4. Update `run_all_tests.py` to include new test

## File Modification Protocol

### DBF File Changes
- Always validate DBF format before applying changes
- Test signal decoding with representative CAN messages
- Update relevant test cases when modifying DBF parsing logic

### GUI Component Changes
- Test on different screen resolutions and DPI settings
- Verify mouse wheel scrolling functionality
- Ensure proper widget alignment and column stretching

### Plugin Modifications
- Test plugin loading/unloading functionality
- Verify proper cleanup of resources
- Check error handling for missing dependencies

## Deployment

### Package Installation
```bash
# Development installation
pip install -e .

# Production installation
pip install .
```

### Console Script
After installation, the tool can be launched using:
```bash
can-tool
```

## Common Issues and Solutions

### Import Errors
- Verify Python path setup in `run_can_tool.py`
- Check that all required dependencies are installed
- Use absolute imports in plugin files

### CAN Communication Issues
- Ensure PCAN drivers are properly installed
- Check device permissions and availability
- Verify CAN bus wiring and termination

### Performance Issues
- Monitor GUI update frequency (default 10 Hz)
- Check for memory leaks in message handling
- Optimize table rendering for large message counts

## Related Files

- Main CLAUDE.md: `../CLAUDE.md` (firmware-wide instructions)
- CAN DBC documentation: `../CAN/README.md`
- Build instructions: `../build_commands.sh`