function drawBeforeCam()
    -- menu:draw()
end

function drawCam()
    if gamestate == 0 then return end

    if gameMap.layers["Ground"] then
        gameMap:drawLayer(gameMap.layers["Ground"])
    end
    
    if gameMap.layers["Buildings" ] then
        gameMap:drawLayer(gameMap.layers["Buildings"])
    end
    

    if gameMap.layers["Buildings2"] then
        gameMap:drawLayer(gameMap.layers["Buildings2"])
    end
    player:draw()
    
    --use gameMap.layers[] then gameMap:drawLayer to draw the map

    world:draw()
    skeleton:draw()

end

function drawAfterCam()
    if gamestate == 0 then return end
    --drawHUD()
    --pause:draw()
end