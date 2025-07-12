#!/usr/bin/env python3
"""
Test DBF Loading Fix
====================

This script tests that the DBF file can be properly loaded with messages.
"""

import sys
import os

# Add current directory to Python path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, current_dir)

def test_dbf_file_access():
    """Test that the DBF file exists and can be accessed"""
    print("🧪 Testing DBF File Access")
    print("=" * 27)
    
    try:
        from can_tool.config import default_config
        
        dbf_path = default_config.get_dbf_path()
        print(f"📁 Configured DBF path: {dbf_path}")
        
        # Check if file exists
        if os.path.exists(dbf_path):
            print(f"✅ DBF file exists: {dbf_path}")
            
            # Check file size
            file_size = os.path.getsize(dbf_path)
            print(f"📏 File size: {file_size} bytes")
            
            if file_size > 0:
                print("✅ DBF file is not empty")
                return True
            else:
                print("❌ DBF file is empty")
                return False
        else:
            print(f"❌ DBF file not found: {dbf_path}")
            return False
        
    except Exception as e:
        print(f"❌ DBF file access test failed: {e}")
        return False

def test_dbf_parsing():
    """Test that the DBF parser can load messages"""
    print("\n🔧 Testing DBF Parsing")
    print("=" * 22)
    
    try:
        from can_tool.core.dbf_parser import BusmasterDBFParser
        from can_tool.config import default_config
        
        dbf_path = default_config.get_dbf_path()
        print(f"📂 Loading DBF file: {dbf_path}")
        
        parser = BusmasterDBFParser(dbf_path)
        
        print(f"📊 Messages loaded: {len(parser.messages)}")
        
        if len(parser.messages) > 0:
            print("✅ DBF file contains messages")
            
            # Show first few messages
            print("\n📋 Sample messages:")
            count = 0
            for msg_id, msg_info in sorted(parser.messages.items()):
                if count < 5:  # Show first 5 messages
                    print(f"   0x{msg_id:03X} - {msg_info['name']} (DLC: {msg_info['dlc']})")
                    count += 1
                else:
                    remaining = len(parser.messages) - count
                    if remaining > 0:
                        print(f"   ... and {remaining} more messages")
                    break
            
            return True
        else:
            print("❌ No messages found in DBF file")
            return False
        
    except Exception as e:
        print(f"❌ DBF parsing test failed: {e}")
        import traceback
        traceback.print_exc()
        return False

def test_add_message_functionality():
    """Test the add_message functionality would work"""
    print("\n🔌 Testing Add Message Functionality")
    print("=" * 36)
    
    try:
        from can_tool.core.dbf_parser import BusmasterDBFParser
        from can_tool.config import default_config
        
        dbf_path = default_config.get_dbf_path()
        parser = BusmasterDBFParser(dbf_path)
        
        # Simulate the add_dbf_message check
        if not parser.messages:
            print("❌ Would show 'No messages found in DBF file' error")
            return False
        else:
            print("✅ Would show message selection dialog")
            print(f"📊 Available messages for selection: {len(parser.messages)}")
            
            # Test message selection format
            print("\n📋 Dialog would show:")
            for i, (msg_id, msg_info) in enumerate(sorted(parser.messages.items())):
                if i < 3:  # Show first 3
                    dialog_text = f"0x{msg_id:03X} - {msg_info['name']} (DLC: {msg_info['dlc']})"
                    print(f"   {dialog_text}")
                elif i == 3:
                    print(f"   ... and {len(parser.messages) - 3} more")
                    break
            
            return True
        
    except Exception as e:
        print(f"❌ Add message functionality test failed: {e}")
        return False

def main():
    """Run DBF loading fix tests"""
    print("🚀 DBF Loading Fix Test\n")
    
    tests = [
        test_dbf_file_access,
        test_dbf_parsing,
        test_add_message_functionality
    ]
    
    passed = 0
    total = len(tests)
    
    for test in tests:
        if test():
            passed += 1
    
    print(f"\n📊 Test Results: {passed}/{total} tests passed")
    
    if passed == total:
        print("\n🎉 SUCCESS: DBF loading is fixed!")
        print("\n✅ Results:")
        print("   • DBF file exists and is accessible")
        print("   • DBF parser loads messages successfully")
        print("   • Add Message functionality will work")
        print("   • No more 'No messages found' error")
        
    else:
        print("\n❌ DBF loading still has issues")
        
    return passed == total

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)