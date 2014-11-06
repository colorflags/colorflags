-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--local storyboard = require "storyboard"
--storyboard.purgeOnSceneChange = true

local composer=require("composer")




display.setStatusBar( display.HiddenStatusBar )

_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen


defaultTransition="crossFade"

audioCanPlay=true


local fontFace
local backgrounImage=nil
local backgroundColor={255,255,255}

local    splash = display.newImageRect( "images/MMG.png", 580, 320 )
    splash.anchorX=0.5
    splash.anchorY=0.5
    splash.x = _W/2
    splash.y = _H/2 



local function eraseSplash()

   transition.to(splash, {time=300,alpha=0})    

  --   startBtnsAbout.alpha=0
--  startBtnsOptions.alpha=0
 -- startBtnsPlayGame.alpha=0
          
end


--composer.recycleOnSceneChange = true

function checkMemory(e)
  collectgarbage();
  print("Memory usage " .. collectgarbage("count"));
  print("Texture memory usage " .. system.getInfo("textureMemoryUsed")/1024/1024 .. "MB")
end

function playSound(audioObj,chn)
	local chnUsed
	if audioCanPlay then
		chnUsed = audio.play(audioObj,{channel=chn})
    end
    return chnUsed		
end

function makeTextButton(txt,x,y,opts)
	local options  = opts or {}
    
    if environment=="simulator" then
      fontFace = options.fontFace or "Helvetica"
    elseif environment=="device" then
      fontFace = options.fontFace or "federalescort3d"
    end

    local fontSize = options.fontSize or 24
    local fontColor= options.fontColor or {255,255,255}
    local param=options.param
    local tapOrTouch=options.tapOrTouch or "tap"
    local listener=options.listener
    local group=options.group
    local btn=display.newEmbossedText(txt,0,0,fontFace,fontSize)
    btn:setFillColor(fontColor[1],fontColor[2],fontColor[3])
    btn.x=x or _W/2
    btn.y=y or _H/2
    if param then
    	btn.param=param
    end
    if listener then
    	btn:addEventListener(tapOrTouch,listener)

    end
    if group then
    	group:insert(btn)
    end
    return btn
end



      timer.performWithDelay(10,eraseSplash,1)


  -- composer.removeScene("main",false)  
--composer.gotoScene("menu")

composer.gotoScene( "menu", {effect = defaultTransition} )