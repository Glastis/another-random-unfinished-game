---
--- Created by glastis.
--- DateTime: 17-Jun-21 2:54
---

local constants = require 'constants'
local map = {}

local function get()
    return map.data
end
map.get = get

local function generate_tile(x, y)
    local tile

    tile = {}
    tile.height = perlin:noise(x/15, y/15, 0.2)

    --[[
    ---- TODO
    ---- Dirty defined tile type, since idk if I will add a biome system, or leave the height controls the climate.
    --]]
    if tile.height < - 0.4 then
        tile.type = 'deep water'
    elseif tile.height < - 0.07 then
        tile.type = 'water'
    elseif tile.height < 0 then
        tile.type = 'shallow water'
    elseif tile.height < 0.2 then
        tile.type = 'shore'
    elseif tile.height < 0.35 then
        tile.type = 'plain'
    elseif tile.height < 0.5 then
        tile.type = 'forest'
    else
        tile.type = 'mountain'
    end

    --[[
    ---- TODO
    ---- tile.features
    ---- tile.ressources
    ---- ...
    ---- others features that will not be added
    ]]--
    return tile
end

local function generate()
    local x
    local y
    local data

    x = 1
    y = 1
    data = {}
    data[y] = {}
    while y <= constants.map_size_y do
        data[y][x] = generate_tile(x, y)
        x = x + 1
        if x > constants.map_size_x then
            y = y + 1
            if y <= constants.map_size_y then
                data[y] = {}
                x = 1
            end
        end
    end
    map.data = data
    return map.data
end
map.generate = generate

return map