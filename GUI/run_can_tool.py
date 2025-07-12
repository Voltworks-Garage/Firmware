#!/usr/bin/env python3
"""
Launcher script for CAN Tool
============================

This script properly sets up the Python path and launches the CAN tool.
Use this if you get "ModuleNotFoundError: No module named 'can_tool'"
"""

import sys
import os

# Add the current directory to Python path so can_tool can be imported
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, current_dir)

def main():
    """Launch the CAN tool with proper path setup"""
    try:
        # Import and run the CAN tool
        from can_tool.main import main as can_main
        print("🚀 Starting CAN Tool...")
        can_main()
    except ImportError as e:
        print(f"❌ Import Error: {e}")
        print("\nTroubleshooting:")
        print("1. Make sure you're in the correct directory:")
        print(f"   Current: {current_dir}")
        print("2. Make sure all files exist:")
        print(f"   can_tool/: {os.path.exists(os.path.join(current_dir, 'can_tool'))}")
        print(f"   can_tool/main.py: {os.path.exists(os.path.join(current_dir, 'can_tool', 'main.py'))}")
        print("3. Try installing python-can: pip install python-can")
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()