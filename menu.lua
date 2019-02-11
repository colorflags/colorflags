--menu.lua
local composer=require("composer")
local scene = composer.newScene()

audio.stop()

-- audio.stop( 2 )
audioReservedChannel2 = nil

music=nil
bobby=nil

if(audioReservedChannel1 == nil) then
    audioReservedChannel1 = audio.play(musicMenu, {channel=1,loops=-1})
end

-- audio.stop( )
-- music = audio.loadStream( "magee_music/magee_main.mp3" )
-- bobby = audio.play(music,{loops=-1})

soundOn=false

local whiteBackground
local titleLogo
local menuColorFlags

local currentObject
local isLoading = false
local touchInsideBtn = false
local isBtnAnim = false

local colorFlagsSpriteCoords = require("lua-sheets.title-menu")
local colorFlagsSheet = graphics.newImageSheet( "images/title-menu.png", colorFlagsSpriteCoords:getSheet() )

local colorFlagsSeq = {
    { name = "colorflags", frames={1,2,3,4,5,6,7,8,9}, time=500, loopCount=0},
}

-- local btnsPlayGame
-- local btnsPlayGameSheetCoords = require("lua-sheets.btns_playgame")
-- local btnsPlayGameSheet = graphics.newImageSheet("images/btns_playgame.png", btnsPlayGameSheetCoords:getSheet())
-- btnsPlayGame = display.newSprite( btnsPlayGameSheet, {frames={2}} )
-- btnsPlayGame.anchorY = .5
-- btnsPlayGame.x=_W/4
-- btnsPlayGame.y=_H - _H/4
-- btnsPlayGame:setFrame( 1 )

-- GLOBALIZE
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
            btnsSheetCoords:getFrameIndex("PlayGame1"),
            btnsSheetCoords:getFrameIndex("PlayGame2"),
            btnsSheetCoords:getFrameIndex("PlayGame3"),
            btnsSheetCoords:getFrameIndex("PlayGame4")
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

local btnsPlayGame
local btnsPlayGameSheetCoords = require("lua-sheets.btns_playgame")
local btnsPlayGameSheet = graphics.newImageSheet("images/btns_playgame.png", btnsPlayGameSheetCoords:getSheet())

local btnsOptions
local btnsOptionsSheetCoords = require("lua-sheets.btns_options")
local btnsOptionsSheet = graphics.newImageSheet("images/btns_options.png", btnsOptionsSheetCoords:getSheet())

local btnsAbout
local btnsAboutSheetCoords = require("lua-sheets.btns_about")
local btnsAboutSheet = graphics.newImageSheet("images/btns_about.png", btnsAboutSheetCoords:getSheet())

-- SAM: needs work
local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then
        if currentObject.name == "playgame" then
            currentObject:setFrame(1)
        elseif currentObject.name == "options" then
            currentObject:setFrame(1)
        elseif currentObject.name == "about" then
            currentObject:setFrame(1)
        end

        -- redundant ??
        -- currentObject:setFrame(1)
        print(touchInsideBtn, isLoading)
        if touchInsideBtn == true and isLoading == false then

            print("touch OFF. inside")
            -- composer.removeScene("start")

            -- prevents scenes from firing twice!!
            isLoading = true
            print("going to..")
            local goto = currentObject.gotoScene
            if goto == "start" and event.target == btnsPlayGame then
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

-- SAM: needs work
local function doFunction(e)
    if currentObject ~= nil then
        if e.x < currentObject.contentBounds.xMin or
            e.x > currentObject.contentBounds.xMax or
            e.y < currentObject.contentBounds.yMin or
            e.y > currentObject.contentBounds.yMax then

            if(isBtnAnim) then
                if currentObject.name == "playgame" then
                    currentObject:setSequence("playgame")
                elseif currentObject.name == "options" then
                    currentObject:setSequence("options")
                elseif currentObject.name == "about" then
                    currentObject:setSequence("about")
                end
            else
                if currentObject.name == "playgame" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "options" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "about" then
                    currentObject:setFrame(1)
                end
            end
            -- currentObject:setFrame(2)
            -- SAM: wtf. how is this working? do some testing.
            if(touchInsideBtn == true) then
                currentObject.xScale = 1
                currentObject.yScale = 1
                print("finger down, outside button: ", currentObject.name)
            end
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                print("finger down, inside button: ", currentObject.name)

                currentObject.xScale = 1
                currentObject.yScale = 1
                -- currentObject.xScale = 1.01
                -- currentObject.yScale = 1.01

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
                    if currentObject.name == "playgame" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "options" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "about" then
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
    transition.to(btnsPlayGame, {time=0,alpha=.98})
    transition.to(btnsOptions, {time=0,alpha=.98})
    transition.to(btnsAbout, {time=0,alpha=.98})
end


function addFunction()
    btnsPlayGame.alpha=1
    btnsOptions.alpha=1
    btnsAbout.alpha=1
    -- btnsPlayGame:addEventListener("touch",doFunction)
    -- btnsOptions:addEventListener("touch",doFunction)
    -- btnsAbout:addEventListener("touch",doFunction)
end

-- MIKE: are we going to use this removeFunction() ??
function removeFunction()
    btnsPlayGame.alpha=0
    btnsOptions.alpha=0
    btnsAbout.alpha=0
    -- btnsPlayGame:removeEventListener("touch",doFunction)
    -- btnsOptions:removeEventListener("touch",doFunction)
    -- btnsAbout:removeEventListener("touch",doFunction)
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

    whiteBackground = display.newRect( _W/2, _H/2, _W, _H )
    whiteBackground:setFillColor(1, 1, 1)

    titleLogo = display.newImageRect( "images/menu_background.png", _W, _H )
    -- titleLogo = display.newImageRect( "images/start-menuWTF.png", _W, _H )
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

    -- rename
    local offsetStartBtns = _H/1.5
    -- local offsetStartBtns = _H/3 + ((_H/2)/2)

    local tempSeq = {
        {
            name = "playgame_anim",
            frames = {
                btnsPlayGameSheetCoords:getFrameIndex("PlayGame1"),
                btnsPlayGameSheetCoords:getFrameIndex("PlayGame2"),
                btnsPlayGameSheetCoords:getFrameIndex("PlayGame3"),
                btnsPlayGameSheetCoords:getFrameIndex("PlayGame4")
            },
            time = 500
        },
    }

    btnsPlayGame = display.newSprite( btnsPlayGameSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsPlayGame.name = "playgame"
    btnsPlayGame:addEventListener( "touch", myTouchListener )
    btnsPlayGame.anchorY = .5
    btnsPlayGame.x = _W/2
    btnsPlayGame.y = offsetStartBtns
    btnsPlayGame:setSequence( "playgame" )
    btnsPlayGame:setFrame(1)
    --  btnsPlayGame.alpha=0.98
    btnsPlayGame.gotoScene="start"
    --  btnsPlayGame:scale(.8,.8)

    local btnSpacing = btnsPlayGame.height + 4

    btnsOptions = display.newSprite( btnsOptionsSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsOptions.name = "options"
    btnsOptions:addEventListener( "touch", myTouchListener )
    btnsOptions.anchorY = .5
    btnsOptions.x = _W/2
    btnsOptions.y = offsetStartBtns+btnSpacing
    -- btnsOptions:setSequence("options")
    btnsOptions:setFrame(1)
    --  btnsOptions.alpha=.98
    btnsOptions.gotoScene = "options"
    --  btnsOptions:scale(.8,.8)

    btnsAbout = display.newSprite( btnsAboutSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsAbout.name = "about"
    btnsAbout:addEventListener( "touch", myTouchListener )
    btnsAbout.anchorY = .5
    btnsAbout.x = _W/2
    btnsAbout.y = offsetStartBtns+(btnSpacing*2)
    -- btnsAbout:setSequence("about")
    btnsAbout:setFrame(1)
    --  btnsAbout.alpha=0.98
    btnsAbout.gotoScene = "about"
    --  btnsAbout:scale(.8,.8)

    sceneGroup:insert(whiteBackground)
    sceneGroup:insert(titleLogo) -- SAM: BACKGROUND NOT TITLE !!! CHANGE NAME
    sceneGroup:insert(menuColorFlags)
    sceneGroup:insert(btnsPlayGame)
    sceneGroup:insert(btnsOptions)
    sceneGroup:insert(btnsAbout)

    btnsPlayGame:addEventListener("touch",doFunction)
    btnsOptions:addEventListener("touch",doFunction)
    btnsAbout:addEventListener("touch",doFunction)
end

function scene:focusMenu()
    print("re-focus menu.lua")
    btnsPlayGame.xScale = 1
    btnsPlayGame.yScale = 1
    isLoading = false
    touchInsideBtn = false
    isBtnAnim = false
end

function scene:show( event )
    local sceneGroup=self.view
    local phase = event.phase

    touchInsideBtn = false
    print("focus")
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

    print("a")
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
