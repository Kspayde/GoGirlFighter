GameWorld = {}
GameWorld.__index = GameWorld

function GameWorld:Create()
    local this = {
        lives = 3,
        score = 0

    }

    setmetatable(this, self)
    return(this)
end

function GameWorld:addLife()
    self.lives = self.lives + 1
end 

function GameWorld:removeLife()
    self.lives = self.lives - 1
end 

function GameWorld:addPoints(pts)
    self.score = self.score + pts
end
