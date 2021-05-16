local bulletImage = love.graphics.newImage('assets/graphics/laser-bolts.png')
local imgWidth, imgHeight = bulletImage:getDimensions()
local bulletGrid = anim8.newGrid(16, 16, imgWidth, imgHeight)

local bulletAnims = {
    basic = anim8.newAnimation(bulletGrid('1-2', 1), 0.1),
    spread = anim8.newAnimation(bulletGrid('5-6', 2), 0.1),
    --rainbow = anim8.newAnimation(bulletGrid('5-6', 2), 0.1),

}

Bullet = {type="bullet"}
Bullet.__index = Bullet 

function Bullet:Create(x, y, x_speed, y_speed, type, friendly)
    local this = {
        x = x,  
        y = y,
        w = 16,
        h = 16,
        x_speed = x_speed,
        y_speed = y_speed,
        image = bulletImage,
        animation = bulletAnims[type],
        friendly = friendly or true

    }

    setmetatable(this, self)
    return(this)
end 

function Bullet:update(dt)
    self.y = self.y - self.y_speed
    if (self.y < -30) or (self.y > 554) then 
        self.enable = false 
    end 
    self.x = self.x + self.x_speed
    if (self.x < -30) or (self.x > 768) then 
        self.enable = false 
    end
    self.animation:update(dt)  
    
    
    self:handleInput()

end 

function Bullet:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 2, 2)

end  

function BulletFilter(item, other)
    return('cross')
end


function Bullet:handleInput()
    
    local actual_x, actual_y, cols, len = world:move(self, target_x, target_y, bulletFilter)
    self.x = actual_x
    self.y = actual_y
    --Detect and ressolve collision 
    if len > 0 then 
        --we have collosions to resolve
        for _, e in ipairs(cols) do 
            if e.other.type == "collectible" then 
                 e.other:activate(self, gameWorld)
                 gameWorld:addPoints(c.other.points)
                 removeCollectible(c.other)
                 Sounds.explosion:play()
            end

        end 
    end
  

    
end