

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    require('dependencies')
    psFont = love.graphics.newFont("PressStart2P.ttf", 8)
    love.graphics.setFont(psFont)

    -- This makes sure that when graphics are scaled UP, that it does not try to smooth
    -- out the pixels.  We want the lower res pixels for our retro inspired shooter
    
    background = love.graphics.newImage('graphics/backgrounds/space-background.png')

    world = bump.newWorld()
    -- instead of using a simple table called 'ship' we're now using a 
    -- full blown Ship class to represent the ship.  See ship.lua

   local w, h = love.graphics.getDimensions()    
    ship = Ship:Create(math.floor((w / 2) - 16), h - (24*3))
    world:add(ship, ship.x, ship.y, ship.w, ship.h)

    bullets = {}
    gameWorld = GameWorld:Create()

    collectibles = {}
    c = Collectible:Create(gCollectibles.spreadBlaster, 60, 20, ship, gameWorld)
    addCollectible(c)

    --table of enemies 
    --enemies{}

    --effects table for explosions and graphical effects that are not in the collision world
    --effects = {}

    bgy = 0

    hud = HUD:Create(gameWorld)

    

    
end



function love.update(dt) -- dt is the amount of time in seconds that has passed since the last frame
    bgy = bgy + 1

    if bgy > love.graphics.getHeight() then 
        bgy = bgy - love.graphics.getHeight()
    end  

    -- All we have to do to update the ship is call its update function
    -- It will handle itself
    ship:update(dt)

    -- this will loop through an INDEXED list (more like a Python list)
    -- get ot Iparis? Indexed pairs?
    -- i will be assigned the indexed number (1 up to the size of the table)
    -- b will be assigned the actual item in that index
    --for i, b in ipairs(bullets) do 
    --    b:update(dt)
    --end  

    --To get the length of a table, use '#' before the variable name
    --numberofCats = #catsTable
    ---- This counts down from the length of the table to 1
    for i=#bullets, 1, -1 do 
        local b = bullets[i] --get the current bullet
        b:update(dt) -- update it
        if b.enable == false then  -- if its off screen, delete it
            -- TO REMOVE an item from a Lua table, use tablelove.filesystem.remove
            -- First parameter is the table name
            -- Second parameter is the index number of the item to be removed
            table.remove(bullets, i)
        end 
    end  

    --To get the length of a table, use '#' before the variable name
    --numberofCats = #catsTable
    ---- This counts down from the length of the table to 1
    for i=#collectibles, 1, -1 do 
        local c = collectibles[i] --get the current bullet
        c:update(dt) -- update it
        if c.enable == false then  -- if its off screen, delete it
            -- TO REMOVE an item from a Lua table, use tablelove.filesystem.remove
            -- First parameter is the table name
            -- Second parameter is the index number of the item to be removed
            table.remove(collectibles, i)
        end 
    end  

    hud:update(dt)
    require('libs/lovebird').update()     
    
    
end

function love.draw()
    local bgWidth, bgHeight = background:getDimensions()
    love.graphics.draw(background, 0, bgy-bgHeight*3, 0, 3, 3)
    love.graphics.draw(background, 0, bgy, 0, 3, 3)

      


    for i, c in ipairs(collectibles) do 
        c:draw()
    end
   
    -- Again, all we need to do is call the ship's draw function and it will
    -- take care of drawing itself 
    ship:draw()

    for i, b in ipairs(bullets) do 
        b:draw()
    end     
    
    hud:draw()
    --love.graphics.print("#Bullets = " .. #bullets, 20, 20)

end

function addBullet(b)
    --add to the bullet table 
    --add to the collision world
    table.insert(bullets, b)
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

