
local hide = false
local mon = "DP-2"
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@75",
    position = "0x0",
    scale    = "1",
})



local terminal    = "alacritty"
local fileManager = "nautilus"
local menu        = "pgrep wofi > /dev/null 2>&1 && killall wofi || wofi --show drun --insensitive"
local clip	  = "~/.config/hypr/scripts/clip.sh"



hl.env("WLR_RENDERER", "vulkan")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("XCURSOR_SIZE", 12)
hl.env("HYPRCURSOR_SIZE", 12)

hl.on("hyprland.start", function () 
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland & systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP & systemctl --user start hyprland-session.target")
  hl.exec_cmd("waybar & hyprpaper & hyprctl setcursor Win7Bulid-Cursors 12 & dunst & nm-applet & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store")
end)

hl.config({
  ecosystem = {
	  no_update_news = true,
	  no_donation_nag = true,
    enforce_permissions = false,
  },
})

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 0,

        border_size = 2,

        col = {
            active_border   = "rgba(a7c080ee)",
            inactive_border = "rgba(a7c08055)",
        },
        resize_on_border = false,
        allow_tearing = true,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,
        active_opacity   = 1,
        inactive_opacity = 1,

        shadow = {
            enabled      = true,
            range        = 1,
            render_power = 1,
	    sharp = true,
	    offset = {5, 7},
            color        = "rgba(a7c08044)",
	    color_inactive = "rgba(a7c08011)",
        },
--	motion_blur = {
--		enabled = true,
--		samples = 7
--	},
        blur = {
            enabled   = true,
            size      = 1,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
	render_unfocused_fps = 30,
	enable_anr_dialog = false,
	session_lock_xray = true,
    },
    cursor = {
	    no_hardware_cursors = true,
	    zoom_disable_aa = true
    }
})
hl.config({
    input = {
        kb_layout  = "us, ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle,fkeys:basic_13-24,caps:none",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity = 0, 
	numlock_by_default = true,
        touchpad = {
            natural_scroll = false,
        },
    },
    render = {
	    direct_scanout = 0,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(clip))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("cliphist wipe"))
local closeWindowBind = hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + C", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("~/.config/dunst/pause.sh"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/.config/hypr/scripts/emoji.sh"))
hl.bind(mainMod .. " + Control_R", hl.dsp.exec_cmd("~/.config/hypr/scripts/refresh.sh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("swaylock -f -c 000000 --line-color 000000 --inside-color 000000 --ring-color a7c080 --key-hl-color e78a4e"))


hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd('hyprctl eval "hl.config({ cursor = { zoom_factor = 1.0 } })"'))
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd('hyprctl eval "hl.config({ cursor = { zoom_factor = $(hyprctl getoption cursor:zoom_factor | awk \'/float/ {print $2 + 0.5}\') } })"'))

hl.bind("F18", hl.dsp.exec_cmd("~/.config/hypr/scripts/mute.sh"))
hl.bind("F17", hl.dsp.exec_cmd("~/.config/hypr/scripts/obs.sh"))
hl.bind("F16", hl.dsp.exec_cmd("sleep 0.5 && hyprshot --mode output -m DP-2 --output-folder /tmp"))
hl.bind("CTRL" .. " + PRINT", hl.dsp.exec_cmd("hyprshot --mode region --output-folder /tmp --freeze"))
hl.bind("ALT" .. " + PRINT", hl.dsp.exec_cmd("hyprpicker -f hex -a -r"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --mode region --output-folder /tmp"))
hl.bind("SHIFT" .. " + PRINT", hl.dsp.exec_cmd("sleep 0.5 && hyprshot --mode output -m DP-2 --output-folder /tmp"))


-- focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
-- move
hl.bind(mainMod .. " +SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " +SHIFT + right",  hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " +SHIFT + up",  hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " +SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
-- resize
hl.bind(mainMod .. " +CTRL + left",  hl.dsp.window.resize({ x = -100, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " +CTRL + right",  hl.dsp.window.resize({ x = 100, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " +CTRL + up",  hl.dsp.window.resize({ x = 0, y = -100, relative = true}), { repeating = true })
hl.bind(mainMod .. " +CTRL + down",  hl.dsp.window.resize({ x = 0, y = 100, relative = true}), { repeating = true })

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1, action = toggle}))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 0, action = toggle}))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + X",         hl.dsp.workspace.toggle_special("secret"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:secret" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
hl.layer_rule({
    name  = "wofi+waybar blur",
    match = { namespace = "^(waybar|wofi)$" },
    blur = true,
    ignore_alpha = 0.01
    }
)
hl.layer_rule({
    name  = "dunst",
    match = { namespace = "notifications"},
    blur = true,
    ignore_alpha = 0.01,
    no_screen_share = true
    }
)

hl.window_rule({
    name  = "optional noscreenshare",
    match = { class = "vesktop"},
    no_screen_share = hide
    }
)
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
