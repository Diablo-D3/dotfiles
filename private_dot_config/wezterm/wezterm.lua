-- On Windows, change shortcut target to: "C:\Program Files\WezTerm\wezterm-gui.exe" start --domain WSL:Debian

local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- rootloops.sh
-- Sugar: 7
-- Colors: 6
-- Sogginess: 4
-- Flavor: Classic
-- Fruit: Blackberry
-- Milk: No milk

config.colors = {
  foreground = "#e5dff1",
  background = "#0a0611",
  cursor_bg = "#beb1da",
  cursor_border = "#f2eff8",
  cursor_fg = "#e5dff1",
  selection_bg = "#e5dff1",
  selection_fg = "#0a0611",
  ansi = {
    "#261d35",
    "#d97780",
    "#7aa860",
    "#bc904f",
    "#6b9bd9",
    "#b77ed1",
    "#52a9a9",
    "#beb1da"
  },
  brights = {
    "#584875",
    "#e6949a",
    "#8ebf73",
    "#d3a563",
    "#88b1e5",
    "#c899de",
    "#63c0bf",
    "#f2eff8"
  },
}
config.enable_tab_bar = false

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

config.term = 'wezterm'

config.font = wezterm.font('Iosevka Term', { weight = 'Regular' })

config.font_rules = {
    {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font('Iosevka Term', { weight = 'Medium' })
    },
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font('Iosevka Term', { weight = 'Medium', italic = true })
    },
}

config.font_size = 14.0

config.keys = {
    {
        key = 'F11',
        mods = '',
        action = wezterm.action.ToggleFullScreen
    }
}

config.allow_win32_input_mode = false
config.enable_kitty_keyboard = true

config.default_prog = { 'bash' }

config.initial_cols = 80
config.initial_rows = 25

wezterm.on('window-config-reloaded', function(_, pane)
    local size = pane:get_dimensions()
    local cell_width = math.floor(size.pixel_width / size.cols + 0.5)
    local cell_height = math.floor(size.pixel_height / size.viewport_rows + 0.5)

    local term_width = math.floor(size.cols * cell_width + 0.5)
    local term_height = math.floor(size.viewport_rows * cell_height + 0.5)

    wezterm.log_info('cell size: ' .. cell_width .. 'x' .. cell_height)
    wezterm.log_info('term size: ' .. term_width .. 'x' .. term_height)
    wezterm.log_info('tput size: ' .. size.cols .. 'x' .. size.viewport_rows)
end)

return config
