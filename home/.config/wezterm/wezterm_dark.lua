-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = "GruvboxDark"
config.color_scheme = "GruvboxDark"

-- config.font = wezterm.font("MesloLGM Nerd Font Mono")
config.font = wezterm.font("Monaspace Argon")
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
-- config.font = wezterm.font("MesloLGM Nerd Font Mono", { weight = "Bold", italic = true })
config.font_size = 14.0
config.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" }

-- and finally, return the configuration to wezterm
return config
