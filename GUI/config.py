"""
Configuration Management
========================

This module handles configuration for the CAN tool, including plugin management.
"""

from typing import Dict, List, Any, Optional

# Default configuration with cross-platform path using forward slashes
DEFAULT_CONFIG = {
    "dbf_path": "../CAN/emoto.dbf",  # Relative path with forward slashes (works on both Windows and Linux)
    "plugins": {
        "isotp_tab": {
            "enabled": False,  # ISO-TP plugin is OFF by default - only loads when manually selected
            "description": "ISO-TP communication for commandService interaction"
        },
        "canopen_sdo_tab": {
            "enabled": True,  # CANopen SDO plugin is ON by default
            "description": "CANopen SDO read/write operations using EDS object dictionary"
        }
    },
    "gui": {
        "refresh_rate_ms": 100,
        "window_title": "CAN Tool - Modular CAN Bus Analysis"
    }
}


class Config:
    """Configuration manager for the CAN tool"""
    
    def __init__(self, config_dict: Optional[Dict[str, Any]] = None):
        """Initialize configuration with optional override"""
        self.config = config_dict or DEFAULT_CONFIG.copy()
    
    def get(self, key: str, default: Any = None) -> Any:
        """Get a configuration value using dot notation (e.g., 'plugins.isotp_tab.enabled')"""
        keys = key.split('.')
        value = self.config
        
        for k in keys:
            if isinstance(value, dict) and k in value:
                value = value[k]
            else:
                return default
        
        return value
    
    def set(self, key: str, value: Any):
        """Set a configuration value using dot notation"""
        keys = key.split('.')
        config_ref = self.config
        
        # Navigate to the parent of the target key
        for k in keys[:-1]:
            if k not in config_ref:
                config_ref[k] = {}
            config_ref = config_ref[k]
        
        # Set the final value
        config_ref[keys[-1]] = value
    
    def is_plugin_enabled(self, plugin_name: str) -> bool:
        """Check if a plugin is enabled"""
        return self.get(f"plugins.{plugin_name}.enabled", False)
    
    def get_enabled_plugins(self) -> List[str]:
        """Get list of enabled plugin names"""
        plugins = self.get("plugins", {})
        return [name for name, config in plugins.items() if config.get("enabled", False)]
    
    def get_dbf_path(self) -> str:
        """Get the DBF file path"""
        return self.get("dbf_path", "")
    
    def get_window_title(self) -> str:
        """Get the application window title"""
        return self.get("gui.window_title", "CAN Tool")
    
    def get_refresh_rate(self) -> int:
        """Get the GUI refresh rate in milliseconds"""
        return self.get("gui.refresh_rate_ms", 100)


def create_plugin_loader():
    """Create a plugin loader function that loads enabled plugins"""
    def _get_isotp_tab():
        # Import plugins
        from plugins.isotp_tab import ISOTPTab
        return ISOTPTab

    def _get_canopen_sdo_tab():
        # Import CANopen SDO plugin
        from plugins.canopen_sdo_tab import CANopenSDOTab
        return CANopenSDOTab
    
    # Registry of available plugins (lazy loading)
    PLUGIN_REGISTRY = {
        "isotp_tab": _get_isotp_tab,
        "canopen_sdo_tab": _get_canopen_sdo_tab
    }
    
    def load_plugins(config: Config, parent_notebook, app_instance) -> List:
        """Load enabled plugins based on configuration"""
        plugins = []
        enabled_plugins = config.get_enabled_plugins()
        
        for plugin_name in enabled_plugins:
            if plugin_name in PLUGIN_REGISTRY:
                try:
                    plugin_class_loader = PLUGIN_REGISTRY[plugin_name]
                    plugin_class = plugin_class_loader()  # Call the lazy loader
                    plugin_instance = plugin_class(parent_notebook, app_instance)
                    plugins.append(plugin_instance)
                    print(f"✅ Loaded plugin: {plugin_name}")
                except Exception as e:
                    print(f"❌ Failed to load plugin {plugin_name}: {e}")
            else:
                print(f"⚠️  Unknown plugin: {plugin_name}")
        
        return plugins
    
    return load_plugins


# Create the default configuration instance
default_config = Config()

# Create the plugin loader function (not called at module level)
def load_plugins(config, parent_notebook, app_instance):
    """Load enabled plugins based on configuration - lazy wrapper"""
    _load_plugins = create_plugin_loader()
    return _load_plugins(config, parent_notebook, app_instance)