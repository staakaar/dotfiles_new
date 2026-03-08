local wezterm = require 'wezterm'
local keybind = require 'keybinds'
local config = wezterm.config_builder()

config.color_scheme = 'nightfox'
config.window_background_opacity = 0.93
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
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333'
}

config.colors = {
  scrollbar_thumb = 'white',
  tab_bar = {
    inactive_tab_edge = '#575757',
  }
}

wezterm.on("gui-startup", function()
  for name, _ in pairs(wezterm.get_builtin_color_schemes()) do
    if name:lower():find("fox") then
      wezterm.log_info("Found: " .. name)
    end
  end
end)

-- keybinds
config.disable_default_key_bindings = true
-- keybind
config.keys = keybind.keys
config.key_tables = keybind.key_tables
config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 2000 }

return config
