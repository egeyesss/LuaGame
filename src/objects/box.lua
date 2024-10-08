box = {}

box.sprite = sprites.enemies.box



 -- box states:
    -- 0: idle, can be moved around
    -- 1: stopped, can't be moved, at the desired spot
box.state = 0

function spawnBox(x,y, box)

box.physics = world:newBSGRectangleCollider(x, y, 16, 16, 0)
box.physics:setFixedRotation(true)
box.physics:setLinearDamping(2)
box.physics.parent = box

box.startX = x
box.startY = y

    function box:update(dt)
        --box:moveLogic(dt, true)
        --local px, py = player:getPosition()
        --local ex, ey = box.physics.getPosition()
        local ex = box.physics:getX() 
        local ey = box.physics:getY()

        if CheckCollision(ex, ey, 16, 16, 616, 568, 14, 14) then
            box.state = 1
        end

        --box:setScaleX()

        if box.state == 1 then
            box.physics:setType('static')
        end

    end

    function box:draw()
        --setWhite()

        local ex = box.physics:getX() + 2
        local ey = box.physics:getY() + 4
        --[[local shadow = sprites.enemies.shadowMed -- medium size shadow
        local shadowOff = -0.75 * box.scaleX
        love.graphics.draw(shadow, ex + shadowOff, ey+9, nil, nil, nil, shadow:getWidth()/2, shadow:getHeight()/2)
        ]]--

        love.graphics.draw(box.sprite, ex, ey, nil, 1, 1, 10, 12)

        if CheckCollision(ex, ey, 16, 16, 616, 568, 14, 14) then
            love.graphics.printf("YOU WON", love.graphics.getWidth() / 2 , love.graphics.getHeight() / 2, 500, "center") -- fix this when back from gym
        end


    end

    function box:win()
        box.state = 1
        local ex = box.physics:getX() + 2
        local ey = box.physics:getY() + 4
    end

    return box

end