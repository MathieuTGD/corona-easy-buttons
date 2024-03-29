local b = {}

b.emptyCallback = function () print("Nothing Happens...") end

b.createTextButton = function ( text, params )
	local g = display.newGroup()

	g.size = params.size or 15
	g.font = params.font or 'Arial'
	g.callback = params.callback or b.emptyCallback
	g.bgWidth = params.width or display.contentWidth + 100
	g.bgHeight = params.height or g.size + 12
	g.bgColor = params.bgColor or {r=.1, g=.1, b=.1}
	g.bgHighlight = params.bgHighlight or {r=.3, g=.3, b=.3}
	g.textColor = params.textColor or {r=.88, g=.88, b=.88}
	g.textHighlight = params.textHighlight or {r=.3, g=1, b=.3}
	g.cornerRadius = params.cornerRadius or 0

	g.isHighlighted = false

	local button = display.newText(text, display.contentCenterX, g.bgHeight * .5, g.font, g.size)
	button:setFillColor(g.textColor.r, g.textColor.g, g.textColor.b)

	local bg
	if g.cornerRadius > 0 then
		bg = display.newRoundedRect(0, 0, g.bgWidth, g.bgHeight, g.cornerRadius)
	else
		bg = display.newRect(0, 0, g.bgWidth, g.bgHeight)
	end
	bg.x = display.contentCenterX
	bg.y = g.bgHeight * .5
	bg:setFillColor(g.bgColor.r, g.bgColor.g, g.bgColor.b)

	function g:highlight ( )
		if g.isHighlighted == false then
			print("BT: Highlight button...")
			bg:setFillColor(g.bgHighlight.r, g.bgHighlight.g, g.bgHighlight.b)
			button:setFillColor(g.textHighlight.r, g.textHighlight.g, g.textHighlight.b)
			g.isHighlighted = true
		end
	end

	function g:highlightOff ( )
		print("BT: Remove Highlight...")
		bg:setFillColor(g.bgColor.r, g.bgColor.g, g.bgColor.b)
		button:setFillColor(g.textColor.r, g.textColor.g, g.textColor.b)
		g.isHighlighted = false
	end

	function g:touch ( event ) 
		if event.phase == "began" then
			self:highlight()
	        -- set touch focus
	        display.getCurrentStage():setFocus( self )
	        self.isFocus = true
	    elseif self.isFocus then
	        if event.phase == "moved" then
	            if event.y > self.y + self.bgHeight or event.y < self.y then 
	            	print("BT: Touch moved out of button...")
	            	display.getCurrentStage():setFocus( nil )
	            	self.isFocus = nil
	            	self:highlightOff()
	            else 
	            	self.isFocus = true
	            	self:highlight()
	            end

	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            -- reset touch focus
	            print("BT: Event ENDED")
	        	self:highlightOff()
	            display.getCurrentStage():setFocus( nil )
	        	if self.isFocus then
	            	g.callback()
	        	end
	            self.isFocus = nil
	        end
	    end
	    return true
	end
	g:addEventListener("touch", g)

	g:insert(bg)
	g:insert(button)

	return g
end



-- TODO
b.createImageButton = function (text, icon, params )
	local g = display.newGroup()
	g.anchorChildren = true

	g.callback = params.callback or b.emptyCallback
	g.size = params.size or 50

	g.bgHeight = params.height or g.size + 12
	g.bgColor = params.bgColor or {r=.1, g=.1, b=.1}
	g.bgHighlight = params.bgHighlight or {r=.3, g=.3, b=.3}
	g.textColor = params.textColor or {r=.88, g=.88, b=.88}
	g.textHighlight = params.textHighlight or {r=.3, g=1, b=.3}

	local txt = display.newText(text,0,0,"Arial", 12)
	txt.x = g.size * .5
	txt.y = g.size - 9
	txt:setFillColor(g.textColor.r, g.textColor.g, g.textColor.b)

	local ic = display.newImage(icon)
	ic.width = g.size - txt.height - 12
	ic.height = g.size - txt.height - 12
	ic.x = g.size * .5
	ic.y = (ic.height *.5) + 5


	local bg = display.newRoundedRect(g.size/2,g.size/2, g.size, g.size, 4)
	bg.alpha = .75
	bg:setFillColor(g.bgColor.r, g.bgColor.g, g.bgColor.b)

	g:insert(bg)
	g:insert(ic)
	g:insert(txt)

	g.anchorX = .5
	g.anchorY = .5
	return g
end


return b