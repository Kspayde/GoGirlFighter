local powerupImage = love.graphics.newImage('assets/graphics/rainbowstar.png')
local imgWidth, imgHeight = powerupImage:getDimensions()
local powerupGrid = anim8.newGrid(16, 16, imgWidth, imgHeight)

local powerupAnims = {
    spread = anim8.newAnimation(powerupGrid('1-2', 1), 0.2),
    life = anim8.newAnimation(powerupGrid('1-2', 2), 0.2)

}


Collectible = {type="collectible"}
Collectible.__index = Collectible

gCollectibles = {
    spreadBlaster = {
        animation = "spread",
        points = 100,
        action = function(ship, gameWorld)
            ship.weapon = SpreadBlaster:Create(ship)

        end
    },
    extraLife = {
        animation = "life",
        points = 0,
        action = function(ship, gameWorld)
            gameWorld:addlife()
        end 
    }
}


function Collectible:Create(def, x, y, ship, gameWorld)
    local this = {
        x = x or 0,
        y = y or 0,
        w = 16,
        h = 16,
        animation = powerupAnims[def.animation],
        image = powerupImage,
        points = def.points or 0,
        action = def.action,
        ship = ship, 
        gameWorld = gameWorld,
        spawnTimer = 0,
        spawnTimerMax =1

    }

    setmetatable(this, self)
    return(this)
end 

function Collectible:update(dt)
    local goalY = self.y + 1
    local actualX, actualY, cols, len = world:move(self, self.x, goalY, function(i, o) return('cross') end)
    self.y = actualY
    self.animation:update(dt)

end 

function Collectible:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 3, 3)

end 

function Collectible:activate()
    self.action(self.ship, self.gameWorld)
end 

function spawnCollectables()
    y = love.math.random(0, love.graphics.getHeight() - 64)
  enemyType = love.math.random(0, 2)
  if enemyType == 0 then
    enemy = Collectable:new{self.big}
  elseif enemyType == 1 then
    enemy = Collectable:new{self.medium}
  else
    enemy = Collectable:new{self.small}
  end
  table.insert(collectables, collectable)

  spawnTimer = spawnTimerMax

end
