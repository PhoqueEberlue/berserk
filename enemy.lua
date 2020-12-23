Enemy = {}
Enemy.__index = Enemy

function Enemy:new()
    local enemy = {x = 1000, y = 300}
    setmetatable(enemy, Enemy)
    enemy.dmg = false
    enemy.hp = 100
    return enemy
end

function Enemy:update()

end

function Enemy:draw()
    if self.dmg then
        love.graphics.rectangle("fill", self.x, self.y, 200, 200)
    else
        love.graphics.rectangle("line", self.x, self.y, 200, 200)
    end
end

function Enemy:collide(pos)
    local x1 = nil
    local x2 = nil
    if pos.direction == 1 then
        x1 = pos.x + pos.width
        x2 = pos.x
    else
        x1 = pos.x
        x2 = pos.x - pos.width
    end
    if x1 > self.x and x2 < self.x + 200 then
        if pos.y + pos.height > self.y and pos.y < self.y + 200 then
            if self.dmg then
                self.dmg = false
            else
                self.dmg = true
            end
        end
    end
end