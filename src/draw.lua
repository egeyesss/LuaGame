function drawBeforeCam()
    menu:draw()
end

function drawCam()

    love.graphics.scale(1.5)

    if gamestate == 0 then return end

    if gameMap.layers["Ground"] then
        gameMap:drawLayer(gameMap.layers["Ground"])
    end
    
    if gameMap.layers["Maze" ] then
        gameMap:drawLayer(gameMap.layers["Maze"])
    end
    
    player:draw()

    if gameMap.layers["Buildings"] then
        gameMap:drawLayer(gameMap.layers["Buildings"])
    end

    
    --use gameMap.layers[] then gameMap:drawLayer to draw the map

    --world:draw() -- to see hitboxes
    box:draw()

end

function drawAfterCam()
    if gamestate == 0 then return end
    drawHUD()
    pause:draw()
end