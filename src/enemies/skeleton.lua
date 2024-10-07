skeleton = {}

skeleton.sprite = sprites.enemies.skeleton

skeleton.health = 5
skeleton.magnitude = 40
skeleton.dir = vector(0,1)
skeleton.viewDistance = 100

function skeleton:aggro(dt)

end

skeleton.grid = anim8.newGrid(20, 24, skeleton.sprite:getWidth(), skeleton.sprite:getHeight())

skeleton.animations = {}
skeleton.animations.walk = anim8.newAnimation(skeleton.grid('1-2', 1), 0.5)
skeleton.animations.staff = anim8.newAnimation(skeleton.grid(3,1), 1)

skeleton.anim = skeleton.animations.walk
skeleton.scaleX = 1

-- 0: standing, 1: walking, 2:running
skeleton.moving = 0

 -- Enemy states:
    -- 0: idle, standing
    -- 1: wander, stopped
    -- 1.1: wander, moving
    -- 99: alert
    -- 100: attacking
skeleton.state = 0

function spawnSkeleton(x,y, skeleton)

skeleton.physics = world:newBSGRectangleCollider(x, y, 12, 16, 3)
skeleton.physics:setFixedRotation(true)
skeleton.physics:setLinearDamping(2)
skeleton.physics.parent = skeleton

skeleton.startX = x
skeleton.startY = y
skeleton.wanderRadius = 30
skeleton.wanderSpeed = 15
skeleton.wanderTimer = 0.5 + math.random()*2
skeleton.wanderBufferTimer = 0
skeleton.wanderDir = vector(1,1)

function skeleton:wanderUpdate(dt)
    if skeleton.state < 1 or skeleton.state >= 2 then return end
    if skeleton.wanderTimer > 0 then skeleton.wanderTimer = skeleton.wanderTimer - dt end
    if skeleton.wanderBufferTimer > 0 then skeleton.wanderBufferTimer = skeleton.wanderBufferTimer - dt end
    if skeleton.wanderTimer < 0 then
        skeleton.state = 1.1
        skeleton.wanderTimer = 0

        local ex = skeleton.physics:getX()
        local ey = skeleton.physics:getY()

        if ex < skeleton.startX and ey < skeleton.startY then
            skeleton.wanderDir = vector(0, 1)
        elseif ex > skeleton.startX and ey < skeleton.startY then
            skeleton.wanderDir = vector(-1, 0)
        elseif ex < skeleton.startX and ey > skeleton.startY then
            skeleton.wanderDir = vector(1, 0)
        else
            skeleton.wanderDir = vector(0, -1)
        end

        skeleton.wanderBufferTimer = 0.2
        skeleton.wanderDir:rotateInplace(math.pi/-2 * math.random())
    end

    if skeleton.state == 1.1 and skeleton.physics then
        skeleton.physics:setX(skeleton.physics:getX() + skeleton.wanderDir.x * skeleton.wanderSpeed * dt)
        skeleton.physics:setY(skeleton.physics:getY() + skeleton.wanderDir.y * skeleton.wanderSpeed * dt)

        if distanceBetween(skeleton.physics:getX(), skeleton.physics:getY(), skeleton.startX, skeleton.startY) > skeleton.wanderRadius and skeleton.wanderBufferTimer <= 0 then
            skeleton.state = 1
            skeleton.wanderTimer = 1 + math.random(0.1, 0.8)
        end
    end
    --skeleton:lookForPlayer()
end

    function skeleton:update(dt)
        --skeleton:moveLogic(dt, true)
        --local px, py = player:getPosition()
        --local ex, ey = skeleton.physics.getPosition()

        --skeleton:setScaleX()

        skeleton:wanderUpdate(dt)

        if skeleton.state == 1 or skeleton.state == 99 then
            skeleton.moving = 1
        end

        

    end

    function skeleton:draw()
        --setWhite()

        local ex, ey = skeleton.physics:getPosition()
        --[[local shadow = sprites.enemies.shadowMed -- medium size shadow
        local shadowOff = -0.75 * skeleton.scaleX
        love.graphics.draw(shadow, ex + shadowOff, ey+9, nil, nil, nil, shadow:getWidth()/2, shadow:getHeight()/2)
        ]]--

        skeleton.anim:draw(skeleton.sprite, ex, ey, nil, skeleton.scaleX, 1, 10, 12)

        if skeleton.state == 99 then
            love.graphics.draw(sprites.enemies.alert, ex, ey-14.5, nil, nil, nil, sprites.enemies.alert:getWidth()/2, sprites.enemies.alert:getHeight()/2)
        end
    end

    function skeleton:die()
        local ex, ey = skeleton.physics:getPosition()
        local args = {}
        args.scaleX = skeleton.scaleX
        --args.form = skeleton.form
    end

    return skeleton

end