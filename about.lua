--about.lua
local composer=require("composer")
local scene = composer.newScene()

local bmpText = {}

local twitterBtn
local mageeBtn
local colorBtn
local mgBtn
local facebookBtn

local canQuit = true
local currentObject
local touchInsideBtn = false

local fontTable = {}
local tempFont
local m

local btnsLeftArrow
local btnsLeftArrowSheetCoords = require("lua-sheets.btns_arrow")
local btnsLeftArrowSheet = graphics.newImageSheet("images/btns_arrow.png", btnsLeftArrowSheetCoords:getSheet())

local function myTouchListener(event)
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    print(currentObject.name)
    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then

        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "btnsLeftArrow" then
            currentObject:setSequence("btnsLeftArrow")
        end

        if touchInsideBtn == true and canQuit == true then

            print("touch OFF. inside")
            -- composer.removeScene("start")

            if(currentObject.name == "btnsLeftArrow") then
                composer.gotoScene("menu", { effect = defaultTransition })
            end

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
            if currentObject.name == "btnsLeftArrow" then
                currentObject.xScale = 1
                currentObject.yScale = 1
            end
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if currentObject.name == "btnsLeftArrow" then
                currentObject.xScale = 1.05
                currentObject.yScale = 1.05
                end
            end
            touchInsideBtn = true
        end
    end
end

local function buttonHit(event)
    local goto = event.target.gotoScene

    composer.gotoScene ( goto, { effect = defaultTransition } )
    return true
end

local function urlMG(e)
  system.openURL( "http://www.facebook.com/mageegames")
end
local function urlTwitter(e)
  system.openURL( "http://www.twitter.com/colorflagsgame")
end
local function urlFacebook(e)
  system.openURL( "http://www.facebook.com/colorflagsgame")
end
local function urlMagee(e)
  system.openURL( "http://www.mageegames.com")
end

local function urlColor(e)
  system.openURL( "http://www.colorflagsgame.com")
end

function scene:create( event )
    local fontOptions

    fontOptions = {
      text = "Mike Magee",
      x = _W/2 ,
      y = 80,
      font = "fonts/snackercomic.fnt",
      fontSize = 25,
      align = "left",
    }
    bmpText.creatorMike = ponyfont.newText(fontOptions)
    -- bmpText.creatorMike.anchorY = 1

    fontOptions = {
      text = "Game Design, Programming, Guitar",
      x = _W/2 ,
      y = 110,
      font = "fonts/ffftusj.fnt",
      fontSize = 25,
      align = "left",
    }
    bmpText.creatorMikeDesc = ponyfont.newText(fontOptions)

    fontOptions = {
      text = "Sam Englander",
      x = _W/2 ,
      y = 140,
      font = "fonts/snackercomic.fnt",
      fontSize = 25,
      align = "left",
    }
    bmpText.creatorSam = ponyfont.newText(fontOptions)

    fontOptions = {
      text = "Audio / Visual Design, Programming",
      x = _W/2,
      y = 170,
      font = "fonts/ffftusj.fnt",
      fontSize = 25,
      align = "left",
    }
    bmpText.creatorSamDesc = ponyfont.newText(fontOptions)

    fontOptions = {
      text = "www.mageegames.com",
      x = _W/2 ,
      y = 200,
      font = "fonts/albas.fnt",
      fontSize = 25,
      align = "left",
    }
    bmpText.mageeGames = ponyfont.newText(fontOptions)

    fontOptions = {
      text = "www.colorflagsgame.com",
      x = _W/2 ,
      y = 230,
      font = "fonts/albas.fnt",
      fontSize = 25,
      align = "left",
    }
    bmpText.colorFlagsGame = ponyfont.newText(fontOptions)

    local margins = 6

    -- mgBtn = display.newImage("images/mg80x80.png", _W-80, _H-80)
    -- mgBtn.anchorX=0
    -- mgBtn.anchorY=0

    twitterBtn = display.newImage("images/twitter51x51.png", _W - 2, 0)
    twitterBtn.anchorX = 1
    twitterBtn.anchorY = 0
    facebookBtn = display.newImage("images/facebook50x50.png", _W - twitterBtn.width - 4, 0)
    facebookBtn.anchorX = 1
    facebookBtn.anchorY = 0




	btnsLeftArrow = display.newSprite( btnsLeftArrowSheet, {frames={1,2}} )
    btnsLeftArrow.name = "btnsLeftArrow"
    btnsLeftArrow.anchorX = 0.5
    btnsLeftArrow.anchorY = 0.5
    btnsLeftArrow.x = _W/2
    btnsLeftArrow.y = _H - 35
	btnsLeftArrow.gotoScene = "menu"
    -- btnsLeftArrow:setFillColor(0.98, 0.42, 0.98)

    -- self.view:insert(mgBtn)
    self.view:insert(twitterBtn)
    self.view:insert(facebookBtn)
    self.view:insert(btnsLeftArrow)
end

function scene:show( event )
    local group = self.view
    if event.phase == "will" then
    elseif event.phase == "did" then

        btnsLeftArrow:addEventListener("touch", myTouchListener)
        btnsLeftArrow:addEventListener("touch", doFunction)
        twitterBtn:addEventListener("tap",urlTwitter)
        bmpText.mageeGames:addEventListener("tap",urlMagee)
        bmpText.colorFlagsGame:addEventListener("tap",urlColor)
        facebookBtn:addEventListener("tap",urlFacebook)
        -- mgBtn:addEventListener("tap",urlMG)
    end
end

function scene:hide( event )
    if event.phase=="will" then
        display.remove(bmpText.creatorMike)
        display.remove(bmpText.creatorMikeDesc)
        display.remove(bmpText.creatorSam)
        display.remove(bmpText.creatorSamDesc)
        display.remove(bmpText.mageeGames)
        display.remove(bmpText.colorFlagsGame)

        btnsLeftArrow:removeEventListener("touch", myTouchListener)
        btnsLeftArrow:removeEventListener("touch", doFunction)
        twitterBtn:removeEventListener("tap",urlTwitter)
        bmpText.mageeGames:removeEventListener("tap",urlMagee)
        bmpText.colorFlagsGame:removeEventListener("tap",urlColor)
        facebookBtn:addEventListener("tap",urlFacebook)
        -- mgBtn:removeEventListener("tap",urlMG)
        composer.removeScene("about",true)
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
