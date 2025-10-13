# CAN Tool GUI

A modular Python-based CAN bus analysis tool with support for real-time message capture, DBF file parsing, signal decoding, and an extensible plugin system.

## Features

- Real-time CAN message capture and display
- DBF (Busmaster) file parsing and signal decoding
- Message transmission scheduling
- Extensible plugin system (ISO-TP, CANopen SDO)
- Interactive graphing and data visualization

## Installation

### 1. Install UV

UV is a fast Python package manager. Install it via pip:

```bash
pip install uv
```

### 2. Set Up the Project

Navigate to the GUI directory and sync dependencies:

```bash
cd Firmware/GUI
uv sync
```

This creates a virtual environment in `.venv` and installs all dependencies.

### 3. Run the Application

```bash
uv run python main.py
```

## Development

### Adding Dependencies

```bash
uv add package-name
```

### Updating Dependencies

```bash
uv sync --upgrade
```

### Running Tests

```bash
uv run python tests/test_config_parser.py
uv run python tests/example_usage.py
```

## Project Structure

```
GUI/
├── config.py              # Configuration management
├── main.py                # Main application entry point
├── core/                  # Core functionality (CAN, DBF parsing)
├── gui/                   # GUI components
├── plugins/               # Plugin system (ISO-TP, CANopen)
└── tests/                 # Test suite
```

## Troubleshooting

If you encounter issues, recreate the virtual environment:

```bash
rm -rf .venv
uv sync
```

## Resources

- [UV Documentation](https://docs.astral.sh/uv/)
- [python-can Documentation](https://python-can.readthedocs.io/)
