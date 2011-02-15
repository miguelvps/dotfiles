local awful = awful
local client = client
local image = image
local root = root

local io = io

--class: Chromium
--name: Untitled
--real name: Transmission Web Interface

module("transmission")


local transmission_cl = false
function transmission()
    if not transmission_cl then
        awful.util.spawn("urxvt -e transmission-remote-cli")
    else
        transmission_cl:kill()
    end
end

awful.rules.rules = awful.util.table.join( awful.rules.rules, {
    { rule = { name = "transmission-remote-cli" },
        properties = { floating = true, above = true, sticky = true, skip_taskbar = true, width = 450, height = 250, x = 919, y = 19},
        callback = function (c) transmission_cl = c end
    },
})
client.add_signal("unmanage", function (c) if c == transmission_cl then transmission_cl = false end end)


local transmission_app_cl = false
function transmission_app()
    if not transmission_app_cl then
        awful.util.spawn("chromium --app=http://127.0.0.1:9091")
    else
        transmission_app_cl:kill()
    end
end

awful.rules.rules = awful.util.table.join( awful.rules.rules, {
    { rule = { class = "Chromium", name = "Untitled" },
        properties = { floating = true },
        callback = function (c) c:add_signal("property::name", function()
                if c.name == "Transmission Web Interface" then
                    transmission_app_cl = c
                    awful.client.floating.set(c, true)
                    c.above = true
                    c.sticky = true
                    c.skip_taskbar = true
                    c:geometry({ x=346, y=19, width=1020, height=400 })
                    client.focus = c
                end
            end)
        end
    }
})
client.add_signal("unmanage", function (c) if c == transmission_app_cl then transmission_app_cl = false end end)


transmission_bt = awful.widget.button({ image = image("/home/miguel/.config/awesome/transmission.png") })
transmission_bt:buttons(awful.util.table.join(
    awful.button({ }, 1, transmission),
    awful.button({ }, 3, transmission_app)
))

root.keys(awful.util.table.join( root.keys(),
    awful.key({"Mod4"}, "b", transmission)
))
