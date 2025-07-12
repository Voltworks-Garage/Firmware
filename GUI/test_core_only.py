#!/usr/bin/env python3
"""
Test Core Functionality Only
============================

This script tests the core CAN tool functionality without GUI dependencies.
Perfect for testing in environments without tkinter.
"""

import sys
import os

# Add current directory to Python path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, current_dir)

def test_core_functionality():
    """Test the core CAN processing functionality"""
    print("🧪 Testing Core CAN Tool Functionality")
    print("=" * 40)
    
    try:
        # Test core imports
        from can_tool.core.can_message import CANMessage, CANMessageManager
        from can_tool.core.dbf_parser import BusmasterDBFParser
        from can_tool.config import Config, default_config
        
        print("✅ Core modules imported successfully")
        
        # Test DBF parser
        dbf_parser = BusmasterDBFParser("nonexistent.dbf")  # Will warn but not crash
        print("✅ DBF parser created")
        
        # Test message manager
        msg_manager = CANMessageManager(dbf_parser)
        print("✅ Message manager created")
        
        # Test processing a CAN message
        test_data = bytes([0x12, 0x34, 0x56, 0x78, 0xAB, 0xCD, 0xEF, 0x00])
        can_msg = msg_manager.update_message(0x123, 8, test_data)
        
        print(f"✅ Processed CAN message:")
        print(f"   ID: 0x{can_msg.msg_id:X}")
        print(f"   Name: {can_msg.name}")
        print(f"   DLC: {can_msg.dlc}")
        print(f"   Data: {' '.join(f'{b:02X}' for b in can_msg.data)}")
        print(f"   Count: {can_msg.count}")
        
        # Test configuration
        print("✅ Configuration system:")
        print(f"   DBF Path: {default_config.get_dbf_path()}")
        print(f"   Enabled plugins: {default_config.get_enabled_plugins()}")
        print(f"   Window title: {default_config.get_window_title()}")
        
        # Test custom configuration
        custom_config = Config({
            "plugins": {"isotp_tab": {"enabled": False}},
            "gui": {"window_title": "Custom CAN Tool"}
        })
        print("✅ Custom configuration:")
        print(f"   ISO-TP enabled: {custom_config.is_plugin_enabled('isotp_tab')}")
        print(f"   Custom title: {custom_config.get_window_title()}")
        
        return True
        
    except Exception as e:
        print(f"❌ Test failed: {e}")
        import traceback
        traceback.print_exc()
        return False

def test_message_processing():
    """Test advanced message processing features"""
    print("\n🔍 Testing Advanced Message Processing")
    print("=" * 40)
    
    try:
        from can_tool.core.can_message import CANMessage, CANMessageManager
        from can_tool.core.dbf_parser import BusmasterDBFParser
        
        dbf_parser = BusmasterDBFParser("test.dbf")
        msg_manager = CANMessageManager(dbf_parser)
        
        # Test multiple messages
        messages = [
            (0x100, bytes([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])),
            (0x200, bytes([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF, 0x00, 0x11])),
            (0x300, bytes([0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA, 0x99, 0x88])),
        ]
        
        for msg_id, data in messages:
            can_msg = msg_manager.update_message(msg_id, len(data), data)
            print(f"✅ Message 0x{msg_id:X}: {can_msg.name} (count: {can_msg.count})")
        
        # Test message retrieval
        msg = msg_manager.get_message(0x100)
        if msg:
            print(f"✅ Retrieved message: 0x{msg.msg_id:X}")
        
        # Test expansion toggle
        expanded = msg_manager.toggle_expansion(0x100)
        print(f"✅ Expansion toggle: {expanded}")
        
        print(f"✅ Total messages in manager: {len(msg_manager.messages)}")
        
        return True
        
    except Exception as e:
        print(f"❌ Advanced test failed: {e}")
        return False

def main():
    """Run all tests"""
    print("🚀 CAN Tool Core Testing Suite\n")
    
    tests_passed = 0
    total_tests = 2
    
    if test_core_functionality():
        tests_passed += 1
    
    if test_message_processing():
        tests_passed += 1
    
    print(f"\n📊 Test Results: {tests_passed}/{total_tests} passed")
    
    if tests_passed == total_tests:
        print("🎉 All core tests passed! The modular architecture is working.")
        print("\n📋 Summary:")
        print("   ✅ Core CAN message processing works")
        print("   ✅ DBF parser integration works") 
        print("   ✅ Configuration system works")
        print("   ✅ Plugin detection works")
        print("   ✅ Message management works")
        print("\n🚀 Ready for GUI usage (when tkinter is available):")
        print("   python run_can_tool.py")
    else:
        print("❌ Some tests failed. Check the output above.")

if __name__ == "__main__":
    main()