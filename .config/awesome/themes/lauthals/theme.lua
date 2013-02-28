---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "sans 7"

theme.main_color    = "#ff9500"
theme.main_weak     = "#ffd577"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#222222"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.main_weak
theme.fg_focus      = theme.main_color
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = theme.main_weak

theme.border_width  = 2
theme.border_normal = "#000000"
theme.border_focus  = theme.main_color
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/underwood/.config/awesome/themes/lauthals/taglist/o_ssquaref.png"
theme.taglist_squares_unsel = "/home/underwood/.config/awesome/themes/lauthals/taglist/o_ssquare.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/underwood/.config/awesome/themes/lauthals/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/underwood/.config/awesome/themes/lauthals/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/underwood/.config/awesome/themes/lauthals/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/underwood/.config/awesome/themes/lauthals/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/underwood/.config/awesome/themes/lauthals/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/underwood/.config/awesome/themes/lauthals/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/underwood/.config/awesome/themes/lauthals/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/underwood/.config/awesome/themes/lauthals/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/underwood/.config/awesome/themes/lauthals/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/underwood/.config/awesome/themes/lauthals/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/underwood/.config/awesome/themes/lauthals/titlebar/maximized_focus_active.png"

theme.wallpaper = "/home/underwood/.config/awesome/themes/lauthals/Hal.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_fairh.png"
theme.layout_fairv = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_fairv.png"
theme.layout_floating  = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_floating.png"
theme.layout_magnifier = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_magnifier.png"
theme.layout_max = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_max.png"
theme.layout_fullscreen = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_fullscreen.png"
theme.layout_tilebottom = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_tilebottom.png"
theme.layout_tileleft   = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_tileleft.png"
theme.layout_tile = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_tile.png"
theme.layout_tiletop = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_tiletop.png"
theme.layout_spiral  = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_spiral.png"
theme.layout_dwindle = "/home/underwood/.config/awesome/themes/lauthals/layouts/o_dwindle.png"

theme.awesome_icon = "/home/underwood/.config/awesome/themes/lauthals/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Own icons
theme.batfull = "/home/underwood/.config/awesome/themes/lauthals/icons/batfull.svg"
theme.calendar = "/home/underwood/.config/awesome/themes/lauthals/icons/calendar.svg"
theme.cpu = "/home/underwood/.config/awesome/themes/lauthals/icons/cpu.svg"
theme.day = "/home/underwood/.config/awesome/themes/lauthals/icons/day.svg"
theme.discharge = "/home/underwood/.config/awesome/themes/lauthals/icons/discharge.svg"
theme.dropbox = "/home/underwood/.config/awesome/themes/lauthals/icons/dropbox.svg"
theme.hd = "/home/underwood/.config/awesome/themes/lauthals/icons/hd.svg"
theme.mail = "/home/underwood/.config/awesome/themes/lauthals/icons/mail.svg"
theme.mailnew = "/home/underwood/.config/awesome/themes/lauthals/icons/mailnew.svg"
theme.mem = "/home/underwood/.config/awesome/themes/lauthals/icons/mem.svg"
theme.music = "/home/underwood/.config/awesome/themes/lauthals/icons/music.svg"
theme.nex = "/home/underwood/.config/awesome/themes/lauthals/icons/next.svg"
theme.night = "/home/underwood/.config/awesome/themes/lauthals/icons/night.svg"
theme.pacman = "/home/underwood/.config/awesome/themes/lauthals/icons/pacman.png"
theme.pause = "/home/underwood/.config/awesome/themes/lauthals/icons/pause.svg"
theme.play = "/home/underwood/.config/awesome/themes/lauthals/icons/play.svg"
theme.prev = "/home/underwood/.config/awesome/themes/lauthals/icons/prev.svg"
theme.recharge = "/home/underwood/.config/awesome/themes/lauthals/icons/recharge.svg"
theme.stop = "/home/underwood/.config/awesome/themes/lauthals/icons/stop.svg"
theme.uname = "/home/underwood/.config/awesome/themes/lauthals/icons/uname.svg"
theme.uptime = "/home/underwood/.config/awesome/themes/lauthals/icons/uptime.svg"
theme.vol = "/home/underwood/.config/awesome/themes/lauthals/icons/vol.svg"
theme.weather = "/home/underwood/.config/awesome/themes/lauthals/icons/weather.svg"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

