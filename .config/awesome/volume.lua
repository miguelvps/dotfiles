local awful = awful
local client = client
local image = image
local io = io
local string = string
local root = root
local widget = widget

module("volume")

local volume_cl = false
function alsamixer()
    if not volume_cl then
        awful.util.spawn("urxvt -e alsamixer")
    else
        volume_cl:kill()
    end
end

awful.rules.rules = awful.util.table.join( awful.rules.rules, {
    { rule = { name = "alsamixer" },
    properties = { floating = true, above = true, sticky = true, skip_taskbar = true,
    x = 800, y = 19, size_hints = { user_position = true, program_position = true } },
    callback = function (c) volume_cl = c end
},
})
client.add_signal("unmanage", function(c) if c == volume_cl then volume_cl = false end end)


volume_tb = {}
volume_tb.cardid = 0
volume_tb.channel = "Master"
volume_tb.widget = widget({ type = "textbox", name = "volume", align = "right" })
volume_tb.set = function (mode)
    local cmd = nil
    if mode == "toggle" then
        cmd = " sset " .. volume_tb.channel .. " toggle"
    elseif mode == "up" then
        cmd = " sset " .. volume_tb.channel .. " 5%+"
    elseif mode == "down" then
        cmd = " sset " .. volume_tb.channel .. " 5%-"
    else
        cmd = " sget " .. volume_tb.channel
    end

    local fd = io.popen("amixer -c " .. volume_tb.cardid .. cmd)
    local status = fd:read("*all")
    fd:close()
    local volume = string.match(status, "(%d?%d?%d)%%")
    volume = string.format("% 3d", volume)
    status = string.match(status, "%[(o[^%]]*)%]")
    if string.find(status, "on", 1, true) then
        volume = volume .. "%"
    else
        volume = volume .. "M"
    end
    volume_tb.widget.text = volume
end

volume_tb.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, alsamixer),
    awful.button({ }, 3, function () volume_tb.set("toggle") end),
    awful.button({ }, 4, function () volume_tb.set("up") end),
    awful.button({ }, 5, function () volume_tb.set("down") end)
))
volume_tb.set()



--volume_bt = awful.widget.button({ image = image("/home/miguel/.config/awesome/volume.png") })
--volume_bt:buttons(awful.util.table.join( awful.button({ }, 1, alsamixer) ))

root.keys(awful.util.table.join( root.keys(),
    awful.key({"Mod4"}, "v",                    alsamixer),
    awful.key({      }, "XF86AudioRaiseVolume", function () volume_tb.set("up") end),
    awful.key({      }, "XF86AudioLowerVolume", function () volume_tb.set("down") end),
    awful.key({      }, "XF86AudioMute",        function () volume_tb.set("toggle") end)
))
