-- =========================================
-- OVERCLOCK BAR (Deepend-style, Lua rebuild)
-- Psych Engine compatible
-- =========================================

local ANGRY_NOTES_START = 219127
local ANGRY_NOTES_END   = 228666

local angryNotes = 0
local angryNotesHit = 0
local overclockValue = 1.0

-- bar visuals
local BAR_X = -90
local BAR_Y = 100
local BAR_WIDTH = 22
local BAR_HEIGHT = 220

function onCreate()
    -- background
    makeLuaSprite('ocBG', nil, BAR_X, BAR_Y)
    makeGraphic('ocBG', BAR_WIDTH + 6, BAR_HEIGHT + 6, '000000')
    setObjectCamera('ocBG', 'other')
    addLuaSprite('ocBG', true)

    -- fill
    makeLuaSprite('ocFill', nil, BAR_X + 3, BAR_Y + BAR_HEIGHT)
    makeGraphic('ocFill', BAR_WIDTH, BAR_HEIGHT, 'FF0000')
    setObjectCamera('ocFill', 'other')
    addLuaSprite('ocFill', true)

    -- count angry notes
    for i = 0, getProperty('unspawnNotes.length')-1 do
        local t = getPropertyFromGroup('unspawnNotes', i, 'strumTime')
        local mustPress = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
        if t > ANGRY_NOTES_START and t < ANGRY_NOTES_END and not mustPress then
            angryNotes = angryNotes + 1
        end
    end
end

-- =========================================
-- NOTE TRACKING
-- =========================================
function opponentNoteHit(id, dir, type, sustain)
    local time = getPropertyFromGroup('notes', id, 'strumTime')
    if time > ANGRY_NOTES_START and time < ANGRY_NOTES_END then
        angryNotesHit = angryNotesHit + 1
        updateOverclock()
    end
end

-- =========================================
-- BAR UPDATE
-- =========================================
function updateOverclock()
    overclockValue = 1 - ((angryNotesHit / angryNotes) * 0.75)
    overclockValue = math.max(0.25, overclockValue)

    local newHeight = BAR_HEIGHT * overclockValue
    local newY = BAR_Y + BAR_HEIGHT - newHeight

    setProperty('ocFill.y', newY)
    setProperty('ocFill.scale.y', overclockValue)

    -- pulse effect
    setProperty('ocFill.scale.x', 1.2)
    doTweenX('ocPulse', 'ocFill.scale', 1, 0.15, 'cubeOut')

    -- optional shake
    setProperty('ocBG.x', BAR_X + getRandomInt(-2, 2))
    runTimer('resetOCPos', 0.05)
end

function onTimerCompleted(tag)
    if tag == 'resetOCPos' then
        setProperty('ocBG.x', BAR_X)
    end
end
