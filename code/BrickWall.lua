BrickWall = {}

function BrickWall:new(x, y, rows, cols)
	
	local r = 1
	local c = 1
	local origX = x
	local origY = y
	local startX = origX
	local startY = origY
	while r <= rows do
		local brick
		c = 1
		while c <= cols do
			brick = display.newImage("brick.png")
			brick.x = startX
			brick.y = startY
			
			-- [jwarden 10.29.2011] NOTE: realistic bricks, but slows the car down too much
			--[[
			physics.addBody( brick, { density = 1, friction = 0.3, bounce = 0.1, 
										bodyType = "dynamic", 
										isBullet = false,
									} )
			brick.linearDamping = 5
			brick.isFixedRotation = false
			brick.angularDamping = 2
			]]--
			
			physics.addBody( brick, { density = 1, friction = 0.2, bounce = 0.1, 
										bodyType = "dynamic", 
										isBullet = false,
									} )
			brick.linearDamping = 2
			brick.isFixedRotation = false
			brick.angularDamping = 1
			
			startX = startX + brick.width
			c = c + 1
		end
		startX = origX
		startY = startY + brick.height
		r = r + 1
	end
end

return BrickWall