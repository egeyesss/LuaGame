function gameStart()
    --setScale()
    love.graphics.setBackgroundColor(26/255, 26/255, 26/255)

    love.graphics.setDefaultFilter("nearest", "nearest")

    fullscreen = true
    testWindow = false
    vertical = false
    setWindowSize(fullscreen, 1920, 1080)

    if vertical then
        fullscreen = false
        testWindow = true
        setWindowSize(fullscreen, 1360, 1920)
    end

    -- The game's graphics scale up, this method finds the right ratio
    setScale()

    vector = require "libs/hump/vector" -- vectors
    flux = require "libs/flux/flux" -- haven't used this

    anim8 = require("libs/anim8")
    sti = require("libs/sti")

    local wf = require("libs/windfield")
    world = wf.newWorld(0, 0)
    world:addCollisionClass('Player')

    require("src/startup/require")
    requireAll()

end

function setWindowSize(full, width, height)
    if full then
        fullscreen = true
        love.window.setFullscreen(true)
        windowWidth = love.graphics.getWidth()
        windowHeight = love.graphics.getHeight()
    else
        fullscreen = false
        if width == nil or height == nil then
            windowWidth = 1920
            windowHeight = 1080
        else
            windowWidth = width
            windowHeight = height
        end
        love.window.setMode( windowWidth, windowHeight, {resizable = not testWindow} )
    end
end

function setScale(input)
    scale = (7.3 / 1200) * windowHeight

    if vertical then
        scale = (7 / 1200) * windowHeight
    end

    if cam then
        --cam:zoomTo(scale)
    end
end

function checkWindowSize()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    if width ~= windowWidth or height ~= windowHeight then
        reinitSize()
    end
end

function reinitSize()
    -- Reinitialize everything
    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()
    setScale()
    --pause:init()
    --initFonts()
end

