--about.lua
local composer=require("composer")
local scene = composer.newScene()

  local startBtn
  local tutorialBtn
  local cruiseBtn
  local background
  local phaseGroup=display.newGroup()

local menuStart  
  
local menuSeq = {
    { name = "start", frames = {6}, time = 500 },
    { name = "start_anim", frames = {7, 8, 9, 10}, time = 500 },
    { name = "cruise", frames = {1}, time = 500 },
    { name = "cruise_anim", frames = {2, 3, 4, 5}, time = 500 },
    { name = "tutorial", frames = {11}, time = 500 },
    { name = "tutorial_anim", frames = {12, 13, 14, 15}, time = 500 }
}

local menuSpriteCoords = require("lua-sheets.playgame-menu")
local menuStartSheet = graphics.newImageSheet( "images/playgame-menu.png", menuSpriteCoords:getSheet() )

--local function phase4(btn)
--display.remove(btn)
-- btn = display.newText(btn.text,btn.x,btn.y, "federalescortchrome", 35 ) 
--end

  local function phase3(e)
transition.to(e,{time=50, xScale=1,yScale=1})
end


  local function phase2(e)

transition.to(e,{time=50, xScale=.8,yScale=.8,onComplete=phase3}) 
  end

local currentObject
local boundaryCheck = false

local function myTouchListener( event )
    if event.phase == "began" then
        print("begin touch, why such a delay?? because referencing a class?")        
        currentObject = event.target 
        display.getCurrentStage():setFocus(currentObject)
    elseif event.phase == "ended" or event.phase == "cancelled" then
        if currentObject.name == "menuStart" then
            currentObject:setSequence("start")
        elseif currentObject.name == "menuTutorial" then
            currentObject:setSequence("tutorial")
        elseif currentObject.name == "menuCruise" then
            currentObject:setSequence("cruise")
        end
        currentObject:setFrame(1)
        
        if boundaryCheck == true then 
            local goto = currentObject.gotoScene
            composer.gotoScene( goto, { effect = defaultTransition } )
        end
        
        currentObject = nil
        display.getCurrentStage():setFocus(nil)
        boundaryCheck = false
    end
end
 
local function doFunction(e)
    if currentObject ~= nil then
        if e.x < currentObject.contentBounds.xMin or
            e.x > currentObject.contentBounds.xMax or
            e.y < currentObject.contentBounds.yMin or 
            e.y > currentObject.contentBounds.yMax then 
 
            if currentObject.name == "menuStart" then
                currentObject:setSequence("start")
            elseif currentObject.name == "menuTutorial" then
                currentObject:setSequence("tutorial")
            elseif currentObject.name == "menuCruise" then
                currentObject:setSequence("cruise")
            end
            currentObject:setFrame(1)
            boundaryCheck = false
        else
            if boundaryCheck == false then
                if currentObject.name == "menuStart" then
                    currentObject:setSequence("start_anim")
                elseif currentObject.name == "menuTutorial" then
                    currentObject:setSequence("tutorial_anim")
                elseif currentObject.name == "menuCruise" then
                    currentObject:setSequence("cruise_anim")
                end
                currentObject:play()
            end
            boundaryCheck = true
        end
    end
end


local function buttonHit(e)
   
   print("buttonhitdaf")

  if e.phase == "began" then
     print("ButtonHit")
    print(e.target)
  elseif e.phase == "moved" then
    print(e.target)
  elseif e.phase == "ended" then 
    display.remove(phaseGroup)
    composer.removeScene("start",false)
    -- if e.target==startBtn then
    --     display.remove(phaseGroup)
    --   composer.hideOverlay("fade",50) 
    --   print("START") 
    --   composer.removeScene("start",false)
    -- elseif e.target==tutorialBtn then
    --     display.remove(phaseGroup)
    --   composer.hideOverlay("fade",50) 
    -- elseif e.target==cruiseBtn then
    --     display.remove(phaseGroup)
    --   composer.hideOverlay("fade",50) 
    -- end 
   -- composer.removeScene("start",false)

  end 
   -- composer.removeScene("start", true)
 -- display.remove(startBtn)

  -- display.remove(tutorialBtn)
  -- display.remove(cruiseBtn)
    --   display.remove(backgr)        
   
 
  return true
end


--local catchAll

--local function catchAllTaps(event)
--    return true
--end



local function removeIt(e)
       display.remove(e)
end

local function catchAllTaps(event)
    return true
end



function scene:create( event )
      local sceneGroup=self.view
 catchAll=display.newRect(0,0,_W,_H)
 catchAll.alpha=0.8
 catchAll.anchorX=0
 catchAll.anchorY=0
 catchAll.isHitTestable = true
print("1")
 background=display.newRoundedRect(50,50,_W-100,_H-100,3)
 background:setFillColor(64/255,64/255,224/225)   
  background:setStrokeColor( 25/255, 1 ,20/255 )
  background.strokeWidth = 5
      background.x=_W/2
      background.y=_H/2
--      background:toFront()
    
    menuStart = display.newSprite( menuStartSheet, menuSeq )
    menuStart:addEventListener( "touch", myTouchListener )
    menuStart:addEventListener( "touch", doFunction )
    menuStart.x=_W/2 
    menuStart.y=_H/2 - 50
    menuStart:setSequence( "start" )
    menuStart:setFrame( 1 )
    menuStart.name = "menuStart"
    menuStart.gotoScene="game" 
 
    menuTutorial = display.newSprite( menuStartSheet, menuSeq )
    menuTutorial:addEventListener( "touch", myTouchListener )
    menuTutorial:addEventListener( "touch", doFunction )
    menuTutorial.x=_W/2 
    menuTutorial.y=_H/2
    menuTutorial:setSequence( "tutorial" )
    menuTutorial:setFrame( 1 )
    menuTutorial.name = "menuTutorial"
    menuTutorial.gotoScene="game" 

    menuCruise = display.newSprite( menuStartSheet, menuSeq )
    menuCruise:addEventListener( "touch", myTouchListener )
    menuCruise:addEventListener( "touch", doFunction )
    menuCruise.x=_W/2 
    menuCruise.y=_H/2 + 50
    menuCruise:setSequence( "cruise" )
    menuCruise:setFrame( 1 )
    menuCruise.name = "menuCruise"
    menuCruise.gotoScene="game" 

   --catchAll:addEventListener("tap",catchAllTaps) 

   sceneGroup:insert(catchAll)
   sceneGroup:insert(background)
   sceneGroup:insert(menuStart)
   sceneGroup:insert(menuTutorial)              
   sceneGroup:insert(menuCruise)
   --sceneGroup:toFront()
   
   phaseGroup:insert(catchAll)
   phaseGroup:insert(background)
   phaseGroup:insert(menuStart)
   phaseGroup:insert(menuTutorial)
   phaseGroup:insert(menuCruise)
   phaseGroup:toFront()


   --cruiseBtn:addEventListener("touch",buttonHit) 
   --startBtn:addEventListener("touch",buttonHit)
   --tutorialBtn:addEventListener("touch",buttonHit)  

end

function scene:show( event )

      local sceneGroup=self.view
    local phase = event.phase

    if event.phase == "will" then
--removeFunction()
  print("2")

    elseif event.phase=="did" then
  print("3")
--  refreshTimer=timer.performWithDelay(20,event.parent.testF,0)   --calling a parent function

--timer.performWithDelay(100,initButtons,1) 

           end
end

function scene:hide( event )
    local sceneGroup=self.view
    local phase = event.phase
    if event.phase=="will" then
  print("4")


      print("HELLO")
     -- transition.to(background, {time=25, xScale=0.01,yScale=0.01,onComplete=removeIt})
       -- phaseGroup:removeEventListener("tap",buttonHit) 
      transition.to(phaseGroup, {time=0, alpha=0,onComplete=removeIt})      
   
    --parent:resumeGame()
     elseif event.phase == "did" then
     print("5")
       


     end
end

function scene:destroy( event )
    local sceneGroup=self.view
  print("6")
  --composer.removeScene("start",true) 
  composer.hideOverlay("start")
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
