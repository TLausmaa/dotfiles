local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_scroll_bar = false
config.color_scheme = "Adventure"
config.enable_tab_bar = false
-- config.window_background_opacity = 0.85
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- This is where you actually apply your config choices
config.keys = {
    {
        key = '8',
        mods = 'OPT',
        action = wezterm.action.SendString '['  
    },
    {
        key = '9',
        mods = 'OPT',
        action = wezterm.action.SendString ']'  
    },
    {
        key = '(',
        mods = 'OPT|SHIFT',
        action = wezterm.action.SendString '{'  
    },
    {
        key = ')',
        mods = 'OPT|SHIFT',
        action = wezterm.action.SendString '}'  
    }
}

return config
