---
--- Created by glastis.
--- DateTime: 19-Jun-21 22:03
---

local file = require 'libs.lua-must-have-functions.file'
local utilities = require 'libs.lua-must-have-functions.utilities'

local common = {}

local function debug_write(str)
    file.write('debug.txt', str)
end
common.debug_write = debug_write

local function debug_write_dump(str)
    file.write('debug.txt', utilities.var_dump(str))
end
common.debug_write_dump = debug_write_dump

return common


