-- =========================================
-- DDE / CRUD HUD MOVING PARTS (Lua)
-- Psych Engine compatible
-- =========================================

-- CAMERA BOUNDS (FROM DEEPEND)
local MIN_X = 140
local MAX_X = 1540
local MIN_Y = 84
local MAX_Y = 884

-- BAR MOVEMENT RANGES (FROM VIDEO)
local BAR_X_MIN = 256
local BAR_X_MAX = 721

local BAR_Y_MIN = 147
local BAR_Y_MAX = 333

function onCreatePost()
    -- ---------------------------------
    -- HORIZONTAL BAR
    -- ---------------------------------
    makeLuaSprite('crudBarX', 'ui/crud/horizontal', BAR_X_MIN, BAR_Y_MIN)
    setObjectCamera('crudBarX', 'other')
    setProperty('crudBarX.antialiasing', false)
    addLuaSprite('crudBarX', true)

    -- ---------------------------------
    -- VERTICAL BAR
    -- ---------------------------------
    makeLuaSprite('crudBarY', 'ui/crud/vertical', BAR_X_MAX + 40, BAR_Y_MIN)
    setObjectCamera('crudBarY', 'other')
    setProperty('crudBarY.antialiasing', false)
    addLuaSprite('crudBarY', true)
end

-- =========================================
-- CAMERA → HUD MAPPING (CORE LOGIC)
-- =========================================
function onUpdatePost()
    -- camera center
    local camX = getProperty('camGame.scroll.x') + screenWidth * 0.5
    local camY = getProperty('camGame.scroll.y') + screenHeight * 0.5

    -- normalize to 0–1
    local xPerc = (camX - MIN_X) / (MAX_X - MIN_X)
    local yPerc = (camY - MIN_Y) / (MAX_Y - MIN_Y)

    xPerc = clamp(xPerc, 0, 1)
    yPerc = clamp(yPerc, 0, 1)

    -- move bars (NO TWEEN — DDE STYLE)
    setProperty('crudBarX.x', math.floor(lerp(BAR_X_MIN, BAR_X_MAX, xPerc)))
    setProperty('crudBarY.y', math.floor(lerp(BAR_Y_MIN, BAR_Y_MAX, yPerc)))
end

-- =========================================
-- UTILS
-- =========================================
function lerp(a, b, t)
    return a + (b - a) * t
end

function clamp(v, min, max)
    if v < min then return min end
    if v > max then return max end
    return v
end
