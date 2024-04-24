local wezterm = require "wezterm"
local module = {}

local ICON = wezterm.nerdfonts.dev_terminal
--local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
--local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local LEFT_CHEVRON = wezterm.nerdfonts.cod_chevron_left
local RIGHT_CHEVRON = wezterm.nerdfonts.cod_chevron_right

local TRANSPARENT = 'rgba(0, 0, 0, 0)'
local WHITE = 'rgb(255, 255, 255)'
local LIGHT_GREY = 'rgb(100, 100, 100)'
local LIGHTER_GREY = 'rgb(150, 150, 150)'

local ROSE = 'rgba(235, 188, 186, 255)'
local PINE = 'rgba(49, 116, 143, 255)'
local IRIS = 'rgba(196, 167, 231, 255)'
local TEXT = 'rgba(224, 222, 244, 255)'

--CLOCK
wezterm.on(
	'update-status',
	function(window, pane)
		local date = wezterm.strftime '%a %b %-d %H:%M '
		window:set_right_status(wezterm.format { { Text = wezterm.nerdfonts.fa_clock_o .. ' ' .. date }, })
		window:set_left_status(wezterm.format { { Text = ICON } })
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
		local title = tab_title(tab)
		if string.len(title) > (max_width - 4) then
			title = wezterm.truncate_right(title, max_width - 6)
			return
			{
				{ Text = ' ' .. LEFT_CHEVRON .. title .. ".." .. RIGHT_CHEVRON .. ' ' }
			}
		else
			title = wezterm.truncate_right(title, max_width - 4)
			return
			{
				{ Text = ' ' .. LEFT_CHEVRON .. title .. RIGHT_CHEVRON .. ' ' }
			}
		end
	end

)

--SETUP CONFIG
function module.apply_to_config(config)

	--CONFIGURE WINDOW
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	config.window_background_opacity = 0.2
	config.text_background_opacity = 1.0
	config.integrated_title_button_style = "Gnome"
	config.integrated_title_button_color = "rgba(255, 255, 255, 255)"
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
	--config.color_scheme = "Afterglow (Gogh)"
	--config.color_scheme = 'Afterglow'
	--config.color_scheme = "AdventureTime"
	--config.color_scheme = 'vimbones'
	--config.color_scheme = 'Violet Dark'
	--config.color_scheme = 'Vs Code Dark+ (Gogh)'
	--config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'

	--TAB BAR SETTINGS
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = false
	config.show_tabs_in_tab_bar = true
	config.show_tab_index_in_tab_bar = false

	config.tab_max_width = 32

	config.colors =
	{
		tab_bar =
		{
			background = TRANSPARENT,
			active_tab =
			{
				bg_color = TRANSPARENT,
				fg_color = WHITE,
				intensity = 'Bold',
				underline = 'None',
				italic = false,
				strikethrough = false,
			},
			inactive_tab =
			{
				bg_color = TRANSPARENT,
				fg_color = LIGHT_GREY,
				intensity = 'Normal',
				underline = 'None',
				italic = false,
				strikethrough = false,
			},
			inactive_tab_hover =
			{
				bg_color = TRANSPARENT,
				fg_color = LIGHTER_GREY,
				intensity = 'Normal',
				underline = 'None',
				italic = true,
				strikethrough = false,
			},
			new_tab =
			{
				bg_color = TRANSPARENT,
				fg_color = LIGHT_GREY,
				intensity = 'Normal',
				underline = 'None',
				italic = false,
				strikethrough = false,
			},
			new_tab_hover =
			{
				bg_color = TRANSPARENT,
				fg_color = LIGHTER_GREY,
				intensity = 'Normal',
				underline = 'None',
				italic = true,
				strikethrough = false,
			},
		},
	}

end

return module

