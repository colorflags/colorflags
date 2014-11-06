--about.lua
local composer=require("composer")
local scene = composer.newScene()

local bg
	local backBtn 
  local modeBtn
  local stopBtn
  local playBtn
	local bg2
  local pauseTimer
  local refreshTimer
  local musicJam
  local musicAnthem
  local musicOff
  local font14



  
  local function phase3(e)

transition.to(e,{time=50, xScale=1,yScale=1})
end


  local function phase2(e)

transition.to(e,{time=50, xScale=.8,yScale=.8,onComplete=phase3})  
  end


  
local function buttonHit(e)

  transition.to(e.target,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})  
	if e.target==backBtn then
    composer.hideOverlay("pause")
    print("back")
  elseif e.target==playBtn then

    if soundOn==false then
    media.playSound(music)

    soundOn=true
    print("music")
    end

  elseif e.target==stopBtn then
    if soundOn==true then
    media.stopSound(music)
    music=nil
    soundOn=false
    print("stop")
     end
  elseif e.target==modeBtn then

  if topBar~=nil then
    if isWideMode==true then
      print("HERRE")
      heightModeTop=35
      heightModeLow=_H-35    
      isWideMode=false
    else 
      heightModeTop=70
      heightModeLow=_H-70   
      isWideMode=true
    end  
      topBar.y=heightModeTop
      lowBar.y=heightModeLow
  end

  end  
  	return true
end








--local catchAll

--local function catchAllTaps(event)
--	return true
--end


local function removeIt(e)
       display.remove(e)
end



function scene:create( event )
	--[[catchAll=display.newRect(0,0,_W,_H)
	catchAll.alpha=1
	catchAll.hitTestable=true
	catchAll:addEventListener("tap",catchAllTaps)
	catchAll:toFront()
	self.view:insert(catchAll)--]]



		     bg=display.newRect(50,50,_W-100,_H-100)
      bg:setFillColor(128/255,0,1)
        bg:toFront() 
      bg.x=_W/2
      bg.y=_H/2
bg:scale(0,0)
      bg.alpha=1
    
     self.view:insert(bg)


end

function scene:show( event )

	if event.phase == "will" then


 bg2=display.newRect(50,50,_W-100,_H-100)
      bg2:setFillColor(128/255,0,1)
       bg2:toFront() 
      bg2.x=_W/2
      bg2.y=_H/2
      bg2:scale(0,0)
      bg2:toFront()

  
      musicAnthem = display.newImage( "images/music_anthem.png", 149,148) 
      musicAnthem.anchorX=0.5 ; musicAnthem.anchorY=0.5
      musicAnthem.x=_W*(1/4) ; musicAnthem.y=_H*(2/3)
      musicAnthem.xScale=.5 ; musicAnthem.yScale=.5
      musicAnthem:toFront()
   --   self.view:insert(musicAnthem)
      musicJam = display.newImageRect( "images/music_jam.png", 149,150) 
      musicJam.anchorX=0.5 ; musicJam.anchorY=0.5
      musicJam.x=_W*(1/2) ; musicJam.y=_H*(2/3)
      musicJam.xScale=.5 ; musicJam.yScale=.5
     -- self.view:insert(musicJam)
  
      musicOff= display.newImageRect( "images/music_off.png", 149,149) 
      musicOff.anchorX=0.5 ; musicOff.anchorY=0.5
      musicOff.x=_W*(3/4) ; musicOff.y=_H*(2/3)
      musicOff.xScale=.5 ;  musicOff.yScale=.5
	    --self.view:insert(musicOff)


   font37 = display.newText("SnComic", _W/2, _H/2, "SnackerComic", 30 )
    font37.x = 150
    font37.y = 100

    font37:setFillColor(224/225,96/225,224/225) 

  backBtn = makeTextButton("Back", _W/2, _H/2, {listener=buttonHit, group=group})
  backBtn:scale(0,0)
  backBtn:toFront()
  backBtn:setFillColor(0,0,1)  
	--backBtn.type = "game"

  playBtn = makeTextButton("Music", _W/4, _H/2, {listener=buttonHit, group=group})
  playBtn:scale(0,0)
  playBtn:toFront()
  --musicBtn.gotoScene = "game"

  stopBtn = makeTextButton("Silence", _W*(3/4), _H/2, {listener=buttonHit, group=group})
  stopBtn:scale(0,0)
  stopBtn:toFront()
 -- stopBtn.gotoScene = "game

   modeBtn = makeTextButton("mode", _W*(1/2), _H*(4/5), {listener=buttonHit, fontFace="federalescort3d" , group=group})
   modeBtn:scale(0,0)
   modeBtn:toFront()

       font14 = display.newText("3dimension", _W/2, _H/2, "federalescort3d", 25 )
    font14.x = 80
    font14.y = 280
 font14:setFillColor(224/225,96/225,224/225) 

   musicJam:toFront()
    musicAnthem:toFront()
      transition.to(backBtn, {time=100, xScale=1,yScale=1})
      transition.to(playBtn, {time=100, xScale=1,yScale=1})
      transition.to(stopBtn, {time=100, xScale=1,yScale=1})
      transition.to(modeBtn, {time=100, xScale=1,yScale=1})      
      transition.to(bg, {time=100, xScale=1,yScale=1})
      timer.performWithDelay(110, musicJam:toFront(), 1 )

  refreshTimer=timer.performWithDelay(20,event.parent.testF,0)
	elseif event.phase=="did" then 




		   end
end

function scene:hide( event )
    if event.phase=="will"then
      transition.to(bg, {time=100, xScale=0.01,yScale=0.01,onComplete=removeIt})
      transition.to(modeBtn, {time=100, xScale=0.01,yScale=0.01,onComplete=removeIt})       
      transition.to(backBtn, {time=100, xScale=0.01,yScale=0.01,onComplete=removeIt}) 
      transition.to(playBtn, {time=100, xScale=0.01,yScale=0.01,onComplete=removeIt})
      transition.to(stopBtn, {time=100, xScale=0.01,yScale=0.01,onComplete=removeIt}) 
      timer.cancel(refreshTimer)   
      
    composer.removeScene("pause",false)    
	 elseif event.phase == "did" then

   returnFunction()

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
