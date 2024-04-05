local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_scroll_bar = false
-- config.color_scheme = "Adventure"
config.enable_tab_bar = false
-- config.window_background_opacity = 0.85
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.colors = {
    foreground = 'white'
}

-- config.font = wezterm.font 'Fira Code'

--[[
config.colors = {
  -- The default text color
  foreground = 'black',
  -- The default background color
  background = 'gray',
  cursor_bg = '#52ad70',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = 'black',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#52ad70',
  -- the foreground color of selected text
  selection_fg = 'black',
  -- the background color of selected text
  selection_bg = '#fffacd',
  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',
}
--]]

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
    },
    {
        key = '7',
        mods = 'OPT',
        action = wezterm.action.SendString '|'
    },
}

return config
