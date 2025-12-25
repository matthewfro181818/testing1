local extraChars = {}

local chars = {}
local json

local anims = {
    'singLEFT',
    'singDOWN',
    'singUP',
    'singRIGHT'
}

--[[
    Instructions:

        //Use via adding at the top of your script:
            local extraChars = require("mods/scripts/ExtraCharModule")
        //Functions:
            --makeCharacter(tag,img,nType,x,y)
            <tag> the tag for the sprite of the character, mostly for easy access to it outside of this!
            <img> is the name of your character's json, it should be inside the characters folder.
            <nType> is the name of the noteType you want to use for your character.
            <isPlayer> is wheter your character is the player or not, should just be true or false.
            <sOffs> is a table which has 2 values: x and y. It should look like: {-100,0} for example. 1st num being x and the 2nd being y.
            <aSuffix> is the suffix for your altNote type, so if your noteType is called "Rizz" then call the alt one "Rizz-alt" and put "-alt" in aSuffix.
            --removeCharacter(tag,destory)
            <tag> the tag of the character you want to remove.
            <destory> wheter you want to permanently remove it or not.
            --changeCharacter(value1, value2)
            <value1> is the tag of the character you want to change.
            <value2> name of the character json your changing to.

]]--

function onCreate()
    if currentModDirectory ~= nil and currentModDirectory ~= '' then
        json = require("mods/"..currentModDirectory.."/scripts/jsonlua")
    else
        json = require("mods/scripts/jsonlua")
    end
end

function extraChars.makeCharacter(tag,charName, nType, isPlayer, sOffs, aSuffix)
    local charJson = json.parse(getTextFromFile('characters/'..charName..'.json'))
    
    local newChar = {
        name = tag,
        positions = charJson.position,
        stageOffset = {
            sOffs[1],sOffs[2]
        },
        animations = charJson.animations,
        idleSuffix = "",
        noteType = nType,
        altSuffix = aSuffix,
        playable = isPlayer,
        doIdle = true,
        specialAnim = false,
        idleLoop
    }

    makeAnimatedLuaSprite(tag, charJson.image, charJson.position[1] + sOffs[1], charJson.position[2] + sOffs[2])
    scaleObject(tag, charJson.scale, charJson.scale)

    for i,animation in ipairs(charJson.animations) do
        addAnimationByPrefix(tag, animation.anim, animation.name, animation.fps, animation.loop)
        addOffset(tag, animation.anim, animation.offsets[1], animation.offsets[2])
        if animation.anim == 'idle' then
            newChar.idleLoop = animation.loop
        end
    end

    setProperty(tag..'.flipX', charJson.flip_x)
    if newChar.playable then
        setProperty(tag..'.flipX', not getProperty(tag..'.flipX'))
    end    
    
    addLuaSprite(tag)


    playAnim(tag, 'idle'..newChar.idleSuffix)
    
    table.insert(chars,newChar)
end

function extraChars.removeCharacter(tag, destroy)
    for i,char in pairs(chars) do
        if char.name == tag then
           removeLuaSprite(tag, destroy)
           if destroy then
                table.remove(chars, i)
           end
           break
        end
    end
end

function extraChars.changeCharacter(value1, value2)
    for i,char in pairs(chars) do
        if value1 == char.name then
            local copy = char
            extraChars.removeCharacter(char.name, true)
            extraChars.makeCharacter(char.name, value2, copy.noteType, copy.playable, copy.stageOffset, copy.altSuffix)
            break
        end
    end
end


function onCountdownTick(counter)
    if #chars == 0 then return end

    for i,char in pairs(chars) do
        if counter % 2 == 0 then
        
            playAnim(char.name, 'idle'..char.idleSuffix)
        
        end 
    end
end
    
function onSongStart()
    
    if #chars == 0 then return end

    for i,char in pairs(chars) do
        
            playAnim(char.name, 'idle'..char.idleSuffix)
        
    end
    
end

function onBeatHit()
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if not char.idleLoop then
            if curBeat % 2 == 0 and char.doIdle and not char.specialAnim then
                playAnim(char.name, 'idle'..char.idleSuffix)
            end
            doIdle = true
        else
            if curBeat % 2 == 0 and char.doIdle and not char.specialAnim and getProperty(char.name..'animation.curAnim.name') ~= "idle" then
                playAnim(char.name, 'idle'..char.idleSuffix)
            end
            doIdle = true
        end
    end
end

function singStuff(membersIndex, noteData, noteType, char)
    if noteType == char.noteType then
        doIdle = false
        playAnim(char.name, anims[noteData + 1], true)
    elseif noteType == char.noteType..char.altSuffix then
        doIdle = false
        playAnim(char.name, anims[noteData + 1]..char.altSuffix, true)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if char.playable then
            singStuff(membersIndex, noteData, noteType, char)
        end
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if not char.playable then
            singStuff(membersIndex, noteData, noteType, char)
        end
    end
end

function onEvent(eventName, value1, value2)
    if #chars == 0 then return end
        if eventName == 'Play Animation' then
            for i,char in pairs(chars) do
                if value2 == char.name then
                    char.specialAnim = true
                    playAnim(char.name, value1)
                    break
                end
            end
        end
    if eventName == 'Alt Idle Animation' then
        for i,char in pairs(chars) do
            if value2 == char.name then
                char.idleSuffix = value2
                playAnim(char.name, 'idle'..char.idleSuffix)
                break
            end
        end
    end
    if eventName == "Change Extra Character" then
        extraChars.changeCharacter(value1, value2)
    end
end



return extraChars