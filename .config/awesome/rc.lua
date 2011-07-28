-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("revelation")

require("safequit")

require("volume")
require("wicd")
require("transmission")


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init(".config/awesome/themes/theme/theme.lua")

naughty.config.default_preset.icon_size = 40
naughty.config.default_preset.bg = beautiful.border_focus
naughty.config.default_preset.fg = "#FFFFFF"

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vi"
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
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags[1] = awful.tag({ "www", "im", "vim", "term", 5, 6, 7, 8, 9 }, 1, awful.layout.suit.tile)


for s = 2, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, awful.layout.suit.tile)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", safequit.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })


mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 2, function(c)
                                              awful.client.floating.toggle(c)
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 }, { keygrabber=true })
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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.focused(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        volume.volume_tb.widget,
        wicd.wicd_bt,
        transmission.transmission_bt,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle({keygrabber=true}) end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join( root.keys(),
    -- Misc
    awful.key({ modkey,           }, "e",      function () mymainmenu:toggle({keygrabber=true}) end),
    awful.key({ modkey,           }, "w",      revelation.revelation),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      safequit.quit),
    awful.key({ modkey, "Control" }, "q",      awesome.quit),
    awful.key({ modkey            }, "r",      function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey            }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Tags
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "\\",     awful.tag.history.restore),


    -- Clients
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            local c = client.focus
            awful.client.focus.bydirection("down")
            if client.focus == c then awful.client.focus.byidx(-1) end
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            local c = client.focus
            awful.client.focus.bydirection("up")
            if client.focus == c then awful.client.focus.byidx(1) end
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "h",
        function ()
            local c = client.focus
            awful.client.focus.bydirection("left")
            if client.focus == c then awful.client.focus.byidx(-1) end
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "l",
        function ()
            local c = client.focus
            awful.client.focus.bydirection("right")
            if client.focus == c then awful.client.focus.byidx(1) end
            if client.focus then client.focus:raise() end
        end),

    -- Toggle screen
    awful.key({ modkey,           }, "s", function () awful.screen.focus_relative(1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.bydirection("down") end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.bydirection("up") end),
    awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.bydirection("left") end),
    awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.bydirection("right") end),

    awful.key({ modkey,           }, "<",     function () awful.tag.incmwfact(-0.006)    end),
    awful.key({ modkey, "Shift"   }, "<",     function () awful.tag.incmwfact( 0.006)    end),
    -- TODO: resize slave client
    --awful.key({ modkey, "Shift" }, "l", function () awful.client.incwfact(-0.05) end),
    --awful.key({ modkey, "Shift" }, "h", function () awful.client.incwfact( 0.05) end),
    awful.key({ modkey, "Control" }, "k",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Control" }, "j",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol(-1)         end),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end)
)

-- Menu keys
awful.menu.menu_keys.up = { "Up", "k" }
awful.menu.menu_keys.down = { "Down", "j" }
awful.menu.menu_keys.exec = { "Enter", "Right", "l" }
awful.menu.menu_keys.close = { "Escape", "Left", "h", "q" }

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "d",      function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift"   }, "f",      awful.client.floating.toggle                     ),
    awful.key({ modkey, "Shift"   }, "s",      awful.client.movetoscreen                        ),
    --awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    --awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)

    --awful.key({ modkey }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    --awful.key({ modkey }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
    --awful.key({ modkey }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    --awful.key({ modkey }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    --awful.key({ modkey }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    --awful.key({ modkey }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
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
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Mod1" }, "#" .. i + 9,
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
    -- TODO: how does this work ?
    --awful.button({ modkey, "Shift" }, 1, awful.mouse.client.dragtotag.widget))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = awful.util.table.join( awful.rules.rules, {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     size_hints_honor = false,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    --{ rule = { class = "feh" },
      --properties = { floating = true } },
    --{ rule = { class = "pinentry" },
      --properties = { floating = true } },
    --{ rule = { class = "gimp" },
      --properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
})
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    --awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position and not c.above then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


function staticapp(name, typ, tag)
    client.add_signal("manage", function(client, startup)
        if startup then
            return
        end
        if client[typ] == name then
            pin = true
            for _, c in ipairs(tag:clients()) do
                if c[typ] == name and c ~= client then
                    pin = false
                    break
                end
            end
            if pin then
                client:tags({tag})
            end
        end
    end)
end

staticapp("chromium", "instance", tags[1][1])
staticapp("URxvt", "class", tags[1][4])
staticapp("weechat", "name", tags[1][2])
staticapp("Gvim", "class", tags[1][3])
-- }}}

--client.add_signal("manage", function (c, startup)
    --naughty.notify({ text = "manage", timeout = 0 })
    --naughty.notify({ text = c.name, timeout = 0 })
    --naughty.notify({ text = c.class, timeout = 0 })
    --naughty.notify({ text = c.instance, timeout = 0 })
    --naughty.notify({ text = c.role, timeout = 0 })
--end)

revelation.revelation()
