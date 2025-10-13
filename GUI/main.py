"""
Main Entry Point
================

This is the main entry point for the modular CAN tool.
It initializes the configuration, loads plugins, and starts the GUI application.
"""

import os
import tkinter as tk

# Import modules
from config import Config, default_config, load_plugins
from gui.main_app import CANApp


def main():
    """Main entry point for the CAN tool"""

    # Create the main window
    root = tk.Tk()

    # Use default configuration (can be extended to load from file)
    config = default_config

    # Set window title
    root.title(config.get_window_title())

    # Get DBF path
    dbf_path = config.get_dbf_path()

    # Validate DBF file exists
    if not os.path.exists(dbf_path):
        print(f"⚠️  Warning: DBF file not found at {dbf_path}")
        print("    The application will still work but without signal decoding.")

    # Create the main application
    app = CANApp(root, dbf_path)

    # Load plugins after app is created but before mainloop
    plugins = load_plugins(config, app.tx_notebook, app)
    app.plugins = plugins
    app.initialize_plugins()

    # Log startup information
    app.log("🚀 CAN Tool Started")
    app.log(f"📁 DBF File: {dbf_path}")

    enabled_plugins = config.get_enabled_plugins()
    if enabled_plugins:
        app.log(f"🔌 Loaded plugins: {', '.join(enabled_plugins)}")
    else:
        app.log("📦 No plugins loaded (use File > Plugins menu to enable)")

    # Set minimum window size
    root.minsize(800, 600)

    # Start the application
    try:
        root.mainloop()
    except KeyboardInterrupt:
        print("\n🛑 Application interrupted by user")
    finally:
        # Cleanup
        if app.running:
            app.disconnect()

        # Cleanup plugins
        for plugin in app.plugins:
            try:
                plugin.cleanup()
            except Exception as e:
                print(f"Error cleaning up plugin {plugin.tab_name}: {e}")


def create_standalone_app(custom_config: dict | None = None):
    """
    Create a standalone application instance with custom configuration.
    Useful for embedding the CAN tool in other applications.

    Args:
        custom_config: Optional dictionary to override default configuration

    Returns:
        tuple: (root, app) - Tkinter root and CANApp instance
    """
    root = tk.Tk()

    # Create configuration
    if custom_config:
        config = Config(custom_config)
    else:
        config = default_config

    root.title(config.get_window_title())

    # Create application
    app = CANApp(root, config.get_dbf_path())

    # Load plugins
    plugins = load_plugins(config, app.tx_notebook, app)
    app.plugins = plugins
    app.initialize_plugins()

    return root, app


if __name__ == "__main__":
    main()
