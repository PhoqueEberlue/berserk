Animation = {}
Animation.__index = Animation

function Animation:new(image, width, height, duration)
    local animation = {}
    setmetatable(animation, Animation)
    animation.spriteSheet = image
    animation.quads = {}
    animation.width = width
    animation.height = height

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration
    animation.currentTime = 0

    return animation
end

function Animation:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime >= self.duration then
        self.currentTime = self.currentTime - self.duration
        return true
    end
    return false
end

function Animation:draw(position)
    local spriteNum = math.floor(self.currentTime / self.duration * #self.quads) + 1
    love.graphics.draw(self.spriteSheet, self.quads[spriteNum], position.x, position.y, 0, position.direction, 1, self.width/2, self.height)
    --love.graphics.rectangle("line", position.x-self.width/2, position.y-self.height, self.width, self.height) -- show hitbox
end
