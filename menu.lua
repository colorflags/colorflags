--menu.lua
local composer=require("composer")
local scene = composer.newScene()

local titleLogo 
local menuColorFlags 

local startBtnsPlayGame
local startBtnsOptions
local startBtnsAbout

local currentObject
local isLoading = false
local touchInsideBtn = false

local isBtnAnim = false

music=nil
bobby=nil

audio.stop( )            
music = audio.loadStream( "magee_music/magee_8bit.mp3" ) 
bobby = audio.play(music,{loops=-1})

soundOn=false

local colorFlagsSpriteCoords = require("lua-sheets.title-menu")
local colorFlagsSheet = graphics.newImageSheet( "images/title-menu.png", colorFlagsSpriteCoords:getSheet() )

local colorFlagsSeq = {
    { name = "colorflags", frames={1,2,3,4,5,6,7,8,9}, time=500, loopCount=0},    
}

local btnsSheetCoords = require("lua-sheets.buttons")
local btnsSheet = graphics.newImageSheet("images/buttons.png", btnsSheetCoords:getSheet())

local btnsSeq = {
    {
        name = "playgame",
        frames = {
            btnsSheetCoords:getFrameIndex("PlayGame3"),
            btnsSheetCoords:getFrameIndex("PlayGame5")
        },
        time = 500 
    },
    {
        name = "playgame_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("PlayGame2"),
            btnsSheetCoords:getFrameIndex("PlayGame3"),
            btnsSheetCoords:getFrameIndex("PlayGame4"),
            btnsSheetCoords:getFrameIndex("PlayGame5")
        },
        time = 500 
    },
    {
        name = "options",
        frames = {
            btnsSheetCoords:getFrameIndex("Options3"),
            btnsSheetCoords:getFrameIndex("Options5")
        },
        time = 500 
    },
    {
        name = "options_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Options2"),
            btnsSheetCoords:getFrameIndex("Options3"),
            btnsSheetCoords:getFrameIndex("Options4"),
            btnsSheetCoords:getFrameIndex("Options5")
        },
        time = 500 
    },
    {
        name = "about",
        frames = {
            btnsSheetCoords:getFrameIndex("About3"),
            btnsSheetCoords:getFrameIndex("About5")
        },
        time = 500 
    },
    {
        name = "about_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("About2"),
            btnsSheetCoords:getFrameIndex("About3"),
            btnsSheetCoords:getFrameIndex("About4"),
            btnsSheetCoords:getFrameIndex("About5")
        },
        time = 500 
    },
}

local menuSpriteCoords = require("lua-sheets.playgame-menu")
local menuStartSheet = graphics.newImageSheet( "images/playgame-menu.png", menuSpriteCoords:getSheet() )


local startBtnSeq = {
    { name = "playgame", frames={8,9}, time=500 },
    { name = "options", frames={5,6}, time=500 },
    { name = "about", frames={1,2}, time=500 }
}

local startBtnsSpriteCoords = require("lua-sheets.menu-btns")

local startBtnsPlayGameSheet = graphics.newImageSheet( "images/menu-btns.png", startBtnsSpriteCoords:getSheet() )
local startBtnsOptionsSheet = graphics.newImageSheet( "images/menu-btns.png", startBtnsSpriteCoords:getSheet() )
local startBtnsAboutSheet = graphics.newImageSheet( "images/menu-btns.png", startBtnsSpriteCoords:getSheet() )

local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    
    if event.phase == "began" then
        -- print("touch ON. inside") 
    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        -- redundant ?? 
        -- currentObject:setFrame(1)
        
        if touchInsideBtn == true and isLoading == false then 
            -- print("touch OFF. inside")
            
            -- prevents scenes from firing twice!!
            isLoading = true
            
            local goto = currentObject.gotoScene
            if goto == "start" and event.target == startBtnsPlayGame then
                composer.showOverlay( goto, { isModal= true})
            else
                composer.gotoScene ( goto, { effect = defaultTransition } )
            end  
        elseif touchInsideBtn == false then
            -- print("touch OFF outside")
        end
        
        currentObject = nil
        display.getCurrentStage():setFocus(nil)
        touchInsideBtn = false
    end
end

--[[
local function doFunction(e)
    if currentObject ~= nil then
        if e.x < currentObject.contentBounds.xMin or
            e.x > currentObject.contentBounds.xMax or
            e.y < currentObject.contentBounds.yMin or
            e.y > currentObject.contentBounds.yMax then
            
            currentObject:setFrame( 1 )
            touchInsideBtn = false
        else
            currentObject:setSequence("")
            touchInsideBtn = true
        end   
    end     
end
]]--

-- buttons funciontality imported from start.lua

local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    
    if event.phase == "began" then
        -- print("touch ON. inside")          
    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "pg" then
            currentObject:setSequence("playgame")
        elseif currentObject.name == "opt" then
            currentObject:setSequence("options")
        elseif currentObject.name == "abt" then
            currentObject:setSequence("about")
        end
        
        -- redundant ?? 
        -- currentObject:setFrame(1)
        
        if touchInsideBtn == true and isLoading == false then 
            -- print("touch OFF. inside")
            -- composer.removeScene("start")
            
            -- prevents scenes from firing twice!!
            isLoading = true
            
            local goto = currentObject.gotoScene
            composer.gotoScene( goto, { effect = defaultTransition } )
            
        elseif touchInsideBtn == false then
            -- print("touch OFF outside")
        end
        
        currentObject = nil
        display.getCurrentStage():setFocus(nil)
        touchInsideBtn = false
    end
end
 
local function doFunction(e)
    if currentObject ~= nil then
        if e.x < currentObject.contentBounds.xMin or
            e.x > currentObject.contentBounds.xMax or
            e.y < currentObject.contentBounds.yMin or 
            e.y > currentObject.contentBounds.yMax then 
            
            if(isBtnAnim) then
                if currentObject.name == "pg" then
                    currentObject:setSequence("playgame")
                elseif currentObject.name == "opt" then
                    currentObject:setSequence("options")
                elseif currentObject.name == "abt" then
                    currentObject:setSequence("about")
                end
            else 
                if currentObject.name == "pg" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "opt" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "abt" then
                    currentObject:setFrame(1)
                end
            end
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if(isBtnAnim) then
                    if currentObject.name == "pg" then
                        currentObject:setSequence("playgame_anim")
                    elseif currentObject.name == "opt" then
                        currentObject:setSequence("options_anim")
                    elseif currentObject.name == "abt" then
                        currentObject:setSequence("about_anim")
                    end
                    currentObject:play()
                else
                    if currentObject.name == "pg" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "opt" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "abt" then
                        currentObject:setFrame(2)
                    end
                end
            end
            touchInsideBtn = true
        end
    end
end

local function prepareMenu()
   titleLogo.alpha=1
    transition.to(startBtnsPlayGame, {time=0,alpha=.98})          
    transition.to(startBtnsOptions, {time=0,alpha=.98}) 
    transition.to(startBtnsAbout, {time=0,alpha=.98})        

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

-- MIKE: are we going to use this removeFunction() ??
function removeFunction()
  startBtnsAbout.alpha=0
    startBtnsPlayGame.alpha=0
      startBtnsOptions.alpha=0
     -- startBtnsAbout:removeEventListener("touch",doFunction)
   --   startBtnsPlayGame:removeEventListener("touch",doFunction)
   --   startBtnsOptions:removeEventListener("touch",doFunction)  
end

--local function checkMemory(e)
 -- collectgarbage();
 -- print("Memory usage " .. collectgarbage("count"));
--  print("Texture memory usage " .. system.getInfo("textureMemoryUsed")/1024/1024 .. "MB")
--end


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
  titleLogo.alpha=0.98

  -- Taken directly from options.lua

  menuColorFlags = display.newSprite(colorFlagsSheet,colorFlagsSeq)
  menuColorFlags.anchorY = 0
  menuColorFlags.x=_W/2
  menuColorFlags.y=0
  menuColorFlags:setSequence("colorflags")
  menuColorFlags.alpha = 0.88
  menuColorFlags:play()

  menuColorFlags:addEventListener("sprite", animationPop)

  local offsetStartBtns = _H/2.2
  local btnSpacing = 58

  startBtnsPlayGame = display.newSprite(btnsSheet, btnsSeq)
  startBtnsPlayGame.name = "pg"
  startBtnsPlayGame:addEventListener( "touch", myTouchListener )
  startBtnsPlayGame.anchorY = 0
  startBtnsPlayGame.x=_W/2
  startBtnsPlayGame.y=offsetStartBtns
  startBtnsPlayGame:setSequence( "playgame" )
  startBtnsPlayGame:setFrame( 1 )
  startBtnsPlayGame.alpha=0.98
  startBtnsPlayGame.gotoScene="start"

  startBtnsOptions= display.newSprite(btnsSheet, btnsSeq)
  startBtnsOptions.name = "opt"
  startBtnsOptions:addEventListener( "touch", myTouchListener )
  startBtnsOptions.anchorY = 0
  startBtnsOptions.x=_W/2
  startBtnsOptions.y=offsetStartBtns+btnSpacing
  startBtnsOptions:setSequence( "options" )
  startBtnsOptions:setFrame( 1 )
  startBtnsOptions.alpha=.98
  startBtnsOptions.gotoScene="options"

  startBtnsAbout= display.newSprite(btnsSheet, btnsSeq)
  startBtnsAbout.name = "abt"
  startBtnsAbout:addEventListener( "touch", myTouchListener )
  startBtnsAbout.anchorY = 0
  startBtnsAbout.x=_W/2
  startBtnsAbout.y=offsetStartBtns+(btnSpacing*2)
  startBtnsAbout:setSequence( "about" )
  startBtnsAbout:setFrame( 1 )
  startBtnsAbout.alpha=0.98
  startBtnsAbout.gotoScene="about"

  sceneGroup:insert(titleLogo) -- BACKGROUND NOT TITLE !!! CHANGE NAME
  sceneGroup:insert(menuColorFlags) 
  sceneGroup:insert(startBtnsPlayGame)
  sceneGroup:insert(startBtnsOptions)
  sceneGroup:insert(startBtnsAbout)  


   startBtnsAbout:addEventListener("touch",myTouchListener)
   startBtnsAbout:addEventListener("touch",doFunction)
   startBtnsPlayGame:addEventListener("touch",myTouchListener)
   startBtnsPlayGame:addEventListener("touch",doFunction)
   startBtnsOptions:addEventListener("touch",myTouchListener) 
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
   --   prepareMenu()
    --timer.performWithDelay(300,eraseSplash,1)

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
