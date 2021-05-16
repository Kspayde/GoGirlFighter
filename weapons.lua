BasicBlaster = {name="basicBlaster"}
BasicBlaster.__index = BasicBlaster

function BasicBlaster:Create(ship)
    local this = {
        ship = ship,
        countdownTime = 0.2,
        countdown = nil,
        sound = Sounds.basicBlaster

    }
    this.countdown = this.countdownTime
    setmetatable(this, self)
    return(this)

end 

function BasicBlaster:update(dt)
    self.countdown = self.countdown - dt

end

function BasicBlaster:handleInput()
    if input:down('action') then 
        if self.countdown <= 0 then
            self:fire()
            log.trace("weapon fired")
            self.countdown = self.countdownTime
        end  
    end

end    

function BasicBlaster:fire()
        local b = Bullet:Create(self.ship.x, self.ship.y, 0, 8, 'basic')
         addBullet(b)
         self.sound:play()
 
end    

preadBlaster = {name="spreadBlaster"}
SpreadBlaster.__index = SpreadBlaster

function SpreadBlaster:Create(ship)
    local this = {
        ship = ship,
        countdownTime = 0.33,
        countdown = nil,
        sound = Sounds.spreadBlaster

    }
    this.countdown = this.countdownTime
    setmetatable(this, self)
    return(this)

end 

function SpreadBlaster:update(dt)
    self.countdown = self.countdown - dt

end

function SpreadBlaster:handleInput()
    if input:pressed('action') then 
        if self.countdown <= 0 then
            self:fire()
            log.trace("weapon fired")
            self.countdown = self.countdownTime
        end  
    end

end    

function SpreadBlaster:fire()
    local b1 = Bullet:Create(self.ship.x, self.ship.y, 0, 8, 'spread')
    local b2 = Bullet:Create(self.ship.x, self.ship.y, -4, 7, 'spread')
    local b3 = Bullet:Create(self.ship.x, self.ship.y, 4, 7, 'spread')

         addBullet(b1)
         addBullet(b2)
         addBullet(b3)
         self.sound:play()
 
end



MegaBlaster = {name="megaBlaster"}
MegaBlaster.__index = MegaBlaster

function MegaBlaster:Create(ship)
    local this = {
        ship = ship,
        countdownTime = 0.33,
        countdown = nil,
        sound = Sounds.MegaBlaster

    }
    this.countdown = this.countdownTime
    setmetatable(this, self)
    return(this)

end 

function MegaBlaster:update(dt)
    self.countdown = self.countdown - dt

end

function MegaBlaster:handleInput()
    if input:pressed('action') then 
        if self.countdown <= 0 then
            self:fire()
            log.trace("weapon fired")
            self.countdown = self.countdownTime
        end  
    end

end    

function MegaBlaster:fire()
    local b1 = Bullet:Create(self.ship.x, self.ship.y, 0, 8, 'mega')
    local b2 = Bullet:Create(self.ship.x, self.ship.y, -4, 7, 'mega')
    local b3 = Bullet:Create(self.ship.x, self.ship.y, 4, 7, 'mega')
    local b4 = Bullet:Create(self.ship.x, self.ship.y, 0, -8, 'mega')
    local b5 = Bullet:Create(self.ship.x, self.ship.y, -4, -7, 'mega')
    local b6 = Bullet:Create(self.ship.x, self.ship.y, 4, -7, 'mega')
         -- Here is how to insert an object into a lua table
         -- Use the table.insert function with two parameters:
         -- First, the table you're inserting into
         --Then, the object you're inserting into the table
         addBullet(b1)
         addBullet(b2)
         addBullet(b3)
         addBullet(b4)
         addBullet(b5)
         addBullet(b6)
         self.sound:play()
 
end   


