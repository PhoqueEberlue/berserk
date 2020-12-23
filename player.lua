require("animation")

Player = {}
Player.__index = Player

function Player:new()
    local player = {}
    setmetatable(player, Player)
    player.position = {x = 500, y = 500, direction = 1}
    player.speed = 800
    player.last_input = nil
    player.end_anim = true
    player.animation = {standing = {}, attack = {}, dash = {}}
    player.animation.standing.staight = love.graphics.newImage("guts_standing.png")
    player.animation.running = Animation:new(love.graphics.newImage("guts_running.png"), 216, 118, 0.8)
    player.animation.attack.front = Animation:new(love.graphics.newImage("guts_attack_front.png"), 389, 242, 0.35)
    player.animation.dash.front = Animation:new(love.graphics.newImage("guts_dash_front.png"), 190, 107, 0.30)
    return player
end

function Player:update(dt)
    if self.last_input ~= nil then
        if self.last_input == "running" then
            self.animation.running:update(dt)
        elseif self.last_input == "attack_front" then
            self.end_anim = self.animation.attack.front:update(dt)
        elseif self.last_input == "dash_front" then
            self.end_anim = self.animation.dash.front:update(dt)
            self.position.x = self.position.x + 1300 * dt * self.position.direction
        end
    end
    if self.end_anim then
        if love.mouse.isDown(1) then
            self.end_anim = false
            self.last_input = "attack_front"
        elseif love.mouse.isDown(2) then
            self.end_anim = false
            self.last_input = "dash_front"
        elseif love.keyboard.isDown("q") then
            self.position.x = self.position.x - self.speed * dt
            self.last_input = "running"
            self.position.direction = -1
        elseif love.keyboard.isDown("d") then
            self.position.x = self.position.x + self.speed * dt
            self.last_input = "running"
            self.position.direction = 1
        elseif self.end_anim then
            self.last_input = nil
        end
    end
end

function Player:draw()
    if self.last_input == "running" and self.position.direction == 1 then
        self.animation.running:draw(self.position)
    elseif self.last_input == "running" and self.position.direction == -1 then
        self.animation.running:draw(self.position)
    elseif self.last_input == "attack_front" then
        self.animation.attack.front:draw(self.position)
        love.graphics.rectangle("line", self.position.x, self.position.y - 240, 195, 225)
    elseif self.last_input == "dash_front" then
        self.animation.dash.front:draw(self.position)
    elseif self.last_input == nil then
        love.graphics.draw(self.animation.standing.staight, self.position.x, self.position.y, 0, -self.position.direction, 1, 153/2, 192)
        --love.graphics.rectangle("line", self.position.x - 153/2, self.position.y - 192, 153, 192) -- show hitbox
    end
end

function Player:isAttacking()
    if self.last_input == "attack_front" then
        return true
    else
        return false
    end
end

function Player:getAttack()
    return {x = self.position.x, y = self.position.y - 240, width = 195, height = 225, direction = self.position.direction}
end