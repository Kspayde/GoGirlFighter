HUD = {}
HUD.__index = HUD

function HUD:Create(gameWorld)
    local this = {
        gameWorld = gameWorld



    }

    setmetatable(this, self)
    return(this)
end


function HUD:update()

end

function HUD:draw()
    local w, h = love.graphics.getDimensions() 
    love.graphics.scale(3)
    love.graphics.printf("Score",0,2,math.floor(w/3),"center")
    love.graphics.printf(self.gameWorld.score,0,14,math.floor(w/3),"center")
    love.graphics.scale(1)


end
