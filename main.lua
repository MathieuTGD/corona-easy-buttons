-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------




buttons = require "buttons"


local function myCallback () 
	print("Called the callback!")
end

bt = buttons.createTextButton("Un test", {size=50, callback=myCallback})
bt.y = 100

bt2 = buttons.createTextButton("Un autre Bouton", {size=12, callback=myCallback})
bt2.y = 200

