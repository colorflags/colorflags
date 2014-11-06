--about.lua
local composer=require("composer")
local scene = composer.newScene()



local function buttonHit(event)
	local goto = event.target.gotoScene
	composer.gotoScene ( goto, { effect = defaultTransition } )
	return true
end

function scene:create( event )
	
	

	local backBtn = makeTextButton("Back", 40, _H-20, {listener=buttonHit, group=group})
	backBtn.gotoScene = "menu"

  self.view:insert(backBtn)
end

function scene:show( event )
	local group = self.view
end

function scene:hide( event )
	if scene.view=="will" then
		   composer.removeScene("options",false)  
		end
end

function scene:destroy( event )
	local group = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
