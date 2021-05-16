local enemyImgae = love.graphics.newImage('graphics/spritesheets/enemies.png')
local imgWidth, imgHeight = enemyImage:getDimensions()
local enemyGrid = anim8.newGrid(64, 32, imgWidth, imgHeight)

local enemyAnims = {
    big = anim8.newAnimation(enemyGrid(1, '1-2'), 0.2),
    medium = anim8.newAnimation(enemygrid(1, '1-2'), 0.2),
    small = anim8.newAnimation(enemyupGrid(1, '1-2'), 0.2)

}


Enemy = {type="Enemy"}
Enemy.__index = Enemy

big = {
    image = "enemy-big.png",
    hits = 4,
    points = 200,
    speed = 300

},
medium = {
    image = "enemy=medium.png",
    hits = 2,
    points =  100,
    speed = 250
},
small = {
    image = "enemy-small.png",
    hits = 1,
    points = 50,
    speed = 200
}


function Enemy:Create(def, x, y, bullet, ship, gameWorld)
    local this = {
        x = x or 0,
        y = y or 0,
        w = 64,
        h = 32,
        animation = enemyAnims[def.animation],
        image = enemyImage,
        speed = def.speed or 0,
        points = def.points or 0,
        action = def.action,
        gameWorld = gameWorld,
        ship = ship,
        spawnTimer = 0,
        spawnTimerMax = 1

    }

    setmetatable(this, self)
    return(this)
end 

function Enemy:update(dt)
    local goalY = self.y + 1
    local actualX, actualY, cols, len = world:move(self, self.x, goalY, function(i, o) return('cross') end)
    self.y = actualY
    self.animation:update(dt)

    if spawnTimer > 0 then 
        spawTimer = spawnTimer - dt 
    else
        spawnEnemy()

end 

function Enemy:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 3, 3)

end 

function Enemy:activate()
    self.action(self.ship, self.gameWorld)
end 

function spawnEnemy()
    y = love.math.random(0, love.graphics.getHeight() - 64)
  enemyType = love.math.random(0, 2)
  if enemyType == 0 then
    enemy = Enemy:new{self.big, update=movelift}
  elseif enemyType == 1 then
    enemy = Enemy:new{self.medium, update=movetoship}
  else
    enemy = Enemy:new{self.small}, update=update}
  end
  table.insert(enemies, enemy)

  spawnTimer = spawnTimerMax

end

function moveLeft(dt)
    self.x = self.x - self.speed * dt
    return moveLeft
end

function moveToship(dt)
    xSpeed = math.sin(math.rad (60)) * self.speed
    ySpeed = math.cos(math.rad (60)) * self.speed
    if (self.y - ship.y) > 10 then
      self.y = self.y - ySpeed * dt
      self.xPos = self.xPos - xSpeed * dt
    elseif (self.y - ship.y) < -10 then
      self.y = self.y + ySpeed * dt
      self.xPos = self.xPos - xSpeed * dt
    else
      self.xPos = self.xPos - self.speed * dt
    end
    return moveToship
  end

  function chargePlayer(dt)
    xDistance = math.abs(self.xPos - ship.xPos)
    yDistance = math.abs(self.yPos - ship.yPos)
    distance = math.sqrt(yDistance^2 + xDistance^2)
    if distance < 150 then
      self.speed = chargeSpeed
      self.angle = 0
      return moveLeft
    end 
    moveToship(self, dt)
    return chargeship
  end

  

  