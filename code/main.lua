require "physics"
require "Car"
require "BrickWall"

function startGame()
	physics.start()
	physics.setDrawMode( "normal" )
	physics.setGravity( 0, 0 )
	
	stage = display.getCurrentStage()
	
	car = Car:new()
	car.x = stage.width / 2
	car.y = stage.height / 2
	
	redDot = display.newImage("red-circle.png")
	redDot.isVisible = false
	
	-- TODO: make this timer end
	timer.performWithDelay(3000, makeBricks, 0)
	
	BrickWall:new(100, stage.height - 200, 4, 6)
	
	Runtime:addEventListener("touch", onTouch)
end

function onTouch(event)
	if event.phase == "began" then
		redDot.isVisible = true
		car:follow(true)
	end
	
	if event.phase == "began" or event.phase == "moved" then
		redDot.x = event.x
		redDot.y = event.y
		car:setDestination(event.x, event.y)
	end
	
	if event.phase == "ended" or event.phase == "cancelled" then
		redDot.isVisible = false
		car:follow(false)
	end	
end

function makeBricks()
	local ran = math.random()
	local randomX = stage.width * ran
	local randomY = stage.height * ran
	randomX = math.max(50, randomX)
	randomY = math.max(50, randomY)
	BrickWall:new(randomX, randomY, 4, 6)
end

startGame()