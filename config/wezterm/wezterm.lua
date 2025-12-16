-- WezTerm Keybindings Documentation by dragonlobster
-- ===================================================
-- Leader Key:
-- The leader key is set to ALT + q, with a timeout of 2000 milliseconds (2 seconds).
-- To execute any keybinding, press the leader key (ALT + q) first, then the corresponding key.

-- Keybindings:
-- 1. Tab Management:
--    - LEADER + c: Create a new tab in the current pane's domain.
--    - LEADER + x: Close the current pane (with confirmation).
--    - LEADER + b: Switch to the previous tab.
--    - LEADER + n: Switch to the next tab.
--    - LEADER + <number>: Switch to a specific tab (0–9).

-- 2. Pane Splitting:
--    - LEADER + |: Split the current pane horizontally into two panes.
--    - LEADER + -: Split the current pane vertically into two panes.
-- 3. Pane Navigation:
--    - LEADER + h: Move to the pane on the left.
--    - LEADER + j: Move to the pane below.
--    - LEADER + k: Move to the pane above.
--    - LEADER + l: Move to the pane on the right.

-- 4. Pane Resizing:
--    - LEADER + LeftArrow: Increase the pane size to the left by 5 units.
--    - LEADER + RightArrow: Increase the pane size to the right by 5 units.
--    - LEADER + DownArrow: Increase the pane size downward by 5 units.
--    - LEADER + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying an ocean wave emoji (🌊).

-- Miscellaneous Configurations:
-- - Tabs are shown even if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.
-- - Tab and split indices are zero-based.

-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
-- local sessions = wezterm.plugin.require("wezterm-sessions")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- max fps
config.max_fps = 60
config.animation_fps = 60

-- Shell
config.default_prog = { "/usr/bin/fish" }

--[[
============================
Font
============================
]]
--

-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })

config.font_size = 11

--[[
============================
Colors
============================
]]
--

config.color_scheme = "farmhouse-dark"
config.colors = {
	background = "#000000",
	cursor_bg = "#C0CAF5",
	cursor_fg = "#000000",
	cursor_border = "#C0CAF5",
}

-- color_scheme not sufficient in providing available colors
-- local colors = wezterm.color.get_builtin_schemes()[color_scheme]

-- color scheme colors for easy access
config.window_background_opacity = 0.5
config.window_decorations = "NONE"
local scheme_colors = {
	tokyo_night = {
		night = {
			bg = "#1a1b26",
			fg = "#a9b1d6",
			red = "#f7768e",
			green = "#9ece6a",
			yellow = "#e0af68",
			blue = "#7aa2f7",
			magenta = "#bb9af7",
			cyan = "#7dcfff",
			white = "#a9b1d6",
			black = "#32344a",
		},
	},
}

-- local tab_colors = {
-- 	tab_bar_active_tab_fg = scheme_colors.tokyo_night.night.blue,
-- 	tab_bar_active_tab_bg = scheme_colors.tokyo_night.night.bg,
-- 	tab_bar_inactive_tab_fg = scheme_colors.tokyo_night.night.bg,
-- 	tab_bar_inactive_tab_bg = scheme_colors.tokyo_night.night.fg,
-- 	tab_bar_text = scheme_colors.tokyo_night.night.bg,
-- 	arrow_foreground_leader = scheme_colors.tokyo_night.night.blue,
-- 	arrow_background_leader = scheme_colors.tokyo_night.night.bg,
-- }
--
config.colors.tab_bar = {
	background = "#181825",
}

--[[
============================
Shortcuts
============================
]]
--

local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim" or process_name == "yazi"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- shortcut_configuration
config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "w",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		mods = "LEADER",
		key = "a",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "q",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER|ALT",
		key = "q",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.ActivateCopyMode,
	},
	-- Sessions
	{
		key = "s",
		mods = "LEADER|ALT",
		action = act.EmitEvent("save_session"),
	},
	{
		key = "o",
		mods = "LEADER",
		action = act.EmitEvent("load_session"),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.EmitEvent("restore_session"),
	},
	{
		key = "d",
		mods = "LEADER",
		action = act.EmitEvent("delete_session"),
	},
	{
		key = "e",
		mods = "LEADER",
		action = act.EmitEvent("edit_session"),
	},

	-- Rename current workspace
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new workspace name",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "n",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
}

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end
table.insert(config.keys, {
	key = "0",
	mods = "LEADER",
	action = wezterm.action.ActivateTab(9),
})

--[[
============================
Tab Bar
============================
]]
--

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- resurrect.config.save_workspace_on_exit = "always"
-- resurrect.config.restore_on_start = "always"

-- local function tab_title(tab_info)
-- 	local title = tab_info.tab_title
-- 	-- if the tab title is explicitly set, take that
-- 	if title and #title > 0 then
-- 		return title
-- 	end
-- 	-- Otherwise, use the title from the active pane
-- 	-- in that tab
-- 	return tab_info.active_pane.title
-- end
--
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local tab_index = tab.tab_index + 1
-- 	if tab.tab_index == 10 then
-- 		tab_index = 0
-- 	end
-- 	local title = " " .. tab_index .. ": " .. tab_title(tab) .. " "
-- 	local left_edge_text = ""
-- 	local right_edge_text = ""
--
-- 	if tab_style == "rounded" then
-- 		title = " " .. tab_index .. ": " .. tab_title(tab) .. " "
-- 		title = wezterm.truncate_right(title, max_width - 2)
-- 		left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
-- 		right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
-- 	end
--
-- 	-- ensure that the titles fit in the available space,
-- 	-- and that we have room for the edges.
-- 	-- title = wezterm.truncate_right(title, max_width - 2)
--
-- 	if tab.is_active then
-- 		return {
-- 			{ Background = { Color = tab_colors.tab_bar_active_tab_bg } },
-- 			{ Foreground = { Color = tab_colors.tab_bar_active_tab_fg } },
-- 			{ Text = left_edge_text },
-- 			{ Background = { Color = tab_colors.tab_bar_active_tab_fg } },
-- 			{ Foreground = { Color = tab_colors.tab_bar_text } },
-- 			{ Text = title },
-- 			{ Background = { Color = tab_colors.tab_bar_active_tab_bg } },
-- 			{ Foreground = { Color = tab_colors.tab_bar_active_tab_fg } },
-- 			{ Text = right_edge_text },
-- 			{ Background = { Color = tab_colors.tab_bar_active_tab_bg } },
-- 			{ Text = " " },
-- 		}
-- 	else
-- 		return {
-- 			{ Background = { Color = tab_colors.tab_bar_inactive_tab_bg } },
-- 			{ Foreground = { Color = tab_colors.tab_bar_inactive_tab_fg } },
-- 			{ Text = left_edge_text },
-- 			{ Background = { Color = tab_colors.tab_bar_inactive_tab_fg } },
-- 			{ Foreground = { Color = tab_colors.tab_bar_inactive_tab_bg } },
-- 			{ Text = title },
-- 			{ Background = { Color = tab_colors.tab_bar_inactive_tab_bg } },
-- 			{ Foreground = { Color = tab_colors.tab_bar_inactive_tab_fg } },
-- 			{ Text = right_edge_text },
-- 			{ Background = { Color = tab_colors.tab_bar_inactive_tab_bg } },
-- 			{ Text = " " },
-- 		}
-- 	end
-- end)
--
-- --[[
-- ============================
-- Leader Active Indicator
-- ============================
-- ]]
-- --
--
-- wezterm.on("update-status", function(window, _)
-- 	-- leader inactive
-- 	local solid_left_arrow = ""
-- 	local arrow_foreground = { Foreground = { Color = tab_colors.arrow_foreground_leader } }
-- 	local arrow_background = { Background = { Color = tab_colors.arrow_background_leader } }
-- 	local prefix = ""
--
-- 	-- leaader is active
-- 	if window:leader_is_active() then
-- 		prefix = " " .. leader_prefix
--
-- 		if tab_style == "rounded" then
-- 			solid_left_arrow = wezterm.nerdfonts.ple_right_half_circle_thick
-- 		else
-- 			solid_left_arrow = wezterm.nerdfonts.pl_left_hard_divider
-- 		end
--
-- 		local tabs = window:mux_window():tabs_with_info()
--
-- 		if tab_style ~= "rounded" then
-- 			for _, tab_info in ipairs(tabs) do
-- 				if tab_info.is_active and tab_info.index == 0 then
-- 					arrow_background = { Foreground = { Color = tab_colors.tab_bar_active_tab_fg } }
-- 					solid_left_arrow = wezterm.nerdfonts.pl_right_hard_divider
-- 					break
-- 				end
-- 			end
-- 		end
-- 	end
--
-- 	window:set_left_status(wezterm.format({
-- 		{ Background = { Color = tab_colors.arrow_foreground_leader } },
-- 		{ Text = prefix },
-- 		arrow_foreground,
-- 		arrow_background,
-- 		{ Text = solid_left_arrow },
-- 	}))
-- end)
config.tab_max_width = 32
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

tabline.setup({
	options = {
		icons_enabled = true,
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
	extensions = {},
})
config.show_new_tab_button_in_tab_bar = false
-- and finally, return the configuration to wezterm
return config
