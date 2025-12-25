-- =========================================
-- DDE / CRUD HUD RECREATION
-- Psych Engine Lua
-- =========================================

-- positions (tweak freely)
local WINDOW_X = 0
local WINDOW_Y = 0

local COUNTER_X = 20
local COUNTER_Y = 120
local COUNTER_SPACING = 20

local TIME_X = 260
local TIME_Y = 20

-- text objects
local timeText
local timeTextBorder
local counters = {}

function onCreatePost()
    -- -------------------------------------
    -- HIDE DEFAULT HUD PARTS
    -- -------------------------------------
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)

    -- keep health bar if you want
    -- setProperty('healthBar.visible', false)

    -- -------------------------------------
    -- MS PAINT WINDOW FRAME
    -- -------------------------------------
    makeLuaSprite('crudWindow', 'ui/crud/window', WINDOW_X, WINDOW_Y)
    setObjectCamera('crudWindow', 'other')
    setProperty('crudWindow.antialiasing', false)
    addLuaSprite('crudWindow', false)

    -- -------------------------------------
    -- TIME TEXT (CUSTOM)
    -- -------------------------------------
    timeTextBorder = makeLuaText('timeBorder', '', 0, TIME_X + 1, TIME_Y + 1)
    setTextSize('timeBorder', 20)
    setTextColor('timeBorder', 'C3BFAF')
    setObjectCamera('timeBorder', 'other')
    setProperty('timeBorder.antialiasing', false)
    addLuaText('timeBorder')

    timeText = makeLuaText('timeMain', '', 0, TIME_X, TIME_Y)
    setTextSize('timeMain', 20)
    setTextColor('timeMain', 'FFFFFF')
    setObjectCamera('timeMain', 'other')
    setProperty('timeMain.antialiasing', false)
    addLuaText('timeMain')

    -- -------------------------------------
    -- JUDGEMENT COUNTERS
    -- -------------------------------------
    local labels = {'SICK', 'GOOD', 'BAD', 'MISS'}

    for i = 1, #labels do
        local name = 'counter_' .. labels[i]

        makeLuaText(name, labels[i] .. ': 0', 0,
            COUNTER_X,
            COUNTER_Y + (i - 1) * COUNTER_SPACING
        )

        setTextSize(name, 16)
        setTextColor(name, 'FFFFFF')
        setObjectCamera(name, 'other')
        setProperty(name .. '.antialiasing', false)

        addLuaText(name)
        counters[labels[i]] = name
    end
end


function onBeatHit()
    hudShake = 3
end

-- camera bounds (tweak to match stage)
local minX, maxX = 140, 1540
local minY, maxY = 84, 884

local hudShake = 0
local secretTriggered = false

-- =========================================
-- UPDATE TIME TEXT
-- =========================================
function onUpdatePost()
    local curTime = getProperty('timeTxt.text')
    if curTime ~= nil then
        setTextString('timeMain', curTime)
        setTextString('timeBorder', curTime)
    end

    -- camera center
    local camX = getProperty('camGame.scroll.x') + screenWidth * 0.5
    local camY = getProperty('camGame.scroll.y') + screenHeight * 0.5

    -- normalize to 0–1
    local xPerc = (camX - minX) / (maxX - minX)
    local yPerc = (camY - minY) / (maxY - minY)

    xPerc = math.max(0, math.min(1, xPerc))
    yPerc = math.max(0, math.min(1, yPerc))

    -- move HUD bars
    setProperty('barX.x', lerp(256, 721, xPerc))
    setProperty('barY.y', lerp(147, 333, yPerc))
    if hudShake > 0 then
        setProperty('camOther.x', getRandomInt(-hudShake, hudShake))
        setProperty('camOther.y', getRandomInt(-hudShake, hudShake))
        hudShake = hudShake - 0.5
    else
        setProperty('camOther.x', 0)
        setProperty('camOther.y', 0)
    end

    local t = getProperty('timeTxt.text')
    if t == '4:45' and not secretTriggered then
        if getRandomInt(0, 100) < 45 then
            setTextColor('timeMain', 'C3BFAF')
            setTextColor('timeBorder', 'FFFFFF')
        end
        secretTriggered = true
    elseif t ~= '4:45' then
        setTextColor('timeMain', 'FFFFFF')
        setTextColor('timeBorder', 'C3BFAF')
    end
end

function bumpCounter(name)
    setProperty(name .. '.scale.x', 1.2)
    setProperty(name .. '.scale.y', 1.2)
    doTweenX(name..'bx', name..'.scale', 1, 0.1, 'cubeOut')
    doTweenY(name..'by', name..'.scale', 1, 0.1, 'cubeOut')
end

function lerp(a, b, t)
    return a + (b - a) * t
end

-- =========================================
-- UPDATE COUNTERS
-- =========================================
function goodNoteHit(id, dir, type, sustain)
    addCounter('SICK') -- Psych treats good hits as sick by default
end

function noteMiss(id, dir, type, sustain)
    addCounter('MISS')
end

function addCounter(name)
    local txt = counters[name]
    if txt == nil then return end

    local cur = tonumber(string.match(getTextString(txt), '%d+')) or 0
    cur = cur + 1
    setTextString(txt, name .. ': ' .. cur)
end

function onUpdate(elapsed)
    local t = getSongPosition() / 1000
    setProperty('crudWindow.x', math.floor(math.sin(t * 0.5) * 2))
    setProperty('crudWindow.y', math.floor(math.cos(t * 0.3) * 2))
end
