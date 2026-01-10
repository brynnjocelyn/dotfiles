-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Regular" })
config.font_size = 16.0

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

config.scrollback_lines = 10000 -- Adjust as needed
config.enable_scroll_bar = false -- Optional: disable scrollbar

-- Selection word boundary customization
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@"
config.enable_wayland = false

-- and finally, return the configuration to wezterm
return config
