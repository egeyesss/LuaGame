player = {}
player.buffer = {}

player.collider = world:newBSGRectangleCollider(100, 150, 12, 12, 3)
player.collider:setCollisionClass('Player')
player.collider:setFixedRotation(true)
player.x = 0
player.y = 0
player.speed = 200
player.dirX = 0
player.dirY = 0
player.moving = false
player.animSpeed = 0.18
player.animTimer = 0
player.attackDir = vector(1,0)
player.rotateMargin = 0.25

-- -1 = in menu
-- 0 = Normal gameplay
-- 0.5 = Rolling
-- 1 = Sword swing
-- 2 = Use (bomb)
-- 3 = Bow (3: bow drawn, 3.1: recover)
-- 4 = grapple (4: armed, 4.1: launching, 4.2: moving)
-- 10 = Damage stun
-- 11 = Hold item
-- 12 = Transition
player.state = 0



player.grid = anim8.newGrid( 16, 32, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight() )

player.animations = {}
player.animations.down = anim8.newAnimation(player.grid('1-4', 1), player.animSpeed)
player.animations.right = anim8.newAnimation(player.grid('1-4', 2), player.animSpeed)
player.animations.up = anim8.newAnimation(player.grid('1-4', 3), player.animSpeed)
player.animations.left = anim8.newAnimation(player.grid('1-4', 4), player.animSpeed)
player.animations.swordDown = anim8.newAnimation(player.grid('1-4', 5), player.animSpeed)
player.animations.swordUp = anim8.newAnimation(player.grid('1-4', 6), player.animSpeed)
player.animations.swordRight = anim8.newAnimation(player.grid('1-4', 7), player.animSpeed)
player.animations.swordLeft = anim8.newAnimation(player.grid('1-4', 8), player.animSpeed)

player.animations.idle = anim8.newAnimation(player.grid(3, 1), player.animSpeed)
player.anim = player.animations.idle


function player:update(dt)

    local dirX, dirY = 0, 0

    if player.state == 0 then

    if love.keyboard.isDown("w") and not love.keyboard.isDown('s') then
        player.dirY = -1
        dirY = -1
        player.anim = player.animations.up
    end
    
    if love.keyboard.isDown("s") and not love.keyboard.isDown('w') then
        player.dirY = 1
        dirY = 1
        player.anim = player.animations.down
    end

    if love.keyboard.isDown("a") and not love.keyboard.isDown('d') then
        player.dirX = -1
        dirX = -1
        player.anim = player.animations.left
    end

    if love.keyboard.isDown("d") and not love.keyboard.isDown('a') then
        player.dirX = 1
        dirX = 1
        player.anim = player.animations.right
    end

    if dirY == 0 and dirX ~= 0 then
        player.dirY = 1
    end

    vx = dirX * player.speed
    vy = dirY * player.speed
    player.collider:setLinearVelocity(vx, vy)

    player.x = player.collider:getX() 
    player.y = player.collider:getY() - 8

    if dirX == 0 and dirY == 0 then
        if player.moving then
            player.moving = false
            player.anim = player.animations.idle
        end
    else
        player.moving = true
    end

    elseif player.state == 1 then

    player.animTimer = player.animTimer - dt
    player.collider:setLinearVelocity((player.attackDir*90):unpack())

    elseif player.state == 1 then
    player.collider:setLinearVelocity(0,0)
    end

if player.animTimer < 0 then
    if player.state == 1 then
        player.state = 1.1
        player.animTimer = 0.25
        player:swordDamage()
    elseif player.state == 1.1 then
        player.state = 0
        player:resetAnimation(player.dir)
    end
end
    player.anim:update(dt)


end

function player:draw()

    player.anim:draw(sprites.playerSheet, player.x, player.y, nil, 1.2, nil, 8, 16)

end

function processBuffer(dt)

end

function player:swingSword()

    -- The player can only swing their sword if the player.state is 0 (regular gameplay)
    if player.state ~= 0 then
        --player:addToBuffer("sword")
        return
    end

    player.attackDir = toMouseVector(player.x, player.y)
    player:setDirFromVector(player.attackDir)

    player.state = 1

    if player.dirX == 1 then 
            player.anim = player.animations.swordRight
        elseif player.dirX == -1 then
            player.anim = player.animations.swordLeft
        elseif player.dirY == 1 then
            player.anim = player.animations.swordDown
        elseif player.dirY == -1 then
            player.anim = player.animations.swordUp
        end

    --player.anim:gotoFrame(1)
    -- animTimer for sword wind-up
    player.animTimer = 0.075

end


function player:swordDamage()
    -- Query for enemies to hit with the sword
    --local hitEnemies = world:queryCircleArea(player:getX(), player:getY(), 24, {'Enemy'})

    local px, py = player.x, player.y
    local dir = player.attackDir:normalized()
    local rightDir = dir:rotated(math.pi/2)
    local leftDir = dir:rotated(math.pi/-2)
    local polygon = {
        px + dir.x*20,
        py + dir.y*20,
        px + dir:rotated(math.pi/8).x*20,
        py + dir:rotated(math.pi/8).y*20,
        px + dir:rotated(math.pi/4).x*20,
        py + dir:rotated(math.pi/4).y*20,
        px + dir:rotated(3*math.pi/8).x*20,
        py + dir:rotated(3*math.pi/8).y*20,
        px + rightDir.x*22,
        py + rightDir.y*22,
        px + rightDir.x*22 + rightDir:rotated(math.pi/2).x*6,
        py + rightDir.y*22 + rightDir:rotated(math.pi/2).y*6,
        px + leftDir.x*22 + leftDir:rotated(math.pi/-2).x*6,
        py + leftDir.y*22 + leftDir:rotated(math.pi/-2).y*6,
        px + leftDir.x*22,
        py + leftDir.y*22,
        px + dir:rotated(3*math.pi/-8).x*20,
        py + dir:rotated(3*math.pi/-8).y*20,
        px + dir:rotated(math.pi/-4).x*20,
        py + dir:rotated(math.pi/-4).y*20,
        px + dir:rotated(math.pi/-8).x*20,
        py + dir:rotated(math.pi/-8).y*20,
    }

    local range = math.random()/4
    --dj.play(sounds.items.sword, "static", "effect", 1, 1+range)

    local hitEnemies = world:queryPolygonArea(polygon, {'Enemy'})
    for _,e in ipairs(hitEnemies) do
        local knockbackDir = getPlayerToSelfVector(e:getX(), e:getY())
        e.parent:hit(1, knockbackDir, 0.1)
    end
end

function player:setDirFromVector(vec)
    local rad = math.atan2(vec.y, vec.x)
    if rad >= player.rotateMargin*-1 and rad < math.pi/2 then
        player.dirX = 1
        player.dirY = 1
    elseif (rad >= math.pi/2 and rad < math.pi) or (rad < (math.pi - player.rotateMargin)*-1) then
        player.dirX = -1
        player.dirY = 1
    elseif rad < 0 and rad > math.pi/-2 then
        player.dirX = 1
        player.dirY = -1
    else
        player.dirX = -1
        player.dirY = -1
    end
end