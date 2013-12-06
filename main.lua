-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------




buttons = require "buttons"


local function myCallback () 
	print("Called the callback!")
end

bt = buttons.createTextButton("A big button", {size=50, callback=myCallback})
bt.y = 100

bt2 = buttons.createTextButton("A smaller button", {size=12, width=200, cornerRadius=6, callback=myCallback})
bt2.y = 200

bt3 = buttons.createImageButton("Test", "icon.png", {size=44, callback=myCallback})
bt3.y = 350
bt3.x = display.contentCenterX