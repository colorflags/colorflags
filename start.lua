--about.lua
local composer=require("composer")
local scene = composer.newScene()

  local startBtn
  local tutorialBtn
  local cruiseBtn
  local background
  local phaseGroup=display.newGroup()
 

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
  
   startBtn = display.newText("Start", _W/2, _H/3, "federalescort3d", 35 )
   startBtn:setFillColor(224/225,96/225,224/225) 
 
   tutorialBtn = display.newText("Tutorial", _W/2, _H/2, "federalescort3d", 35 )
   tutorialBtn:setFillColor(224/225,96/225,224/225)  

   cruiseBtn = display.newText("Cruise", _W/2, _H*(2/3), "federalescort3d", 35 )
   cruiseBtn:setFillColor(224/225,96/225,224/225) 



   catchAll:addEventListener("tap",catchAllTaps) 

   sceneGroup:insert(catchAll)
   sceneGroup:insert(background) 
   sceneGroup:insert(startBtn)              
   sceneGroup:insert(cruiseBtn)
   sceneGroup:insert(tutorialBtn)

   phaseGroup:insert(catchAll)
   phaseGroup:insert(background) 
   phaseGroup:insert(cruiseBtn)
   phaseGroup:insert(startBtn)
   phaseGroup:insert(tutorialBtn)
   phaseGroup:toFront()


   cruiseBtn:addEventListener("touch",buttonHit) 
   startBtn:addEventListener("touch",buttonHit)
   tutorialBtn:addEventListener("touch",buttonHit)  

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