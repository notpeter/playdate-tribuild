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

local function lerp2d(p1, p2, t)
    return point.new(lerp(p1.x, p2.x, t), lerp(p1.y, p2.y, t))
end

-- local function lerper(min, max, steps)
--     local step = 0
--     local direction = 1
--     return function()
--         if step == steps then
--             direction = -1
--         elseif step == 0 then
--             direction = 1
--         end
--         step = step + direction
--         local l = lerp(min, max, step/steps)
--         return l
--     end
-- end

local function lerper2d(p1, p2, steps)
    local step = 0
    local direction = 1
    return function()
        if step == steps then
            direction = -1
        elseif step == 0 then
            direction = 1
        end
        step = step + direction
        local l = lerp2d(p1, p2, step/steps)
        return l
    end
end

function bits.init()
    -- local q = 1.1547
    -- local width = 277
    local top = point.new(200, 0)
    local left = point.new(61, 239)
    local right = point.new(338, 239)

    -- local top1 = lerp2d(left, right, 0.5)
    -- local left1 = lerp2d(top, right, 0.5)

    local right1 = lerp2d(right, lerp2d(top, left, 0.5), 1.5)
    local left1 = lerp2d(left, lerp2d(top, right, 0.5), 1.5)
    local top1 = lerp2d(top, lerp2d(left, right, 0.5), 1.5)

    new_top = lerper2d(top, top1, 100)
    new_left = lerper2d(left, left1, 100)
    new_right = lerper2d(right, right1, 100)
end

function bits.update()
    local top = point.new(200, 0)
    local left = point.new(61, 239)
    local right = point.new(338, 239)

    -- local top = new_top()
    local left = new_left()
    local right = new_right()
    -- local top = new_top()

    gfx.clear()
    for i = 1,9 do
        draw_line(top.x, top.y, lerp(left.x, right.x, i/10), lerp(left.y, right.y, i/10))
        draw_line(right.x, right.y, lerp(left.x, top.x, i/10), lerp(left.y, top.y, i/10))
        draw_line(left.x, left.y, lerp(right.x, top.x, i/10), lerp(right.y, top.y, i/10))
    end

    local p = poly.new(top, left, right, top)
    -- gfx.setLineWidth(2)
    draw_poly(p)
    -- gfx.setLineWidth(1)
end
