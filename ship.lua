
Ship = {type="ship"}
-- Set the __index metamethod equal to itself (don't worry about what this means)
Ship.__index = Ship


function Ship:Create(x, y)
    -
    local this = {
        x = x or 0, -- the x position on screen
        y = y or 0, -- the y position on screen
        w = 48,
        h = 48,
        speed = 5, -- the speed of the ship for movement
        weaponCountdown = 0.2,
        image = love.graphics.newImage("assets/graphics/ship.png"), -- the ship's graphic image
        weapon = nil,
        shield = nil 
    }

    this.weapon = BasicBlaster:Create(this)
    this.shield = Shield:Create(this)

    local imgWidth, imgHeight = this.image:getDimensions()

   its pieces
    -- Each frame is 16 pixels wide by 24 pixels high
    local g = anim8.newGrid(48, 48, imgWidth, imgHeight)

    this.animation = anim8.newAnimation(g('1-2', 1), 0.15)

    -- This line finishes setting the table called 'this' as a class like object
    setmetatable(this, self)

    return(this)
end


function Ship:update(dt)

    
    self.weapon:update(dt)
    self:handleInput()
   
    self.animation:update(dt)
    self.shield:update(dt)
end

function Ship:draw()

    self.animation:draw(self.image, self.x, self.y, 0, 1.5, 1.5)
    self.shield:draw()
end

function shipFilter(item, other)
    return('cross')
end


function Ship:handleInput()
    local target_x = self.x 
    local target_y = self.y 
    if input:down('left') then 
        target_x = self.x - self.speed 
    elseif input:down('right') then 
        target_x = self.x + self.speed
    end
    if input:down('up') then 
        target_y = self.y - self.speed 
    elseif input:down('down') then 
        target_y = self.y + self.speed
    end  

    local actual_x, actual_y, cols, len = world:move(self, target_x, target_y, shipFilter)
    self.x = actual_x
    self.y = actual_y
    --Detect and ressolve collision 
    if len > 0 then 
        --we have collosions to resolve
        for _, c in ipairs(cols) do 
            if c.other.type == "collectible" then 
                 c.other:activate(self, gameWorld)
                 gameWorld:addPoints(c.other.points)
                 removeCollectible(c.other)
                 Sounds.powerup:play()
            end

        end 
    end
  
    
    self.weapon:handleInput()   
    if input:pressed('shield') then 
        self.shield:activate()
    --else
        --self.shield:deActivate()

        
    end

    
end

  

  
