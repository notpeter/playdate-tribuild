import "CoreLibs/math"

bits = {}

-- Constants
local screen_width <const> = 400
local screen_height <const> = 240

-- Local aliases
local gfx <const> = playdate.graphics
local spr <const> = playdate.graphics.sprite
local geo <const> = playdate.geometry
local line <const> = playdate.geometry.lineSegment
local poly <const> = playdate.geometry.polygon
local point <const> = playdate.geometry.point

local draw_line <const> = playdate.graphics.drawLine
local draw_poly <const> = playdate.graphics.drawPolygon

-- Local Functions
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
    -- local unit_triangle = 1.1547 -- (side length for triangle with height)
    -- local unit_height = 0.866025
    -- local hheight <const> = screen_height // 2

    local max = 200
    local points = {
        point.new(max // 2 - 1, 0), -- top
        point.new(0, max - 1), -- left
        point.new(max - 1, max - 1),
        -- point.new(screen_height // 2, 0), top
    }

    local top = points[1]
    local left = points[2]
    local right = points[3]

    local right1 = lerp2d(right, lerp2d(top, left, 0.5), 0.3)
    local left1 = lerp2d(left, lerp2d(top, right, 0.5), 2.0)
    local top1 = lerp2d(top, lerp2d(left, right, 0.5), 0.3)

    local rate = 50
    new_top = lerper2d(top, top, rate)
    new_left = lerper2d(left, left1, rate)
    new_right = lerper2d(right, right, rate)
end

function bits.update()
    local left = new_left()
    local right = new_right()
    local top = new_top()

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
