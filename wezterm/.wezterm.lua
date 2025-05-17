-- ~/.dotfiles/wezterm/.wezterm.lua

-- Import the wezterm module
local wezterm = require 'wezterm'
-- Import the mux module, which helps manage windows, tabs, and panes
local mux = wezterm.mux

-- This table will hold the configuration
local terminal_configuration = {}

if wezterm.config_builder then
  terminal_configuration = wezterm.config_builder()
end

-- Font Configuration
terminal_configuration.font = wezterm.font 'FiraCode Nerd Font'

-- Set a larger font size
terminal_configuration.font_size = 18.0

-- Window Opacity
terminal_configuration.window_background_opacity = 0.85

-- Color Scheme
terminal_configuration.color_scheme = 'Tokyo Night Storm'

terminal_configuration.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
terminal_configuration.use_fancy_tab_bar = false

-- Event to handle actions on GUI startup
wezterm.on('gui-startup', function(command_line_arguments)
  local tab, pane, window = mux.spawn_window(command_line_arguments or {})

  if window then
    local gui_window_object = window:gui_window()
    if gui_window_object then
      gui_window_object:maximize()
    end
  end
end)

-- Return the configuration
return terminal_configuration
