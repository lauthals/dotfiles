-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
awful.rules = require("awful.rules")
-- Theme handling library
local beautiful = require("beautiful")
-- Widget and layout library
local wibox = require("wibox")
-- Notification library
local naughty = require("naughty")
-- Vicious widgets
local vicious = require("vicious")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/underwood/.config/awesome/themes/lauthals/theme.lua")
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- {{{ My Widgets
-- {{{ Text Seperator
separator_left = wibox.widget.textbox("[")
separator_right = wibox.widget.textbox("]")
space = wibox.widget.textbox(" ")

local bar_height = 7
local bar_width = 60
local bar_bg = "#434343"
local bar_margin_top = 5
local bar_margin_bottom = 5
local bar_fg = "#bbbbbb"
local fg_critical = "#ff0000"
local bg_critical = "#780000"
--local bar_fg = { type = "linear", from = { 0, 0 }, to = { 50, 0 }, stops = { { 0, beautiful.fg_normal }, { 0.5, beautiful.fg_normal }, { 1, beautiful.fg_normal }}}

-- {{{ Volume
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.vol)
volbar  = awful.widget.progressbar()
volbar:set_width(bar_width)
volbar:set_height(bar_height)
volbar:set_vertical(false)
volbar:set_background_color(bar_bg)
volbar:set_color(bar_fg)
vicious.register(volbar, vicious.widgets.volume, "$1", 5, "Master" )
volbar_with_margin = wibox.layout.margin()
volbar_with_margin:set_widget(volbar)
volbar_with_margin:set_top(bar_margin_top)
volbar_with_margin:set_bottom(bar_margin_bottom)

volbar:buttons(awful.util.table.join(
    awful.button({ }, 1, 
        function ()
            awful.util.spawn("pavucontrol")
        end)) )

volicon:buttons(awful.util.table.join(
    awful.button({ }, 1, 
        function ()
            awful.util.spawn("pavucontrol")
        end)) )
-- }}}

-- {{{ Battery
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.batfull)
batwidget = wibox.widget.textbox()
batbar = awful.widget.progressbar()
batbar:set_width(bar_width)
batbar:set_height(bar_height)
batbar:set_vertical(false)
batbar:set_background_color(bar_bg)
batbar:set_color(bar_fg)
vicious.register(batwidget, vicious.widgets.bat, 
    function(widget, args)
        if args[1] == "↯" then
            return ""
        else
            return args[3].."h"
        end
    end, 
60, "BAT1")
vicious.register(batbar, vicious.widgets.bat, 
    function(widget, args)
        if args[1] == "-" then
            baticon:set_image(beautiful.discharge)
            if args[2] < 10 then
                batbar:set_color(fg_critical)
                batbar:set_background_color(bg_critical)
                if args[2] < 5 then
                naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Battery low!",
                     text = "Achtung, der Akku steht nur noch bei "..args[2].."%!",
                     timeout = 60 })
                 end
            end
        elseif args[1] == "+" then
            batbar:set_color(bar_fg)
            batbar:set_background_color(bar_bg)
            baticon:set_image(beautiful.recharge)
        else
            baticon:set_image(beautiful.batfull)
        end
        return args[2]
    end
, 60, "BAT1")
batbar_with_margin = wibox.layout.margin()
batbar_with_margin:set_widget(batbar)
batbar_with_margin:set_top(bar_margin_top)
batbar_with_margin:set_bottom(bar_margin_bottom)
-- }}}

-- {{{ CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.cpu)
cpubar = awful.widget.progressbar()
cputemp = wibox.widget.textbox()
cpubar:set_width(bar_width)
cpubar:set_height(bar_height)
cpubar:set_vertical(false)
cpubar:set_background_color(bar_bg)
cpubar:set_color(bar_fg)
vicious.register(cpubar, vicious.widgets.cpu, 
    function(widget, args)
        if args[1] > 50 then
            cpubar:set_color(fg_critical)
            cpubar:set_background_color(bg_critical)
        else
            cpubar:set_color(bar_fg)
            cpubar:set_background_color(bar_bg)
        end
        return args[1]
    end, 5)
vicious.register(cputemp, vicious.widgets.thermal, "$1°C", 10,"thermal_zone0")
cpubar_with_margin = wibox.layout.margin()
cpubar_with_margin:set_widget(cpubar)
cpubar_with_margin:set_top(bar_margin_top)
cpubar_with_margin:set_bottom(bar_margin_bottom)

cpubar:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -name \"htop\" -e htop", false) end)
))

cpuicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -name \"htop\" -e htop", false) end)
))
-- }}}

-- {{{ Mem
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.mem)
memwidget = wibox.widget.textbox()
membar = awful.widget.progressbar()
membar:set_width(bar_width)
membar:set_height(bar_height)
membar:set_vertical(false)
membar:set_background_color(bar_bg)
membar:set_color(bar_fg)
vicious.register(memwidget, vicious.widgets.mem, "$2/$3MB", 60)
vicious.register(membar, vicious.widgets.mem, 
    function(widget, args)
        if args[1] > 90 then
            membar.set_color(fg_critical)
            membar.set_background_color(bg_critical)
        else
            membar:set_color(bar_fg)
            membar:set_background_color(bar_bg)
        end
        return args[1]
    end, 60)
membar_with_margin = wibox.layout.margin()
membar_with_margin:set_widget(membar)
membar_with_margin:set_top(bar_margin_top)
membar_with_margin:set_bottom(bar_margin_bottom)

membar:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -e htop", false) end)
))

memicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -e htop", false) end)
))
-- }}}

--[[ {{{ Wifi
wifiicon = wibox.widget.imagebox()
wifiicon:set_image(beautiful.mem)
wifibar = awful.widget.progressbar()
wifiwidget = wibox.widget.textbox()
wifitooltip = awful.tooltip({ objects = { wifiicon, wifibar } })
wifibar:set_width(bar_width)
wifibar:set_height(bar_height)
wifibar:set_vertical(false)
wifibar:set_background_color(bar_bg)
wifibar:set_color(bar_fg)
vicious.register(wifiwidget, vicious.widgets.wifi,"${ssid}",60, "wlp3s0")
vicious.register(wifibar, vicious.widgets.wifi,
    function(widget, args)
--        wifitooltip:set_text(args["ssid"])
        return args["linp"]
    end,
60, "wlp3s0")
wifibar_with_margin = wibox.layout.margin()
wifibar_with_margin:set_widget(wifibar)
wifibar_with_margin:set_top(bar_margin_top)
wifibar_with_margin:set_bottom(bar_margin_bottom)

wifibar:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -e netcfg-menu", false) end)
))

wifiicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -e netcfg-menu", false) end)
))
--  }}}--]]

-- {{{ MPD
mpdicon = wibox.widget.imagebox()
mpdicon:set_image(beautiful.music)
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
function (widget, args)
        if args["{state}"] == "Stop" then 
            return "Stopped"
        elseif args["{state}"] == "Pause" then
            return "Paused"
        else 
            return args["{Title}"]..' - '.. args["{Artist}"]
        end
    end, 15)

mpdwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -name \"ncmpcpp\" -e ncmpcpp", false) end)
))

mpdicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvtc -name \"ncmpcpp\" -e ncmpcpp", false) end)
))
-- }}}

-- {{{ Packages
pkgicon = wibox.widget.imagebox()
pkgicon:set_image(beautiful.pacman)
pkgwidget = wibox.widget.textbox()
pkgtooltip = awful.tooltip({ objects = { pkgwidget, pkgicon}})
vicious.register(pkgwidget, vicious.widgets.pkg, 
    function(widget,args)
        local io = { popen = io.popen }
        local s = io.popen("pacman -Qu")
        local str = ''
        for line in s:lines() do
            str = str .. line .. "\n"
        end
        if str ~= '' then
            pkgtooltip:set_text(str)
            pkgtooltip:add_to_object(pkgwidget)
            pkgtooltip:add_to_object(pkgicon)
        else
            pkgtooltip:remove_from_object(pkgwidget)
            pkgtooltip:remove_from_object(pkgicon)
        end
        s:close()
        return " " .. args[1]
    end
, 1800, "Arch")

pkgwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, 
        function () 
            awful.util.spawn("urxvtc -name \"pacman\" -geometry 80x20 -e bash -c \"sudo pacman -Syu && echo '\nAktualisierung abgeschlossen. Beim nächsten Tastendruck schließt das Fenster.' && read\"", false) 
        end)
))

pkgicon:buttons(awful.util.table.join(
    awful.button({ }, 1, 
    function () 
        awful.util.spawn("urxvtc -name \"pacman\" -geometry 80x20 -e bash -c \"sudo pacman -Syu && echo '\nAktualisierung abgeschlossen. Beim nächsten Tastendruck schließt das Fenster.' && read\"", false) 
    end)
))
-- }}}

-- {{{ Mails
mailicon = wibox.widget.imagebox()
mailicon:set_image(beautiful.mail)
mailwidget = wibox.widget.textbox()
vicious.register(mailwidget, vicious.widgets.gmail, 
    function(widget, args)
        if args["{count}"] > 0 then
            mailicon:set_image(beautiful.mailnew)
        else
            mailicon:set_image(beautiful.mail)
        end
        return args["{count}"]
    end
, 900)

mailwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, 
        function () 
            awful.util.spawn("urxvtc -name \"mutt\" -e \"mutt\"", false) 
            local screen = mouse.screen
            awful.tag.viewonly(tags[screen][1])
        end)) )

mailicon:buttons(awful.util.table.join(
    awful.button({ }, 1, 
        function ()
            awful.util.spawn("urxvtc -name \"mutt\" -e \"mutt\"", false) 
            local screen = mouse.screen
            awful.tag.viewonly(tags[screen][1])
        end)) )

-- }}}

-- {{{ Uptime
exitmenu = {
   { "restart", awesome.restart },
   { "quit", awesome.quit },
   { "reboot", "shutdown -r now" },
   { "shutdown", "shutdown -h now" }
}

uptimemenu = awful.menu( { items = exitmenu } )

uptimeicon = wibox.widget.imagebox()
uptimeicon:set_image(beautiful.uptime)
uptimewidget = wibox.widget.textbox()
vicious.register(uptimewidget, vicious.widgets.uptime, "$1d, $2:$3", 60)

uptimeicon:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () uptimemenu:toggle() end )
                   ))

uptimewidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () uptimemenu:toggle() end )
                   ))
-- }}}

-- {{{ Other icons

-- }}}

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Wallpaper                                                                    
if beautiful.wallpaper then                                                         
    for s = 1, screen.count() do                                                    
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)                     
    end                                                                             
end                                                                                 
-- }}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
startlayouts = {layouts[2], layouts[3], layouts[1] , layouts[1] , layouts[1] , layouts[1] , layouts[1] , layouts[1] , layouts[1] , layouts[1]}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "com", "web", "term", "code", 5, 6, 7, 8, 9 }, s, startlayouts)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- }}}

-- Menubar configuration                                                            
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.calendar)
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt() -- ({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wiboxes
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end 
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Fill the bottom wibox
    local bottom_layout = wibox.layout.align.horizontal()
    local bottom_right_layout = wibox.layout.fixed.horizontal()
    local bottom_left_layout = wibox.layout.fixed.horizontal()

    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)

    bottom_left_layout:add(separator_left)
    bottom_left_layout:add(space)
    bottom_left_layout:add(volicon)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(volbar_with_margin)
    bottom_left_layout:add(space)
    bottom_left_layout:add(separator_right)
    
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    
    bottom_left_layout:add(separator_left)
    bottom_left_layout:add(space)
    bottom_left_layout:add(baticon)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(batbar_with_margin)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(batwidget)
    bottom_left_layout:add(space)
    bottom_left_layout:add(separator_right)
    --[[
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    
    bottom_left_layout:add(separator_left)
    bottom_left_layout:add(space)
    bottom_left_layout:add(wifiicon)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(wifibar_with_margin)
    bottom_left_layout:add(space)
    bottom_left_layout:add(wifiwidget)
    bottom_left_layout:add(separator_right)
    --]]
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    
    bottom_left_layout:add(separator_left)
    bottom_left_layout:add(space)
    bottom_left_layout:add(cpuicon)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(cpubar_with_margin)
    bottom_left_layout:add(space)
    bottom_left_layout:add(cputemp)
    bottom_left_layout:add(space)
    bottom_left_layout:add(separator_right)
    
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    
    bottom_left_layout:add(separator_left)
    bottom_left_layout:add(space)
    bottom_left_layout:add(memicon)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(membar_with_margin)
    bottom_left_layout:add(space)
    bottom_left_layout:add(space)
    bottom_left_layout:add(memwidget)
    bottom_left_layout:add(space)
    bottom_left_layout:add(separator_right)

-- ----------------------------------------- --

    bottom_right_layout:add(separator_left)
    bottom_right_layout:add(mpdicon)
    bottom_right_layout:add(mpdwidget)
    bottom_right_layout:add(space)
    bottom_right_layout:add(separator_right)
    
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    
    bottom_right_layout:add(separator_left)
    bottom_right_layout:add(space)
    bottom_right_layout:add(pkgicon)
    bottom_right_layout:add(pkgwidget)
    bottom_right_layout:add(space)
    bottom_right_layout:add(separator_right)
    
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    
    bottom_right_layout:add(separator_left)
    bottom_right_layout:add(space)
    bottom_right_layout:add(mailicon)
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    bottom_right_layout:add(mailwidget)
    bottom_right_layout:add(space)
    bottom_right_layout:add(separator_right)
    
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    
    bottom_right_layout:add(separator_left)
    bottom_right_layout:add(space)
    bottom_right_layout:add(uptimeicon)
    bottom_right_layout:add(space)
    bottom_right_layout:add(uptimewidget)
    bottom_right_layout:add(space)
    bottom_right_layout:add(separator_right)
    
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)
    bottom_right_layout:add(space)

    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_right(bottom_right_layout)

    mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift","Control"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Hide / show wibox
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Sound
    awful.key({            }, "XF86AudioRaiseVolume", 
        function () 
            awful.util.spawn("/usr/bin/vol_up", false)
        end),
    awful.key({            }, "XF86AudioLowerVolume", 
        function () 
            awful.util.spawn("/usr/bin/vol_down", false) 
        end),
    awful.key({            }, "XF86AudioMute", 
        function () 
            awful.util.spawn("/usr/bin/mute_toggle", false) 
        end),
    awful.key({            }, "XF86AudioPrev", 
        function () 
            awful.util.spawn("/usr/bin/mpc prev", false) 
        end),
    awful.key({            }, "XF86AudioNext", 
        function () 
            awful.util.spawn("/usr/bin/mpc next", false) 
        end),
    awful.key({            }, "XF86AudioPlay", 
        function () 
            awful.util.spawn("/usr/bin/mpc toggle", false) 
        end),
    awful.key({            }, "XF86AudioStop", 
        function () 
            awful.util.spawn("/usr/bin/mpc stop", false) 
        end),

    -- Prompt
    awful.key({ modkey },            "x",     function () menubar.show() end),

    awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

awful.key({ modkey            }, "F11",
        function ()
        awful.prompt.run({ prompt = "Calculate: " }, 
            mypromptbox[mouse.screen].widget,
            function (expr)
                local result = awful.util.eval("return (" .. expr .. ")")
                local xmessage = "xmessage -timeout 10 -file -"
                awful.util.spawn_with_shell("echo '" .. expr .. ' = ' .. result .. "' | " .. xmessage, false)
            end)
        end),
   
    awful.key({ modkey }, "d",
              function ()
                  awful.prompt.run({ prompt = "dwb: " },
                  mypromptbox[mouse.screen].widget,
                  function(expr)
                      awful.util.spawn("dwb '".. expr .."'")
                  end)    
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { instance = "htop" },
      properties = { floating = true } },
    { rule = { instance = "mutt" },
      properties = { tag = tags[1][1] } },
    { rule = { instance = "pacman" },
      properties = { floating = true } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "gimp" },
      properties = { tag = tags[1][5] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
