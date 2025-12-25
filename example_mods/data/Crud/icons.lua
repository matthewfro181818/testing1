function makeFlexibleIcon(tag, image, isPlayer)
    makeLuaSprite(tag, image, 0, 0)
    setObjectCamera(tag, 'hud')
    setProperty(tag..'.antialiasing', false)
    addLuaSprite(tag, true)

    -- IMPORTANT: do NOT scale yet
    updateHitbox(tag)

    -- Store metadata
    setProperty(tag..'.isPlayer', isPlayer)
end

function fitIconToBar(tag)
    local barY = getProperty('healthBar.y')
    local barX = getProperty('healthBar.x')
    local barW = getProperty('healthBar.width')

    local iw = getProperty(tag..'.width')
    local ih = getProperty(tag..'.height')

    -- Desired visual size (tweakable)
    local target = 90
    local scale = target / math.max(iw, ih)

    setProperty(tag..'.scale.x', scale)
    setProperty(tag..'.scale.y', scale)
    updateHitbox(tag)

    -- Position
    local x
    if getProperty(tag..'.isPlayer') then
        x = barX + barW - iw * scale * 0.5
    else
        x = barX - iw * scale * 0.5
    end

    local y = barY - ih * scale * 0.6

    setProperty(tag..'.x', math.floor(x))
    setProperty(tag..'.y', math.floor(y))
end

function onUpdatePost()
    fitIconToBar('iconP1_custom')
    fitIconToBar('iconP2_custom')
end

function setIconFlip(tag)
    if not getProperty(tag..'.isPlayer') then
        setProperty(tag..'.flipX', true)
    else
        setProperty(tag..'.flipX', false)
    end
end

function changeIcon(tag, newImage)
    loadGraphic(tag, newImage)
    updateHitbox(tag)
end

function onCreatePost()
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)

    makeFlexibleIcon('iconP1_custom', 'icons/icon-bf-crud-pixel', true)
    makeFlexibleIcon('iconP2_custom', 'icons/icon-jeff-pixel', false)

    setIconFlip('iconP2_custom')
end

function onUpdatePost()
    fitIconToBar('iconP1_custom')
    fitIconToBar('iconP2_custom')
end

function onBeatHit()
    setProperty('iconP1_custom.scale.x', getProperty('iconP1_custom.scale.x') * 1.05)
    setProperty('iconP1_custom.scale.y', getProperty('iconP1_custom.scale.y') * 1.05)
end
