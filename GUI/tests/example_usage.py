#!/usr/bin/env python3
"""
Example Usage of Modular CAN Tool
=================================

This file demonstrates how to use the modular CAN tool in different ways.
"""

import sys
import os

# Add current directory to path for local imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def example_core_usage():
    """Example of using just the core components (no GUI)"""
    print("📦 Core Components Example")
    print("=" * 30)
    
    # Import core components
    from core.can_message import CANMessage, CANMessageManager
    from core.dbf_parser import BusmasterDBFParser
    from config import Config
    
    # Create a DBF parser (will warn if file doesn't exist)
    dbf_parser = BusmasterDBFParser("test.dbf")
    
    # Create message manager
    msg_manager = CANMessageManager(dbf_parser)
    
    # Simulate processing a CAN message
    test_data = bytes([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])
    can_msg = msg_manager.update_message(0x123, 8, test_data)
    
    print(f"✅ Processed message: ID=0x{can_msg.msg_id:X}, Name={can_msg.name}")
    print(f"✅ Message count: {can_msg.count}")
    
    # Test configuration
    config = Config()
    enabled_plugins = config.get_enabled_plugins()
    print(f"✅ Configuration loaded, enabled plugins: {enabled_plugins}")

def example_custom_config():
    """Example of using custom configuration"""
    print("\n🔧 Custom Configuration Example")
    print("=" * 35)
    
    from config import Config
    
    # Create custom config with ISO-TP disabled
    custom_config = Config({
        "dbf_path": "/path/to/my/custom.dbf",
        "plugins": {
            "isotp_tab": {"enabled": False}  # Disable ISO-TP
        },
        "gui": {
            "window_title": "My Custom CAN Tool",
            "refresh_rate_ms": 50  # Faster refresh
        }
    })
    
    print(f"✅ Custom DBF path: {custom_config.get_dbf_path()}")
    print(f"✅ Window title: {custom_config.get_window_title()}")
    print(f"✅ ISO-TP enabled: {custom_config.is_plugin_enabled('isotp_tab')}")
    print(f"✅ Enabled plugins: {custom_config.get_enabled_plugins()}")

def example_gui_usage():
    """Example of using the GUI application"""
    print("\n🖥️  GUI Application Example")
    print("=" * 30)
    
    try:
        # This will only work if tkinter is available
        import main
        from main import create_standalone_app
        
        print("✅ GUI components available")
        print("To run the full application:")
        print("   python main.py")
        print("\nTo create a custom standalone app:")
        print("   root, app = create_standalone_app(custom_config)")
        print("   root.mainloop()")
        
    except ImportError as e:
        print(f"❌ GUI not available: {e}")
        print("This is normal in environments without tkinter")

def example_plugin_development():
    """Example of developing custom plugins"""
    print("\n🔌 Plugin Development Example")
    print("=" * 32)
    
    print("To create a custom plugin:")
    print("""
from gui.base_tab import BaseTab

class MyCustomTab(BaseTab):
    @property
    def tab_name(self):
        return "My Feature"
    
    @property  
    def tab_description(self):
        return "Custom functionality for my application"
    
    def create_widgets(self):
        # Create your UI here
        import tkinter as tk
        from tkinter import ttk
        
        label = ttk.Label(self.tab_frame, text="Hello, Custom Plugin!")
        label.pack(pady=20)
    
    def on_can_message_received(self, msg):
        # Process incoming CAN messages
        print(f"Custom plugin received: {msg.arbitration_id:X}")
    """)
    
    print("Then add it to the plugin registry in config.py")

def main():
    """Run all examples"""
    print("🚀 Modular CAN Tool Usage Examples\n")
    
    try:
        example_core_usage()
        example_custom_config()
        example_gui_usage()
        example_plugin_development()
        
        print("\n" + "=" * 50)
        print("🎉 All examples completed successfully!")
        print("\nTo get started:")
        print("1. For core functionality: Use core modules")
        print("2. For GUI application: Run 'python main.py'")
        print("3. For custom integration: Use create_standalone_app()")
        print("4. For plugins: Inherit from BaseTab")
        
    except Exception as e:
        print(f"\n❌ Example failed: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()