# CAN Tool Tests - Claude Development Guide

## Test Suite Overview

The CAN Tool test suite contains 20+ comprehensive test files covering all major functionality, from core components to full application integration. Tests are designed to run independently and provide thorough coverage of the application's capabilities.

## Test Categories and Organization

### Core Functionality Tests

**`test_core_only.py`**
- Tests core components without GUI dependencies
- DBF parsing, message handling, configuration management
- Can run in headless environments

**`test_config_parser.py`**
- Configuration system validation
- Plugin configuration management
- Cross-platform path handling

**`test_dbf_business_logic.py`**
- DBF file parsing accuracy
- Signal encoding/decoding validation
- Multiplexed message handling

**`test_app_initialization.py`**
- Application startup sequence
- Plugin loading and initialization
- Resource allocation and cleanup

### GUI and User Interface Tests

**`test_tx_functionality.py`**
- Message transmission features
- Manual and DBF-based message creation
- Start/stop/delete operations

**`test_tx_row_columns.py`**
- TX table layout and alignment
- Column resizing behavior
- Header synchronization

**`test_tx_mousewheel_fix.py`**
- Mouse wheel scrolling functionality
- Widget binding verification
- Event propagation

**`test_complete_tx_table_stretching.py`**
- Dynamic table resizing
- Window scaling behavior
- Widget constraint handling

### DBF Integration Tests

**`test_dbf_loading.py`**
- DBF file loading functionality
- Error handling for invalid files
- Signal definition parsing

**`test_dbf_loading_fix.py`**
- Specific bug fix validation
- Regression testing
- Edge case handling

**`test_dbf_dropdown.py`**
- DBF message selection interface
- Dropdown population and filtering
- User interaction workflows

**`test_dbf_message_dropdown_summary.py`**
- Integration test summary
- DBF dropdown functionality validation
- Complete workflow testing

### Plugin and Modular Tests

**`test_modular.py`**
- Plugin system architecture
- Module loading and dependency handling
- Interface compliance

**`test_isotp_dropdown.py`**
- ISO-TP plugin functionality
- Command selection and parameter handling
- Device configuration integration

**`test_decoupling.py`**
- Component isolation and independence
- Interface boundary testing
- Dependency injection validation

**`test_menu_features.py`**
- Application menu system
- File operations and plugin management
- User interface consistency

### Integration and Verification Tests

**`test_complete_functionality.py`**
- Full application workflow testing
- End-to-end functionality validation
- Performance and stability testing

**`test_fixes_verification.py`**
- Regression test suite
- Bug fix validation
- Previously reported issue verification

## Test Development Guidelines

### Creating New Tests

#### Test File Structure
```python
#!/usr/bin/env python3
"""
Test Description
================

Brief description of what this test validates.
"""

import sys
import os
import unittest
import tkinter as tk

# Add parent directory to path for imports
current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)
sys.path.insert(0, parent_dir)

from can_tool.main import CANApp

class TestNewFeature(unittest.TestCase):
    """Test class for new feature validation"""
    
    def setUp(self):
        """Set up test environment"""
        self.root = tk.Tk()
        self.root.withdraw()  # Hide test window
        
        # Create test DBF path
        self.test_dbf_path = os.path.join(parent_dir, "tests", "test_data", "test.dbf")
        
        # Initialize application
        self.app = CANApp(self.root, self.test_dbf_path)
    
    def tearDown(self):
        """Clean up test environment"""
        try:
            self.app.cleanup()
        except:
            pass
        self.root.destroy()
    
    def test_specific_functionality(self):
        """Test specific feature behavior"""
        # Test implementation
        self.assertTrue(condition, "Failure message")
    
    def test_error_conditions(self):
        """Test error handling"""
        with self.assertRaises(ExpectedException):
            # Code that should raise exception
            pass

if __name__ == "__main__":
    unittest.main()
```

#### Test Naming Conventions
- File: `test_[feature_name].py`
- Class: `Test[FeatureName]`
- Method: `test_[specific_behavior]`

### Testing GUI Components

#### GUI Test Setup
```python
def setUp(self):
    """Set up GUI test environment"""
    self.root = tk.Tk()
    self.root.withdraw()  # Hide during testing
    
    # Create minimal app instance
    self.app = CANApp(self.root, "dummy_dbf_path")
    
    # Allow GUI to initialize
    self.root.update()

def test_widget_creation(self):
    """Test GUI widget creation"""
    # Verify widgets exist
    self.assertIsNotNone(self.app.device_combo)
    self.assertIsNotNone(self.app.console)
    
    # Test widget properties
    self.assertEqual(self.app.baud_var.get(), "500000")
```

#### Event Simulation
```python
def test_button_click(self):
    """Test button click handling"""
    # Simulate button click
    self.app.connect_button.invoke()
    
    # Allow GUI to process event
    self.root.update()
    
    # Verify expected behavior
    self.assertEqual(self.app.connection_state, "connecting")
```

### Testing Plugin System

#### Plugin Loading Tests
```python
def test_plugin_loading(self):
    """Test plugin loading mechanism"""
    # Test plugin registration
    from can_tool.config import load_plugins, default_config
    
    plugins = load_plugins(default_config, None, self.app)
    self.assertGreater(len(plugins), 0)
    
    # Test plugin initialization
    for plugin in plugins:
        self.assertTrue(hasattr(plugin, 'tab_name'))
        self.assertTrue(hasattr(plugin, 'create_widgets'))
```

#### Plugin Interface Tests
```python
def test_plugin_interface_compliance(self):
    """Test plugin interface implementation"""
    from can_tool.plugins.isotp_tab import ISOTPTab
    
    plugin = ISOTPTab(None, self.app)
    
    # Test required interface methods
    self.assertTrue(hasattr(plugin, 'tab_name'))
    self.assertTrue(hasattr(plugin, 'tab_description'))
    self.assertTrue(callable(getattr(plugin, 'create_widgets')))
```

### Testing CAN Communication

#### Mock CAN Interface
```python
class MockCANBus:
    """Mock CAN bus for testing"""
    def __init__(self, *args, **kwargs):
        self.messages = []
        self.connected = False
    
    def send(self, msg):
        self.messages.append(msg)
    
    def recv(self, timeout=None):
        # Return test message or None
        return None
    
    def shutdown(self):
        self.connected = False

def test_can_communication(self):
    """Test CAN message handling with mock interface"""
    # Replace CAN bus with mock
    self.app.bus = MockCANBus()
    
    # Test message transmission
    test_msg = can.Message(arbitration_id=0x123, data=[1, 2, 3, 4])
    self.app.bus.send(test_msg)
    
    # Verify message was sent
    self.assertEqual(len(self.app.bus.messages), 1)
    self.assertEqual(self.app.bus.messages[0].arbitration_id, 0x123)
```

### Testing DBF Integration

#### DBF Parser Tests
```python
def test_dbf_parsing(self):
    """Test DBF file parsing accuracy"""
    from can_tool.core.dbf_parser import BusmasterDBFParser
    
    # Create test DBF content
    test_dbf_content = """
    [START_MSG]TestMessage,123,8
    [START_SIGNALS]TestSignal,8,0,0,U,255,0,0,0,1,units
    [END_MSG]
    """
    
    # Write to temporary file
    with tempfile.NamedTemporaryFile(mode='w', suffix='.dbf', delete=False) as f:
        f.write(test_dbf_content)
        temp_path = f.name
    
    try:
        # Test parsing
        parser = BusmasterDBFParser(temp_path)
        self.assertIn(123, parser.messages)
        self.assertEqual(parser.messages[123]['name'], 'TestMessage')
    finally:
        os.unlink(temp_path)
```

#### Signal Encoding Tests
```python
def test_signal_encoding(self):
    """Test signal value encoding accuracy"""
    # Test signal encoding
    signal_values = {'TestSignal': 42}
    encoded_data = self.parser.encode_message_from_signals(123, signal_values)
    
    # Verify encoding
    self.assertIsNotNone(encoded_data)
    self.assertEqual(len(encoded_data), 8)
    
    # Test round-trip encoding/decoding
    decoded_signals = self.parser.decode_message(123, 8, encoded_data)
    self.assertEqual(decoded_signals['TestSignal'], 42)
```

## Test Execution and Automation

### Running Tests

#### Individual Tests
```bash
cd tests/
python test_core_only.py
python test_tx_functionality.py
```

#### All Tests
```bash
cd tests/
python run_all_tests.py
```

#### Test Runner Script
```python
#!/usr/bin/env python3
"""Run all CAN Tool tests"""

import os
import sys
import unittest

def discover_and_run_tests():
    """Discover and run all test files"""
    # Set up test environment
    current_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Discover tests
    loader = unittest.TestLoader()
    suite = loader.discover(current_dir, pattern='test_*.py')
    
    # Run tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    # Return exit code
    return 0 if result.wasSuccessful() else 1

if __name__ == "__main__":
    sys.exit(discover_and_run_tests())
```

### Continuous Integration

#### Test Requirements
```python
# requirements_test.txt
python-can>=4.0.0
canopen  # Optional for CANopen tests
```

#### CI Configuration
```yaml
# .github/workflows/tests.yml
name: Run Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.9
    - name: Install dependencies
      run: |
        pip install -r requirements_test.txt
    - name: Run tests
      run: |
        cd GUI/tests
        python run_all_tests.py
```

## Test Data Management

### Test DBF Files
Store test DBF files in `tests/test_data/`:
- `simple.dbf` - Basic message definitions
- `complex.dbf` - Complex signals and multiplexed messages
- `invalid.dbf` - Malformed file for error testing

### Mock Data Generation
```python
def create_test_can_message(msg_id, data):
    """Create test CAN message"""
    import can
    return can.Message(
        arbitration_id=msg_id,
        data=data,
        is_extended_id=False
    )
```

## Performance Testing

### Load Testing
```python
def test_high_message_rate(self):
    """Test application performance with high CAN message rates"""
    # Generate high-rate message stream
    messages = [create_test_can_message(0x123, [i] * 8) for i in range(1000)]
    
    start_time = time.time()
    for msg in messages:
        self.app.handle_rx_message(msg)
    
    # Allow GUI updates to complete
    self.root.update()
    
    elapsed = time.time() - start_time
    self.assertLess(elapsed, 5.0, "High message rate handling too slow")
```

### Memory Testing
```python
def test_memory_usage(self):
    """Test memory usage during extended operation"""
    import psutil
    process = psutil.Process()
    
    initial_memory = process.memory_info().rss
    
    # Simulate extended operation
    for _ in range(10000):
        test_msg = create_test_can_message(0x123, [1, 2, 3, 4])
        self.app.handle_rx_message(test_msg)
    
    final_memory = process.memory_info().rss
    memory_growth = final_memory - initial_memory
    
    # Memory growth should be reasonable (< 100MB for this test)
    self.assertLess(memory_growth, 100 * 1024 * 1024, "Excessive memory growth detected")
```

## Adding New Test Categories

When adding new features, create corresponding test files following these patterns:
1. **Unit Tests**: Test individual components in isolation
2. **Integration Tests**: Test component interaction
3. **GUI Tests**: Test user interface behavior
4. **Performance Tests**: Test under load conditions
5. **Regression Tests**: Prevent previously fixed bugs from returning