-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Atom'
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

config.use_fancy_tab_bar = false

-- Disable title bar but enable resizable border
config.window_decorations = "RESIZE"

config.font_size = 16

-- Disable treating Alt as a modifier for commands
-- and let it work as a normal key
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

local act = wezterm.action

config.keys = {
  { key = '{', mods = 'SHIFT|SUPER', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|SUPER', action = act.MoveTabRelative(1) },
}

return config
