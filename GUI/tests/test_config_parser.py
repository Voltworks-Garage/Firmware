#!/usr/bin/env python3
"""
Test script for config parser
"""

import sys
import os

# Add the can_tool directory to Python path
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from can_tool.core.config_parser import ConfigParser

def test_config_parser():
    # Navigate from GUI/ to Firmware/
    gui_dir = os.path.dirname(__file__)
    firmware_root = os.path.dirname(gui_dir)
    print(f"Testing config parser with firmware root: {firmware_root}")
    
    parser = ConfigParser(firmware_root)
    parser.load_all_configs()
    
    print(f"\nLoaded {len(parser.device_configs)} device configs:")
    for name, config in parser.device_configs.items():
        print(f"  {name}: TX=0x{config.tx_id:03X}, RX=0x{config.rx_id:03X}")
        print(f"    Commands: {list(config.commands.keys())}")

if __name__ == "__main__":
    test_config_parser()