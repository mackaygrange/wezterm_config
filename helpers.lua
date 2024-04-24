local wezterm = require "wezterm"
local module = {}

local ICON = wezterm.nerdfonts.dev_terminal
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local LEFT_CHEVRON = wezterm.nerdfonts.cod_chevron_left
local RIGHT_CHEVRON = wezterm.nerdfonts.cod_chevron_right

local MINIMIZE = wezterm.nerdfonts.cod_chrome_minimize
local MAXIMIZE = wezterm.nerdfonts.cod_chrome_maximize
local EXIT = wezterm.nerdfonts.cod_chrome_close

local TRANSPARENT = 'rgba(0, 0, 0, 0)'
local WHITE = 'rgb(255, 255, 255)'

local ROSE = 'rgba(235, 188, 186, 255)'
local PINE = 'rgba(49, 116, 143, 255)'
local IRIS = 'rgba(196, 167, 231, 255)'
local LOVE = 'rgba(235, 111, 146, 255)'

local BASE =  'rgba(25, 23, 36, 255)'
local OVERLAY = 'rgba(38, 35, 58, 255)'
local TEXT = 'rgba(224, 222, 244, 255)'
local HIGHLIGHT_HIGH = 'rgba(82, 79, 103, 255)'
local HIGHLIGHT_MED = 'rgba(64, 61, 82, 255)'
local HIGHLIGHT_LOW = 'rgba(33, 32, 46, 255)'


--CLOCK
wezterm.on(
	'update-status',
	function(window, pane)
		local date = wezterm.strftime '%a %b %-d %H:%M   '
		window:set_right_status(wezterm.format { { Text = wezterm.nerdfonts.fa_clock_o .. ' ' .. date }, { Foreground = { Color = TEXT } }, })
		window:set_left_status(wezterm.format { { Text = " " .. ICON .. " " }, { Foreground = { Color = TEXT } }, })
	end
)

--SET TAB TITLE
local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
    		return title
  	end
  	return tab_info.active_pane.title
end

--FORMAT TABS
wezterm.on(
'format-tab-title',
function(tab, tabs, panes, config, hover, max_width)
    local edge_background = BASE
    local background = HIGHLIGHT_LOW
    local foreground = TEXT

    if tab.is_active then
        background = HIGHLIGHT_HIGH
    elseif hover then
        background = HIGHLIGHT_MED
    end

    local edge_foreground = background

    local title = tab_title(tab)

    if string.len(title) > (max_width - 2) then
        title = wezterm.truncate_right(title, max_width - 4)
        return
        {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title .. ".."},
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    else
        title = wezterm.truncate_right(title, max_width - 2)
        return
        {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end
end
)

--SETUP CONFIG
function module.apply_to_config(config)

	--CONFIGURE WINDOW
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	config.window_background_opacity = 0.2
    --config.win32_system_backdrop = 'Acrylic'
    --config.win32_acrylic_accent_color = BASE
	config.text_background_opacity = 1.0
	config.integrated_title_button_style = "Windows"
	config.integrated_title_button_color = OVERLAY
	config.window_padding =
	{
  		left = '2cell',
  		right = '2cell',
  		top = '1cell',
  		bottom = '1cell',
	}

	--SET FONT
	config.font_dirs = { 'fonts' }
	config.font_locator = 'ConfigDirsOnly'
	config.font = wezterm.font('CaskaydiaCove Nerd Font Mono', {weight = 'Regular'})

	--SET COLOR SCHEME
    config.color_scheme = "rose-pine"

	--TAB BAR SETTINGS
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = false
	config.show_tabs_in_tab_bar = true
	config.show_tab_index_in_tab_bar = false
	config.tab_max_width = 24

    --TAB BAR STYLE
	config.colors =
	{
		tab_bar =
		{
			background = BASE,
			active_tab =
			{
				bg_color = HIGHLIGHT_HIGH,
				fg_color = TEXT,
				intensity = 'Bold',
				underline = 'None',
				italic = false,
				strikethrough = false,
			},
			inactive_tab =
			{
				bg_color = HIGHLIGHT_LOW,
				fg_color = TEXT,
				intensity = 'Normal',
				underline = 'None',
				italic = false,
				strikethrough = false,
			},
			inactive_tab_hover =
			{
				bg_color = HIGHLIGHT_MED,
				fg_color = TEXT,
				intensity = 'Normal',
				underline = 'None',
				italic = true,
				strikethrough = false,
			},
			new_tab =
			{
				bg_color = HIGHLIGHT_LOW,
				fg_color = TEXT,
				intensity = 'Normal',
				underline = 'None',
				italic = false,
				strikethrough = false,
			},
			new_tab_hover =
			{
				bg_color = HIGHLIGHT_MED,
				fg_color = TEXT,
				intensity = 'Normal',
				underline = 'None',
				italic = true,
				strikethrough = false,
			},
		},
	}
    
    --INTEGRATED WINDOW BUTTONS STYLE
    config.tab_bar_style =
    {
        window_hide = wezterm.format
        {
            { Background = { Color = HIGHLIGHT_LOW } },
            { Foreground = { Color = TEXT } },
            { Text = " " .. MINIMIZE .. " " },
        },
        window_hide_hover = wezterm.format
        {
            { Background = { Color = HIGHLIGHT_MED } },
            { Foreground = { Color = TEXT } },
            { Text = " " .. MINIMIZE .. " " },
        },
        window_maximize = wezterm.format
        {
            { Background = { Color = HIGHLIGHT_LOW } },
            { Foreground = { Color = TEXT } },
            { Text = " " .. MAXIMIZE .. " " },
        },
        window_maximize_hover = wezterm.format
        {
            { Background = { Color = HIGHLIGHT_MED } },
            { Foreground = { Color = TEXT } },
            { Text = " " .. MAXIMIZE .. " " },
        },
        window_close = wezterm.format
        {
            { Background = { Color = HIGHLIGHT_LOW } },
            { Foreground = { Color = TEXT } },
            { Text = " " .. EXIT .. " " },
        },
        window_close_hover = wezterm.format
        {
            { Background = { Color = LOVE } },
            { Foreground = { Color = TEXT } },
            { Text = " " .. EXIT .. " " },
        },
    }

end

return module

