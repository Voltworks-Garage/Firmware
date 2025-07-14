# CAN Tool Tests

This directory contains test scripts and example usage files for the CAN tool application.

## Test Categories

### Core Functionality Tests
- `test_core_only.py` - Tests core components without GUI
- `test_config_parser.py` - Tests configuration parsing functionality
- `test_dbf_business_logic.py` - Tests DBF file parsing logic
- `test_app_initialization.py` - Tests application startup and initialization

### GUI and User Interface Tests
- `test_tx_functionality.py` - Tests TX message transmission features
- `test_tx_row_columns.py` - Tests TX table column layout and alignment
- `test_tx_mousewheel_fix.py` - Tests mouse wheel scrolling functionality
- `test_complete_tx_table_stretching.py` - Tests TX table resizing behavior

### DBF Integration Tests  
- `test_dbf_loading.py` - Tests DBF file loading functionality
- `test_dbf_loading_fix.py` - Tests DBF loading bug fixes
- `test_dbf_dropdown.py` - Tests DBF message dropdown functionality
- `test_dbf_message_dropdown_summary.py` - Summary of DBF dropdown tests

### Plugin and Modular Tests
- `test_modular.py` - Tests modular architecture and plugin system
- `test_isotp_dropdown.py` - Tests ISO-TP plugin dropdown functionality
- `test_decoupling.py` - Tests component decoupling and isolation
- `test_menu_features.py` - Tests menu functionality

### Integration and Verification Tests
- `test_complete_functionality.py` - Full application functionality test
- `test_fixes_verification.py` - Verifies that reported bugs are fixed

### Examples and Utilities
- `example_usage.py` - Demonstrates various ways to use the CAN tool
- `scratch_6.py` - Experimental/scratch testing code

## Running Tests

All tests are designed to be run independently. From the tests directory:

```bash
# Run individual tests
python test_core_only.py
python test_tx_functionality.py

# Or run all tests
python run_all_tests.py
```

## Note

Tests have been moved from the main GUI directory to keep the codebase organized. All import paths have been updated to work from this new location.