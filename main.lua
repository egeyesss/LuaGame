function love.load()

    gamestate = 0

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

    spawnBox(350, 200, box)

end

function love.update(dt)
    updateAll(dt)
end

function love.draw()
    drawBeforeCam()

    cam:attach()
        drawCam() 
    cam:detach()

    drawAfterCam()
end

function love.keypressed(key)
    if gamestate == 0 then return end

    if gamestate == 1 then -- if we are in game

        if key == 'escape' then
            pause:toggle()
        end
        
    end

    if gamestate == 2 then -- if we are in pause menu

        if key == 'escape' then
            pause:toggle()
        end

    end

end

function love.mousepressed(x, y, button)
    if gamestate == 0 then -- if we are in starting menu

        if button == 1 and CheckCollision(100, 350, 200, 40, x, y, 1, 1) then
            gamestate = 1 -- for "Start Game"
        elseif button == 1 and CheckCollision(100, 405, 200, 40, x, y, 1, 1) then
            -- options:draw() -- for "Options" but its not made yet
        elseif button == 1 and CheckCollision(100, 460, 200, 40, x, y, 1, 1) then
            love.event.quit() -- for "Quit Game"
        end
    
    end

    if gamestate == 2 then -- if we paused the game
    
        if button == 1 and CheckCollision(100, 350, 200, 40, x, y, 1, 1) then
            gamestate = 1 -- for "Resume"
            pause:toggle()
        elseif button == 1 and CheckCollision(100, 405, 200, 40, x, y, 1, 1) then
            -- options:draw() -- for "Options" but its not made yet
        elseif button == 1 and CheckCollision(100, 460, 200, 40, x, y, 1, 1) then
            love.event.quit() -- for "Quit Game"
        end

    end
    
    if gamestate == 1 then -- if we are in game
    
    end
    
end