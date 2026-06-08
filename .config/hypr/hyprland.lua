-------------
-- Configs --
-------------

hl.config({
	general = {
		resize_on_border = true,
	},
	animations = {
		enabled = false,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
        disable_splash_rendering = true,
	},
})

----------------------
-- Display settings --
----------------------

hl.monitor({
	output = "DP-3",
	mode = "1920x1080@144",
	position = "1080x440",
	scale = 1,
})

hl.monitor({
	output = "HDMI-A-3",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
	transform = 1,
})

------------------
-- Applications --
------------------

local terminal = "ghostty"
local menu = "hyprlauncher"
local fileManager = "dolphin"
local browser = "zen-browser"

----------------------
-- Keybind settings --
----------------------

local mainMod = "SUPER"

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind(mainMod .. "+ L", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. "+ Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+ C", hl.dsp.window.close())
hl.bind(mainMod .. "+ V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+ M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. "+ E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. "+ W", hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------
-- Workspace settings --
------------------------

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. "+ " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. "+ SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Autostart

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("spotify-launcher", { workspace = 1 })
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)
