pause = {}

pause.active = false
pause.scale = scale
pause.alpha = 0
pause.width = 130 * pause.scale
pause.x = love.graphics.getWidth()/2 - (pause.width/2)
pause.y = 40 * pause.scale

pause.trueY = 0 * pause.scale
pause.fadeY = 40 * pause.scale

pause.leftX = love.graphics.getWidth()/2 - (56 * scale)


function pause:init()
    pause.active = false
    pause.scale = scale
    pause.alpha = 0
    pause.width = 130 * pause.scale
    pause.x = love.graphics.getWidth()/2 - (pause.width/2)
    pause.y = 40 * pause.scale

    pause.trueY = 0 * pause.scale
    pause.fadeY = 40 * pause.scale

    pause.textTitle = ""
    pause.textSubtitle = ""

    pause.leftX = love.graphics.getWidth()/2 - (56 * scale)

    if windowWidth < windowHeight then
        pause.scale = scale * 0.8
    end
end

function pause:open()
    self.active = true
    flux.to(pause, 0.25, {alpha = 1}):ease("quadout")
    flux.to(pause, 0.25, {y = pause.trueY}):ease("quadout")

    pause:draw()

    player.walking = false
end

function pause:close()
    self.active = false
    flux.to(pause, 0.25, {alpha = 0}):ease("quadout"):oncomplete(function() pause.active = false end)
    flux.to(pause, 0.25, {y = pause.fadeY}):ease("quadout")

    player.walking = true
end

function pause:toggle()
    if self.active then
        if pause.alpha == 1 then
            gamestate = 1
            pause:close()
        end
    else
        if pause.alpha <= 0 then
            gamestate = 2
            pause:open()
        end
    end
end

function pause:update(dt)
    if pause.active == false then return end

    pause.textTitle = ""
    pause.textSubtitle = ""
    pause.spriteZ = nil
    pause.spriteX = nil

    if pause.gridY == 0 then
    end

    if pause.gridY == 1 then
    end

    local mx, my = love.mouse.getPosition()
    pause.hoverIndex = -1
end

function pause:draw()
    if self.active then
        love.graphics.setColor(0,0,0,0.7 * pause.alpha)
        love.graphics.rectangle("fill", -10, -10, love.graphics.getWidth() + 20, love.graphics.getHeight() + 20)

        -- Resume
        love.graphics.setColor(0,0,1,pause.alpha) -- button color
        love.graphics.rectangle("fill", 100, 350, 200, 40) -- button
        setWhite() -- reset color
        love.graphics.printf("Resume", 150, 363, 100,"center") -- button text

        -- Options
        love.graphics.setColor(0,0,1,pause.alpha) -- button color
        love.graphics.rectangle("fill", 100, 405, 200, 40) -- button
        setWhite() -- reset color
        love.graphics.printf("Options", 150, 418, 100,"center") -- button text

        -- Quit Game
        love.graphics.setColor(0,0,1,pause.alpha) -- button color
        love.graphics.rectangle("fill", 100, 460, 200, 40) -- button
        setWhite() -- reset color
        love.graphics.printf("Quit Game", 150, 473, 100,"center") -- button text

    end
end