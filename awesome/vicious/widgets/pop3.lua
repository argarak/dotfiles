-- pop3.lua
-- POP3 widget for Vicious
-- Author: Boris Bolgradov

local setmetatable = setmetatable
local util = require("awful.util")
local io = { open = io.open }

-- Shows how many new messages you have in a POP3 mail server
module("vicious.widgets.pop3")

local script = "/usr/share/awesome/lib/vicious/widgets/pop3-fetcher.lua"
local tempfile = "/tmp/pop3-fetcher.out"
local cmd = "lua ".. script .. " %s %s %s %s > " .. tempfile

-- Takes a list as argument containing host, port, username and password in that order
-- e.g. {"mail.myhost.com", 110, "John", "132435"}
local function worker(format, warg)
    if not warg or #warg ~= 4 then
        return "login info missing!"
    end

    -- run fetching script
    cmd = cmd:format(warg[1], warg[2], warg[3], warg[4])
    util.spawn_with_shell(cmd)

    -- read from tempfile
    local file = io.open(tempfile)
    if file then
        local msgs = file:read()
        file:close()
        return {msgs}
    else
        return {0}
    end
end

setmetatable(_M, { __call = function(_, ...) return worker(...) end })