---
--- Created by glastis.
--- DateTime: 17-Jun-21 3:10
---

local file = require 'libs.lua-must-have-functions.file'
local common = require 'common'

perlin = {}
perlin.p = {}

local function string_sum(str)
    local sum
    local t
    local i

    sum = 0
    t = {}
    i = 1
    str:gsub(".",function(c) table.insert(t,c) end)
    while t[i] do
        sum = sum + string.byte(t[i], 1)
        i = i + 1
    end
    return sum
end

perlin.size = 256
perlin.gx = {}
perlin.gy = {}
perlin.randMax = 256

function perlin:load(seed)
    local i

    i = 1
    if type(seed) == 'string' then
        seed = string_sum(seed)
        common.debug_write_dump(seed)
    end
    math.randomseed(seed)
    perlin.permutation = {}
    while i <= perlin.size do
        perlin.permutation[i] = math.random(1, 255)
        self.p[i] = perlin.permutation[i]
        self.p[256 + i] = perlin.p[i]
        i = i + 1
    end
end

function perlin:noise(x, y, z)
    local X = math.floor(x) % 256
    local Y = math.floor(y) % 256
    local Z = math.floor(z) % 256
    x = x - math.floor(x)
    y = y - math.floor(y)
    z = z - math.floor(z)
    local u = fade(x)
    local v = fade(y)
    local w = fade(z)
    local A  = self.p[X+1]+Y
    local AA = self.p[A+1]+Z
    local AB = self.p[A+2]+Z
    local B  = self.p[X+2]+Y
    local BA = self.p[B+1]+Z
    local BB = self.p[B+2]+Z

    return lerp(w, lerp(v, lerp(u, grad(self.p[AA+1], x  , y  , z  ),
            grad(self.p[BA+1], x-1, y  , z  )),
            lerp(u, grad(self.p[AB+1], x  , y-1, z  ),
                    grad(self.p[BB+1], x-1, y-1, z  ))),
            lerp(v, lerp(u, grad(self.p[AB+2], x  , y  , z-1),
                    grad(self.p[BA+2], x-1, y  , z-1)),
                    lerp(u, grad(self.p[AB+2], x  , y-1, z-1),
                            grad(self.p[BB+2], x-1, y-1, z-1))))
end

function fade( t )
    return t * t * t * (t * (t * 6 - 15) + 10)
end

function lerp( t, a, b )
    return a + t * (b - a)
end

function grad( hash, x, y, z )
    local h = hash % 16
    local u = h < 8 and x or y
    local v = h < 4 and y or ((h == 12 or h == 14) and x or z)
    return ((h % 2) == 0 and u or -u) + ((h % 3) == 0 and v or -v)
end