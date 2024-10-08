menu = {}

function menu:draw()

    local startBG = love.graphics.newImage('sprites/background.jpg')

    if gamestate == 0 then
        --love.graphics.setFont(fonts.pause1) -- get fonts later
        love.graphics.draw(startBG)

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 100, 350, 200, 40)
        setWhite() -- reset colors
        love.graphics.printf("Start Game", 150, 363, 100, "center")

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 100, 405, 200, 40)
        setWhite() -- reset colors
        love.graphics.printf("Options", 150, 418, 100, "center")
        
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 100, 460, 200, 40)
        setWhite() -- reset colors
        love.graphics.printf("Quit Game", 150, 473, 100, "center")

        setWhite() -- reset colors
    end
end

function menu:select(key)
    if gamestate == 0 and key == 'enter' then
        loadMap('TestMap',0,0)
        gamestate = 1
    else return end

    -- Testing destinations (be sure to remove!)
    --[[
    if key == "1" then
        loadMap("test")
    elseif key == "2" then
        loadMap("test5")
    elseif key == "3" then
        loadMap("test2")
    elseif key == "4" then
        loadMap("testDungeon2", 408, 494)
    end
    ]]
end