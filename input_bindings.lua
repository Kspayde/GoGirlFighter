
input = Input()

input:bind('2', function ()
    love.graphics.captureScreenshot("shmup_" .. os.time() .. ".png")
end    
)

input:bind('a', 'left')
input:bind('d', 'right')
input:bind('w', 'up')
input:bind('s', 'down')

input:bind('space', 'action')
input:bind('f,', 'switch_weapon')
input:bind('c', 'shield')

--input:bind('p', 'pause')
--inout:bind('dpleft' 'left')