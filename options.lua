--about.lua
local composer=require("composer")
local scene = composer.newScene()

  local infoYesBtn
  local infoNoBtn
  local infoIcon
  local phasePic
  local backBtn
  local stopBtn
  local playBtn
  local phaseNarrowBtn
  local phaseWideBtn
  local phaseFullBtn
  local ffBtn
  local rwBtn

  local pauseTimer
  local refreshTimer
  local font
  local musicOff
  local phaseGroup=display.newGroup()

-- phase2 and phase 3 are used for button click animation
  local function phase3(e)
    transition.to(e,{time=50, xScale=1,yScale=1})
  end
  local function phase2(e)
    transition.to(e,{time=50, xScale=.8,yScale=.8,onComplete=phase3}) 
  end
 

-- phaseA and phase B are used for info icon animation
  local function phaseB(e)
    transition.to(e,{time=50, xScale=.4,yScale=.4})
  end
  local function phaseA(e)
    transition.to(e,{time=50, xScale=.35,yScale=.35,onComplete=phaseB}) 
  end


  local function buttonHit(e)  	
    if e.target==backBtn then
--back

        local goto = e.target.gotoScene
	    composer.gotoScene ( goto, { effect = defaultTransition } )              
    elseif e.target==ffBtn or e.target==rwBtn then
-- << >>    	
        if e.target==ffBtn then  
           transition.to(ffBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2}) 
        elseif e.target==rwBtn then    
          transition.to(rwBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})  
        end       
    else  
      display.remove(ffBtn)
      display.remove(rwBtn)
      if e.target.type=="music" then
        display.remove(stopBtn)
        display.remove(jamBtn)
        display.remove(playBtn)  
        if e.target==playBtn then 
-- play        	
          stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), native.systemFonts, 35 ) 
          jamBtn = display.newText("MuSic",_W*(1/4)-15, _H*(4/5) , native.systemFonts, 35 )                      
          if soundOn==false then
            media.playSound(music)
            soundOn=true
            print("music")
          end
          playBtn = display.newText("AntheM", _W/2-10, _H*(4/5), native.systemFonts, 35 )          
          transition.to(playBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})        
        elseif e.target==stopBtn then
-- stop        	
          playBtn = display.newText("AntheM", _W/2-10, _H*(4/5), native.systemFonts, 35 )         
          jamBtn = display.newText("MuSic", _W*(1/4)-15, _H*(4/5), native.systemFonts, 35 )
 
          if soundOn==true then
            media.stopSound(music)
            music=nil
            soundOn=false
            print("stop")
          end
          stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), native.systemFonts, 35 )          
          transition.to(stopBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})       
        elseif e.target==jamBtn then
-- anthem        	
          stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), native.systemFonts, 35 )      
          playBtn = display.newText("AntheM", _W/2-10, _H*(4/5), native.systemFonts, 35 )
          jamBtn = display.newText("MuSic", _W*(1/4)-15, _H*(4/5), native.systemFonts, 35 )
          ffBtn = display.newText(">>", (_W*(1/6))+60, _H*(2/3), native.systemFonts, 35 )      
          rwBtn = display.newText("<<", _W*(1/6), _H*(2/3), native.systemFonts, 35 )
          ffBtn:setFillColor( 0,0,0 )
          rwBtn:setFillColor( 0,0,0 )
          transition.to(ffBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2}) 
          transition.to(rwBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})                   
          transition.to(jamBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2}) 
          phaseGroup:insert(ffBtn)
          phaseGroup:insert(rwBtn)
          ffBtn:addEventListener("tap",buttonHit) 
          rwBtn:addEventListener("tap",buttonHit) 
        end

 
        playBtn:setFillColor(0,0,0) 
        jamBtn:setFillColor(0,0,0)  
        stopBtn:setFillColor(0,0,0)
        jamBtn.type="music"
        stopBtn.type="music"
        playBtn.type="music"
        phaseGroup:insert(jamBtn)
        phaseGroup:insert(stopBtn)
        phaseGroup:insert(playBtn)
        jamBtn:addEventListener("tap",buttonHit) 
        stopBtn:addEventListener("tap",buttonHit) 
        playBtn:addEventListener("tap",buttonHit)


    elseif e.target.type=="phase" then
        display.remove(phaseWideBtn)
        display.remove(phaseNarrowBtn)
        display.remove(phasePic)
        if e.target==phaseWideBtn then
-- wide        	
            phasePic = display.newImage("images/widePic.png", 585,337)
            heightModeTop=35
            heightModeLow=_H-35     
            phaseNarrowBtn = display.newText("nArrow", _W*(3/4) ,_H*(1/6), native.systemFonts, 35 ) 
            phaseWideBtn = display.newText("wide", _W*(1/5), _H*(1/6) , native.systemFonts, 35 )
            transition.to(phaseWideBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        elseif e.target==phaseNarrowBtn then
-- narrow        	
            phasePic = display.newImage("images/narrowPic.png", 585,337)
            heightModeTop=70
            heightModeLow=_H-70  
            phaseWideBtn = display.newText("wide", _W*(1/5) ,_H*(1/6) , native.systemFonts, 35 )  
            phaseNarrowBtn = display.newText("nArrow",_W*(3/4) ,_H*(1/6), native.systemFonts, 35 )
            transition.to(phaseNarrowBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        end

        phasePic.x = _W/2
        phasePic.y = _H*(1/6)
        phasePic.xScale = .2
        phasePic.yScale = .2   
        phaseGroup:insert(phasePic)   

        phaseNarrowBtn:setFillColor(0,0,0) 
        phaseWideBtn:setFillColor(0,0,0) 
        phaseWideBtn.type="phase"
        phaseNarrowBtn.type="phase"
        phaseGroup:insert(phaseWideBtn)
        phaseGroup:insert(phaseNarrowBtn)
        phaseWideBtn:addEventListener("tap",buttonHit) 
        phaseNarrowBtn:addEventListener("tap",buttonHit) 
    elseif e.target.type=="info" then
        display.remove(infoIcon)
        if e.target==infoYesBtn then
-- Yes
           transition.to(infoYesBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
           infoMode=true
           infoIcon = display.newImage("images/info.png",256,256)  

        elseif e.target==infoNoBtn then
-- No
           transition.to(infoNoBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
           infoMode=false
           infoIcon = display.newImage("images/infoGray.png",256,256)             
        end   

 
 
       infoIcon.x = _W/2
       infoIcon.y = _H/2
       infoIcon.xScale = .4
       infoIcon.yScale = .4
       phaseGroup:insert(infoIcon)
       transition.to(infoIcon,{time=50, xScale=0.45,yScale=0.45,onComplete=phaseA})

    end
  end 
  return true
end

function scene:create( event )


	titleLogo = display.newImageRect( "images/optionsMenu.png", 568, 320 )
	titleLogo.anchorX=0.5
	titleLogo.anchorY=0.5
	titleLogo.x = _W/2
	titleLogo.y = _H/2	
    self.view:insert(titleLogo)

	backBtn = makeTextButton("Back", 40, _H-20, {listener=buttonHit, group=group})
	backBtn.gotoScene = "menu"
  backBtn:setFillColor(224/225,96/225,224/225) 
    self.view:insert(backBtn)
end


function scene:show( event )
  
  local group = self.view
  if event.phase == "will" then

   phaseNarrowBtn = display.newText("nArrow", _W*(3/4), _H*(1/6), native.systemFonts, 35 )

   if heightModeTop == 35 then
     phasePic = display.newImage("images/widePic.png", 585,337)
   else
     phasePic = display.newImage("images/narrowPic.png", 585,337)
   end
   phasePic.x = _W/2
   phasePic.y = _H*(1/6)
   phasePic.xScale = .2
   phasePic.yScale = .2   

   phaseWideBtn = display.newText("wide", _W*(1/5), _H*(1/6), native.systemFonts, 35 )

   infoYesBtn = display.newText("Yes", _W*(1/5),_H*(1/2), native.systemFonts, 35)


   if infoMode == true then
     infoIcon = display.newImage("images/info.png",256,256)
   else
     infoIcon = display.newImage("images/infoGray.png",256,256)   
   end  
   infoIcon.x = _W/2
   infoIcon.y = _H/2
   infoIcon.xScale = .4
   infoIcon.yScale = .4

   infoNoBtn = display.newText("No", _W*(3/4),_H*(1/2), native.systemFonts, 35)

   playBtn = display.newText("AntheM", _W/2-10, _H*(4/5), native.systemFonts, 35 )
   stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), native.systemFonts, 35 )
   jamBtn = display.newText("MuSic", _W*(1/4)-15, _H*(4/5), native.systemFonts, 35 )



   infoYesBtn:setFillColor(0,0,0)
   infoYesBtn.type="info"
   infoNoBtn:setFillColor(0,0,0)
   infoNoBtn.type="info"   
   --playBtn = display.newText("AntheM", _W/2, _H/2, native.systemFonts, 35 )
   playBtn:setFillColor(0,0,0) 
  --    playBtn:setFillColor(224/225,96/225,224/225) 
   playBtn.type="music"   
  -- stopBtn = display.newText("Mute", _W/2, _H/2, native.systemFonts, 35 )
 -- stopBtn:setFillColor(224/225,96/225,224/225)  
   stopBtn:setFillColor(0,0,0)  
   stopBtn.type="music"
  -- jamBtn = display.newText("MuSic", _W/2, _H/2, native.systemFonts, 35 )
 --  jamBtn:setFillColor(224/225,96/225,224/225) 
   jamBtn:setFillColor(0,0,0) 
   jamBtn.type="music"
  -- phaseNarrowBtn = display.newText("nArrow", _W/2, _H/2, native.systemFonts, 35 )
 --  phaseNarrowBtn:setFillColor(224/225,96/225,224/225)  
   phaseNarrowBtn:setFillColor(0,0,0) 
   phaseNarrowBtn.type="phase"
  -- phaseWideBtn = display.newText("wide", _W/2, _H/2, native.systemFonts, 35 )
 --  phaseWideBtn:setFillColor(224/225,96/225,224/225) 
     phaseWideBtn:setFillColor(0,0,0) 
   phaseWideBtn.type="phase"

   phaseGroup:insert(infoYesBtn)
   phaseGroup:insert(infoIcon)
   phaseGroup:insert(phasePic)  
   phaseGroup:insert(infoNoBtn)
   phaseGroup:insert(jamBtn)
   phaseGroup:insert(phaseNarrowBtn) 
   phaseGroup:insert(phaseWideBtn)
   phaseGroup:insert(playBtn)
   phaseGroup:insert(stopBtn)  
   jamBtn:addEventListener("tap",buttonHit) 
   phaseNarrowBtn:addEventListener("tap",buttonHit) 
   phaseWideBtn:addEventListener("tap",buttonHit) 
   playBtn:addEventListener("tap",buttonHit)
   stopBtn:addEventListener("tap",buttonHit)  
   infoYesBtn:addEventListener("tap",buttonHit)    
   infoNoBtn:addEventListener("tap",buttonHit)               
--[[ transition.to(playBtn, {time=25,x= _W/2-10,y=_H*(17/24)+5 })   
   transition.to(stopBtn, {time=25,x=_W*(3/4)+10 ,y= _H*(19/24)-10 }) 
   transition.to(jamBtn, {time=25,x=_W*(1/4)-15 ,y= _H*(15/24) }) 
   transition.to(phaseNarrowBtn, {time=25,x=_W*(1/4)+30 ,y=_H*(7/24) }) 
   transition.to(phaseWideBtn, {time=25, x= _W*(3/4)-10 ,y=_H*7/24 }) 
 --]]
    elseif event.phase=="did" then
    end
end

function scene:hide( event )
    if event.phase == "will" then
       display.remove(phaseGroup)     

          composer.removeScene("options",false)    
    elseif event.phase == "did" then
      --  composer.gotoScene("menu", {effect=defaultTransition} )

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
