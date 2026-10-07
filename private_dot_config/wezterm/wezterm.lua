-- On Windows, change shortcut target to: "C:\Program Files\WezTerm\wezterm-gui.exe" start --domain WSL:Debian

local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- Root Loops color scheme
-- via https://rootloops.sh?sugar=8&colors=7&sogginess=0&flavor=2&fruit=10&milk=0
config.colors = {
    foreground = "#f3f3f3",
    background = "#060606",
    cursor_bg = "#ababab",
    cursor_border = "#e2e2e2",
    cursor_fg = "#060606",
    selection_bg = "#f3f3f3",
    selection_fg = "#060606",
    ansi = {
        "#222222",
        "#ec9384",
        "#6cc581",
        "#cbab4f",
        "#96abed",
        "#dd8ed6",
        "#54c0d1",
        "#ababab"
    },
    brights = {
        "#525252",
        "#f2b2a6",
        "#80dc95",
        "#e1c166",
        "#b2c3f2",
        "#e7aee1",
        "#70d5e7",
        "#e2e2e2"
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

config.font = wezterm.font('IoskeleyMonoTerm Nerd Font Mono', { weight = 'Regular' })

config.font_rules = {
    {
        intensity = 'Normal',
        italic = true,
        font = wezterm.font('IoskeleyMonoTerm Nerd Font Mono', { weight = 'Regular', italic = true })
    },
    {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font('IoskeleyMonoTerm Nerd Font Mono', { weight = 'Bold' })
    },
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font('IoskeleyMonoTerm Nerd Font Mono', { weight = 'Bold', italic = true })
    },
}

config.font_size = 12      -- 17x41
config.cell_width = 0.941  -- 16/17
config.line_height = 0.976 -- 41/40


--config.freetype_load_target = "Light"
--config.freetype_render_target = "HorizontalLcd"

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
