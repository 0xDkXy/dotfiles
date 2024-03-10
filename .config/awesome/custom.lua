local awful = require('awful')
local gears = require("gears")

gears.debug.print_warning("Entry custom.lua")
awful.spawn("picom -b")

