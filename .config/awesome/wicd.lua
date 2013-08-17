local awful = awful
local client = client
local image = image
local root = root

module("wicd")

local wicd_cl = false
function wicd()
    if not wicd_cl then
        awful.util.spawn("urxvt -e wicd-curses")
    else
        wicd_cl:kill()
    end
end

awful.rules.rules = awful.util.table.join( awful.rules.rules, {
    { rule = { name = "wicd-curses" },
    properties = { floating = true, above = true, sticky = true, skip_taskbar = true, x = 747, y = 19, height = 200, width = 620 },
    callback = function (c) wicd_cl = c end
},
})
client.add_signal("unmanage", function(c) if c == wicd_cl then wicd_cl = false end end)


wicd_bt = awful.widget.button({ image = image("/home/miguel/.config/awesome/wicd.png") })
awful.widget.layout.margins[wicd_bt] = { left = 10, right = 150 }
wicd_bt:buttons(awful.util.table.join( awful.button({ }, 1, wicd) ))


root.keys(awful.util.table.join( root.keys(),
    awful.key({"Mod4"}, "n", wicd)
))
