-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Set up a Unix domain for remote control
-- config.unix_domains = {
--     {
--         name = "unix",
-- 		skip_permissions_check = true
--     }
-- }

config.exit_behavior = "CloseOnCleanExit"
config.clean_exit_codes = { 0, 130 }
config.window_close_confirmation = "NeverPrompt"

-- Automatically connect to the unix domain on startup
-- config.default_gui_startup_args = { "connect", "unix" }

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = "GruvboxDark"
config.color_scheme = "GruvboxDark"

-- config.font = wezterm.font("MesloLGM Nerd Font Mono")
config.font = wezterm.font("Monaspace Neon")
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
-- config.font = wezterm.font("MesloLGM Nerd Font Mono", { weight = "Bold", italic = true })
config.font_size = 14.0
config.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" }
config.hide_tab_bar_if_only_one_tab = true

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "GruvboxDark"
	else
		return "Gruvbox Light"
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

-- neovim zen-mode setting
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

config.initial_cols = 158
config.initial_rows = 44
-- and finally, return the configuration to wezterm

-- Add undercurl settings
config.underline_position = -2
config.underline_thickness = 1
return config
