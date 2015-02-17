--menu.lua
local composer=require("composer")
local scene = composer.newScene()

local titleLogo 
local startBtnsPlayGame
local startBtnsOptions
local startBtnsAbout


 music=nil
 soundOn=false
print("HeightModeTop")
 print(heightModeTop)

local startBtnSeq = {
    { name = "playgame", frames={5,6}, time=500 },
    { name = "options", frames={3,4}, time=500 },
    { name = "about", frames={1,2}, time=500 }
}

local startBtnsSpriteCoords = require("lua-sheets.start-btns")

local startBtnsPlayGameSheet = graphics.newImageSheet( "images/start-btns.png", startBtnsSpriteCoords:getSheet() )
local startBtnsOptionsSheet = graphics.newImageSheet( "images/start-btns.png", startBtnsSpriteCoords:getSheet() )
local startBtnsAboutSheet = graphics.newImageSheet( "images/start-btns.png", startBtnsSpriteCoords:getSheet() )


local function tapBtn(e)
  local goto = e.target.gotoScene
  composer.gotoScene(goto, {effect=defaultTransition} )
  return true
end



local currentObject

local function myTouchListener( event )
    if event.phase == "began" then      
        print("began phase")
        -- event.target.alpha = 0.5

        -- event.target:setFrame( 1 )
        currentObject = event.target

        display.getCurrentStage():setFocus(event.target)
    elseif event.phase == "ended" or event.phase == "cancelled" then
        print("end phase")
        -- event.target.alpha = 1
        
        currentObject:setFrame(1)
        currentObject = nil
        
        display.getCurrentStage():setFocus(nil)

    end
end


local function doFunction(e)
    if currentObject ~= nil then
        if e.x < currentObject.contentBounds.xMin or
            e.x > currentObject.contentBounds.xMax or
            e.y < currentObject.contentBounds.yMin or
            e.y > currentObject.contentBounds.yMax then
            currentObject:setFrame( 1 )
            -- print("Its out")
        else
            currentObject:setFrame( 2 )
            -- print("Its in")
        end        
    else
        -- composer.gotoScene ( "game", { effect = defaultTransition } )
        -- print("event data to this function has been discontinued")
    end
    -- print(event.phase)
end






local function eraseSplash()
   titleLogo.alpha=1
 
   transition.to(startBtnsAbout, {time=400,alpha=1})        
   transition.to(startBtnsPlayGame, {time=400,alpha=1})          
   transition.to(startBtnsOptions, {time=400,alpha=1}) 
      startBtnsAbout:addEventListener("tap",tapBtn)
      startBtnsPlayGame:addEventListener("tap",tapBtn)
      startBtnsOptions:addEventListener("tap",tapBtn)       
      startBtnsAbout:addEventListener("touch",doFunction)
      startBtnsPlayGame:addEventListener("touch",doFunction)
      startBtnsOptions:addEventListener("touch",doFunction)  

  --   startBtnsAbout.alpha=0
--  startBtnsOptions.alpha=0
 -- startBtnsPlayGame.alpha=0
          
end

local function checkMemory(e)
  collectgarbage();
  print("Memory usage " .. collectgarbage("count"));
  print("Texture memory usage " .. system.getInfo("textureMemoryUsed")/1024/1024 .. "MB")
end

function scene:create( event )
	titleLogo = display.newImageRect( "images/start-menuWTF.png", 568, 320 )
	titleLogo.anchorX=0.5
	titleLogo.anchorY=0.5
	titleLogo.x = _W/2
	titleLogo.y = _H/2	
	titleLogo.alpha=0

	-- Taken directly from options.lua

	local offsetStartBtns = 38

	startBtnsPlayGame = display.newSprite( startBtnsPlayGameSheet, startBtnSeq )
	startBtnsPlayGame:addEventListener( "touch", myTouchListener )
	startBtnsPlayGame.x=_W/2 ;startBtnsPlayGame.y=(_H/2)+offsetStartBtns
	startBtnsPlayGame:setSequence( "playgame" )
	startBtnsPlayGame:setFrame( 1 )
  startBtnsPlayGame.alpha=0
  startBtnsPlayGame.gotoScene="game"


	startBtnsOptions= display.newSprite( startBtnsOptionsSheet, startBtnSeq )
	startBtnsOptions:addEventListener( "touch", myTouchListener )
	startBtnsOptions.x=_W/2 ;startBtnsOptions.y=(_H/2+46)+offsetStartBtns
	startBtnsOptions:setSequence( "options" )
	startBtnsOptions:setFrame( 1 )
  startBtnsOptions.alpha=0
  startBtnsOptions.gotoScene="options"

	startBtnsAbout= display.newSprite( startBtnsAboutSheet, startBtnSeq )
	startBtnsAbout:addEventListener( "touch", myTouchListener )
	startBtnsAbout.x=_W/2 ;startBtnsAbout.y=(_H/2+88)+offsetStartBtns
	startBtnsAbout:setSequence( "about" )
	startBtnsAbout:setFrame( 1 )
  startBtnsAbout.alpha=0
  startBtnsAbout.gotoScene="about"



    self.view:insert(titleLogo)	
	self.view:insert(startBtnsPlayGame)
	self.view:insert(startBtnsOptions)
	self.view:insert(startBtnsAbout)	

end



function scene:show( event )
	if event.phase == "will" then
      --Runtime:addEventListener("enterFrame", checkMemory)
  --    btnPlay:addEventListener("tap",tapBtn)
    --  btnOptions:addEventListener("tap",tapBtn)
    --  btnAbout:addEventListener("tap",tapBtn)    
    elseif event.phase == "did" then
      eraseSplash()
	 -- timer.performWithDelay(300,eraseSplash,1)
	end
end

function scene:hide( event )


  if event.phase=="will" then


    composer.removeScene("menu",false)   
  end  
end

function scene:destroy( event )
	local group = self.view
	
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-----------------------------------------------------------------------------------------
return scene