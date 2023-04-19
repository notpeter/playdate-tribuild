import "CoreLibs/math"

bits = {}

local gfx = playdate.graphics
local spr = playdate.graphics.sprite
local geo = playdate.geometry
local line = playdate.geometry.lineSegment
local poly = playdate.geometry.polygon
local point = playdate.geometry.point

local draw_line = playdate.graphics.drawLine
local draw_poly = playdate.graphics.drawPolygon

local function lerp(min, max, t)
	return min + (max - min) * t
end

function bits.update()
    local q = 1.1547
    local width = 277
    local top = point.new(200, 0)
    local left = point.new(61, 239)
    local right = point.new(338, 239)
    local p = poly.new(top, left, right, top)
    for i = 1,9 do
        draw_line(top.x, top.y, lerp(left.x, right.x, i/10), left.y)
    end
    for i = 1,9 do
        draw_line(right.x, right.y, lerp(left.x, top.x, i/10), lerp(left.y, top.y, i/10))
    end
    for i = 1,9 do
        draw_line(left.x, left.y, lerp(right.x, top.x, i/10), lerp(right.y, top.y, i/10))
    end
    gfx.setLineWidth(2)
    draw_poly(p)
    gfx.setLineWidth(1)
end
