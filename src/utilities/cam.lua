camera = require 'libs/camera'
cam = camera(0,0)

function cam:update(dt)

    local camX, camY = player.collider:getPosition();
    
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    
    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight
    
 -- calculations to make the cam not look beyond map's borders:
    if camX < w/2 then
        camX = w/2
    end
    
    if camY < h/2 then
        camY = h/2
    end
    
    if camX > (mapW - w/2) then
        camX = (mapW - w/2)
    end
    
    if camY > (mapH - h/2) then
        camY = (mapH - h/2)
    end
    
    cam:lookAt(player.x, player.y)
    cam:lockPosition(camX, camY)

    cam.x, cam.y = cam:position()
end