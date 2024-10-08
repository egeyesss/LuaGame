function drawHUD()
    drawHP()
    drawMana()
    --drawCoins()
end

function drawHP()

    love.graphics.setColor(0,0,0) -- hp bar (empty)
    love.graphics.rectangle('fill', 8, 20, 120, 15)
    love.graphics.setColor(1,0,0) -- hp bar 
    love.graphics.rectangle('fill', 8, 20, (player.health/player.maxHealth) * 120 , 15)
    love.graphics.setColor(1,1,1) -- hp bar (number)
    love.graphics.print("50/50", 56, 20,r,sx,sy,ox,oy)

    setWhite() -- reset colors

end

function drawMana()

    love.graphics.setColor(0,0,0) -- mana bar (empty)
    love.graphics.rectangle('fill', 8, 40, 120, 15)
    love.graphics.setColor(0,0,1) -- mana bar
    love.graphics.rectangle('fill', 8, 40, (player.mana/player.maxMana) * 120, 15)
    love.graphics.setColor(1,1,1) -- mana bar (number)
    love.graphics.print("10/10", 56, 40,r,sx,sy,ox,oy)

    setWhite()-- reset colors

end
