function love.load()
    require("player")
    require("enemy")
    E = Enemy:new()
    P = Player:new()
    love.window.setFullscreen(true)
    local grey = 100
    love.graphics.setBackgroundColor(grey/255, grey/255, grey/255, 0)
end

function love.update(dt)
    P:update(dt)
    if P:isAttacking() then
        E:collide(P:getAttack())
    end
end

function love.draw()
    P:draw()
    E:draw()
end
