local wezterm = require("wezterm")
local config = {}
local launch_menu = {}
local act = wezterm.action

config.default_prog = { "powershell.exe", "-NoLogo" }

table.insert(launch_menu, {
	label = "PowerShell",
	args = { "powershell.exe", "-NoLogo" },
})
table.insert(launch_menu, {
	label = "Pwsh",
	args = { "pwsh.exe", "-NoLogo" },
})

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Catppuccin Mocha"
config.window_padding = {
	bottom = 0,
}
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1.0
config.win32_system_backdrop = "Acrylic"
config.integrated_title_buttons = {}
config.window_decorations = "RESIZE"
-- Tab settings
config.use_fancy_tab_bar = false
config.tab_max_width = 12
config.tab_bar_at_bottom = true

-- Tab style
--[[
config.colors = {
	tab_bar = {
		background = "#282828",
	},
}
]]
--

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	title = wezterm.truncate_right(title, max_width - 2)
	return {
		{ Text = " " .. title .. " " },
	}
end)

config.launch_menu = launch_menu

config.keys = {
	-- Create a new tab in the same domain as the current pane.
	-- This is usually what you want.
	{
		key = "t",
		mods = "SHIFT|ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
}

return config
