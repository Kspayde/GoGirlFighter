Shield = {}
Shield.__index = Shield

function Shield:Create(ship)
  local this = {
    ship = ship,
    duration = 5,
    radius = 38,
    colors = {
      {1,0,0,1}, -- red
      {0,1,0,1}, -- blue
      {0,0,1,1}  -- green
    },
    colorIndex = 1,
    active = false
  }
  setmetatable(this, self)
  return(this)
end

function Shield:activate()
  if self.duration > 0 then 
    self.active = true
  else
    self.active = false
  end
end

function Shield:deActivate()
    self.active = false
end

function addTime()
  self.duration = self.duration + t
end



function Shield:update(dt)
  if self.active then
    self.colorIndex = self.colorIndex + 1
    if self.colorIndex > #self.colors then
      self.colorIndex = 1
    end
    self.duration = self.duration - dt
    if self.duration <= 0 then 
      self:deActivate()
    end
  end
end

function Shield:draw()
  if self.active then
    love.graphics.push("all")
    love.graphics.setColor(self.colors[self.colorIndex])
    --love.graphics.circle("line", self.ship.x + self.ship.w / 2, self.ship.y + self.ship.h / 2, self.radius)
    love.graphics.circle("line", self.ship.x + (self.ship.w * 3)/2, self.ship.y + (self.ship.h * 3)/3, self.radius)
    love.graphics.pop()
  end
end

