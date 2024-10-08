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
        --local ex, ey = box.physics.getPosition()
        local ex = box.physics:getX() 
        local ey = box.physics:getY()

        if CheckCollision(ex, ey, 16, 16, 616, 570, 14, 14) then -- if box at the end of the maze >>
            box.state = 1
        end

        if box.state == 1 then -- when end of the desired spot, stop the box from moving
            --box.physics:setType('static')
        end

    end

    function box:draw()
        setWhite()

        local ex = box.physics:getX() + 2
        local ey = box.physics:getY() + 4

        love.graphics.draw(box.sprite, ex, ey, nil, 1, 1, 10, 12)

        if box.state == 1 then 
            love.graphics.printf("YOU WON", 400 , 500, 500, "center") 
        end

    end

    return box

end