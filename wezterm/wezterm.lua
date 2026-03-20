local wezterm = require 'wezterm'
local keybind = require 'keybinds'
local config = wezterm.config_builder()
config.automatically_reload_config = true

config.color_scheme = 'nightfox'
config.term = 'xterm-256color'
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.use_ime = true
config.color_scheme_dirs = { wezterm.home_dir .. '/.config/wezterm/colors/wezterm.toml' }
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 12
config.font = wezterm.font 'Fira Code'
config.font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true })
config.bold_brightens_ansi_colors = true
config.line_height = 1.2
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }
config.enable_scroll_bar = true
config.min_scroll_bar_height = '2cell'
config.cursor_thickness = '2px'
config.underline_thickness = '2px'

-- window setting
config.window_frame = {
  font = wezterm.font { family = 'Fira Code', weight = 'Bold' },
  font_size = 12.0,
  active_titlebar_bg = 'none',
  inactive_titlebar_bg = 'none'
}

config.colors = {
  scrollbar_thumb = 'gray',
  tab_bar = {
    inactive_tab_edge = '#575757',
  }
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"

  if tab.is_active then
    -- background = "#ae8b2d"
    background = "#1e90ff"
    foreground = "#FFFFFF"
  end

  local title = "  " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "  "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- keybinds
config.disable_default_key_bindings = true
-- keybind
config.keys = keybind.keys
config.key_tables = keybind.key_tables
config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 2000 }

return config
