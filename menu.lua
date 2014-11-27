--menu.lua
local composer=require("composer")
local scene = composer.newScene()

local titleLogo
local menuColorFlags 
local startBtnsPlayGame
local startBtnsOptions
local startBtnsAbout

music=nil
bobby=nil

audio.stop( )            
music = audio.loadStream( 'anthems/magee-gameover.mp3' ) 
bobby = audio.play(music,{loops=-1})


local colorFlagsSpriteCoords = require("lua-sheets.title-menu")
local colorFlagsSheet = graphics.newImageSheet( "images/title-menu.png", colorFlagsSpriteCoords:getSheet() )

local colorFlagsSeq = {
    { name = "colorflags", frames={1,2,3,4,5,6,7,8,9}, time=500, loopCount=0},    
}

local startBtnSeq = {
    { name = "playgame", frames={3,4}, time=500 },
    { name = "tutorial", frames={5,6}, time=500 },
    { name = "about", frames={1,2}, time=500 }
}

local startBtnsSpriteCoords = require("lua-sheets.btns-menu")

local startBtnsPlayGameSheet = graphics.newImageSheet( "images/btns-menu.png", startBtnsSpriteCoords:getSheet() )
local startBtnsOptionsSheet = graphics.newImageSheet( "images/btns-menu.png", startBtnsSpriteCoords:getSheet() )
local startBtnsAboutSheet = graphics.newImageSheet( "images/btns-menu.png", startBtnsSpriteCoords:getSheet() )


local currentObject
local boundaryCheck = false

local function myTouchListener( event )
    if event.phase == "began" then      
        print("began phase")
        -- event.target.alpha = 0.5
        -- event.target:setFrame( 1 )
        currentObject = event.target

        -- Can't remember what this was for?
        display.getCurrentStage():setFocus(event.target)

    elseif event.phase == "ended" or event.phase == "cancelled" then
        print("end phase")
        -- event.target.alpha = 1
        
        if boundaryCheck == true then 
            local goto = event.target.gotoScene
            composer.gotoScene ( goto, { effect = defaultTransition } )

        end

        currentObject:setFrame(1)
        currentObject = nil
        
        -- Can't remember what this was for?
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
            boundaryCheck = false
        else
            currentObject:setFrame( 2 )
            -- print("Its in")
            boundaryCheck = true
        end   
    end     
end


local function eraseSplash()
   titleLogo.alpha=1
    transition.to(startBtnsPlayGame, {time=400,alpha=.98})          
    transition.to(startBtnsOptions, {time=400,alpha=.98}) 
    transition.to(startBtnsAbout, {time=400,alpha=.98})        

      -- startBtnsAbout:addEventListener("tap",tapBtn)
      -- startBtnsPlayGame:addEventListener("tap",tapBtn)
      -- startBtnsOptions:addEventListener("tap",tapBtn)       
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

  menuColorFlags = display.newSprite(colorFlagsSheet,colorFlagsSeq)
  menuColorFlags.x=_W/2; menuColorFlags.y=70
  menuColorFlags:setSequence("colorflags")
  menuColorFlags.alpha = 0.88
  menuColorFlags:play()

  function animationPop(event)
      local thisAnimation = event.target
      if (thisAnimation.frame == 1) then
        thisAnimation.alpha = .9
      elseif (thisAnimation.frame == 3) then
        thisAnimation.alpha=1
      elseif ( event.phase == "loop" ) then
        thisAnimation.alpha = .3
      end
  end
  menuColorFlags:addEventListener("sprite", animationPop)

	local offsetStartBtns = 20

	startBtnsPlayGame = display.newSprite( startBtnsPlayGameSheet, startBtnSeq )
	startBtnsPlayGame:addEventListener( "touch", myTouchListener )
	startBtnsPlayGame.x=_W/2 ;startBtnsPlayGame.y=(_H/2)+offsetStartBtns
	startBtnsPlayGame:setSequence( "playgame" )
	startBtnsPlayGame:setFrame( 1 )
  startBtnsPlayGame.alpha=0
  startBtnsPlayGame.gotoScene="game"


	startBtnsOptions= display.newSprite( startBtnsOptionsSheet, startBtnSeq )
	startBtnsOptions:addEventListener( "touch", myTouchListener )
	startBtnsOptions.x=_W/2 ;startBtnsOptions.y=(_H/2+50)+offsetStartBtns
	startBtnsOptions:setSequence( "tutorial" )
	startBtnsOptions:setFrame( 1 )
  startBtnsOptions.alpha=0
  startBtnsOptions.gotoScene="options"

	startBtnsAbout= display.newSprite( startBtnsAboutSheet, startBtnSeq )
	startBtnsAbout:addEventListener( "touch", myTouchListener )
	startBtnsAbout.x=_W/2 ;startBtnsAbout.y=(_H/2+100)+offsetStartBtns
	startBtnsAbout:setSequence( "about" )
	startBtnsAbout:setFrame( 1 )
  startBtnsAbout.alpha=0
  startBtnsAbout.gotoScene="about"

  self.view:insert(titleLogo)	-- BACKGROUND NOT TITLE !!! CHANGE NAME
  self.view:insert(menuColorFlags) 
	self.view:insert(startBtnsPlayGame)
	self.view:insert(startBtnsOptions)
	self.view:insert(startBtnsAbout)	
end

function scene:show( event )
	if event.phase == "will" then
      --Runtime:addEventListener("enterFrame", checkMemory)
    elseif event.phase == "did" then
	  timer.performWithDelay(300,eraseSplash,1)

      -- ALSO IN ERASESPLASH>>>>????
      -- COMPARE WITH gameover.lua


      -- startBtnsAbout:addEventListener("touch",doFunction)
      -- startBtnsPlayGame:addEventListener("touch",doFunction)
      -- startBtnsOptions:addEventListener("touch",doFunction) 
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