

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    require('dependencies')
    psFont = love.graphics.newFont("PressStart2P.ttf", 8)
    love.graphics.setFont(psFont)

    
    background = love.graphics.newImage('assets/graphics/seamlessspace.PNG')

    world = bump.newWorld()

   local w, h = love.graphics.getDimensions()    
    ship = Ship:Create(math.floor((w / 2) - 48), h - (48*1.5))
    world:add(ship, ship.x, ship.y, ship.w, ship.h)

    bullets = {}
    gameWorld = GameWorld:Create()

    collectibles = {}
    c = Collectible:Create(gCollectibles.spreadBlaster, 60, 20, ship, gameWorld)
    addCollectible(c)

    enemies = {}
    e = Enemy:Create(ship, gameWorld)
    addCollectible(c)



    bgy = 0

    hud = HUD:Create(gameWorld)

    

    
end



function love.update(dt) -- dt is the amount of time in seconds that has passed since the last frame
    bgy = bgy + 1

    if bgy > love.graphics.getHeight() then 
        bgy = bgy - love.graphics.getHeight()
    end  


    ship:update(dt)
    bullet:update(dt)

    for i=#bullets, 1, -1 do 
        local b = bullets[i] --get the current bullet
        b:update(dt) -- update it
        if b.enable == false then  -
            table.remove(bullets, i)
        end 
    end  

    for i=#enemies, 1, -1 do 
        local c = enemies[i] --get the current bullet
        e:update(dt) -- update it
        if c.enable == false then  
            table.remove(enemies, i)
        end 
        

    end  

    



    hud:update(dt)
    require('libs/lovebird').update()     
    
    
end

function love.draw()
    local bgWidth, bgHeight = background:getDimensions()
    love.graphics.draw(background, 0, bgy-bgHeight)
    love.graphics.draw(background, 0, bgy)

      


    for i, c in ipairs(collectibles) do 
        c:draw()
    end

    for i, e in ipairs(enemies) do 
        e:draw()
    end
   

    Enemy:draw()
    ship:draw()

    for i, b in ipairs(bullets) do 
        b:draw()
    end     
    
    hud:draw()
    

end

function addBullet(b)
    --add to the bullet table 
    --add to the collision world
    table.insert(bullets, b)@
    world:add(b, b.x, b.y, b.w, b.h)
end 

function addCollectible(c)
    table.insert(collectibles, c)
    world:add(c, c.x, c.y, c.w, c.h)
end

function removeCollectible(c)
    world:remove(c)
    for i, collectible in ipairs(collectibles) do 
        if collectible == c then 
            table.remove(collectibles, i)
            return
        end
    end
end

function addEnemies(e)
    table.insert(enemies, e)
    world:add(e, e.x, e.y, e.w, e.h)
end

function removeEnemy(e)
    world:remove(e)
    for i, enemy in ipairs(enemies) do 
        if enemy== c then 
            table.remove(enemies, i)
            return
        end
    end
end
