function updateAll(dt)

    updateGame(dt)

end

function updateGame(dt)

    player:update(dt)
    world:update(dt)
    box:update(dt)

    flux.update(dt)

    cam:update(dt)
    pause:update(dt)
    shake:update(dt)

end