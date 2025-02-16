-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.84
config.macos_window_background_blur = 10

-- my coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
	tab_bar = {
    background = "#011423"
  },
}

-- Tab bar styles
local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local background = config.colors.background  -- Your background color
    local foreground = config.colors.foreground  -- Your foreground color
    local inactive_foreground = "#607489"         -- Dimmed foreground for inactive tabs

    -- You might want distinct hover colors too
    local hover_background = "#022846" -- Example hover background
    local hover_foreground = "#CBE0F0" -- Example hover foreground

    -- local edge_background = background -- Use background for edge
    -- local edge_foreground = tab.is_active and foreground or (hover and hover_foreground or inactive_foreground)

    if tab.is_active then
        background = "#214969"
    end
    if hover then
        background = hover_background
        foreground = hover_foreground
    end

    local title = tab_title(tab)
    title = wezterm.truncate_right(title, max_width - 2)  -- Truncate if needed

    return {
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = " " }, -- Left padding
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = " " }, -- Right padding
    }
end)

config.tab_bar_style = {
    -- ... other tab bar style settings ...
    new_tab = wezterm.format {  -- Style for the "+" button
        { Background = { Color = "#022846" } }, -- Your tab bar background color
        { Foreground = { Color = "#CBE0F0" } }, -- Your foreground color (or a suitable contrast)
        { Text = " + " },  -- The "+" character
    },
    new_tab_hover = wezterm.format { -- Style for the "+" button on hover
        { Background = { Color = "#033259" } }, -- Example hover color
        { Foreground = { Color = "#CBE0F0" } }, -- Your foreground color (or a suitable contrast)
        { Text = " + " },  -- The "+" character
    },
}


-- and finally, return the configuration to wezterm
return config
