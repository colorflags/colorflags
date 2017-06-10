local composer = require( "composer" )
local scene = composer.newScene()

-- create()
function scene:create( event )
    local sceneGroup = self.view
    
    local a = display.newRect(0, 0, 500, 500)
    a:setFillColor(0, 0, 1)
    
    sceneGroup:insert(a)
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
end
 
function scene:show( event )
     local parent = event.parent
     local phase = event.phase
     print(parent.cumboy)
     if "will" == phase then
--         parent:pause()
     else  -- did phase
--          print( parent.currentLevel )
     end
end

function scene:hide( event )
    local parent = event.parent
    local phase = event.phase

    if "did" == phase then
--        parent:resume()
    end
end 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene