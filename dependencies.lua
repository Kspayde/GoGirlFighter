
-- To include an external library in Lua, we use the 'require' function
log = require('libs/log')
Input = require('libs/Input')
inspect = require('libs/inspect')








-- Sometimes require returns a result that must be assigned to a variable
-- This is what anim8 does
anim8 = require("libs/anim8/anim8")
bump = require('libs/bump')
-- But sometimes all you have to do is include the file.  Notice how you do not
-- need the .lua file extension, very similar to python
require('sound')
require('input_bindings')
require('weapons')
require('bullet')
require('ship')
require('enemy')
require('game_world')
require('shield')
require('collectible')
require('hud')
