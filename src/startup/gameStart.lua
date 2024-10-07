function gameStart()
    --setScale()
    love.graphics.setBackgroundColor(26/255, 26/255, 26/255)

    love.graphics.setDefaultFilter("nearest", "nearest")

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

end

function initGlobals()

    -- game state: 0: main menu, 1: gameplay, 2: game paused
    gamestate = 0

end

--[[function setScale(input)
    scale = (7.3 / 1200) * windowHeight

    if vertical then
        scale = (7 / 1200) * windowHeight
    end

    if cam then
        --cam:zoomTo(scale)
    end
end ]]--

--[[ function checkWindowSize()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    if width ~= windowWidth or height ~= windowHeight then
        reinitSize()
    end
end ]]--

--[[ function reinitSize()
    -- Reinitialize everything
    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()
    setScale()
    --pause:init()
    --initFonts()
end ]]--