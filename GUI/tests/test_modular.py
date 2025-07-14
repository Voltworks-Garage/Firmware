#!/usr/bin/env python3
"""
Test script for the modular CAN tool
====================================

This script tests the modular architecture by importing and running the CAN tool.
"""

import sys
import os

# Add the current directory to Python path so we can import can_tool
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def test_imports():
    """Test that all modules can be imported correctly"""
    print("🧪 Testing imports...")
    
    try:
        # Test core imports
        from can_tool.core import CANMessage, CANMessageManager, BusmasterDBFParser, CANTableView
        print("  ✅ Core modules imported successfully")
        
        # Test GUI imports  
        from can_tool.gui import BaseTab, CANApp
        print("  ✅ GUI modules imported successfully")
        
        # Test plugin imports
        from can_tool.plugins import ISOTPTab
        print("  ✅ Plugin modules imported successfully")
        
        # Test config imports
        from can_tool.config import Config, default_config, load_plugins
        print("  ✅ Config module imported successfully")
        
        # Test main imports
        from can_tool.main import main, create_standalone_app
        print("  ✅ Main module imported successfully")
        
        # Test top-level imports
        from can_tool import main, create_standalone_app, Config
        print("  ✅ Top-level imports successful")
        
        return True
        
    except ImportError as e:
        print(f"  ❌ Import error: {e}")
        return False
    except Exception as e:
        print(f"  ❌ Unexpected error: {e}")
        return False

def test_configuration():
    """Test configuration system"""
    print("\n🔧 Testing configuration...")
    
    try:
        from can_tool.config import Config, default_config
        
        # Test default config
        assert default_config.get("plugins.isotp_tab.enabled") == True
        print("  ✅ Default configuration loaded")
        
        # Test custom config
        custom_config = Config({
            "plugins": {
                "isotp_tab": {"enabled": False}
            }
        })
        assert custom_config.get("plugins.isotp_tab.enabled") == False
        print("  ✅ Custom configuration works")
        
        # Test plugin detection
        enabled = default_config.get_enabled_plugins()
        assert "isotp_tab" in enabled
        print("  ✅ Plugin detection works")
        
        return True
        
    except Exception as e:
        print(f"  ❌ Configuration test failed: {e}")
        return False

def test_plugin_system():
    """Test plugin loading system"""
    print("\n🔌 Testing plugin system...")
    
    try:
        import tkinter as tk
        from tkinter import ttk
        from can_tool.config import load_plugins, default_config
        from can_tool.gui.main_app import CANApp
        
        # Create minimal test environment
        root = tk.Tk()
        root.withdraw()  # Hide window during test
        
        # Create a test notebook
        notebook = ttk.Notebook(root)
        
        # Create minimal app instance
        app = CANApp(root, "test.dbf")  # Non-existent DBF is OK for test
        
        # Load plugins
        plugins = load_plugins(default_config, notebook, app)
        
        assert len(plugins) > 0, "No plugins were loaded"
        print(f"  ✅ Loaded {len(plugins)} plugin(s)")
        
        # Test plugin interface
        for plugin in plugins:
            assert hasattr(plugin, 'tab_name'), "Plugin missing tab_name property"
            assert hasattr(plugin, 'tab_description'), "Plugin missing tab_description property"
            assert hasattr(plugin, 'create_widgets'), "Plugin missing create_widgets method"
            print(f"  ✅ Plugin '{plugin.tab_name}' has correct interface")
        
        root.destroy()
        return True
        
    except Exception as e:
        print(f"  ❌ Plugin system test failed: {e}")
        return False

def main():
    """Run all tests"""
    print("🚀 Testing Modular CAN Tool Architecture\n")
    
    tests = [
        test_imports,
        test_configuration, 
        test_plugin_system
    ]
    
    passed = 0
    total = len(tests)
    
    for test in tests:
        if test():
            passed += 1
    
    print(f"\n📊 Results: {passed}/{total} tests passed")
    
    if passed == total:
        print("🎉 All tests passed! The modular architecture is working correctly.")
        print("\n🚀 You can now run the application with:")
        print("   python -m can_tool.main")
        return True
    else:
        print("❌ Some tests failed. Please check the errors above.")
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)