
--menu.lua
local composer=require("composer")
local scene = composer.newScene()

local titleLogo 
local btnPlay
local btnOptions
local btnAbout
local splash

local function tapBtn(e)
  local goto = e.target.gotoScene
  composer.gotoScene(goto, {effect=defaultTransition} )
  return true
end


local function eraseSplash()
   titleLogo.alpha=1
   transition.to(splash, {time=400,alpha=0})  
end


function scene:create( event )
  titleLogo = display.newImageRect( "images/menu.png", 480, 320 )
  titleLogo.anchorX=0.5
  titleLogo.anchorY=0.5
  titleLogo.x = _W/2
  titleLogo.y = _H/2  
  titleLogo.alpha=0

    btnPlay=makeTextButton("Play Game", _W/2, _H/2+40, bOptions)
    btnPlay.gotoScene="game"

    btnOptions=makeTextButton("Options", _W/2, _H/2+80, bOptions)
    btnOptions.gotoScene="options"

    btnAbout=makeTextButton("About", _W/2, _H/2+120, bOptions)
    btnAbout.gotoScene="about"

  splash = display.newImageRect( "images/MMG.png", 580, 320 )
  splash.anchorX=0.5
  splash.anchorY=0.5
  splash.x = _W/2
  splash.y = _H/2 

    self.view:insert(titleLogo) 
  self.view:insert(btnPlay)
  self.view:insert(btnOptions)
  self.view:insert(btnAbout)  
  self.view:insert(splash)
end

function scene:show( event )
  if event.phase == "will" then
      --Runtime:addEventListener("enterFrame", checkMemory)
      btnPlay:addEventListener("tap",tapBtn)
      btnOptions:addEventListener("tap",tapBtn)
      btnAbout:addEventListener("tap",tapBtn)    
    elseif event.phase == "did" then
    timer.performWithDelay(300,eraseSplash,1)
  end
end

function scene:hide( event )
  local group = self.view
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
