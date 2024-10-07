function loadMap(mapName, destX, destY)

    if destX and destY then
        player:setPosition(destX, destY)
    end

    gameMap = sti("maps/" .. mapName .. ".lua")

end