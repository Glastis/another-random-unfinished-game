require 'libs.perlin'
local file = require 'libs.lua-must-have-functions.file'
local utilities = require 'libs.lua-must-have-functions.utilities'
local constants = require 'constants'
local map = require 'map'

local tiles = {}

local function load_tiles()
    tiles['deep water'] = love.graphics.newImage('assets/sprites/terrain/deep_water.png')
    tiles['water'] = love.graphics.newImage('assets/sprites/terrain/water.png')
    tiles['shallow water'] = love.graphics.newImage('assets/sprites/terrain/shallow_water.png')
    tiles['shore'] = love.graphics.newImage('assets/sprites/terrain/sand.png')
    tiles['plain'] = love.graphics.newImage('assets/sprites/terrain/grass.png')
    tiles['forest'] = love.graphics.newImage('assets/sprites/terrain/forest.png')
    tiles['mountain'] = love.graphics.newImage('assets/sprites/terrain/mountain.png')
end

function love.load()
    file.write('debug.txt', '', 'w')
    perlin:load(constants.map_default_seed)
    load_tiles()
    map.generate()
    love.window.setMode(constants.window_size_x, constants.window_size_y)
end

function love.update(dt)

end

function draw_terrain()
    local x
    local y

    x = 1
    y = 1
    while map.data[y] do
        love.graphics.draw(
                tiles[map.data[y][x].type],
                (x - 1) * constants.tile_size_x * constants.tile_scale_x,
                (y - 1) * constants.tile_size_y * constants.tile_scale_y,
                0,
                constants.tile_scale_x,
                constants.tile_scale_y
        )
        x = x + 1
        if not map.data[y][x] then
            x = 1
            y = y + 1
        end
    end
end

function love.draw()
    draw_terrain()
end
