function love.load()

    require("src/startup/gameStart")
    gameStart()

    gameMap = sti('maps/test.lua')

    walls = {}
    if gameMap.layers['Walls'] then
        for i, obj in pairs(gameMap.layers['Walls'].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls,wall)
        end
    end

    spawnSkeleton(360, 300, skeleton)

end

function love.update(dt)
    updateAll(dt)

end

function love.draw()
    drawBeforeCam()

    cam:attach()
        drawCam()

        love.graphics.rectangle('line', 350, 350, 10, 10)
    cam:detach()

    drawAfterCam()
end

function love.keypressed(key)

end

function love.keyreleased(key)

end

function love.mousepressed(x, y, button)
    --[[ if button == 1 then
        player:swingSword()
    end ]]--
end

function love.mousereleased(x, y, button)

end