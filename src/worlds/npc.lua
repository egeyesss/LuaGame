npcs = {}

function spawnNPC(name, x, y)
    local npc = {}
    npc.name = name
    npc.x = x
    npc.y = y
    npc.sprite = sprites.npc.merchant

    -- if name then npc.sprite = sprites.npc['merchant' .. name] -- don't know if this works


    function npc:draw()
        --love.graphics.draw()
    end

    table.insert(npcs, npc)
end

function npcs:draw()

    for _,n in ipairs(npcs) do
        n:draw()
    end

end
