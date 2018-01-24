
-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html

local CreateText = require("cf_text")

--game.lua
local composer = require("composer")
local scene = composer.newScene()

audio.stop( 1 )
audioReservedChannel1 = nil
audio.stop( 2 )
audioReservedChannel2 = nil

-- audio stuff
local music
local bobby

local debugOptions = {}
debugOptions.gotoDeath = false
debugOptions.constantSpeed = true
debugOptions.cycleModes = false
debugOptions.topBottomBars = false
debugOptions.brazilToCanada = false -- make this into array with a variety of sets - changing between 2 or more countries in sequence

local gameMechanics = {}
gameMechanics.playCountryDuration = 5000
gameMechanics.transitionToCountryDuration = 50
gameMechanics.firstPaletteDelay = 10
gameMechanics.countriesSpawned = 0
gameMechanics.overrideFlag = false
gameMechanics.heightModeTop = 35
gameMechanics.heightModeLow = _H - 35

-- FPS
if fps == 30 then
    gameMechanics.paletteSpawnDelay = 85
else
    gameMechanics.paletteSpawnDelay = 42.5
end

local cuedCountry = nil

local setCountryParameters
local newCountry
local moveObject
local readyObject

local setFlag
local delayPace
local finishScale
local nextFlag

local activeCountry

local xBtn
local fwBtn

local canSkip = false
local currentObject
local touchInsideBtn = false
local isBtnAnim = false

local gotoDeath = false    --for testing purposes. if true, go to GameOver screen.
local state = 1
local stateFour = 0
local stateFourGrow = 0
local speed = 2
local timeVar = 1250
local levels
local score = 0
local numDeaths = 0
local idx = 3

--SAM: checks if game just started
local countriesCompleted = 0

local flagScaleStyle = 2
local flagScalePos = 0 -- used only when flagScaleStyle = 2

local infoPic
local code
local info
local infoMode = false
local infoTimer
local spawnTable = {}   --Create a table to hold our spawns
local lineTable = {} --Table for deleting lighning lines
local lineTableCount = 0
local currColor = "first"
local prevColor = "first"
local motion
local choice = 0
local timerSpeed
local flag2Timer
local finalChallenge = false
local count = 1
local firstObject = true
local setTheFlag = false
local xCoord = 0
local yCoord = 0
local topBar1
local topBar2
local lowBar1
local lowBar2
local sideTimer
--local countryTraceTimer
local mapTimer
local flagTimer
local paceTimer
local setFlagTimer
local killBarsTimer
local resetSpawnTimer
local flag3Timer
local newFlagTimer
local killLowTimer
local killTopTimer
local rotationTimer

-- SAM: clear this weird shit up
local paceRect = {}

local map
local mapGroup
local waterGroup
local newGroup
local zoomMultiplier = .3

local flagFrameOptions
-- rename to flagFrame
local testFrame

local flag
local random

local deadText = nil
local speedTextDesc
local scoreTextDesc
local bonusText
local scoreText
local speedText
local countryText

local country

local nationalFlags1Coords = require("lua-sheets.national-flags1")
local nationalFlags1Sheet = graphics.newImageSheet("images/national-flags1.png", nationalFlags1Coords:getSheet())
local nationalFlags2Coords = require("lua-sheets.national-flags2")
local nationalFlags2Sheet = graphics.newImageSheet("images/national-flags2.png", nationalFlags2Coords:getSheet())
local nationalFlags3Coords = require("lua-sheets.national-flags3")
local nationalFlags3Sheet = graphics.newImageSheet("images/national-flags3.png", nationalFlags3Coords:getSheet())
local nationalFlagsSeq = {
    {name = "andorra", sheet = nationalFlags1Sheet, frames = {1}},
    {name = "argentina", sheet = nationalFlags1Sheet, frames = {2}},
    {name = "australia", sheet = nationalFlags1Sheet, frames = {3}},
    {name = "austria", sheet = nationalFlags1Sheet, frames = {4}},
    {name = "belgium", sheet = nationalFlags1Sheet, frames = {5}},
    {name = "brazil", sheet = nationalFlags1Sheet, frames = {6}},
    {name = "canada", sheet = nationalFlags1Sheet, frames = {7}},
    {name = "chile", sheet = nationalFlags1Sheet, frames = {8}},
    {name = "china", sheet = nationalFlags1Sheet, frames = {9}},
    {name = "croatia", sheet = nationalFlags1Sheet, frames = {10}},
    {name = "cyprus", sheet = nationalFlags1Sheet, frames = {11}},
    {name = "czechrepublic", sheet = nationalFlags1Sheet, frames = {12}},
    {name = "denmark", sheet = nationalFlags1Sheet, frames = {13}},
    {name = "egypt", sheet = nationalFlags1Sheet, frames = {14}},
    {name = "estonia", sheet = nationalFlags1Sheet, frames = {15}},
    {name = "finland", sheet = nationalFlags1Sheet, frames = {16}},
    {name = "france", sheet = nationalFlags1Sheet, frames = {17}},
    {name = "germany", sheet = nationalFlags1Sheet, frames = {18}},
    {name = "greece", sheet = nationalFlags1Sheet, frames = {19}},
    {name = "hungary", sheet = nationalFlags1Sheet, frames = {20}},
    {name = "iceland", sheet = nationalFlags1Sheet, frames = {21}},
    {name = "india", sheet = nationalFlags1Sheet, frames = {22}},
    {name = "indonesia", sheet = nationalFlags1Sheet, frames = {23}},
    {name = "ireland", sheet = nationalFlags1Sheet, frames = {24}},
    {name = "israel", sheet = nationalFlags2Sheet, frames = {1}},
    {name = "italy", sheet = nationalFlags2Sheet, frames = {2}},
    {name = "japan", sheet = nationalFlags2Sheet, frames = {3}},
    {name = "lithuania", sheet = nationalFlags2Sheet, frames = {4}},
    {name = "luxembourg", sheet = nationalFlags2Sheet, frames = {5}},
    {name = "malaysia", sheet = nationalFlags2Sheet, frames = {6}},
    {name = "malta", sheet = nationalFlags2Sheet, frames = {7}},
    {name = "mexico", sheet = nationalFlags2Sheet, frames = {8}},
    {name = "netherlands", sheet = nationalFlags2Sheet, frames = {9}},
    {name = "newzealand", sheet = nationalFlags2Sheet, frames = {10}},
    {name = "norway", sheet = nationalFlags2Sheet, frames = {11}},
    {name = "philippines", sheet = nationalFlags2Sheet, frames = {12}},
    {name = "poland", sheet = nationalFlags2Sheet, frames = {13}},
    {name = "portugal", sheet = nationalFlags2Sheet, frames = {14}},
    {name = "russia", sheet = nationalFlags2Sheet, frames = {16}},
    {name = "sanmarino", sheet = nationalFlags2Sheet, frames = {17}},
    {name = "singapore", sheet = nationalFlags2Sheet, frames = {18}},
    {name = "slovakia", sheet = nationalFlags2Sheet, frames = {19}},
    {name = "slovenia", sheet = nationalFlags2Sheet, frames = {20}},
    {name = "southafrica", sheet = nationalFlags2Sheet, frames = {21}},
    {name = "southkorea", sheet = nationalFlags2Sheet, frames = {22}},
    {name = "spain", sheet = nationalFlags2Sheet, frames = {23}},
    {name = "srilanka", sheet = nationalFlags2Sheet, frames = {24}},
    {name = "sweden", sheet = nationalFlags3Sheet, frames = {1}},
    {name = "switzerland", sheet = nationalFlags3Sheet, frames = {2}},
	-- SAM: Taiwan flag out of order in sprite/atlas because originally named Republic of China
    {name = "taiwan", sheet = nationalFlags2Sheet, frames = {15}},
    {name = "thailand", sheet = nationalFlags3Sheet, frames = {3}},
    {name = "turkey", sheet = nationalFlags3Sheet, frames = {4}},
    {name = "unitedarabemirates", sheet = nationalFlags3Sheet, frames = {5}},
    {name = "unitedkingdom", sheet = nationalFlags3Sheet, frames = {6}},
    {name = "unitedstates", sheet = nationalFlags3Sheet, frames = {7}}
}

local topBtmBarSpriteCoords = require("lua-sheets.TopBtmBar")
local topBtmBarSheet = graphics.newImageSheet("images/TopBtmBar.png", topBtmBarSpriteCoords:getSheet())

local topBtmBarSeq = {
    {name = "top", frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, time = 1000, loopCount = 0},
    {name = "btm", frames = {6, 7, 8, 9, 10, 1, 2, 3, 4, 5}, time = 1000, loopcount = 0},
}

local countryOutlineSheetCoords = require("lua-sheets.country_outline_mask")
local countryOutlineSheet = graphics.newImageSheet("images/country_outline_mask.png", countryOutlineSheetCoords:getSheet())
local countryOutline

local fxGroup
local fxBG
local fxAnim

local newTex = graphics.newTexture({type = "canvas", width = display.contentWidth, height = display.contentHeight})

local canvasObj = display.newImageRect(
    newTex.filename,  -- "filename" property required
    newTex.baseDir,   -- "baseDir" property required
    display.contentWidth,
    display.contentHeight
)
canvasObj.x = display.contentCenterX
canvasObj.y = display.contentCenterY

--SAM: for masked effects! noise generator
local circ
local mask

local buttonSheetInfo = require("lua-sheets.back_buttons")
local buttonSheet = graphics.newImageSheet( "images/back_buttons.png", buttonSheetInfo:getSheet() )

local btnsSheetCoords = require("lua-sheets.buttons")
local btnsSheet = graphics.newImageSheet("images/buttons.png", btnsSheetCoords:getSheet())

local btnsSeq = {
    {
        name = "xBtn",
        frames = {
            btnsSheetCoords:getFrameIndex("xBtn3"),
            btnsSheetCoords:getFrameIndex("xBtn5")
        },
        time = 500
    },
    {
        name = "xBtn_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("xBtn2"),
            btnsSheetCoords:getFrameIndex("xBtn3"),
            btnsSheetCoords:getFrameIndex("xBtn4"),
            btnsSheetCoords:getFrameIndex("xBtn5")
        },
        time = 500
    },
    {
        name = "fwBtn",
        frames = {
            btnsSheetCoords:getFrameIndex("backArrowBtn3"),
            btnsSheetCoords:getFrameIndex("backArrowBtn5")
        },
        time = 500
    },
    {
        name = "fwBtn_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("backArrowBtn2"),
            btnsSheetCoords:getFrameIndex("backArrowBtn3"),
            btnsSheetCoords:getFrameIndex("backArrowBtn4"),
            btnsSheetCoords:getFrameIndex("backArrowBtn5")
        },
        time = 500
    }
}

local menuSpriteCoords = require("lua-sheets.playgame-menu")
local menuStartSheet = graphics.newImageSheet( "images/playgame-menu.png", menuSpriteCoords:getSheet() )

local countryOutlineSheetCoords = require("lua-sheets.country_outline_mask")
local countryOutlineSheet = graphics.newImageSheet("images/country_outline_mask.png", countryOutlineSheetCoords:getSheet())
local countryOutline

local paletteBarSheetCoords = require("lua-sheets.palette_bar")
local paletteBarSheet = graphics.newImageSheet("images/palette_bar.png", paletteBarSheetCoords:getSheet())
local paletteBarTop
local paletteBarBtm

local fxGroup
local fxBG
local fxAnim

local newTex = graphics.newTexture({type = "canvas", width = display.contentWidth, height = display.contentHeight})

local canvasObj = display.newImageRect(
    newTex.filename,  -- "filename" property required
    newTex.baseDir,   -- "baseDir" property required
    display.contentWidth,
    display.contentHeight
)
canvasObj.x = display.contentCenterX
canvasObj.y = display.contentCenterY

--SAM: for masked effects! noise generator
local circ
local mask

--SAM: is this needed?
local function myImplodeListener(event)
    local thisSprite = event.target
    if (event.phase == "ended") then
        thisSprite.alpha = 0
        thisSprite:pause()
    end
end

local function round(val, n)
   if (n) then
      return math.floor( (val * 10^n) + 0.5) / (10^n)
   else
      return math.floor(val+0.5)
   end
end

local function myTouchListener(event)
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    print(currentObject.name)
    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then

        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "fwBtn" then
            currentObject:setSequence("fwBtn")
        elseif currentObject.name == "xBtn" then
            currentObject:setSequence("xBtn")
        end

        --SAM: canSkip is a bad variable name. This var controls access to both back AND quit buttons. Remove feature?
        if touchInsideBtn == true then

            print("touch OFF. inside")
            -- composer.removeScene("start")

            if(currentObject.name == "xBtn") then
                -- print("sideTimer:", sideTimer)
                if sideTimer then
                    timer.cancel(sideTimer)
                end

                composer.gotoScene ( "menu", { effect = defaultTransition } )
            elseif(currentObject.name == "fwBtn" and canSkip == true) then
                nextFlag()
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

            if(isBtnAnim) then
                if currentObject.name == "fwBtn" then
                    currentObject:setSequence("fwBtn")
                elseif currentObject.name == "xBtn" then
                    currentObject:setSequence("xBtn")
                end
            else
                if currentObject.name == "fwBtn" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "xBtn" then
                    currentObject:setFrame(1)
                end
            end
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if(isBtnAnim) then
                    if currentObject.name == "fwBtn" then
                        currentObject:setSequence("fwBtn_anim")
                    elseif currentObject.name == "xBtn" then
                        currentObject:setSequence("xBtn_anim")
                    end
                    currentObject:play()
                else
                    if currentObject.name == "fwBtn" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "xBtn" then
                        currentObject:setFrame(2)
                    end
                end
            end
            touchInsideBtn = true
        end
    end
end
--------------------------------
-- change to newImageRect()
local background = display.newRect(0, 0, _W, _H)
background:setFillColor(1, 1, 1)
background.anchorX = 0.5
background.anchorY = 0.5
background.name = "background"
background.x = _W / 2 ;background.y = _H / 2
background:toBack()

local water
local function setupVariables()
    w1 = 1;w2 = 1;w3 = 1
    k1 = 0;k2 = 0;k3 = 0
    r1 = 1;r2 = 0;r3 = 0
    o1 = 1;o2 = .502;o3 = 0
    y1 = 1;y2 = 1;y3 = 0
    g1 = 0;g2 = .4;g3 = 0
    b1 = 0;b2 = 0;b3 = 1

    paletteBarTop = display.newSprite( paletteBarSheet , {frames={paletteBarSheetCoords:getFrameIndex("palette_bar_top")}} )
    paletteBarBtm = display.newSprite( paletteBarSheet , {frames={paletteBarSheetCoords:getFrameIndex("palette_bar_btm")}} )

    if platform == "ios" then
        paletteBarTop.x = _W/2
        paletteBarTop.y = 0
        paletteBarTop.anchorX = .5
        paletteBarTop.anchorY = 0

        paletteBarBtm.x = _W/2
        paletteBarBtm.y = _H
        paletteBarBtm.anchorX = .5
        paletteBarBtm.anchorY = 1
    elseif platform == "android" then
        paletteBarTop.width = _W
        paletteBarTop.x = _W/2
        paletteBarTop.y = 0
        paletteBarTop.anchorX = .5
        paletteBarTop.anchorY = 0

        paletteBarBtm.width = _W
        paletteBarBtm.x = _W/2
        paletteBarBtm.y = _H
        paletteBarBtm.anchorX = .5
        paletteBarBtm.anchorY = 1
    end

    local margins = 6
    fwBtn = display.newSprite(btnsSheet, btnsSeq)
    fwBtn:setSequence("fwBtn")
    fwBtn.type = "fwBtn"
    fwBtn.name = "fwBtn"
    fwBtn.xScale = -1
    fwBtn.anchorX=0
    fwBtn.anchorY=0
    fwBtn.x = _W - margins
    fwBtn.y = _H - fwBtn.height - margins

    xBtn = display.newSprite(btnsSheet, btnsSeq)
    xBtn:setSequence("xBtn")
    xBtn.type = "xBtn"
    xBtn.name = "xBtn"
    xBtn.anchorX=0
    xBtn.anchorY=0
    xBtn.x = 0 + margins
    xBtn.y = 0 + margins
    xBtn.gotoScene = "menu"

    fwBtn:addEventListener("touch", myTouchListener)
    fwBtn:addEventListener("touch", doFunction)
    xBtn:addEventListener("touch", myTouchListener)
    xBtn:addEventListener("touch", doFunction)

    waterGroup = display.newGroup()
    local water = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )

    display.setDefault( "textureWrapX", "repeat" )
    display.setDefault( "textureWrapY", "repeat" )
    water.alpha = 1

    water.fill = { type = "image", filename = "images/water.png"}
    water.fill.scaleX = 32/display.actualContentWidth
    water.fill.scaleY = 32/display.actualContentHeight

    display.setDefault( "textureWrapX", "clampToEdge" )
    display.setDefault( "textureWrapY", "clampToEdge" )

    water.texOffsetX = 0
    water.texOffsetY = 0
    water.lastT = system.getTimer()
    water.rateX = 1
    water.rateY = -1

    function water.enterFrame( self )
    	local curT 	= system.getTimer()
    	local dt 	= curT - self.lastT
    	self.lastT 	= curT

    	local dOffsetX = dt * self.rateX / 20000
    	local dOffsetY = dt * self.rateY / 50000

    	self.texOffsetX = self.texOffsetX + dOffsetX
    	self.texOffsetY = self.texOffsetY + dOffsetY

    	--
    	-- Keep values in bounds [-1, 1]
    	--
    	if( dOffsetX >= 0 ) then
    		while(self.texOffsetX > 1) do
    			self.texOffsetX = self.texOffsetX - 2
    		end
    	else
    		while(self.texOffsetX < -1) do
    			self.texOffsetX = self.texOffsetX + 2
    		end
    	end
    	if( dOffsetY >= 0 ) then
    		while(self.texOffsetY > 1) do
    			self.texOffsetY = self.texOffsetY - 2
    		end
    	else
    		while(self.texOffsetY < -1) do
    			self.texOffsetY = self.texOffsetY + 2
    		end
    	end

    	self.fill.x = self.texOffsetX
    	self.fill.y = self.texOffsetY
    end

    Runtime:addEventListener( "enterFrame", water )
    waterGroup:insert(water)

    -- rename?
	local waterMask = graphics.newMask("images/map_mask.png")
	waterGroup:setMask(waterMask)
    waterGroup.maskX = _W/2
    waterGroup.maskY = _H/2

    -- do this math one time in this function, reuse
    if platform == "ios" then
        waterGroup.maskScaleY = 1.01
    elseif platform == "android" then
        -- divide (display.contentHeight + 35) by height of map_mask.png (waterMask)
        local alignMask = round( (_H + gameMechanics.heightModeTop) / 320, 2)
        -- alignMask will be 1.23
        -- print(alignMask)
        waterGroup.maskScaleY = alignMask
    end

    -- ['@1x'] = {2031, 851},
    -- ['@2x'] = {4062, 1702},
    -- ['@4x'] = {8124, 3404}

    mapDimensions = CFGameScaleComponents:getItemByID(1)

    testWidth = mapDimensions.dimensions['@1x'].width
    testHeight = mapDimensions.dimensions['@1x'].height

    mapGroup = display.newGroup()
    map = display.newImageRect("images/worldmap_2017_300.png", 8191, 4084)
    map.alpha = 1
    map.anchorX = 0
    map.anchorY = 0
    map.name = "map"
    map.x = 0
    map.y = 0
	mapGroup:insert(map)
    mapGroup.xScale = 1 * zoomMultiplier
    mapGroup.yScale = 1 * zoomMultiplier

    newGroup = display.newGroup()
    newGroup:insert(mapGroup)

	local mapMask = graphics.newMask("images/map_mask.png")

    newGroup:setMask(mapMask)
	newGroup.maskX = _W/2
	newGroup.maskY = _H/2

    -- do this math one time in this function, reuse
    if platform == "ios" then
        newGroup.maskScaleY = 1.01
    elseif platform == "android" then
        -- divide (display.contentHeight + 35) by height of map_mask.png (waterMask)
        local alignMask = round( (_H + gameMechanics.heightModeTop) / 320, 2)
        -- alignMask will be 1.23
        -- print(alignMask)
        newGroup.maskScaleY = alignMask
    end

    -- mapGroup:setMask(mapMask)
	-- mapGroup.maskScaleY = 1.01
	-- mapGroup.maskX = _W/2
	-- mapGroup.maskY = _H/2

    -- SAM: better name for variables speed and timeVar
    levelsArray = {
        {speed = 1, timeVar = 2550},
        {speed = 2, timeVar = 1700},
        {speed = 3, timeVar = 1250},
        {speed = 4, timeVar = 1000},
        {speed = 5, timeVar = 910},
        {speed = 6, timeVar = 750},
        {speed = 7, timeVar = 700},
        {speed = 8, timeVar = 600},
        {speed = 9, timeVar = 550},
        {speed = 10, timeVar = 450},
        {speed = 11, timeVar = 420},
        {speed = 12, timeVar = 400},
        {speed = 13, timeVar = 380},
        {speed = 14, timeVar = 365},
        {speed = 15, timeVar = 345},
        {speed = 16, timeVar = 335},
        {speed = 17, timeVar = 305},
        {speed = 18, timeVar = 280},
        {speed = 19, timeVar = 260},
        {speed = 20, timeVar = 240},
        {speed = 21, timeVar = 220},
        {speed = 22, timeVar = 200},
        {speed = 23, timeVar = 190},
        {speed = 24, timeVar = 185},
        {speed = 25, timeVar = 175},
        {speed = 26, timeVar = 170},
        {speed = 27, timeVar = 170},
        {speed = 28, timeVar = 165},
        {speed = 29, timeVar = 165},
        {speed = 30, timeVar = 160},
        {speed = 31, timeVar = 155},
        {speed = 32, timeVar = 155},
        {speed = 33, timeVar = 150},
        {speed = 34, timeVar = 145},
        {speed = 35, timeVar = 145},
        {speed = 36, timeVar = 140},
        {speed = 37, timeVar = 135},
        {speed = 38, timeVar = 125},
        {speed = 39, timeVar = 120},
        {speed = 40, timeVar = 110}
    }

    -- flag.anchorX = 0.5 ; flag.anchorY = 0.5
    --
    -- flag.width = 500
    -- flag.height = 333
    -- flag.xScale = .2
    -- flag.yScale = .2 * .7
    -- flag.anchorX = 1
    -- flag.anchorY = 0.5
    --
    -- flag.x = _W
    -- flag.y = _H/2

    flagFrameOptions = {
        x = _W,
        y = _H/2,
        width = 500,
        height = 333,
        xScale = .2,
        yScale = .2 * .7,
        anchorX = 1,
        anchorY = .5,
        flagPadding = 1,
        flagOffset = .5
    }

    -- rename testFrame to flagFrame
    testFrame = display.newRect(
        flagFrameOptions.x,
        flagFrameOptions.y,
        flagFrameOptions.width * flagFrameOptions.xScale + flagFrameOptions.flagPadding,
        flagFrameOptions.height * flagFrameOptions.yScale + flagFrameOptions.flagPadding
    )

    testFrame.anchorX = flagFrameOptions.anchorX
    testFrame.anchorY = flagFrameOptions.anchorY
    testFrame:setFillColor(0, 0, 0)

    -- flagFrameAnchorX and flagFrameAnchorY are derived from flagFrameOptions (used by testFrame) to place GUI objects pertaining and bound to flag area
    -- flagFrameAnchorX and flagFrameAnchorY set to the top-left corner of this flag area (flag, flagFrame, and lightningIcons)
    local flagFrameAnchorX = flagFrameOptions.x - ((flagFrameOptions.width * flagFrameOptions.xScale + flagFrameOptions.flagPadding) - 12) -- 12 to offset an extra amount from left-side of the flagFrame

    local flagFrameAnchorY = (flagFrameOptions.y - ((flagFrameOptions.height * flagFrameOptions.yScale + flagFrameOptions.flagPadding) / 2) - 6)
end

local function infoAppear()
   transition.to(infoPic, {time=500, alpha=1})
end

local function deleteText()
display.remove(CountryText)
 end

local function countryScale()
   countryTimer=transition.to( countryText, { time=500, alpha=0 })
   timer.performWithDelay(500,deleteText,1)
end

local animateCountryTimer
local animateCountry
local function triggerAnimateCountry()
    animateCountryTimer = timer.performWithDelay( 1000, animateCountry, 1 )
    -- timer.cancel(animateCountryTimer)
end
animateCountry = function()
    transition.to( fxBG.fill.effect, { time=10, angle=0, onComplete=
        function()
            transition.to( fxBG.fill.effect, { time=1390, angle=20, transition=easing.continuousLoop})
        end
    })
    transition.to( fxBG, { tag="moveNeedle", delay=50, time=1350, rotation=fxBG.rotation+90, transition = easing.inOutQuad, onComplete=function()
            triggerAnimateCountry()
        end
    })
end

-- READYOBJ: setFlag
setFlag = function()
    setTheFlag = true
end

-- READYOBJ: delayPace
delayPace = function()
    paceRect.isMoving = true
end

-- READYOBJ: setCountryParameters
setCountryParameters = function()
    -- if countriesCompleted > 0 then
    --     print(type(flag)) -- flag var type seems to be a table?
    --     flag:removeSelf()
    --     flag = nil
    -- end

    -- xBtn:toFront()
    -- fwBtn:toFront()

    music = nil

    newCountry()
    sideTimer = timer.performWithDelay(gameMechanics.transitionToCountryDuration, finishScale, 1)
    -- SAM: IMPORTANT, rename paceTimer to something more serious
    paceTimer = timer.performWithDelay(10, delayPace, 1)
    mapTimer = transition.to( mapGroup, { time=gameMechanics.transitionToCountryDuration, x=xCoord, y=yCoord, xScale=1*zoomMultiplier, yScale=1*zoomMultiplier})
end

-- READYOBJ: newCountry
newCountry = function()
    -- largerCountries to debugOptions
    -- local largerCountries = {2, 3, 6, 7, 9, 39, 55}
    -- local e = largerCountries[math.random(table.getn(largerCountries))]

    -- make this into array with a variety of sets - changing between 2 or more countries in sequence

    -- SAM: change to countries? All country data is kept in here.. reference to cf_game_settings.lua
    if not cuedCountry then
        local randomCountry = math.random(CFGameSettings:getLength())
        country = CFGameSettings:getItemByID(randomCountry)
    else
        country = CFGameSettings:getItemByID(cuedCountry)
    end
        -- local randomCountry = math.random(CFGameSettings:getLength())
        -- country = CFGameSettings:getItemByID(randomCountry)
    -- print("current country: ", country.name)

    --SAM: should i put this outside the countries() function? Or is no need for it to be in a function?
    function destroyStuff()

        if(countryOutline ~= nil) then
            countryOutline:removeSelf()
            countryOutline = nil
        end

        -- print(mapGroup.numChildren)
        if(mapGroup) then
            for j=mapGroup.numChildren, 1, -1 do
                if(mapGroup[j].id == "fxGroup") then
                    for k=mapGroup[j].numChildren, 1, -1 do
                        local child = mapGroup[j][k]
                        print("fxGroup item")
                        print(child.fill)
                        child:removeSelf()
                        child = nil
                    end
                    print("remove group: ", mapGroup[j].id )
                    mapGroup[j]:removeSelf()
                end
            end
        end
    end
    destroyStuff()

    countryOutline = display.newSprite( countryOutlineSheet, {frames={countryOutlineSheetCoords:getFrameIndex(country.name)}} )

    -- print("country width:", countryOutline.width, "country height:", countryOutline.height)

    -- SAM: zoom to country
    --[[
    if countryOutline.width < _W/2 and countryOutline.height < _H/2 then
    end
    ]]--

    -- SAM: countryOutline scaling
    countryOutlineWidthMultiplier = display.pixelHeight/display.contentWidth
    countryOutlineHeightMultiplier = display.pixelWidth/display.contentHeight
    -- print("pixelHeight / contentWidth: ", countryOutlineWidthMultiplier)
    -- print("pixelWidth / contentHeight: ", countryOutlineHeightMultiplier)
    countryOutline:scale(1/countryOutlineWidthMultiplier, 1/countryOutlineHeightMultiplier)

    -- SAM: originally a local variable
    fxGroup = display.newGroup()
    fxGroup.id = "fxGroup"

    -- print("countryOutline.width:" .. countryOutline.width, "countryOutline.height" .. countryOutline.height)

    local fxSize
    if(countryOutline.width > countryOutline.height) then
        -- delete?
        -- fxSize = math.ceil(countryOutline.width * countryOutline.xScale) + 120
        fxSize = math.ceil(countryOutline.width) + 120
    else
        -- delete?
        -- fxSize = math.ceil(countryOutline.height * countryOutline.yScale) + 120
        fxSize = math.ceil(countryOutline.width) + 120
    end

    -- print("circumference of fxBG:", fxSize)

	-- SAM: make into local variable? I don't know if there's a visual difference for when fxBG is local vs global. Leave as is until thoroughly tested
	fxBG = display.newCircle(0, 0, fxSize)
    fxBG.anchorX = .5
    fxBG.anchorY = .5

    -- SAM: what does this scaleFactorX and scaleFactorY do?
    local scaleFactorX = 1
	local scaleFactorY = 1

    -- print("fxBG width:", fxBG.width, "fxBG height:", fxBG.height)

    if (fxBG.width > fxBG.height) then
        scaleFactorY = fxBG.width / fxBG.height
    else
        scaleFactorX = fxBG.height / fxBG.width
    end

    local tileMultiplier = .9
    display.setDefault("textureWrapX", "repeat")
    display.setDefault("textureWrapY", "mirroredRepeat")
    -- SAM: rename png, add scaling variants
    fxBG.fill = {type = "image", filename = "images/fxgroup.png"}
    -- scales the cloud texture
    fxBG.fill.scaleX = tileMultiplier * 1
    fxBG.fill.scaleY = tileMultiplier * 1
    fxBG.fill.effect = "filter.straighten"
    fxBG.fill.effect.width = 20
    fxBG.fill.effect.height = 1
    fxBG.fill.effect.angle = 20
    fxBG.rotation = 0

    fxGroup.x=(map.x)-(map.x-country.coords.x-(countryOutline.width/2))
    fxGroup.y=(map.y)-(map.y-country.coords.y-(countryOutline.height/2))
    fxGroup:insert(fxBG)

    newTex = graphics.newTexture( { type="canvas", width=fxSize, height=fxSize } )
    newTex:draw(countryOutline)
    newTex:invalidate()

    -- SAM: masks fxBG (newCircle) with country outline
    mask = graphics.newMask(newTex.filename, newTex.baseDir)
    fxGroup:setMask(mask)
    canvasObj.alpha = 0

    mapGroup:insert(fxGroup)

    -- sends newCircle() to back, behind country
    -- fxGroup:toBack()

    -- (2031/2) - 958 - (?/2)
    -- (851/2) - 225 - (?/2)
    -- xCoord=(_W/2)-country.coords.x-(countryOutline.width/2)
    -- yCoord=(_H/2)-country.coords.y-(countryOutline.height/2)
    -- (2031/2) - (958*1.5) - ((?*1.5)/2)
    -- (851/2) - (225*1.5) - ((?*1.5)/2)
    xCoord=(_W/2)-(country.coords.x*zoomMultiplier)-((countryOutline.width*zoomMultiplier)/2)
    yCoord=(_H/2)-(country.coords.y*zoomMultiplier)-((countryOutline.height*zoomMultiplier)/2)

    -- print("xCoord:", xCoord, "yCoord:", yCoord)

    if(countriesCompleted == 0) then
        animateCountry()
    end

    info="images/infoBrazil.png"

    flag=display.newSprite(nationalFlags1Sheet,nationalFlagsSeq, 100, 10)
    flag:setSequence(country.name)
    flag.x = _W - flagFrameOptions.flagOffset
    flag.y = _H/2
    flag.width = 500
    flag.height = 333
    flag.xScale = .2
    flag.yScale = .2 * .7
    flag.anchorX = 1
    flag.anchorY = 0.5

    code = country.code

    if(country.colors.r) then
        r1 = country.colors.r.r
        r2 = country.colors.r.g
        r3 = country.colors.r.b
        -- print(r1, r2, r3)
    end
    if(country.colors.w) then
        w1 = country.colors.w.r
        w2 = country.colors.w.g
        w3 = country.colors.w.b
        -- print(w1, w2, w3)
    end
    if(country.colors.y) then
        y1 = country.colors.y.r
        y2 = country.colors.y.g
        y3 = country.colors.y.b
        -- print(y1, y2, y3)
    end
    if(country.colors.g) then
        g1 = country.colors.g.r
        g2 = country.colors.g.g
        g3 = country.colors.g.b
        -- print(g1, g2, g3)
    end
    if(country.colors.b) then
        b1 = country.colors.b.r
        b2 = country.colors.b.g
        b3 = country.colors.b.b
        -- print(b1, b2, b3)
    end
    if(country.colors.o) then
        o1 = country.colors.o.r
        o2 = country.colors.o.g
        o3 = country.colors.o.b
        -- print(o1, o2, o3)
    end
    if(country.colors.k) then
        k1 = country.colors.k.r
        k2 = country.colors.k.g
        k3 = country.colors.k.b
        -- print(k1, k2, k3)
    end

	-- if check.. when first flag appear. there will be no music. !!!
    if countriesCompleted ~= 0 then
        audio.stop(bobby)
    end

    music = audio.loadStream("anthems/" .. country.name .. ".mp3")
    bobby = audio.play(music, {loops=-1, onComplete=function(event)
        print("finished streaming ANTHEM on channel ", event.channel)
    end})
end

local function removeFlag()
    flag:removeSelf()
    flag = nil
end

--MIKE: Can we somehow arrange the finishScale() function after the newFlag() function, its importance is pretty relevant to newFlag() ?? Maybe merge all functions pertaining to newFlag and flag enlargement into one neat function
finishScale = function()
    canSkip=true

    transition.to(flag, {time = 1000, alpha = 1})

    --SAM: delete this? used for offsetting when speedUp() occurs - can happen in during midst of a country
    -- timerSpeed = timer.performWithDelay(9500, speedUp, 1)

    countriesCompleted = countriesCompleted + 1
end

-- READYOBJ: moveObject
moveObject = function(e)
    if gameMechanics.countriesSpawned == 0 then
        print("hey")
        readyObject(1)
        return
    end
    readyObject()
end

-- SAM: rename this, calls newFlag and resets the palettes
-- READYOBJ: readyObject
readyObject = function(firstCountry)
    if firstCountry then
        print("first")
        gameMechanics.countriesSpawned = gameMechanics.countriesSpawned + 1
        print("countriesSpawned: " .. gameMechanics.countriesSpawned)
        setCountryParameters()
        setFlagTimer = timer.performWithDelay(gameMechanics.playCountryDuration, setFlag, 1)
        return
    end
    if setTheFlag == true then
        print("normal")
        setTheFlag = false
        -- gameMechanics.overrideFlag = false

        removeFlag()

        setCountryParameters()
        timer.cancel(setFlagTimer)
        -- print(setFlagTimer)
        setFlagTimer = timer.performWithDelay(gameMechanics.playCountryDuration, setFlag, 1)
    end
end

nextFlag = function()
    if country.id < CFGameSettings:getLength() then
        cuedCountry = country.id + 1
    else
        cuedCountry = 1
    end

    timer.cancel(setFlagTimer)
    setFlag()
end

local countryPickerOpts = {
    isModal = true,
    effect = "fade",
    time = 0,
    params = {
        pickerCountry = "choose a country"
    }
}
composer.showOverlay("_tableview", countryPickerOpts)

scene.countryPicker = function(chosenWithCountryPicker)
    -- local pickerCountry = chosenWithCountryPicker
    -- newFlag(pickerCountry)
    cuedCountry = chosenWithCountryPicker
    timer.cancel(setFlagTimer)
    setFlag()
end
------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
function scene:create(e)
    --
    -- local margins = 6
    -- fwBtn = display.newSprite(btnsSheet, btnsSeq)
    -- fwBtn:setSequence("fwBtn")
    -- fwBtn.type = "fwBtn"
    -- fwBtn.name = "fwBtn"
    -- fwBtn.xScale = -1
    -- fwBtn.anchorX=0
    -- fwBtn.anchorY=0
    -- fwBtn.x = _W - margins
    -- fwBtn.y = _H - fwBtn.height - margins
    --
    -- xBtn = display.newSprite(btnsSheet, btnsSeq)
    -- xBtn:setSequence("xBtn")
    -- xBtn.type = "xBtn"
    -- xBtn.name = "xBtn"
    -- xBtn.anchorX=0
    -- xBtn.anchorY=0
    -- xBtn.x = 0 + margins
    -- xBtn.y = 0 + margins
    -- xBtn.gotoScene = "menu"
    -- fwBtn:addEventListener("touch", myTouchListener)
    -- fwBtn:addEventListener("touch", doFunction)
    -- xBtn:addEventListener("touch", myTouchListener)
    -- xBtn:addEventListener("touch", doFunction)
end

function scene:show(e)
    local sceneGroup = self.view

    if (e.phase == "will") then
        setupVariables()

        sceneGroup:insert(waterGroup)
        sceneGroup:insert(newGroup)

        random = math.randomseed( os.time() )
    elseif (e.phase == "did") then
        -- READYOBJ: START

        system.activate( "multitouch" )
        Runtime:addEventListener("enterFrame", moveObject)

        -- timer.performWithDelay(15000, checkMemory,0)
    end
end

function scene:hide(e)
  print("HIDE")
  if e.phase == "will" then

    fwBtn:removeEventListener("touch", myTouchListener)
    fwBtn:removeEventListener("touch", doFunction)
    xBtn:removeEventListener("touch", myTouchListener)
    xBtn:removeEventListener("touch", doFunction)
    --composer.removeScene("tableView")
    display.remove(background)

    display.remove(paletteBarTop)
    display.remove(paletteBarBtm)
    display.remove(testFrame)

    display.remove(flag)
    display.remove(xBtn)
    display.remove(fwBtn)
    display.remove(countryText)
    display.remove(country)
    display.remove(infoPic)
    print("quit")
    Runtime:removeEventListener("enterFrame", moveObject)

    composer.removeScene("cruise",false)
  end
end

function scene:destroy(e)
    print("DESTROY")
end

scene:addEventListener( "create", scene)
scene:addEventListener( "show"  , scene)
scene:addEventListener( "hide"  , scene)
scene:addEventListener( "destroy"  , scene)
-----------------------------------------------------------------------------------------
return scene
