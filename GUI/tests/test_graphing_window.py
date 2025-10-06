#!/usr/bin/env python3
"""
Test Graphing Window Functionality
===================================

This test validates the signal graphing window functionality, including:
- Window creation and initialization
- Signal selection and addition
- Multi-axis plotting with different colors
- Real-time data updates
- Error handling for missing matplotlib
"""

import sys
import os
import unittest
import tkinter as tk
import time
from unittest.mock import Mock, patch

# Add parent directory to path for imports
current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)
sys.path.insert(0, parent_dir)

try:
    from can_tool.gui.main_app import CANApp
    from can_tool.gui.graphing_window import GraphingWindow, SignalData, MATPLOTLIB_AVAILABLE
    from can_tool.core.can_message import CANMessage
except ImportError as e:
    print(f"Import error: {e}")
    sys.exit(1)


class TestGraphingWindow(unittest.TestCase):
    """Test signal graphing window functionality"""
    
    def setUp(self):
        """Set up test environment"""
        self.root = tk.Tk()
        self.root.withdraw()  # Hide test window
        
        # Create test DBF path
        self.test_dbf_path = os.path.join(parent_dir, "CAN", "emoto.dbf")
        if not os.path.exists(self.test_dbf_path):
            self.test_dbf_path = "test.dbf"  # Fallback for testing
        
        # Initialize application
        self.app = CANApp(self.root, self.test_dbf_path)
        
        # Add some test message data
        self._setup_test_messages()
    
    def tearDown(self):
        """Clean up test environment"""
        try:
            if hasattr(self.app, 'graphing_window') and self.app.graphing_window:
                self.app.graphing_window.on_window_close()
        except:
            pass
        
        try:
            self.root.destroy()
        except:
            pass
    
    def _setup_test_messages(self):
        """Set up test CAN messages with decoded signals"""
        # Create a mock CAN message with decoded signals
        test_msg = CANMessage(
            msg_id=0x123,
            name="test_message",
            dlc=8,
            data=b'\x01\x02\x03\x04\x05\x06\x07\x08',
            count=1,
            last_time=time.time(),
            decoded_signals={
                'voltage': '12.5',
                'current': '5.2',
                'temperature': '25.0'
            }
        )
        
        # Add to message manager
        self.app.message_manager.messages[0x123] = test_msg
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_graphing_window_creation(self):
        """Test that graphing window can be created"""
        # Test opening graphing window
        self.app.open_graphing_window()
        
        # Verify window was created
        self.assertIsNotNone(self.app.graphing_window)
        self.assertIsNotNone(self.app.graphing_window.window)
        
        # Allow GUI to update
        self.root.update()
        
        # Verify window components exist
        self.assertIsNotNone(self.app.graphing_window.figure)
        self.assertIsNotNone(self.app.graphing_window.canvas)
        self.assertIsNotNone(self.app.graphing_window.signal_tree)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_signal_data_container(self):
        """Test SignalData container functionality"""
        signal_data = SignalData("voltage", "test_message", "V", "#ff0000")
        
        # Test initial state
        self.assertEqual(signal_data.signal_name, "voltage")
        self.assertEqual(signal_data.message_name, "test_message")
        self.assertEqual(signal_data.full_name, "test_message.voltage")
        self.assertEqual(signal_data.units, "V")
        self.assertEqual(signal_data.color, "#ff0000")
        
        # Test adding data points
        current_time = time.time()
        signal_data.add_data_point(current_time, 12.5)
        signal_data.add_data_point(current_time + 1, 13.0)
        
        # Verify data was stored
        self.assertEqual(len(signal_data.timestamps), 2)
        self.assertEqual(len(signal_data.values), 2)
        self.assertEqual(signal_data.values[0], 12.5)
        self.assertEqual(signal_data.values[1], 13.0)
        
        # Test recent data retrieval
        times, values = signal_data.get_recent_data(60.0)
        self.assertEqual(len(times), 2)
        self.assertEqual(len(values), 2)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_color_palette_generation(self):
        """Test color palette generation"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Test color generation
        colors = graphing_window.colors
        self.assertGreater(len(colors), 0)
        
        # Test getting next color
        color1 = graphing_window._get_next_color()
        color2 = graphing_window._get_next_color()
        
        # Colors should be different
        self.assertNotEqual(color1, color2)
        
        # Colors should be valid hex format
        self.assertTrue(color1.startswith('#'))
        self.assertEqual(len(color1), 7)  # #RRGGBB format
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_signal_addition(self):
        """Test adding signals to the graph"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Add a signal
        signal_name = "test_message.voltage"
        graphing_window.add_signal(signal_name)
        
        # Verify signal was added
        self.assertIn(signal_name, graphing_window.signal_data)
        
        # Verify signal data properties
        signal_data = graphing_window.signal_data[signal_name]
        self.assertEqual(signal_data.signal_name, "voltage")
        self.assertEqual(signal_data.message_name, "test_message")
        self.assertIsNotNone(signal_data.color)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_signal_removal(self):
        """Test removing signals from the graph"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Add and then remove a signal
        signal_name = "test_message.voltage"
        graphing_window.add_signal(signal_name)
        self.assertIn(signal_name, graphing_window.signal_data)
        
        graphing_window.remove_signal(signal_name)
        self.assertNotIn(signal_name, graphing_window.signal_data)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_can_message_processing(self):
        """Test CAN message processing for graphing"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Add a signal to track
        signal_name = "test_message.voltage"
        graphing_window.add_signal(signal_name)
        
        # Get the test message
        can_msg = self.app.message_manager.messages[0x123]
        
        # Process the message
        initial_points = len(graphing_window.signal_data[signal_name].values)
        graphing_window.on_can_message_received(0x123, can_msg)
        
        # Verify data point was added
        final_points = len(graphing_window.signal_data[signal_name].values)
        self.assertGreater(final_points, initial_points)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_time_window_configuration(self):
        """Test time window configuration"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Test initial time window
        self.assertEqual(graphing_window.time_window, 60.0)
        
        # Test changing time window
        graphing_window.time_window_var.set("120")
        graphing_window.on_time_window_changed()
        self.assertEqual(graphing_window.time_window, 120.0)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_update_rate_configuration(self):
        """Test update rate configuration"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Test initial update rate
        self.assertEqual(graphing_window.update_interval, 100)
        
        # Test changing update rate
        graphing_window.update_rate_var.set("200")
        graphing_window.on_update_rate_changed()
        self.assertEqual(graphing_window.update_interval, 200)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_clear_all_signals(self):
        """Test clearing all signals"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Add multiple signals
        graphing_window.add_signal("test_message.voltage")
        graphing_window.add_signal("test_message.current")
        
        self.assertEqual(len(graphing_window.signal_data), 2)
        
        # Clear all signals (mock the confirmation dialog)
        with patch('tkinter.messagebox.askyesno', return_value=True):
            graphing_window.clear_all_signals()
        
        self.assertEqual(len(graphing_window.signal_data), 0)
    
    def test_matplotlib_unavailable_handling(self):
        """Test graceful handling when matplotlib is not available"""
        # Mock matplotlib as unavailable
        with patch('can_tool.gui.graphing_window.MATPLOTLIB_AVAILABLE', False):
            with patch('tkinter.messagebox.showerror') as mock_error:
                self.app.open_graphing_window()
                
                # Should show error message
                mock_error.assert_called_once()
                
                # Should not create graphing window
                self.assertIsNone(self.app.graphing_window)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_window_close_cleanup(self):
        """Test proper cleanup when window is closed"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Verify window is running
        self.assertTrue(graphing_window.is_running)
        
        # Close window
        graphing_window.on_window_close()
        
        # Verify cleanup
        self.assertFalse(graphing_window.is_running)
        self.assertIsNone(graphing_window.window)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_multiple_y_axes(self):
        """Test that multiple signals create separate y-axes"""
        self.app.open_graphing_window()
        graphing_window = self.app.graphing_window
        
        # Add multiple signals with different units
        graphing_window.add_signal("test_message.voltage")
        graphing_window.add_signal("test_message.current")
        graphing_window.add_signal("test_message.temperature")
        
        # Verify all signals were added
        self.assertEqual(len(graphing_window.signal_data), 3)
        
        # Each signal should have a different color
        colors = [signal.color for signal in graphing_window.signal_data.values()]
        self.assertEqual(len(set(colors)), 3)  # All colors should be unique


class TestGraphingIntegration(unittest.TestCase):
    """Test integration between main app and graphing window"""
    
    def setUp(self):
        """Set up test environment"""
        self.root = tk.Tk()
        self.root.withdraw()  # Hide test window
        
        # Create test DBF path
        self.test_dbf_path = os.path.join(parent_dir, "CAN", "emoto.dbf")
        if not os.path.exists(self.test_dbf_path):
            self.test_dbf_path = "test.dbf"  # Fallback for testing
        
        # Initialize application
        self.app = CANApp(self.root, self.test_dbf_path)
    
    def tearDown(self):
        """Clean up test environment"""
        try:
            if hasattr(self.app, 'graphing_window') and self.app.graphing_window:
                self.app.graphing_window.on_window_close()
        except:
            pass
        
        try:
            self.root.destroy()
        except:
            pass
    
    def test_menu_integration(self):
        """Test that graphing window is accessible from menu"""
        # Verify Tools menu exists
        menubar = self.app.root.nametowidget(self.app.root['menu'])
        menu_labels = []
        
        for i in range(menubar.index('end') + 1):
            try:
                label = menubar.entrycget(i, 'label')
                menu_labels.append(label)
            except:
                pass
        
        self.assertIn('Tools', menu_labels)
    
    @unittest.skipIf(not MATPLOTLIB_AVAILABLE, "Matplotlib not available")
    def test_message_forwarding(self):
        """Test that CAN messages are forwarded to graphing window"""
        # Create mock CAN message
        mock_msg = Mock()
        mock_msg.is_error_frame = False
        mock_msg.arbitration_id = 0x123
        mock_msg.dlc = 8
        mock_msg.data = b'\x01\x02\x03\x04\x05\x06\x07\x08'
        
        # Open graphing window
        self.app.open_graphing_window()
        
        # Mock the graphing window's message handler
        with patch.object(self.app.graphing_window, 'on_can_message_received') as mock_handler:
            # Process message through main app
            self.app.handle_rx_message(mock_msg)
            
            # Verify graphing window was notified
            mock_handler.assert_called_once()


def run_graphing_tests():
    """Run all graphing window tests"""
    print("🧪 Running CAN Tool Graphing Window Tests...")
    
    # Create test suite
    test_suite = unittest.TestSuite()
    
    # Add test cases
    test_suite.addTest(unittest.makeSuite(TestGraphingWindow))
    test_suite.addTest(unittest.makeSuite(TestGraphingIntegration))
    
    # Run tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(test_suite)
    
    # Print summary
    if result.wasSuccessful():
        print(f"✅ All tests passed! ({result.testsRun} tests)")
        return 0
    else:
        print(f"❌ {len(result.failures)} failures, {len(result.errors)} errors")
        return 1


if __name__ == "__main__":
    exit_code = run_graphing_tests()
    sys.exit(exit_code)