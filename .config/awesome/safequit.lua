---------------------------------------------------------------------------
-- @author Uli Schlachter
-- @copyright 2010 Uli Schlachter
-- @release @AWESOME_VERSION@
---------------------------------------------------------------------------

local setmetatable = setmetatable
local pairs = pairs
local capi = {
    awesome = awesome,
    client = client,
    timer = timer
}

module("safequit")

local timer = nil

local function quit_on_empty()
    if #capi.client.get() == 0 then
        capi.awesome.quit()
    end
end

-- Kill all clients and quit awesome when they are gone
function quit()
    -- If we are already busy, don't do anything
    if timer ~= nil then
        return
    end

    -- Kill all clients
    for k, c in pairs(capi.client.get()) do
        c:kill()
    end

    -- And start our timer
    local timer = capi.timer({ timeout = 0.1 })
    timer:add_signal("timeout", quit_on_empty)
    timer:start()
end

function abort()
    if timer then
        timer:stop()
    end
    timer = nil
end

--setmetatable(_M, { __call = function(_, ...) return quit(...) end })

-- vim: ft=lua:et:sw=4:ts=4:sts=4:enc=utf-8:tw=78
