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
music = audio.loadStream( 'anthems/Magee_ColorFlags2_B_7.mp3' ) 
bobby = audio.play(music,{loops=-1})

 soundOn=false
print("HeightModeTop")
 print(heightModeTop)

local colorFlagsSpriteCoords = require("lua-sheets.title-menu")
local colorFlagsSheet = graphics.newImageSheet( "images/title-menu.png", colorFlagsSpriteCoords:getSheet() )

local colorFlagsSeq = {
    { name = "colorflags", frames={1,2,3,4,5,6,7,8,9}, time=500, loopCount=0},    
}

local startBtnSeq = {
    { name = "playgame", frames={8,9}, time=500 },
    { name = "tutorial", frames={5,6}, time=500 },
    { name = "about", frames={1,2}, time=500 }
}

local startBtnsSpriteCoords = require("lua-sheets.menu-btns")

local startBtnsPlayGameSheet = graphics.newImageSheet( "images/menu-btns.png", startBtnsSpriteCoords:getSheet() )
local startBtnsOptionsSheet = graphics.newImageSheet( "images/menu-btns.png", startBtnsSpriteCoords:getSheet() )
local startBtnsAboutSheet = graphics.newImageSheet( "images/menu-btns.png", startBtnsSpriteCoords:getSheet() )


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
        
        -- BOUNDRY CHECK
        if boundaryCheck == true then 
            local goto = event.target.gotoScene

            if goto == "start" and event.target == startBtnsPlayGame then
              composer.showOverlay( goto, { isModal= true})
            else
              composer.gotoScene ( goto, { effect = defaultTransition } )
            end  
        end
        
        if currentObject ~= nil then
          currentObject:setFrame(1)
          currentObject = nil
        end 
        -- Can't remember what this was for?
        display.getCurrentStage():setFocus(nil) 

    end
end


local function doFunction(e)
     print("doFunction")
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


  --   startBtnsAbout.alpha=0
--  startBtnsOptions.alpha=0
 -- startBtnsPlayGame.alpha=0
          
end


function addFunction()

  startBtnsAbout.alpha=1
    startBtnsPlayGame.alpha=1
      startBtnsOptions.alpha=1

 ---       startBtnsAbout:addEventListener("touch",doFunction)
  --    startBtnsPlayGame:addEventListener("touch",doFunction)
   --   startBtnsOptions:addEventListener("touch",doFunction)  
end

function removeFunction()
  startBtnsAbout.alpha=0
    startBtnsPlayGame.alpha=0
      startBtnsOptions.alpha=0
     -- startBtnsAbout:removeEventListener("touch",doFunction)
   --   startBtnsPlayGame:removeEventListener("touch",doFunction)
   --   startBtnsOptions:removeEventListener("touch",doFunction)  
end

local function checkMemory(e)
  collectgarbage();
  print("Memory usage " .. collectgarbage("count"));
  print("Texture memory usage " .. system.getInfo("textureMemoryUsed")/1024/1024 .. "MB")
end


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

function scene:create( event )
  local sceneGroup=self.view
  print("a")
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

  menuColorFlags:addEventListener("sprite", animationPop)

  local offsetStartBtns = 20

  startBtnsPlayGame = display.newSprite( startBtnsPlayGameSheet, startBtnSeq )
  startBtnsPlayGame:addEventListener( "touch", myTouchListener )
  startBtnsPlayGame.x=_W/2 ;startBtnsPlayGame.y=(_H/2)+offsetStartBtns
  startBtnsPlayGame:setSequence( "playgame" )
  startBtnsPlayGame:setFrame( 1 )
  startBtnsPlayGame.alpha=0
  startBtnsPlayGame.gotoScene="start"



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

  sceneGroup:insert(titleLogo) -- BACKGROUND NOT TITLE !!! CHANGE NAME
  sceneGroup:insert(menuColorFlags) 
  sceneGroup:insert(startBtnsPlayGame)
  sceneGroup:insert(startBtnsOptions)
  sceneGroup:insert(startBtnsAbout)  


   startBtnsAbout:addEventListener("touch",doFunction)
   startBtnsPlayGame:addEventListener("touch",doFunction)
   startBtnsOptions:addEventListener("touch",doFunction) 
end

function scene:show( event )
    local sceneGroup=self.view
    local phase = event.phase
  if event.phase == "will" then
    print("b")
      --Runtime:addEventListener("enterFrame", checkMemory)
    elseif event.phase == "did" then
      print("c")
    timer.performWithDelay(300,eraseSplash,1)

      -- ALSO IN ERASESPLASH>>>>????
      -- COMPARE WITH gameover.lua


  end
end

function scene:hide( event )
      local sceneGroup=self.view
    local phase = event.phase

  if event.phase=="will" then

print("d")
    composer.removeScene("menu",false)   
  end  
end

function scene:destroy( event )
  local group = self.view
  print("e")
  
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-----------------------------------------------------------------------------------------
return scene