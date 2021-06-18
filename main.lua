require 'libs.perlin'
local file = require 'libs.lua-must-have-functions.file'
local utilities = require 'libs.lua-must-have-functions.utilities'

local wd = 0

function love.load()
    file.write('debug.txt', '', 'w')
    perlin:load()
    love.window.setMode(800, 800)
end

function love.update(dt)

end

function love.draw()
    local color
    for i=1,500 do
        for j=1,500 do
            local x = perlin:noise(i/10, j/10, 0.3)
            if x < - 0.5 then
                color = { 2, 26, 215 }
            elseif x < 0 then
                color = { 2, 86, 215 }
            elseif x < 0.2 then
                color = { 200, 215, 2 }
            elseif x < 0.5 then
                color = { 30, 150, 1 }
            else
                color = { 112, 112, 112 }
            end
            color = { color[1] / 255, color[2] / 255, color[3] / 255 }
            --if wd < 50 then
            --    local write = {}
            --    write['wd'] = wd
            --    write['x'] = x
            --    write['color'] = color
            --    write['unpacked'] = { unpack(color)}
            --    write['i'] = i
            --    write['j'] = j
            --    file.write('debug.txt', utilities.var_dump(write) .. '\n', 'a')
            --    wd = wd + 1
            --end
            love.graphics.setColor(unpack(color))
            love.graphics.rectangle("fill", 5*(i-1), 5*(j-1), 5, 5)
        end
        --error()
    end
    --error(tmp)
end
