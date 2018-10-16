-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html
local CFText = require("cf_text")
local composer = require("composer")
local scene = composer.newScene()

-- stop audioReservedChannel1. set it to nil?
audio.stop( 1 )
audioReservedChannel1 = nil
audio.stop( 2 )
audioReservedChannel2 = nil

-- audio stuff
local music
local bobby

-- SAM: SFXShortL to sfxShortL
local SFXShortL = audio.loadSound( "sfx/shortL.wav" )
local SFXShortR = audio.loadSound( "sfx/shortR.wav" )
local SFXPaletteHit = audio.loadSound( "sfx/puff-attempt.wav" )
local offsetPaletteDeathSFX = 20

--effects createPalette()
cornersArray = {"TopLeft", "TopRight", "BottomLeft", "BottomRight"}
local inclusiveColorsArray = {}
local codeLetterToColorKey = {
    w = "white",
    k = "black",
    r = "red",
    o = "orange",
    y = "yellow",
    g = "green",
    b = "blue"
}

local game_W = display.actualContentWidth -- Get the width of the screen
local game_H = display.actualContentHeight -- Get the height of the screen

--SAM: var to handle death
--SAM: var to handle animations

local debugOptions = {}
debugOptions.god = false
debugOptions.constantSpeed = true
debugOptions.cycleModes = false
debugOptions.topBottomBars = false
debugOptions.brazilToCanada = false -- make this into array with a variety of sets - changing between 2 or more countries in sequence
debugOptions.adherenceToFlagColors = false

local gameMechanics = {}
gameMechanics.playCountryDuration = 4000
gameMechanics.transitionToCountryDuration = 2000
gameMechanics.firstPaletteDelay = 10
gameMechanics.countriesSpawned = 0
gameMechanics.overrideFlag = false
gameMechanics.heightModeTop = 35
gameMechanics.heightModeLow = _H - 35
gameMechanics.mode = 1
-- FPS
if fps == 30 then
    gameMechanics.paletteSpawnDelay = 85
else
    gameMechanics.paletteSpawnDelay = 42.5
end

-- delete
-- lightningY=90
-- infoMode=true

local lightningCount = 1

local score = 0
local numDeaths = 0

local levelsArray
local speedTableIndex = 3
local speed
local timeVar

-- checks if game just started
local countriesCompleted = 0

local infoPic
local code

-- MIKE: get rid of all the info related stuff for now. Bring back in CF 2.0
local info
local infoMode = true
local infoTimer
local spawnTable = {}   --Create a table to hold our spawns
local lineTable = {} --Table for deleting lighning lines
local lineTableCount = 0
local currentColor = "first"
local previousColor = "first"
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

------------------------------------------------------------------------------------------------------
-- TELL MIKE
-- SAM: declaring these variables first, assigning functions to them later. That way they can be called in any function regardless of how far down it is in the file.
-- https://forums.coronalabs.com/topic/65415-addeventlistener-listener-cannot-be-nil-nil/

local setCountryParameters
local newCountry
local moveObject
local readyObject

local resetSpawnTable
local setFlag
local delayPace
local finishScale
local onOptionsTap
local speedUp
------------------------------------------------------------------------------------------------------

local newFlagTimer
local killLowTimer
local killTopTimer
local flagLightningReady
local flagLightningActive = false
local rotationTimer
local lightningIcon1
local lightningIcon2
local lightningIcon3
local lightningIcon4
local lightningIcon5
local lightningScore = 0
local lightningMultiplier = 1
local line
--SAM: what is paceRect used for
local paceRect
local map
local mapGroup
local waterGroup
local newGroup
local zoomMultiplier = .1

local jitterCameraPosition = {}
jitterCameraPosition.pseudoTargetX = 0
jitterCameraPosition.pseudoTargetY = 0
jitterCameraPosition.x1 = 0
jitterCameraPosition.y1 = 0

local distanceFromCamera = {}
distanceFromCamera.pseudoTargetX = 0
distanceFromCamera.pseudoTargetY = 0
distanceFromCamera.x = 0
distanceFromCamera.y = 0
distanceFromCamera.enemySpeed = 30
distanceFromCamera.amplitude = .01

local flagFrameOptions
-- rename to flagFrame
local testFrame

local flag
local random

local bonusText

-- SAM: store all scoreboard variables inside an array.. scoreboardArray = {}

local speedTextGroup
local speedText
local speedTextDesc
local speedDecreaseBtnGroup
local speedIncreaseBtnGroup
local speedDecreaseBtnFill
local speedIncreaseBtnFill
local speedDecreaseBtnSym
local speedIncreaseBtnSym

local scoreTextGroup
local scoreText
local scoreTextDesc
local scoreDecreaseBtnGroup
local scoreIncreaseBtnGroup
local scoreDecreaseBtnFill
local scoreIncreaseBtnFill
local scoreDecreaseBtnSym
local scoreIncreaseBtnSym

local modeTextGroup
local modeText
local modeTextDesc
local modeDecreaseBtnGroup
local modeIncreaseBtnGroup
local modeDecreaseBtnFill
local modeIncreaseBtnFill
local modeDecreaseBtnSym
local modeIncreaseBtnSym

local gameDebugGroup

local gameDebugArray = {}

gameDebugArray.gameDebugDeathBtnGroup = nil
gameDebugArray.gameDebugDeathBtnDesc = nil
gameDebugArray.gameDebugDeathBtnFill = nil
gameDebugArray.gameDebugDeathBtnSym = nil

gameDebugArray.gameDebugSpeedBtnGroup = nil
gameDebugArray.gameDebugSpeedBtnDesc = nil
gameDebugArray.gameDebugSpeedBtnFill = nil
gameDebugArray.gameDebugSpeedBtnSym = nil

gameDebugArray.gameDebugCycleBtnGroup = nil
gameDebugArray.gameDebugCycleBtnDesc = nil
gameDebugArray.gameDebugCycleBtnFill = nil
gameDebugArray.gameDebugCycleBtnSym = nil

local deathScenario2Array = {}

-- SAM: change to countries? All country data is kept in here.. reference to cf_game_settings.lua
local country
local countryText

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

-- REMOVE
local topBtmBarSpriteCoords = require("lua-sheets.TopBtmBar")
local topBtmBarSheet = graphics.newImageSheet("images/TopBtmBar.png", topBtmBarSpriteCoords:getSheet())

local topBtmBarSeq = {
    {name = "top", frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, time = 1000, loopCount = 0},
    {name = "btm", frames = {6, 7, 8, 9, 10, 1, 2, 3, 4, 5}, time = 1000, loopcount = 0},
}

local bonusImplodeSpriteCoords1 = require("lua-sheets.bonus-implode1")
local bonusImplodeSheet1 = graphics.newImageSheet("images/bonus-implode1.png", bonusImplodeSpriteCoords1:getSheet())

local bonusImplodeSpriteCoords2 = require("lua-sheets.bonus-implode2")
local bonusImplodeSheet2 = graphics.newImageSheet("images/bonus-implode2.png", bonusImplodeSpriteCoords2:getSheet())

local bonusImplodeSeq = {
    {name = "2x", sheet = bonusImplodeSheet1, frames = {1, 2, 3, 4, 5, 6}, time = 800, loopCount = 1},
    {name = "3x", sheet = bonusImplodeSheet2, frames = {1, 2, 3, 4, 5, 6}, time = 800, loopCount = 1},
    {name = "4x", sheet = bonusImplodeSheet1, frames = {7, 8, 9, 10, 11, 12}, time = 800, loopCount = 1},
    {name = "5x", sheet = bonusImplodeSheet2, frames = {7, 8, 9, 10, 11, 12}, time = 800, loopCount = 1},
    {name = "6x", sheet = bonusImplodeSheet1, frames = {13, 14, 15, 16, 17, 18}, time = 800, loopCount = 1},
    {name = "7x", sheet = bonusImplodeSheet1, frames = {19, 20, 21, 22, 23, 24}, time = 800, loopCount = 1},
    {name = "8x", sheet = bonusImplodeSheet1, frames = {25, 26, 27, 28, 29, 30}, time = 800, loopCount = 1},
    {name = "9x", sheet = bonusImplodeSheet2, frames = {13, 14, 15, 16, 17, 18}, time = 800, loopCount = 1},
}

-- SAM: how about no multipack! There are only going to be 4 or 5 more image files anyway. This will make configuring the animation sequence easier

-- SAM: char1, char2, charPlus

local bonusScatter = {}
bonusScatter.spriteCoords1 = require("lua-sheets.bonus-scatter1")
bonusScatter.sheet1 = graphics.newImageSheet("images/bonus-scatter1.png", bonusScatter.spriteCoords1:getSheet())

bonusScatter.sequence = {
    {
        name = "1",
        sheet = bonusScatter.sheet1,
        frames = {5, 5, 5, 5, 6, 7, 8, 9, 10, 11, 2, 3, 4},
        -- ???
        -- transition = easing.inCubic,
        time = 800,
        loopCount = 1},
}

-- SAM: put in new bonusShatter array
local bonusShatterBool = true
local bonusImplode = display.newSprite(bonusScatter.sheet1, bonusScatter.sequence)
bonusImplode:scale(.5, .5)
bonusImplode.alpha = 0 --start with 0

local function spriteListener( event )
    -- print( "Sprite event: ", event.target.sequence, event.target.frame, event.phase )
end

-- Add sprite listener (assumes "mySprite" is a valid sprite object)
bonusImplode:addEventListener( "sprite", spriteListener )

local lightningIconsCoords = require("lua-sheets.new-lightning-icons")
local lightningIconsSheet = graphics.newImageSheet("images/new-lightning-icons.png", lightningIconsCoords:getSheet())
-- local lightningIcons = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})

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

-- READYOBJ: onOptionsTap
onOptionsTap = function(event)
    local optionName = event.target.name
    if optionName == "speedDecrease" or optionName == "speedIncrease" then
        if flag ~= nil and debugOptions.constantSpeed == false then
            if optionName == "speedIncrease" then
                speedUp()
            end

            -- wrap in a function.. this can all be in the speedUp() function?
            if fps == 30 then
                speed = levelsArray[speedTableIndex].speed
            else
                speed = levelsArray[speedTableIndex].speed / 2
            end

            timeVar = levelsArray[speedTableIndex].timeVar
            speedText.text = speed
            speedText:toFront()
        end
    elseif optionName == "modeDecrease" or optionName == "modeIncrease" then
        if flag ~= nil and debugOptions.cycleModes == false then
            if optionName == "modeDecrease" then
                if gameMechanics.mode > 1 then
                    gameMechanics.mode = gameMechanics.mode - 1
                else
                    gameMechanics.mode = 3
                end
            elseif optionName == "modeIncrease" then
                if gameMechanics.mode < 3 then
                    gameMechanics.mode = gameMechanics.mode + 1
                else
                    gameMechanics.mode = 1
                end
            end
            -- print("gameMechanics.mode set in onOptionsTap(): " .. gameMechanics.mode)
            -- SAM: rename gameMechanics.mode to mode
            modeText.text = gameMechanics.mode

            timer.cancel(setFlagTimer)
            setFlag()
            gameMechanics.overrideFlag = true
        end
    elseif optionName == "gameDebugDeath" then
        if debugOptions.god == false then
            debugOptions.god = true
            gameDebugDeathBtnSym.text = "X"
        else
            debugOptions.god = false
            gameDebugDeathBtnSym.text = ""
        end
    elseif optionName == "gameDebugSpeed" then
        if debugOptions.constantSpeed == false then
            debugOptions.constantSpeed = true
            gameDebugSpeedBtnSym.text = "X"
        else
            debugOptions.constantSpeed = false
            gameDebugSpeedBtnSym.text = ""
        end
    elseif optionName == "gameDebugCycle" then
        if debugOptions.cycleModes == false then
            debugOptions.cycleModes = true
            gameDebugCycleBtnSym.text = "X"
        else
            debugOptions.cycleModes = false
            gameDebugCycleBtnSym.text = ""
        end
    end
    return true
end

-- local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelHeight, game_H)
local background = display.newRect(0, 0, display.pixelHeight, game_H)
background:setFillColor(1, 1, 1)
-- background.anchorX = .5
-- background.anchorY = .5
background.name = "background"
-- background.x = game_W/2
-- background.y = game_H/2
background:toBack()

-- local waterMask
-- local mapMask
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
        paletteBarTop.x = _W/2 -- fix like for platform == "android"
        paletteBarTop.y = 0
        paletteBarTop.anchorX = .5
        paletteBarTop.anchorY = 0

        paletteBarBtm.x = _W/2 -- fix like for platform == "android"
        paletteBarBtm.y = _H -- fix like for platform == "android"
        paletteBarBtm.anchorX = .5
        paletteBarBtm.anchorY = 1
    elseif platform == "android" then
        -- paletteBarTop.width = display.actualContentWidth +
        print("actualContentWidth from game.lua", display.actualContentWidth)
        paletteBarTop.width = game_W
        paletteBarTop.x = game_W/2
        paletteBarTop.y = 0
        paletteBarTop.anchorX = .5
        paletteBarTop.anchorY = 0

        paletteBarBtm.width = game_W
        paletteBarBtm.x = game_W/2
        paletteBarBtm.y = game_H
        paletteBarBtm.anchorX = .5
        paletteBarBtm.anchorY = 1
    end

    -- paletteBarTop.alpha = 0
    -- paletteBarBtm.alpha = 0

    waterGroup = display.newGroup()
    water = display.newRect( display.contentCenterX, display.contentCenterY, game_W, game_H ) -- IMPORTANT, must be set to game_W / game_H, which change according to immerstiveSticky mode

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
	local waterMask = graphics.newMask("images/map_mask_2018.png")
	waterGroup:setMask(waterMask)
    waterGroup.maskX = display.contentCenterX
    waterGroup.maskY = display.contentCenterY
    -- waterGroup.maskX = game_W/2
    -- waterGroup.maskY = game_H/2

    -- do this math one time in this function, reuse
    if platform == "ios" then
        waterGroup.maskScaleX = 1.10
        waterGroup.maskScaleY = 1.01
    elseif platform == "android" then

        -- SAM: immersiveSticky, on newer androids
        -- helps when entering immersiveSticky mode (or allow hiding of nav bar).
        -- water will always extend past screen edges and will resize the group past the display's width, hopefully across all android devices.
        waterGroup.maskScaleX = 1.5

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
    -- map.alpha = 0
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

	-- mapMask = graphics.newMask("images/map_mask_2018.png")

    newGroup:setMask(waterMask)
    newGroup.maskX = display.contentCenterX
    newGroup.maskY = display.contentCenterY
	-- newGroup.maskX = game_W/2
	-- newGroup.maskY = game_H/2

    -- do this math one time in this function, reuse
    if platform == "ios" then
        newGroup.maskScaleX = 1.10
        newGroup.maskScaleY = 1.01
    elseif platform == "android" then

        -- SAM: immersiveSticky, on newer androids
        -- helps when entering immersiveSticky mode (or allow hiding of nav bar).
        -- water will always extend past screen edges and will resize the group past the display's width, hopefully across all android devices.
        newGroup.maskScaleX = 1.5

        -- divide (display.contentHeight + 35) by height of map_mask.png (waterMask)
        local alignMask = round( (_H + gameMechanics.heightModeTop) / 320, 2)
        -- alignMask will be 1.23
        -- print(alignMask)
        newGroup.maskScaleY = alignMask
    end

    newGroup.alpha = 0

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
    local lightningIconPaddingLeft = ((flagFrameOptions.width * flagFrameOptions.xScale + flagFrameOptions.flagPadding) / 5) -- 5 in this case, represents the # of lightningIcons
    -- local lightningIconPaddingBottom

    lightningIcon1 = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})
    lightningIcon1.x = flagFrameAnchorX
    lightningIcon1.y = flagFrameAnchorY

    lightningIcon2 = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})
    lightningIcon2.x = flagFrameAnchorX + (lightningIconPaddingLeft)
    lightningIcon2.y = flagFrameAnchorY

    lightningIcon3 = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})
    lightningIcon3.x = flagFrameAnchorX + (lightningIconPaddingLeft * 2)
    lightningIcon3.y = flagFrameAnchorY

    lightningIcon4 = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})
    lightningIcon4.x = flagFrameAnchorX + (lightningIconPaddingLeft * 3)
    lightningIcon4.y = flagFrameAnchorY

    lightningIcon5 = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})
    lightningIcon5.x = flagFrameAnchorX + (lightningIconPaddingLeft * 4)
    lightningIcon5.y = flagFrameAnchorY

    lightningIcon1.alpha = .2
    lightningIcon2.alpha = .2
    lightningIcon3.alpha = .2
    lightningIcon4.alpha = .2
    lightningIcon5.alpha = .2

    --[[
    -- jitterCameraPosition to add/enhance position derived from distanceFromCamera
    jitterCameraPosition.target = display.newCircle(_W/2, _H/2, 20)
    jitterCameraPosition.target:setFillColor(0)
    jitterCameraPosition.target.anchorX = .5
    jitterCameraPosition.target.anchorY = .5
    jitterCameraPosition.x0 = 0
    jitterCameraPosition.y0 = jitterCameraPosition.target.y
    jitterCameraPosition.enemySpeed = 15
    jitterCameraPosition.amplitude = 2

    local jitterEvent = function( event )
        jitterCameraPosition.x0 = jitterCameraPosition.x0 + 1
        local y = jitterCameraPosition.y0 + math.sin(jitterCameraPosition.x0 / jitterCameraPosition.enemySpeed) * jitterCameraPosition.amplitude
        jitterCameraPosition.target.x = jitterCameraPosition.x0
        -- OR
        jitterCameraPosition.target.x = 0
        jitterCameraPosition.target.y = y
    end
    Runtime:addEventListener( "enterFrame", jitterEvent )
    ]]--
end

function adjustWidthsAfterResize( event )

    game_W = display.actualContentWidth
    game_H = display.actualContentHeight

    local bigRed = display.newRect(display.screenOriginX, 0, game_W, game_H)
    bigRed.anchorX = 0
    bigRed.anchorY = 0
    bigRed:setFillColor( 0.9, 0, 0 )
    transition.to(bigRed, {time=200, alpha=0, onComplete = function() display.remove(bigRed) end})

    background.xScale = 2 -- scale by 2 of display.pixelHeight - original width of newRect()

    -- IMPORTANT, must be set to game_W / game_H, which change according to immerstiveSticky mode
    water.x = display.contentCenterX
    water.y = display.contentCenterY
    water.width = game_W
    water.height = game_H

    waterGroup.maskScaleX = 2 -- scale by 2 of game_W
    newGroup.maskScaleX = 2 -- scale by 2 of game_W

end

if platform == "android" then
    local function onResize( event )
        -- SAM: this needs to happen again - IMPORTANT!
        native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
        onResizeTimer = timer.performWithDelay( 1000, function() adjustWidthsAfterResize() end )
    end
    Runtime:addEventListener( "resize", onResize )
end

local function setupScoreboard()

    local scoreboardColor = {
        highlight = {r = 1, g = 1, b = 1},
        shadow = {r = 0, g = 0, b = 0}
    }

    local scoreboardOffsetFromLeft = 5
    local scoreboardOffsetFromEachOther = 60
    local scoreboardOffsetIncDecBtns = 1.2

    local scoreTextGroupAnchorX = scoreboardOffsetFromLeft
    local scoreTextGroupAnchorY = _H/2

    scoreTextGroup = display.newGroup()
    scoreTextDesc = display.newEmbossedText("score:", scoreTextGroupAnchorX, scoreTextGroupAnchorY, "PTMono-Bold", 12)
    scoreTextDesc:setFillColor(.2, .9, .4)
    scoreTextDesc:setEmbossColor(scoreboardColor)
    scoreTextDesc.anchorX = 0
    scoreTextDesc.anchorY = 1
    scoreTextGroup:insert(scoreTextDesc)

    scoreText = display.newEmbossedText(score, scoreTextGroupAnchorX + (scoreTextDesc.width/2), scoreTextGroupAnchorY, "PTMono-Bold", 18)
    scoreText:setFillColor(.2, .9, .4)
    scoreText:setEmbossColor(scoreboardColor)
    scoreText.anchorY = 0
    scoreTextGroup:insert(scoreText)

    local speedTextGroupAnchorX = scoreboardOffsetFromLeft + scoreboardOffsetFromEachOther
    local speedTextGroupAnchorY = _H/2

    speedTextGroup = display.newGroup()

    speedTextDesc = display.newEmbossedText("speed:", speedTextGroupAnchorX, speedTextGroupAnchorY, "PTMono-Bold", 12)
    speedTextDesc:setFillColor(.2, .9, .4)
    speedTextDesc:setEmbossColor(scoreboardColor)
    speedTextDesc.anchorX = 0
    speedTextDesc.anchorY = 1
    speedTextGroup:insert(speedTextDesc)

    speedText = display.newEmbossedText("???", speedTextGroupAnchorX + (speedTextDesc.width/2), speedTextGroupAnchorY, "PTMono-Bold", 18)
    speedText:setFillColor(.2, .9, .4)
    speedText:setEmbossColor(scoreboardColor)
    speedText.anchorY = 0
    speedTextGroup:insert(speedText)

    speedDecreaseBtnGroup = display.newGroup()
    speedDecreaseBtnGroup.name = "speedDecrease"
    speedDecreaseBtnFill = display.newRoundedRect(speedDecreaseBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2) - 11, speedTextGroupAnchorY - speedTextDesc.height * scoreboardOffsetIncDecBtns, 16, 16, 1)
    speedDecreaseBtnFill:setFillColor(.4, .4, .4)
    speedDecreaseBtnFill.anchorY = 1
    speedDecreaseBtnSym = display.newText(speedDecreaseBtnGroup, "-", speedDecreaseBtnFill.x, speedDecreaseBtnFill.y - (speedDecreaseBtnFill.height/2), "PTMono-Bold", 14)
    speedDecreaseBtnSym.anchorX = .5
    speedDecreaseBtnSym.anchorY = .5
    speedTextGroup:insert(speedDecreaseBtnGroup)
    speedDecreaseBtnGroup:addEventListener("tap", onOptionsTap)

    speedIncreaseBtnGroup = display.newGroup()
    speedIncreaseBtnGroup.name = "speedIncrease"
    speedIncreaseBtnFill = display.newRoundedRect(speedIncreaseBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2) + 11, speedTextGroupAnchorY - speedTextDesc.height * scoreboardOffsetIncDecBtns, 16, 16, 1)
    speedIncreaseBtnFill:setFillColor(.4, .4, .4)
    speedIncreaseBtnFill.anchorY = 1
    speedIncreaseBtnSym = display.newText(speedIncreaseBtnGroup, "+", speedIncreaseBtnFill.x, speedIncreaseBtnFill.y - (speedIncreaseBtnFill.height/2), "PTMono-Bold", 14)
    speedIncreaseBtnSym.anchorX = .5
    speedIncreaseBtnSym.anchorY = .5
    speedTextGroup:insert(speedIncreaseBtnGroup)
    speedIncreaseBtnGroup:addEventListener("tap", onOptionsTap)

    local modeTextGroupAnchorX = scoreboardOffsetFromLeft + (scoreboardOffsetFromEachOther*2)
    local modeTextGroupAnchorY = _H/2

    modeTextGroup = display.newGroup()
    modeTextDesc = display.newEmbossedText("mode:", modeTextGroupAnchorX, modeTextGroupAnchorY, "PTMono-Bold", 12)
    modeTextDesc:setFillColor(.2, .9, .4)
    modeTextDesc:setEmbossColor(scoreboardColor)
    modeTextDesc.anchorX = 0
    modeTextDesc.anchorY = 1
    modeTextGroup:insert(modeTextDesc)

    modeText = display.newEmbossedText("???", modeTextGroupAnchorX + (modeTextDesc.width/2), modeTextGroupAnchorY, "PTMono-Bold", 18)
    modeText:setFillColor(.2, .9, .4)
    modeText:setEmbossColor(scoreboardColor)
    modeText.anchorY = 0
    modeTextGroup:insert(modeText)

    modeDecreaseBtnGroup = display.newGroup()
    modeDecreaseBtnGroup.name = "modeDecrease"
    modeDecreaseBtnFill = display.newRoundedRect(modeDecreaseBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2) - 11, modeTextGroupAnchorY - modeTextDesc.height * scoreboardOffsetIncDecBtns, 16, 16, 1)
    modeDecreaseBtnFill:setFillColor(.4, .4, .4)
    modeDecreaseBtnFill.anchorY = 1
    modeDecreaseBtnSym = display.newText(modeDecreaseBtnGroup, "-", modeDecreaseBtnFill.x, modeDecreaseBtnFill.y - (modeDecreaseBtnFill.height/2), "PTMono-Bold", 14)
    modeDecreaseBtnSym.anchorX = .5
    modeDecreaseBtnSym.anchorY = .5
    modeTextGroup:insert(modeDecreaseBtnGroup)
    modeDecreaseBtnGroup:addEventListener("tap", onOptionsTap)

    modeIncreaseBtnGroup = display.newGroup()
    modeIncreaseBtnGroup.name = "modeIncrease"
    modeIncreaseBtnFill = display.newRoundedRect(modeIncreaseBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2) + 11, modeTextGroupAnchorY - modeTextDesc.height * scoreboardOffsetIncDecBtns, 16, 16, 1)
    modeIncreaseBtnFill:setFillColor(.4, .4, .4)
    modeIncreaseBtnFill.anchorY = 1
    modeIncreaseBtnSym = display.newText(modeIncreaseBtnGroup, "+", modeIncreaseBtnFill.x, modeIncreaseBtnFill.y - (modeIncreaseBtnFill.height/2), "PTMono-Bold", 14)
    modeIncreaseBtnSym.anchorX = .5
    modeIncreaseBtnSym.anchorY = .5
    modeTextGroup:insert(modeIncreaseBtnGroup)
    modeIncreaseBtnGroup:addEventListener("tap", onOptionsTap)

    gameDebugGroup = display.newGroup()

    local gameDebugDeathGroupAnchorY = _H/2 + scoreTextGroup.height * scoreboardOffsetIncDecBtns + 4

    gameDebugDeathBtnGroup = display.newGroup()
    gameDebugDeathBtnGroup.name = "gameDebugDeath"

    local textParams =
    {
        text = "god?",
        x = scoreTextGroupAnchorX + (scoreTextDesc.width/2),
        y = gameDebugDeathGroupAnchorY,
        font = "PTMono-Bold",
        fontSize = 12,
        align = "center"
    }
    gameDebugDeathBtnDesc = display.newEmbossedText(textParams)
    gameDebugDeathBtnDesc:setFillColor(.2, .9, .4)
    gameDebugDeathBtnDesc:setEmbossColor(scoreboardColor)
    gameDebugDeathBtnDesc.anchorX = .5
    gameDebugDeathBtnDesc.anchorY = 0
    gameDebugGroup:insert(gameDebugDeathBtnDesc)

    gameDebugDeathBtnFill = display.newRoundedRect(gameDebugDeathBtnGroup, scoreTextGroupAnchorX + (scoreTextDesc.width/2), gameDebugDeathGroupAnchorY, 20, 20, 1)
    gameDebugDeathBtnFill:setFillColor(.2, .2, .2)
    gameDebugDeathBtnFill.anchorY = 1
    gameDebugDeathBtnSym = display.newText(gameDebugDeathBtnGroup, "", gameDebugDeathBtnFill.x, gameDebugDeathBtnFill.y - (gameDebugDeathBtnFill.height/2), "PTMono-Bold", 20)
    if debugOptions.god == true then
        gameDebugDeathBtnSym.text = "X"
    end
    gameDebugDeathBtnGroup:addEventListener("tap", onOptionsTap)
    gameDebugGroup:insert(gameDebugDeathBtnGroup)

    local gameDebugSpeedGroupAnchorY = _H/2 + scoreTextGroup.height * scoreboardOffsetIncDecBtns + 4

    gameDebugSpeedBtnGroup = display.newGroup()
    gameDebugSpeedBtnGroup.name = "gameDebugSpeed"

    local textParams =
    {
        text = "constant\nspeed?",
        x = speedTextGroupAnchorX + (speedTextDesc.width/2),
        y = gameDebugSpeedGroupAnchorY,
        font = "PTMono-Bold",
        fontSize = 12,
        align = "center"
    }

    gameDebugSpeedBtnDesc = display.newEmbossedText(textParams)
    gameDebugSpeedBtnDesc:setFillColor(.2, .9, .4)
    gameDebugSpeedBtnDesc:setEmbossColor(scoreboardColor)
    gameDebugSpeedBtnDesc.anchorX = .5
    gameDebugSpeedBtnDesc.anchorY = 0
    gameDebugGroup:insert(gameDebugSpeedBtnDesc)

    gameDebugSpeedBtnFill = display.newRoundedRect(gameDebugSpeedBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2), gameDebugSpeedGroupAnchorY, 20, 20, 1)
    gameDebugSpeedBtnFill:setFillColor(.2, .2, .2)
    gameDebugSpeedBtnFill.anchorY = 1
    gameDebugSpeedBtnSym = display.newText(gameDebugSpeedBtnGroup, "", gameDebugSpeedBtnFill.x, gameDebugSpeedBtnFill.y - (gameDebugSpeedBtnFill.height/2), "PTMono-Bold", 20)
    if debugOptions.constantSpeed == true then
        gameDebugSpeedBtnSym.text = "X"
    end
    gameDebugSpeedBtnGroup:addEventListener("tap", onOptionsTap)
    gameDebugGroup:insert(gameDebugSpeedBtnGroup)


    local gameDebugCycleGroupAnchorY = _H/2 + scoreTextGroup.height * scoreboardOffsetIncDecBtns + 4

    gameDebugCycleBtnGroup = display.newGroup()
    gameDebugCycleBtnGroup.name = "gameDebugCycle"

    local textParams =
    {
        text = "cycle\nmodes?",
        x = modeTextGroupAnchorX + (modeTextDesc.width/2),
        y = gameDebugCycleGroupAnchorY,
        font = "PTMono-Bold",
        fontSize = 12,
        align = "center"
    }

    gameDebugCycleBtnDesc = display.newEmbossedText(textParams)
    gameDebugCycleBtnDesc:setFillColor(.2, .9, .4)
    gameDebugCycleBtnDesc:setEmbossColor(scoreboardColor)
    gameDebugCycleBtnDesc.anchorX = .5
    gameDebugCycleBtnDesc.anchorY = 0
    gameDebugGroup:insert(gameDebugCycleBtnDesc)

    gameDebugCycleBtnFill = display.newRoundedRect(gameDebugCycleBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2), gameDebugCycleGroupAnchorY, 20, 20, 1)
    gameDebugCycleBtnFill:setFillColor(.2, .2, .2)
    gameDebugCycleBtnFill.anchorY = 1
    gameDebugCycleBtnSym = display.newText(gameDebugCycleBtnGroup, "", gameDebugCycleBtnFill.x, gameDebugCycleBtnFill.y - (gameDebugCycleBtnFill.height/2), "PTMono-Bold", 20)
    if debugOptions.cycleModes == true then
        gameDebugCycleBtnSym.text = "X"
    end
    gameDebugCycleBtnGroup:addEventListener("tap", onOptionsTap)
    gameDebugGroup:insert(gameDebugCycleBtnGroup)
end

-- SAM: combine functions speedUp() and resetSpawnTable()
speedUp = function()
    if speedTableIndex ~= #levelsArray then
        speedTableIndex = speedTableIndex + 1
        speed = levelsArray[speedTableIndex].speed
        timeVar = levelsArray[speedTableIndex].timeVar
        speedText.text = speed
        speedText:toFront()
    elseif finalChallenge == false then
        finalChallenge = true
    end
end

-- READYOBJ: resetSpawnTable
resetSpawnTable = function()
    if music ~= nil then
        media.stopSound(music)
        music = nil
    end
    spawnTable = {}
    count = 1
    -- same as countriesCompleted counted?
    firstObject = true
    currentColor = nil    --reset bonus score gameMechanics.modes for new flag
    previousColor = nil

    -- SAM: bonusText activity
    if bonusText ~= nil then
        bonusText:removeSelf()
        bonusText = nil
    end

    if debugOptions.cycleModes == true then
    	--decide what gameMechanics.mode is next
        if gameMechanics.mode == 1 then
            gameMechanics.mode = 2
            --speedTableIndex = speedTableIndex + 1
        elseif gameMechanics.mode == 2 then
            gameMechanics.mode = 3
            --speedTableIndex = speedTableIndex / 2 - 1
            --speedTableIndex = math.round(speedTableIndex)
        elseif gameMechanics.mode == 3 then
            gameMechanics.mode = 1
            --speedTableIndex = (speedTableIndex) * 2
        end
    end

    --ERROR: crashes, let the game run
    -- speed = levels[speedTableIndex].speed
    -- timeVar = levels[speedTableIndex].timeVar

    speedText.text = speed
    speedText:toFront()
end

local function endGame(self)
    display.remove(self)
    choice = choice + 1
    if choice == numDeaths then
        local options = {effect = defaultTransition, params = {saveScore = score}}
        paceRect.isMoving = false
        composer.gotoScene("gameover", options)
    end
end



local function lookupCode(code, spawn)
    if code == "bw" then
        if spawn.type == "blue" or spawn.type == "white" then
            return 1
        end
    elseif code == "bwy" then
        if spawn.type == "blue" or spawn.type == "white" or spawn.type == "yellow" then
            return 1
        end
    elseif code == "rw" then
        if spawn.type == "red" or spawn.type == "white" then
            return 1
        end
    elseif code == "ry" then
        if spawn.type == "red" or spawn.type == "yellow" then
            return 1
        end
    elseif code == "rg" then
        if spawn.type == "red" or spawn.type == "green" then
            return 1
        end
    elseif code == "yb" then
        if spawn.type == "yellow" or spawn.type == "blue" then
            return 1
        end
    elseif code == "bkw" then
        if spawn.type == "blue" or spawn.type == "black" or spawn.type == "white" then
            return 1
        end
    elseif code == "ryb" then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "blue" then
            return 1
        end
    elseif code == "rwb" then
        if spawn.type == "red" or spawn.type == "white" or spawn.type == "blue" then
            return 1
        end
    elseif code == "ryk" then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "black" then
            return 1
        end
    elseif code == "ogw" then
        if spawn.type == "orange" or spawn.type == "green" or spawn.type == "white" then
            return 1
        end
    elseif code == "rgw" then
        if spawn.type == "red" or spawn.type == "green" or spawn.type == "white" then
            return 1
        end
    elseif code == "ryg" then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "green" then
            return 1
        end
    elseif code == "ygbw" then
        if spawn.type == "yellow" or spawn.type == "green" or spawn.type == "blue" or spawn.type == "white" then
            return 1
        end
    elseif code == "ogbw" then
        if spawn.type == "orange" or spawn.type == "green" or spawn.type == "blue" or spawn.type == "white" then
            return 1
        end
    elseif code == "rybw" then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "blue" or spawn.type == "white" then
            return 1
        end
    elseif code == "rbwk" then
        if spawn.type == "red" or spawn.type == "blue" or spawn.type == "white" or spawn.type == "black" then
            return 1
        end
    elseif code == "royg" then
        if spawn.type == "red" or spawn.type == "orange" or spawn.type == "yellow" or spawn.type == "green" then
            return 1
        end
    elseif code == "rgwk" then
        if spawn.type == "red" or spawn.type == "green" or spawn.type == "white" or spawn.type == "black" then
            return 1
        end
    elseif code == "rygbwk" then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "green" or spawn.type == "blue" or spawn.type == "white" or spawn.type == "black" then
            return 1
        end
    end
    return 0
end

local function removePalette(self)
    if spawnTable[self.index] ~= 0 and spawnTable[self.index] ~= nil then
        self:removeEventListener("touch", objTouch)
        spawnTable[self.index] = 0
        self:removeSelf()
    end
end

local function removeText(text)
    text:removeSelf()
end

-- REVIEW: rename?
local function boundaryElimination(e)
    for i = 1, #spawnTable do
		--junk paletts go away
        if spawnTable[i] ~= 0 and spawnTable[i].dead ~= true then
            spawnTable[i].PaletteActive = false
            spawnTable[i]:removeEventListener("touch", objTouch)
            transition.to(spawnTable[i], {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
			--Pallets player lost with.  Fling them at the screen
        elseif spawnTable[i] ~= 0 and spawnTable[i].dead == true  then

            if gameMechanics.mode == 3 then

                transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W / 2, y = _H / 2, xScale = 6, yScale = 6, onComplete = endGame })
            else

                if numDeaths == 1 then
                    transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W / 2, y = _H / 2, xScale = 8, yScale = 8, onComplete = endGame })

                elseif numDeaths == 2 then
                    if spawnTable[i].isTopLeft == true or spawnTable[i].isBottomLeft == true then
                        transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W * (1 / 3), y = _H / 2, xScale = 6, yScale = 6, onComplete = endGame })
                    else
                        transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W * (2 / 3), y = _H / 2, xScale = 6, yScale = 8, onComplete = endGame })
                    end
                else
                    if spawnTable[i].isTopLeft == true or spawnTable[i].isBottomLeft == true then
                        if spawnTable[i].y < _W / 2 then
                            transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W * (1 / 3), y = _H * (1 / 3), xScale = 6, yScale = 6, onComplete = endGame })
                        elseif spawnTable[i].y > _W / 2 then
                            transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W * (1 / 3), y = _H * (2 / 3), xScale = 6, yScale = 6, onComplete = endGame })
                        end
                    else
                        if spawnTable[i].y < _W / 2 then
                            transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W * (2 / 3), y = _H * (1 / 3), xScale = 6, yScale = 6, onComplete = endGame })
                        elseif spawnTable[i].y > _W / 2 then
                            transition.to(spawnTable[i], {time = 900, rotation = 400, x = _W * (2 / 3), y = _H * (2 / 3), xScale = 6, yScale = 6, onComplete = endGame })
                        end
                    end
                end
            end
        end
    end
end

-- REVIEW: rename?
local function boundaryCheck(e)
    local temp
    local breakLoop = false
	--breakLoop ensures this outerloop will break after it finds the bad pallet
    if #spawnTable > 0 and breakLoop == false then
        for i = 1, #spawnTable do
            if spawnTable[i] ~= 0 and spawnTable[i] ~= nil then
                if spawnTable[i].x < -40 or spawnTable[i].x > _W + 40 then
                    if lookupCode(code, spawnTable[i]) == 1 then    --Out of bound and Palette Matches flag. GameOver

                        breakLoop = true

                        -- SAM: bonusText activity
                        if bonusText ~= nil then
                            bonusText:removeSelf()
                            bonusText = nil
                        end
                        if not debugOptions.god then
                            paceRect.isMoving = false
                            spawnTable[i]:toFront()
                            Runtime:removeEventListener("enterFrame", boundaryCheck)
                            Runtime:removeEventListener("enterFrame", moveObject)
                            for i = 1, #spawnTable do
								--Check for palettes that are out of bounds
                                if spawnTable[i] ~= 0 then
                                    spawnTable[i].isPaletteActive = false
                                    spawnTable[i]:removeEventListener("touch", objTouch)
									--Check for gameover palettes
                                    if spawnTable[i].x < - 40 or spawnTable[i].x > _W + 40 then
                                        if gameMechanics.mode == 1 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                spawnTable[i]:removeEventListener("touch", objTouch)
                                                spawnTable[i].dead = true
                                                numDeaths = numDeaths + 1
                                            else
                                                spawnTable[i].dead = false
                                            end
                                        end
                                    end

                                    print("effects for palettes within bounds")
                                    if gameMechanics.mode == 3 and spawnTable[i].dead ~= true  then
                                        transition.to(spawnTable[i], {time = 300, alpha = 0})
                                    end

                                    print("reverse motion for death effect")
                                    if spawnTable[i].isTopLeft == true or spawnTable[i].isBottomLeft == true then
                                        -- SAM: temp = ???
                                        temp = spawnTable[i].x
                                        if gameMechanics.mode == 1 or gameMechanics.mode == 3 then
                                            transition.to(spawnTable[i], {time = 2000, x = temp + 90})
                                        elseif gameMechanics.mode == 2 then
                                            transition.to(spawnTable[i], {time = 2000, x = temp - 90})
                                        end
                                    else
                                        -- SAM: temp = ???
                                        temp = spawnTable[i].x
                                        if gameMechanics.mode == 1 or gameMechanics.mode == 3 then
                                            transition.to(spawnTable[i], {time = 2000, x = temp - 90})
                                        elseif gameMechanics.mode == 2 then
                                            transition.to(spawnTable[i], {time = 2000, x = temp + 90})
                                        end
                                    end
                                    if gameMechanics.mode ~= 3 and spawnTable[i] ~= 0 then
                                        if spawnTable[i].isGrown == false then
                                            spawnTable[i]:removeSelf()
                                            spawnTable[i] = 0
                                        end
                                    end
                                end
                            end

                            print("calling boundaryElimination")
                            timer.performWithDelay(2000, boundaryElimination, 1)
                            return --SAM: why?
                        elseif debugOptions.god then
                            for i = 1, #spawnTable do
                                if spawnTable[i] ~= 0 then
                                    if spawnTable[i].x < -40 or spawnTable[i].x > _W + 40 then
                                        if gameMechanics.mode == 1 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                spawnTable[i]:removeEventListener("touch", objTouch)
                                                spawnTable[i]:removeSelf()
                                                spawnTable[i] = 0
                                            end
                                        elseif gameMechanics.mode == 2 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                spawnTable[i]:removeEventListener("touch", objTouch)
                                                spawnTable[i]:removeSelf()
                                                spawnTable[i] = 0
                                            end
                                        elseif gameMechanics.mode == 3 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                spawnTable[i]:removeEventListener("touch", objTouch)
                                                spawnTable[i]:removeSelf()
                                                spawnTable[i] = 0
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function paletteGrow(self)
    transition.to(self, {time = timeVar * (.5), xScale = 1, yScale = 1})
end

-- PALETTES
local function spawnPalette(params)

    -- SAM: spawned pad's color
    -- print(params.type)

    local object = display.newRoundedRect(0, 0, 80, 60, 3)

    -- temp, look into shadow
    -- object.strokeWidth = 2
    -- object:setStrokeColor( .1, .1, .1 )

    object.isPaletteActive = true
    object.isGrown = false
    object.anchorY = 0.5 ; object.anchorX = 0.5
    object.objTable = params.objTable   --Set the objects table to a table passed in by parameters
    object.index = #object.objTable + 1    --Automatically set the table index to be inserted into the next available table index
    object.myName = "Object: " .. object.index  --Give the object a custom name
    --SAM: eradicate this isTopLeft and isBottomLeft business
    object.isTopLeft = params.isTopLeft
    object.isBottomLeft = params.isBottomLeft
    object.corner = params.corner
    object.type = params.type

	-- print("created" .. object.myName)
    if gameMechanics.mode == 1 then
        if object.corner == "TopRight" then
            object.x = game_W - 40
            object.y = gameMechanics.heightModeTop
        elseif object.corner == "BottomLeft" then
            object.x = 40
            object.y = gameMechanics.heightModeLow
        end
    elseif gameMechanics.mode == 2 then
        if object.corner == "TopLeft" then
            object.x = 40
            object.y = gameMechanics.heightModeTop
        elseif object.corner == "BottomRight" then
            object.x = game_W - 40
            object.y = gameMechanics.heightModeLow
        end
    elseif gameMechanics.mode == 3 then
        if object.corner == "TopRight" then
            object.x = _W / 2 + 40
            object.y = gameMechanics.heightModeTop
        elseif object.corner == "TopLeft" then
            object.x = _W / 2 - 40
            object.y = gameMechanics.heightModeTop
        elseif object.corner == "BottomRight" then
            object.x = _W / 2 + 40
            object.y = gameMechanics.heightModeLow
        elseif object.corner == "BottomLeft" then
            object.x = _W / 2 - 40
            object.y = gameMechanics.heightModeLow
        end
    end
    if params.type == "white" then
        object:setFillColor(w1, w2, w3)
        object.L1 = w1   --L1, L2, L3 set colors for lightning beams
        object.L2 = w2
        object.L3 = w3
    elseif params.type == "black" then
        object:setFillColor(k1, k2, k3)
        object.L1 = k1
        object.L2 = k2
        object.L3 = k3
    elseif params.type == "red" then
        object:setFillColor(r1, r2, r3)
        object.L1 = r1
        object.L2 = r2
        object.L3 = r3
    elseif params.type == "orange" then
        object:setFillColor(o1, o2, o3)
        object.L1 = o1
        object.L2 = o2
        object.L3 = o3
    elseif params.type == "yellow" then
        object:setFillColor(y1, y2, y3)
        object.L1 = y1
        object.L2 = y2
        object.L3 = y3
    elseif params.type == "green" then
        object:setFillColor(g1, g2, g3)
        object.L1 = g1
        object.L2 = g2
        object.L3 = g3
    elseif params.type == "blue" then
        object:setFillColor(b1, b2, b3)
        object.L1 = b1
        object.L2 = b2
        object.L3 = b3
    end
    object.touch = objTouch
    object:addEventListener("touch", object)
	--object:addEventListener("enterFrame", moveObject)
    object.objTable[object.index] = object --Insert the object into the table at the specified index
    object:scale(0, 0)

	--new pallets are being scaled to full size as they appear
    if gameMechanics.mode == 1 or gameMechanics.mode == 2 then
        if object.index == 1 or object.index == 2 then
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
            if spawnTable[object.index - 2] ~= 0 then
                spawnTable[object.index - 2]:toFront()
            end
        end
    elseif gameMechanics.mode == 3 then
        if object.index == 1 or object.index == 2 or object.index == 3 or object.index == 4 then
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
            if spawnTable[object.index - 4] ~= 0 then
                spawnTable[object.index - 4]:toFront()
            end
        end
    end
    paceRect.isMoving = true
    return object
end

local function lightningIcons()
    local lightningIconActivatedOpacity = .2
    if lightningCount == 0 then
        lightningIcon1.alpha = lightningIconActivatedOpacity
    elseif lightningCount == 1 then
        lightningIcon1.alpha = 1
        lightningIcon2.alpha = lightningIconActivatedOpacity
    elseif lightningCount == 2 then
        lightningIcon2.alpha = 1
        lightningIcon3.alpha = lightningIconActivatedOpacity
    elseif lightningCount == 3 then
        lightningIcon3.alpha = 1
        lightningIcon4.alpha = lightningIconActivatedOpacity
    elseif lightningCount == 4 then
        lightningIcon4.alpha = 1
        lightningIcon5.alpha = lightningIconActivatedOpacity
    elseif lightningCount == 5 then
        lightningIcon5.alpha = 1
    end
end

local function removeLine()
    for i = 1, #lineTable do
        display.remove(lineTable[i])
    end
end

local function flagRotate4()
    transition.to(flag, {time = 30, rotation = 0})
end

local function flagRotate3()
    transition.to(flag, {time = 40, rotation = 10, onComplete = flagRotate4})
end

local function flagRotate2()
    transition.to(flag, {time = 40, rotation = -10, onComplete = flagRotate3})
end

local function flagRotate1()
    transition.to(flag, {time = 40, rotation = 10, onComplete = flagRotate2})
end

local function lightningButton(flagTouchEvent)
    -- what happend when you use lightning and no matching palettes are on-screen?
    print(flagTouchEvent)
    if lightningCount > 0 and flagTouchEvent and paceRect.isMoving == true then
        lineTable = {}
        lineTableCount = 0
        lightningCount = lightningCount - 1
        transition.to(flag, {time = 30, rotation = -10, onComplete = flagRotate1})
        for i = 1, #spawnTable do
            if spawnTable[i] ~= 0 and spawnTable[i] ~= nil and spawnTable[i].isGrown == true then
                if lookupCode(code, spawnTable[i]) == 1 then  --colors match
                    spawnTable[i].isPaletteActive = false
                    spawnTable[i].isGrown = false
                    lineTableCount = lineTableCount + 1
                    line = display.newLine(spawnTable[i].x, spawnTable[i].y, _W / 2, _H / 2)
                    line:setStrokeColor(spawnTable[i].L1, spawnTable[i].L2, spawnTable[i].L3)
                    line.strokeWidth = 6
                    line:toFront()
                    lineTable[lineTableCount] = line
                    transition.to(line, {time = 300, xScale = 0.01, yScale = 0.01, onComplete = removeLine})
                    lightningStrike(spawnTable[i])
                end
            end
        end
    end
    lightningIcons()
end

local function lightningEnable()
    --SAM: we can just keep this running rather than removing it and adding it again whenever lightningCount changes from 0
    -- add animation (flag shakes) when you have no lightning to use
    if lightningCount > 0 then
        flag:addEventListener("tap", lightningButton)
        lightningIcons()
    else
        flag:removeEventListener("tap", lightningButton)
    end
end


local function trackLightningScore()
    print("spread from trackLightningScore:", spread)
    -- SAM: my lightning tracker. keeping things simple
    if spread == 0 then
        lightningScore = 0
    elseif spread >= 2 and lightningCount <= 4 then
        -- SAM: do we no longer need lightningScore?
        lightningScore = lightningScore + 1
        lightningCount = lightningCount + 1
    end
    print("lightningCount from trackLightningScore:", lightningCount)
    lightningIcons()
    --[[ SAM: Mike's trackLightningScore methods
    if lightningScore >= 10 then
        lightningScore = score - (10 * lightningMultiplier)
        lightningCount = lightningCount + 1
        lightningMultiplier = lightningMultiplier + 1
        lightningIcons()
    end
    ]]--
end

function lightningStrike(self)
	--You are Alive
    if self.isGrown == false then
        self:removeSelf()
        spawnTable[self.index] = 0
    else
        if self.x < 1 or self.x > _W - 1 then
            transition.to(self, {time = 100, rotation = 0, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
        else
            transition.to(self, {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
        end
    end
    currentColor = self.type
	--bonus score
    if currentColor == previousColor then
        spread = spread + 1

        -- SAM: bonusText activity
        if bonusText ~= nil then
            bonusText:removeSelf()
            bonusText = nil
        end

        local bonusTextTemp = display.newText("+" .. spread, scoreText.x, scoreText.y - scoreText.height, "PTMono-Bold", 14)
        bonusTextTemp:setFillColor(0, 0, 0)

        local bonusTextFadeDir = math.random(10,20)
        if math.random() > .5 then
            bonusTextFadeDir = -bonusTextFadeDir
        end
        transition.to(bonusTextTemp, {time=400, size=25, alpha=.5, x=bonusTextTemp.x+bonusTextFadeDir, y=bonusTextTemp.y-14, onComplete=function()
            bonusTextTemp.alpha = 0
            bonusTextTemp:removeSelf()
            bonusTextTemp = nil
        end})

        -- SAM: disable bonusImplode for now...
        if motion ~= nil then
            timer.cancel(motion)
            motion = nil
        end
        if spread then
            bonusImplode:setSequence("1")
        end
        bonusImplode.alpha = 1
        bonusImplode:toFront()
        bonusImplode:play()
        bonusImplode.x = _W * (4 / 5)
        bonusImplode.y = _H / 2
        motion = timer.performWithDelay(800, cancelTimerBonusImplode, 1)
    else
        spread = 1
        currentColor = nil
        previousColor = nil

        -- SAM: bonusText activity
        if bonusText ~= nil then
            bonusText:removeSelf()
            bonusText = nil
        end
    end
    previousColor = self.type



    scoreText.text = score + spread
    score = score + spread

    -- SAM: bonuses and additional lightningStrikes derived from using lightningStrikes
    -- for now, turn this off.

    -- lightningScore = lightningScore + spread
    -- trackLightningScore()
end

-- READYOBJ: setFlag
setFlag = function()
    setTheFlag = true
end

-- READYOBJ: delayPace
delayPace = function()
    paceRect.isMoving = true
    if speedText ~= 0 and speedText ~= nil then
        speedText.text = speed
        speedText:toFront()
    end
end

local function nextMove()
    pointAnimation:pause()
    pointAnimation:toBack()
end

local function infoAppear()
    transition.to(infoPic, {time = 500, alpha = 1})
end

local function deleteCountryText()
    display.remove(CountryText)
end

local function countryTextScale()
    countryTimer = transition.to(countryText, {time = 500, alpha = 0})
    timer.performWithDelay(500, deleteCountryText, 1)
end

local function adherenceToFlagColors(e)
    local result

    -- SAM: if inclusiveColorsArray == nil then... no need to pass in number! just set inclusiveColorsArray = nil after each flag
    if(e == 0) then
        result = function()
            local dataArray = {}
            -- SET
            -- local countryColors = {}
            local flagColorCount = 0
            for k, v in pairs(country.colors) do
                -- print(k, v.r)
                flagColorCount = flagColorCount + 1
                dataArray[flagColorCount] = { k, {v.r, v.g, v.b} }
            end
            return dataArray
        end
        return result()
    else
        result = function()
            local randomColorIndex = math.random(table.getn(inclusiveColorsArray))
            local randomColorArray = inclusiveColorsArray[randomColorIndex][2]
            local colors = {}

            for i = 1, #randomColorArray do
                colors[i] = randomColorArray[i]
            end

            -- print("chose { " .. inclusiveColorsArray[randomColorIndex][1] .. " } from codes")
            -- print("r = " .. colors[1], "g = " .. colors[2], "b = " .. colors[3])

            --only need to pass in color code
            return inclusiveColorsArray[randomColorIndex][1]
        end
        return result()
    end
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

previousCountry = nil
-- READYOBJ: setCountryParameters
setCountryParameters = function(restartCountry)

    if not debugOptions.constantSpeed and gameMechanics.overrideFlag == true then
        speedUp()
    end

    -- wrap in a function.. this can all be in the speedUp() function?
    if fps == 30 then
        speed = levelsArray[speedTableIndex].speed
    else
        speed = levelsArray[speedTableIndex].speed / 2
    end

    timeVar = levelsArray[speedTableIndex].timeVar
    speedText.text = speed
    speedText:toFront()

    music = nil

    -- SAM: bonusText activity
    if bonusText ~= nil then
        print("bonusText from ", "setCountryParameters()")
        bonusText:removeSelf()
        bonusText = nil

        --SAM: delete?
        spread = 1
        previousColor = nil
        currentColor = nil
    end


    -- SAM: rename gameMechanics.mode to mode
    -- print("gameMechanics.mode set in setCountryParameters(): ", gameMechanics.mode)
    modeText.text = gameMechanics.mode

    if restartCountry == nil then
        if countriesCompleted > 0 then
            previousCountry = country
        end
        newCountry()
        sideTimer = timer.performWithDelay(gameMechanics.transitionToCountryDuration, finishScale, 1)
        -- SAM: IMPORTANT, rename paceTimer to something more serious
        paceTimer = timer.performWithDelay(10, delayPace, 1)

        -- SAM: Experimentation, in process
        local sineEvent = function( event )
            -- math to use sinusoid curve
            distanceFromCamera.x = distanceFromCamera.x + 1
            local y = distanceFromCamera.y  + math.sin(distanceFromCamera.x / distanceFromCamera.enemySpeed) * distanceFromCamera.amplitude
            distanceFromCamera.pseudoTargetX = distanceFromCamera.x
            -- OR
            distanceFromCamera.pseudoTargetX = 0
            distanceFromCamera.pseudoTargetY = y
            print(y)
        end
        -- Runtime:addEventListener( "enterFrame", sineEvent )

        local cameraEvent = function( event )
            print(previousCountry.name, previousCountry.coords.x)
            print(country.name, country.coords.x)

            previousXCoord = xCoord
            previousYCoord = yCoord

            zoomMultiplier = .3
            xCoord=(_W/2)-(country.coords.x*zoomMultiplier)-((countryOutline.width*zoomMultiplier)/2)
            yCoord=(_H/2)-(country.coords.y*zoomMultiplier)-((countryOutline.height*zoomMultiplier)/2)

            local transXCoord = previousXCoord - (previousXCoord-xCoord/2)
            local transYCoord = previousYCoord - (previousYCoord-yCoord/2)

            -- for reference
            -- mapGroup.x=xCoord
            -- mapGroup.y=yCoord
            -- mapGroup.xScale=1*zoomMultiplier
            -- mapGroup.yScale=1*zoomMultiplier

            mapTimer = transition.to( mapGroup, { transition=easing.inCirc,
                time=gameMechanics.transitionToCountryDuration/2,
                x=transXCoord,
                y=transYCoord,
                xScale=1*zoomMultiplier,
                yScale=1*zoomMultiplier,
                onComplete=function(event)
                    zoomMultiplier = .3
                    xCoord=(_W/2)-(country.coords.x*zoomMultiplier)-((countryOutline.width*zoomMultiplier)/2)
                    yCoord=(_H/2)-(country.coords.y*zoomMultiplier)-((countryOutline.height*zoomMultiplier)/2)
                    mapTimer = transition.to(mapGroup, { transition=easing.inCirc,
                        time=gameMechanics.transitionToCountryDuration/2,
                        x=xCoord,
                        y=yCoord,
                        xScale=1*zoomMultiplier,
                        yScale=1*zoomMultiplier
                    })

                end})
        end
        if(countriesCompleted == 0) then
            zoomMultiplier = .3
            xCoord=(_W/2)-(country.coords.x*zoomMultiplier)-((countryOutline.width*zoomMultiplier)/2)
            yCoord=(_H/2)-(country.coords.y*zoomMultiplier)-((countryOutline.height*zoomMultiplier)/2)
            mapGroup.x = xCoord
            mapGroup.y = yCoord
            mapGroup.xScale = 1 * zoomMultiplier
            mapGroup.yScale = 1 * zoomMultiplier
            transition.to( newGroup, {delay=40, time=200, alpha=1} )
        else
            cameraEvent()
        end

        -- old style. Currently working on function to handle transitions to zoom in and out!
        -- mapTimer = transition.to( mapGroup, { time=gameMechanics.transitionToCountryDuration, x=xCoord, y=yCoord, xScale=1*zoomMultiplier, yScale=1*zoomMultiplier})
    else
        paceTimer = timer.performWithDelay(10, delayPace, 1)
    end
end

-- READYOBJ: newCountry
newCountry = function()
    -- largerCountries to debugOptions
    -- local largerCountries = {2, 3, 6, 7, 9, 39, 55}
    -- local e = largerCountries[math.random(table.getn(largerCountries))]

    -- make this into array with a variety of sets - changing between 2 or more countries in sequence
    if debugOptions.brazilToCanada == true then
        if country == nil then
            e = 6
        else
            if country.name == "brazil" then
                e = 7
            else
                e = 6
            end
        end
        country = CFGameSettings:getItemByID(e)
    end

    -- SAM: change to countries? All country data is kept in here.. reference to cf_game_settings.lua
    local randomCountry = math.random(CFGameSettings:getLength())
    country = CFGameSettings:getItemByID(randomCountry)

    -- print("current country: ", country.name)

    inclusiveColorsArray = adherenceToFlagColors(0)

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

    -- SAM: DELETE? i think i already have this all figured out. now in a new location
    -- (2031/2) - 958 - (?/2)
    -- (851/2) - 225 - (?/2)
    -- xCoord=(_W/2)-country.coords.x-(countryOutline.width/2)
    -- yCoord=(_H/2)-country.coords.y-(countryOutline.height/2)
    -- (2031/2) - (958*1.5) - ((?*1.5)/2)
    -- (851/2) - (225*1.5) - ((?*1.5)/2)
    -- xCoord=(_W/2)-(country.coords.x*zoomMultiplier)-((countryOutline.width*zoomMultiplier)/2)
    -- yCoord=(_H/2)-(country.coords.y*zoomMultiplier)-((countryOutline.height*zoomMultiplier)/2)
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

    -- SAM: figure out a better solution for this! Groups (flag, flagFrame, and lightningIcons)?
    lightningIcon1:toFront()
    lightningIcon2:toFront()
    lightningIcon3:toFront()
    lightningIcon4:toFront()
    lightningIcon5:toFront()

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

    music = audio.loadStream("anthems/" .. country.name .. ".wav")
    bobby = audio.play(music, {channel = 1, loops=-1, onComplete=function(event)
        print("finished streaming ANTHEM on channel ", event.channel)
    end})
    audio.setVolume( .5, { channel = 1 } )
end

local function killBars()
    killLowTimer = transition.to(lowBar, {time = 800, alpha = 0})
    killTopTimer = transition.to(topBar, {time = 800, alpha = 0})
end

local function countryTrace()
    countryTrace:removeSelf()
    countryTrace = nil
end

local function removeFlag()
    flag:removeEventListener("touch", lightningButton)
    flag:removeSelf()
    flag = nil
end

-- SAM: Can we somehow arrange the finishScale() function after the setCountryParameters() function, its importance is pretty relevant to setCountryParameters() ?? Maybe merge all functions pertaining to setCountryParameters and flag enlargement into one neat function
-- SAM: seems as though the only game-mechanic related part of this function a call to lightningEnable()
-- no longer using topBar and lowBar

finishScale = function()
    topBar = display.newSprite(topBtmBarSheet, topBtmBarSeq)
	topBar:setFillColor(0, 0, 0)
	topBar.yScale = -1
	topBar.anchorX = 0.5
    topBar.anchorY = 1
    topBar.x = _W / 2
	topBar.y = -30
    topBar.alpha = 0
    topBar:toFront()
    topBar:setSequence("top")
    topBar:play()

	lowBar = display.newSprite(topBtmBarSheet, topBtmBarSeq)
    lowBar:setFillColor(0, 0, 0)
	lowBar.anchorX = 0.5
    lowBar.anchorY = 1
	lowBar.x = _W / 2
	lowBar.y = _H + 30
    lowBar.alpha = 0
    lowBar:toFront()
    lowBar:setSequence("btm")
    lowBar:play()

    if debugOptions.topBottomBars == true then
        transition.to(topBar, {time = 1300, alpha = .6, y = -35})
        transition.to(lowBar, {time = 1300, alpha = .6, y = _H + 35})
    end

	transition.to(flag, {time = 1000, alpha = 1})

    -- WTF
    if flag ~= nil then
        lightningEnable()
    end
    -- flagLightningReady = timer.performWithDelay(1000, lightningEnable, 1)

    -- SAM: delete this? used for offsetting when speedUp() occurs - can happen in during midst of a country
    -- timerSpeed = timer.performWithDelay(9500, speedUp, 1)

	countriesCompleted = countriesCompleted + 1
    -- print("end of finishScale() function")
end

-- PALETTES: initializes palettes, sets color and corner params. Calls spawnPalette()
local function createPalette()
    -- local spawns

    if gameMechanics.mode == 1 then
        if debugOptions.adherenceToFlagColors == true then
            local colorKey = {}
            for i = 1, 2 do
                local codeLetter
                codeLetter = adherenceToFlagColors(1)
                colorKey[i] = codeLetterToColorKey[codeLetter]
            end
            -- print("random flag colors to palette.")
            -- print("colorKey1: " .. colorKey[1])
            -- print("colorKey2: " .. colorKey[2])

            spawnPalette({objTable = spawnTable, type = colorKey[1], corner = "TopRight"})
            spawnPalette({objTable = spawnTable, type = colorKey[2], corner = "BottomLeft"})
        else
            local e = math.random(7)
            if e == 1 then
                spawnPalette({objTable = spawnTable, type = "white", corner = "TopRight"})
            elseif e == 2 then
                spawnPalette({objTable = spawnTable, type = "black", corner = "TopRight"})
            elseif e == 3 then
                spawnPalette({objTable = spawnTable, type = "red", corner = "TopRight"})
            elseif e == 4 then
                spawnPalette({objTable = spawnTable, type = "orange",  corner = "TopRight"})
            elseif e == 5 then
                spawnPalette({objTable = spawnTable, type = "yellow", corner = "TopRight"})
            elseif e == 6 then
                spawnPalette({objTable = spawnTable, type = "green", corner = "TopRight"})
            elseif e == 7 then
                spawnPalette({objTable = spawnTable, type = "blue", corner = "TopRight"})
            end

            local f = math.random(7)
            if f == 1 then
                spawnPalette({objTable = spawnTable, type = "white", corner = "BottomLeft"})
            elseif f == 2 then
                spawnPalette({objTable = spawnTable, type = "black", corner = "BottomLeft"})
            elseif f == 3 then
                spawnPalette({objTable = spawnTable, type = "red", corner = "BottomLeft"})
            elseif f == 4 then
                spawnPalette({objTable = spawnTable, type = "orange", corner = "BottomLeft"})
            elseif f == 5 then
                spawnPalette({objTable = spawnTable, type = "yellow", corner = "BottomLeft"})
            elseif f == 6 then
                spawnPalette({objTable = spawnTable, type = "green", corner = "BottomLeft"})
            elseif f == 7 then
                spawnPalette({objTable = spawnTable, type = "blue", corner = "BottomLeft"})
            end
        end
    elseif gameMechanics.mode == 2 then
        if debugOptions.adherenceToFlagColors == true then
            local colorKey = {}
            for i = 1, 2 do
                local codeLetter
                codeLetter = adherenceToFlagColors(1)
                colorKey[i] = codeLetterToColorKey[codeLetter]
            end
            -- print("random flag colors to palette.")
            -- print("colorKey1: " .. colorKey[1])
            -- print("colorKey2: " .. colorKey[2])

            spawnPalette({objTable = spawnTable, type = colorKey[1], corner = "TopLeft"})
            spawnPalette({objTable = spawnTable, type = colorKey[2], corner = "BottomRight"})
        else
            local e = math.random(7)
            if e == 1 then
                spawns = spawnPalette({objTable = spawnTable, type = "white", corner = "TopLeft"})
            elseif e == 2 then
                spawns = spawnPalette({objTable = spawnTable, type = "black", corner = "TopLeft"})
            elseif e == 3 then
                spawns = spawnPalette({objTable = spawnTable, type = "red", corner = "TopLeft"})
            elseif e == 4 then
                spawns = spawnPalette({objTable = spawnTable, type = "orange", corner = "TopLeft"})
            elseif e == 5 then
                spawns = spawnPalette({objTable = spawnTable, type = "yellow", corner = "TopLeft"})
            elseif e == 6 then
                spawns = spawnPalette({objTable = spawnTable, type = "green", corner = "TopLeft"})
            elseif e == 7 then
                spawns = spawnPalette({objTable = spawnTable, type = "blue", corner = "TopLeft"})
            end

            local f = math.random(7)
            if f == 1 then
                spawns = spawnPalette({objTable = spawnTable, type = "white", corner = "BottomRight"})
            elseif f == 2 then
                spawns = spawnPalette({objTable = spawnTable, type = "black", corner = "BottomRight"})
            elseif f == 3 then
                spawns = spawnPalette({objTable = spawnTable, type = "red", corner = "BottomRight"})
            elseif f == 4 then
                spawns = spawnPalette({objTable = spawnTable, type = "orange", corner = "BottomRight"})
            elseif f == 5 then
                spawns = spawnPalette({objTable = spawnTable, type = "yellow", corner = "BottomRight"})
            elseif f == 6 then
                spawns = spawnPalette({objTable = spawnTable, type = "green", corner = "BottomRight"})
            elseif f == 7 then
                spawns = spawnPalette({objTable = spawnTable, type = "blue", corner = "BottomRight"})
            end
        end
    elseif gameMechanics.mode == 3 then
        for i = 1, 4 do
            if debugOptions.adherenceToFlagColors == true then
                local colorKey
                local codeLetter
                codeLetter = adherenceToFlagColors(1)
                colorKey = codeLetterToColorKey[codeLetter]

                print("random flag colors to palette.")
                print("colorKey" .. i .. ": " .. colorKey)

                spawnPalette({objTable = spawnTable, type = colorKey, corner = cornersArray[i]})
            else
                local random = math.random(7)
                if random == 1 then
                    spawns = spawnPalette({objTable = spawnTable, type = "white", corner = cornersArray[i]})
                elseif random == 2 then
                    spawns = spawnPalette({objTable = spawnTable, type = "black", corner = cornersArray[i]})
                elseif random == 3 then
                    spawns = spawnPalette({objTable = spawnTable, type = "red", corner = cornersArray[i]})
                elseif random == 4 then
                    spawns = spawnPalette({objTable = spawnTable, type = "orange", corner = cornersArray[i]})
                elseif random == 5 then
                    spawns = spawnPalette({objTable = spawnTable, type = "yellow", corner = cornersArray[i]})
                elseif random == 6 then
                    spawns = spawnPalette({objTable = spawnTable, type = "green", corner = cornersArray[i]})
                elseif random == 7 then
                    spawns = spawnPalette({objTable = spawnTable, type = "blue", corner = cornersArray[i]})
                end
            end
        end
    end
end

-- READYOBJ: moveObject
moveObject = function(e)
    -- print("from moveObject: " .. paceRect.x)
    if gameMechanics.countriesSpawned == 0 then
        readyObject(1)
        return
    end
    if paceRect.isMoving == true then
        if fps == 30 then
            paceRect.x = paceRect.x + speed
        else
            paceRect.x = paceRect.x + (speed / 2)
        end
		--reset PaceRect, call readyObjects() to create a new palette or flag
        readyObject()
    end

    -- PALETTES: movement and direction of color palettes
    if gameMechanics.mode == 1 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
				--isGrown means is palette full size
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    if spawnTable[i].corner == "TopRight" then
                        spawnTable[i].x = spawnTable[i].x - speed
                    elseif spawnTable[i].corner == "BottomLeft" then
                        spawnTable[i].x = spawnTable[i].x + speed
                    end
                end
            end
        end
    elseif gameMechanics.mode == 2 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    if spawnTable[i].corner == "TopLeft" then
                        spawnTable[i].x = spawnTable[i].x + speed
                    elseif spawnTable[i].corner == "BottomRight" then
                        spawnTable[i].x = spawnTable[i].x - speed
                    end
                end
            end
        end
    elseif gameMechanics.mode == 3 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    if spawnTable[i].corner == "TopLeft" or spawnTable[i].corner == "BottomLeft" then
                        spawnTable[i].x = spawnTable[i].x - speed
                    elseif spawnTable[i].corner == "TopRight" or spawnTable[i].corner == "BottomRight" then
                        spawnTable[i].x = spawnTable[i].x + speed
                    end
                end
            end
        end
    end
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
    -- print("past first country")
    if paceRect.x > gameMechanics.paletteSpawnDelay or gameMechanics.overrideFlag == true then
        -- print("new spacing determined when " .. paceRect.x .. " > " .. 85)
        paceRect.x = 0
        if setTheFlag == true then
            if gameMechanics.overrideFlag == true then
                print("restart")
                setTheFlag = false
                paceRect.isMoving = false
                gameMechanics.overrideFlag = false

                -- removeFlag()

                for i = 1, #spawnTable do
                    if spawnTable[i] ~= 0 then
                        removePalette(spawnTable[i])
                    end
                end

                resetSpawnTable()
                setCountryParameters(1)
                timer.cancel(setFlagTimer)
                setFlagTimer = timer.performWithDelay(gameMechanics.playCountryDuration, setFlag, 1)
            else
                print("normal")
                setTheFlag = false
                paceRect.isMoving = false
                gameMechanics.overrideFlag = false

                removeFlag()

                for i = 1, #spawnTable do
                    if spawnTable[i] ~= 0 then
                        removePalette(spawnTable[i])

                        -- MIKE: animations
                        -- spawnTable[i].isGrown = false
                        -- spawnTable[i].isPaletteActive = false
                        -- transition.to(spawnTable[i], {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
                    end
                end

                -- MIKE: putting a delay on this was causing a crash when testing.
                -- flag3Timer = transition.to(flag, {time = 500, alpha = 0, onComplete = removeFlag})

                resetSpawnTable()
                setCountryParameters()
                timer.cancel(setFlagTimer)
                setFlagTimer = timer.performWithDelay(gameMechanics.playCountryDuration, setFlag, 1)

                -- MIKE: old timers, trying to make time between flags consistent
                --[[
                killBarsTimer = timer.performWithDelay(500, killBars)
                resetSpawnTimer = timer.performWithDelay(540, resetSpawnTable)
                if infoMode == true then
                    infoTimer = transition.to(infoPic, {time = 500, alpha = 0})
                end
                -- SAM: flag timers - calls newFlag()
                newFlagTimer = timer.performWithDelay(600, setCountryParameters)
                ]]--
            end
        else
            --CREATE A NEW COLOR SQUARE
            -- print("createPalette()")
            createPalette()

            -- sooner???
            -- firstObject = false

            if firstObject == true then
                firstObject = false
            elseif firstObject == false then
                if gameMechanics.mode == 1 or gameMechanics.mode == 2 then
                    if spawnTable[count] ~= 0 then
						--isGrown means colorPalletes are full size scale=1
                        spawnTable[count].isGrown = true
                    end
                    if spawnTable[count + 1] ~= 0 then
                        spawnTable[count + 1].isGrown = true
                    end
                    count = count + 2
                elseif gameMechanics.mode == 3 then --SAM: this should be gameMechanics.mode == 3
                    if spawnTable[count] ~= 0 then
                        spawnTable[count].isGrown = true
                    end
                    if spawnTable[count + 1] ~= 0 then
                        spawnTable[count + 1].isGrown = true
                    end
                    if spawnTable[count + 2] ~= 0 then
                        spawnTable[count + 2].isGrown = true
                    end
                    if spawnTable[count + 3] ~= 0 then
                        spawnTable[count + 3].isGrown = true
                    end
                    count = count + 4
                end
            end
        end
    end
end

local bonusTimer
local eventTimer
local t = {}
function t:timer(event)
    local count = event.count
    if count ~= 9 then
        bonusShatter.x = bonusShatter.x - 50
    else
        bonusShatter.alpha = 0
        timer.cancel(event.source)
    end
end

local function cancelTimerBonusImplode()
    bonusImplode.alpha = 0
    bonusImplode:pause()
end

function objTouch(self, e)
    if e.phase == "began" and e.target.isPaletteActive == true then
    -- animatePaletteDestroy(spawnTable[self.index].x, spawnTable[self.index].y, spawnTable[self.index].isTopLeft)

        local playPaletteDeathR = audio.play( SFXPaletteHit, { onComplete=function(event)
            print(event.channel)
        end })

        if lookupCode(code, e.target) == 0 then   --You are Dead --color does not match
            -- HOOKSOUND
            -- local pHit = audio.play( SFXPaletteHit )

            -- SAM: bonusText activity
            if bonusText ~= nil then
                bonusText:removeSelf()
                bonusText = nil
            end

            if not debugOptions.god then
                self:toFront()
                self.isPaletteActive = false
                self:removeEventListener("touch", objTouch)

				-- Death Palette Animation
                for i = 1, #spawnTable do
                    if spawnTable[i] ~= 0 then
                        spawnTable[i].isGrown = false
                        spawnTable[i].isPaletteActive = false
						-- spawnTable[i]:removeEventListener("enterFrame", moveObject)
                    end
                    if spawnTable[i] ~= 0 and spawnTable[i] ~= e.target then
                        spawnTable[i]:removeEventListener("touch", objTouch)
                        transition.to(spawnTable[i], {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
                    end
                end
                transition.to(e.target, {time = 700, rotation = 400, x = _W / 2, y = _H / 2, xScale = 8, yScale = 8, onComplete = endGame })
                numDeaths = 1
                Runtime:removeEventListener("enterFrame", boundaryCheck)

                Runtime:removeEventListener("enterFrame", moveObject)
                return
            end
            if e.target.isGrown == false then --if canceled
                transition.cancel(self)
                transition.to(e.target, {time = 500, rotation = 400, xScale = 5, yScale = 5, onComplete = removePalette })
            else --not cancelled
                transition.to(e.target, {time = 500, rotation = 400, xScale = 5, yScale = 5, onComplete = removePalette })
            end
            e.target.isPaletteActive = false
			--You are Alive
        else
            -- HOOKSOUND
            -- local pHit = audio.play( SFXPaletteHit )
            e.target.isPaletteActive = false
            if e.target.isGrown == false then
                e.target:removeSelf()
                spawnTable[e.target.index] = 0
            else
                if self.x < 1 or self.x > _W - 1 then
                    transition.to(e.target, {time = 100, rotation = 0, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
                else
                    transition.to(e.target, {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
                end
            end
            currentColor = e.target.type
			--BONUS SCORE
            if currentColor == previousColor then
                print("match!")
                -- spread = spread + 1
                spread = spread + 1
                -- SAM: bonusText activity
                if bonusText ~= nil then
                    bonusText:removeSelf()
                    bonusText = nil
                end

                local bonusTextTemp = display.newText("+" .. spread, scoreText.x, scoreText.y - scoreText.height, "PTMono-Bold", 14)
                bonusTextTemp:setFillColor(0, 0, 0)

                local bonusTextFadeDir = math.random(10,20)
                if math.random() > .5 then
                    bonusTextFadeDir = -bonusTextFadeDir
                end
                transition.to(bonusTextTemp, {time=400, size=25, alpha=.5, x=bonusTextTemp.x+bonusTextFadeDir, y=bonusTextTemp.y-14, onComplete=function()
                    bonusTextTemp.alpha = 0
                    bonusTextTemp:removeSelf()
                    bonusTextTemp = nil
                end})

                if motion ~= nil then
                    timer.cancel(motion)
                    motion = nil
                end

                if bonusShatterBool == true then
                    if spread == 2 then
                        bonusImplode:setSequence("2x")
                    elseif spread == 3 then
                        bonusImplode:setSequence("3x")
                    elseif spread == 4 then
                        bonusImplode:setSequence("4x")
                    elseif spread == 5 then
                        bonusImplode:setSequence("5x")
                    elseif spread == 6 then
                        bonusImplode:setSequence("6x")
                    elseif spread == 7 then
                        bonusImplode:setSequence("7x")
                    elseif spread == 8 then
                        bonusImplode:setSequence("8x")
                    elseif spread == 9 then
                        bonusImplode:setSequence("9x")
                    end
                    bonusImplode.alpha = 1
                    bonusImplode:toFront()
                    bonusImplode:play()
                    bonusImplode.x = _W * (4 / 5)
                    bonusImplode.y = _H / 2
                    motion = timer.performWithDelay(800, cancelTimerBonusImplode, 1)
                end

            else
                spread = 0
                currentColor = nil
                previousColor = nil

                -- SAM: bonusText activity
                if bonusText ~= nil then
                    bonusText:removeSelf()
                    bonusText = nil
                end
            end

            previousColor = e.target.type

            score = score + 1 + spread
            scoreText.text = score

            -- lightningScore = lightningScore + spread
            trackLightningScore()

        end
    end
    return true
end
------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
function scene:create(e)
    --SAM: determine objects to be managed by scene:create()
    -- print("CREATE")
end

function scene:show(e)
    if (e.phase == "will") then
        -- print("SHOWWILL")

        setupVariables()
        setupScoreboard()
        random = math.randomseed(os.time())
        paceRect = display.newRect(0, 0, 80, 60)
        paceRect:setFillColor(1, 0, 0)
        paceRect.anchorX = 0 ; paceRect.anchorY = 0.5
        paceRect.x = 0 ; paceRect.y = _H / 2
        paceRect.isTopLeft = false
        paceRect.isMoving = false
        paceRect.alpha = 0
        self.view:insert(paceRect)

    elseif (e.phase == "did") then
        Runtime:addEventListener("enterFrame", boundaryCheck)

        -- READYOBJ: START

        Runtime:addEventListener("enterFrame", moveObject)
        system.activate("multitouch")

        -- setCountryParameters()
        -- setFlag()
        -- SAM: flag timers - length of country/flag duration
        -- originally set to 20000
        -- timer.cancel(setFlagTimer)
		--  timer.performWithDelay(15000, checkMemory,0)
    end
end

function scene:hide(e)
    -- print("HIDE")
    if e.phase == "will" then
        -- important listeners and timers to be cancelled!
        transition.cancel( "moveNeedle" )
        timer.cancel(animateCountryTimer)
        Runtime:removeEventListener( "enterFrame", water )

        display.remove(background)

        display.remove(gameDebugGroup)
        display.remove(speedTextGroup)
        display.remove(scoreTextGroup)
        display.remove(modeTextGroup)

        display.remove(paletteBarTop)
        display.remove(paletteBarBtm)
        display.remove(waterGroup)
        display.remove(newGroup)

        display.remove(flag)
        display.remove(testFrame)

		-- what about mask applied to fxGroup
        display.remove(fxGroup)
        display.remove(piece)
        display.remove(mapGroup)
        display.remove(topBar)
        display.remove(lowBar)
        display.remove(infoPic)
        display.remove(lightningIcon1)
        display.remove(lightningIcon2)
        display.remove(lightningIcon3)
        display.remove(lightningIcon4)
        display.remove(lightningIcon5)
        if timerSpeed ~= nil then
            timer.cancel(timerSpeed)
        end
        Runtime:removeEventListener("enterFrame", boundaryCheck)
        Runtime:removeEventListener("enterFrame", moveObject)
        composer.removeScene("game", false)
    end
end

function scene:destroy(e)
    --SAM: determine objects to be managed by scene:destroy()
    -- print("DESTROY")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-----------------------------------------------------------------------------------------
return scene
