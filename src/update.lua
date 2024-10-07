function updateAll(dt)

    updateGame(dt)

end

function updateGame(dt)

    player:update(dt)
    world:update(dt)
    skeleton:update(dt)
    --enemies:destroyDead()

    cam:update(dt)
    shake:update(dt)

end