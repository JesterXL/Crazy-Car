require "physics"

Car = {}

function Car:new()
	local car = display.newImage("car.png")
	car.reachedDestination = false
	car.targetX = 0
	car.targetY = 0
	car.speed = 30
	
	function car:setDestination(x, y)
		self.targetX = x
		self.targetY = y
		self.reachedDestination = false
	end
	
	function car:follow(turnOn)
		if turnOn == true then
			Runtime:addEventListener("enterFrame", self)
		else
			Runtime:removeEventListener("enterFrame", self)
		end
	end
	
	function car:getRotation()
		local rot = math.atan2(self.targetY - self.y, self.targetX - self.x) / math.pi * 180 - 90
		return rot
	end
	
	function car:enterFrame(event)
		
		-- [jwarden 10.26.2011] NOTE: How you do it in Flash...
		--[[
		self.rotation = self:getRotation()

		local deltaX = self.x - self.targetX
		local deltaY = self.y - self.targetY
		local dist = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))

		local moveX = self.speed * (deltaX / dist)
		local moveY = self.speed * (deltaY / dist)

		if (math.abs(moveX) > dist or math.abs(moveY) > dist) then
			self.x = self.targetX
			self.y = self.targetY
		else
			self.x = self.x - moveX
			self.y = self.y - moveY
		end
		]]--
		
		-- NOTE: How you do it in Corona
		
		-- TODO: figure out good rotation
		--local targetRot = self:getRotation()
		--local deltaRot = targetRot - self.rotation
		--print("deltaRot: ", deltaRot)
		--self.rotation = self.rotation - math.min(self.speed, deltaRot)
		self.rotation = self:getRotation()
		
		local deltaX = self.targetX - self.x
		local deltaY = self.targetY - self.y
		local dist = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))

		local moveX = self.speed * (deltaX / dist)
		local moveY = self.speed * (deltaY / dist)

		if (math.abs(moveX) > dist or math.abs(moveY) > dist) then
			self.x = self.targetX
			self.y = self.targetY
		else
			self:applyForce(deltaX, deltaY, self.x, self.y)
		end
	end
	
	physics.addBody( car, { density = 2, friction = 0.3, bounce = 0.2, 
								bodyType = "kinematic", 
								isBullet = true,
							} )
	car.linearDamping = 2
	car.isFixedRotation = false
	car.angularDamping = 1
	
	return car
end

return Car