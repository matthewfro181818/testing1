-- ===============================
-- DDE / CRUD NOTE ASSET GLOW
-- Psych Engine Lua
-- ===============================

local hitScale = 1.15
local returnScale = 1.0
local glowTime = 0.05

function onCreatePost()
    -- Make notes glow-friendly
    for i = 0, getProperty('unspawnNotes.length')-1 do
        setPropertyFromGroup('unspawnNotes', i, 'blend', 'add')
        setPropertyFromGroup('unspawnNotes', i, 'alpha', 0.95)
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    applyNoteGlow(id, false)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    applyNoteGlow(id, true)
end

function applyNoteGlow(noteID, isOpponent)
    local group = isOpponent and 'notes' or 'notes'

    -- scale pop
    setPropertyFromGroup(group, noteID, 'scale.x', hitScale)
    setPropertyFromGroup(group, noteID, 'scale.y', hitScale)

    -- strong glow alpha
    setPropertyFromGroup(group, noteID, 'alpha', 1.25)

    -- DDE-style cyan outline glow
    setPropertyFromGroup(group, noteID, 'color', getColorFromHex('66FFFF'))

    -- tween back
    doTweenX('noteGlowX'..noteID, group..'.members['..noteID..'].scale', returnScale, glowTime, 'cubeOut')
    doTweenY('noteGlowY'..noteID, group..'.members['..noteID..'].scale', returnScale, glowTime, 'cubeOut')
    doTweenAlpha('noteGlowA'..noteID, group..'.members['..noteID..']', 0.95, glowTime, 'cubeOut')

    runTimer('resetNoteColor'..noteID, glowTime)
end

function onTimerCompleted(tag)
    if string.find(tag, 'resetNoteColor') then
        local id = tonumber(tag:gsub('resetNoteColor', ''))
        if id ~= nil then
            setPropertyFromGroup('notes', id, 'color', 0xFFFFFFFF)
        end
    end
end
