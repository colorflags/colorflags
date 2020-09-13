-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html
require("cf_color")
local composer = require("composer")
local cameraEvent = require("cameraevent")
local scene = composer.newScene()

local pGet = ssk.persist.get
local pSet = ssk.persist.set

local game_W = display.actualContentWidth -- Get the width of the screen
local game_H = display.actualContentHeight -- Get the height of the screen

-- audio stuff
local music
local bobby
local SFXArray = {}
SFXArray.poof = {
    audio.loadSound("sfx/a1.wav"),
    audio.loadSound("sfx/a2.wav"),
    audio.loadSound("sfx/a3.wav"),
    audio.loadSound("sfx/a4.wav"),
    audio.loadSound("sfx/a5.wav"),
    audio.loadSound("sfx/a6.wav"),
    audio.loadSound("sfx/a7.wav"),
    audio.loadSound("sfx/a8.wav"),
    audio.loadSound("sfx/a9.wav"),
    audio.loadSound("sfx/a10.wav"),
    audio.loadSound("sfx/b1.wav"),
    audio.loadSound("sfx/b2.wav"),
    audio.loadSound("sfx/b3.wav"),
    audio.loadSound("sfx/b4.wav"),
    audio.loadSound("sfx/b5.wav"),
    audio.loadSound("sfx/b6.wav"),
    audio.loadSound("sfx/b7.wav"),
    audio.loadSound("sfx/b8.wav"),
    audio.loadSound("sfx/b9.wav")
}
SFXArray.poofSize = table.maxn(SFXArray.poof)
SFXArray.lightning = {
    audio.loadSound("sfx/l1.wav"),
    audio.loadSound("sfx/l2.wav"),
    audio.loadSound("sfx/l3.wav"),
    audio.loadSound("sfx/l4.wav")
}
SFXArray.lightningSize = table.maxn(SFXArray.lightning)

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

local debugOptions = {}
debugOptions.god = false
debugOptions.godSpeed = false
debugOptions.godCycle = false
debugOptions.adherenceToFlagColors = false
debugOptions.debugPanel = true
debugOptions.debugPanelStoredValues = {}
debugOptions.scoreKeeper = true

if debugOptions.scoreKeeper == true then
    pSet( "score.json", "highScore" , 0 )
end

-- understand this, could it be of use in this situation?
-- ssk.persist.setDefault( "iap.json", "disabled_ads", false , { save = false } )
if pGet("score.json", "debugPanelStoredValues") == nil then
    pSet( "score.json", "debugPanelStoredValues" , { false, false, false } )
end

local gameMechanics = {}
gameMechanics.playCountryDuration = 30000 -- default 30000
gameMechanics.transitionToCountryDuration = 2000
gameMechanics.firstPaletteDelay = 10
gameMechanics.firstPalette = true
gameMechanics.growSpeedIndependance = false
gameMechanics.countriesSpawned = 0
gameMechanics.overrideFlag = false
gameMechanics.heightModeTop = 35
gameMechanics.heightModeLow = _H - 35
gameMechanics.mode = 1

-- FPS
if fps == 30 then
    gameMechanics.paletteSpawnDelay = 170 -- 85
else
    gameMechanics.paletteSpawnDelay = 85
end

local lightningCount = 1
local lightningKillCount = 0

local score = 0
local numDeaths = 0

-- bad names here?
local levelsIndex = 1
-- SAM: better name for variables speed and timeVar

local speed -- use godSpeed? we already have speed as obj in levelsArray
local timeVar
local timeVarMultiplier = 0.5

local levelsArray
levelsArray = {
    {speed=0.50, timeVar=5900},
    {speed=0.55, timeVar=5400},
    {speed=0.60, timeVar=4950},
    {speed=0.65, timeVar=4450},
    {speed=0.70, timeVar=4400},
    {speed=0.75, timeVar=4200},

    {speed=0.80, timeVar=4000},
    {speed=0.85, timeVar=3800},
    {speed=0.90, timeVar=3600},
    {speed=0.95, timeVar=3400},
    {speed=1.00, timeVar=3200},
    {speed=1.05, timeVar=3000},
    {speed=1.10, timeVar=2800},
    {speed=1.15, timeVar=2600},
    {speed=1.20, timeVar=2400}
}

-- checks if game just started
local countriesCompleted = 0

local code

local spawnTable = {}   --Create a table to hold our spawns
local lineTable = {} --Table for deleting lighning lines
local lineTableCount = 0
local currentColor = "first"
local previousColor = "first"
local choice = 0
local timerSpeed
local flag2Timer
local finalChallenge = false
local count = 1
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
-- SAM: declaring these variables first, assigning functions to them later. That way they can be called in any function regardless of how far down it is in the file.
local setCountryParameters
local newCountry
local moveObject
local readyObject

local resetSpawnTable
local setFlag
local delayPace
local finishScale
local onOptionsTouch
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

local paceRect
local map
local mapGroup
local waterGroup
local newGroup
local zoomMultiplier = .3

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

local flagFrame
local flagFrameOptions

local bmpText

local flag

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
gameDebugArray.gameDebugPanelToggle = nil
gameDebugArray.gameDebugPanelInner = nil
gameDebugArray.gameDebugPanelOuter = nil

gameDebugArray.gameDebugGodBtnGroup = nil
gameDebugArray.gameDebugGodBtnDesc = nil
gameDebugArray.gameDebugGodBtnFill = nil
gameDebugArray.gameDebugGodBtnSym = nil

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

local function spriteListener( event )
    -- print( "Sprite event: ", event.target.sequence, event.target.frame, event.phase )
end

local lightningIconsCoords = require("lua-sheets.new-lightning-icons")
local lightningIconsSheet = graphics.newImageSheet("images/new-lightning-icons.png", lightningIconsCoords:getSheet())
-- local lightningIcons = display.newSprite(lightningIconsSheet, {frames={math.random(5)}})

local countryFillSheetCoords = require("lua-sheets.country_fill_mask")
local countryFillSheet = graphics.newImageSheet("images/country_fill_mask.png", countryFillSheetCoords:getSheet())
local countryFill

local whiteBackground
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

-- READYOBJ: onOptionsTouch
onOptionsTouch = function(event)
    if event.phase == "began" then
        local optionName = event.target.name
        if optionName == "speedDecrease" or optionName == "speedIncrease" then
            if flag ~= nil and debugOptions.godSpeed == true then
                if optionName == "speedIncrease" then
                    speedUp()
                elseif optionName == "speedDecrease" then
                    speedDown()
                end
            end
        elseif optionName == "modeDecrease" or optionName == "modeIncrease" then
            if flag ~= nil and debugOptions.godCycle == true then
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
                -- print("gameMechanics.mode set in onOptionsTouch(): " .. gameMechanics.mode)
                -- SAM: rename gameMechanics.mode to mode
                modeText.text = gameMechanics.mode

                timer.cancel(setFlagTimer)
                setFlag()
                gameMechanics.overrideFlag = true
            end
        elseif optionName == "gameDebugGod" then
            if debugOptions.god == false then
                debugOptions.god = true
                gameDebugGodBtnSym.text = "X"
            else
                debugOptions.god = false
                gameDebugGodBtnSym.text = ""
            end
            pSet( "score.json", "debugPanelStoredValues" , { debugOptions.god, debugOptions.godSpeed, debugOptions.godCycle } )
        elseif optionName == "gameDebugSpeed" then
            if debugOptions.godSpeed == false then
                debugOptions.godSpeed = true
                gameDebugSpeedBtnSym.text = "X"

                speedDecreaseBtnGroup.alpha = 1
                speedIncreaseBtnGroup.alpha = 1
            else
                debugOptions.godSpeed = false
                gameDebugSpeedBtnSym.text = ""

                speedDecreaseBtnGroup.alpha = 0
                speedIncreaseBtnGroup.alpha = 0
            end
            print("godspeed", debugOptions.godSpeed)
            pSet( "score.json", "debugPanelStoredValues" , { debugOptions.god, debugOptions.godSpeed, debugOptions.godCycle } )
        elseif optionName == "gameDebugCycle" then
            if debugOptions.godCycle == false then
                debugOptions.godCycle = true
                gameDebugCycleBtnSym.text = "X"

                modeDecreaseBtnGroup.alpha = 1
                modeIncreaseBtnGroup.alpha = 1
            else
                debugOptions.godCycle = false
                gameDebugCycleBtnSym.text = ""

                modeDecreaseBtnGroup.alpha = 0
                modeIncreaseBtnGroup.alpha = 0
            end
            pSet( "score.json", "debugPanelStoredValues" , { debugOptions.god, debugOptions.godSpeed, debugOptions.godCycle } )
        elseif optionName == "gameDebugPanel" then
            if debugOptions.debugPanel == false then
                debugOptions.debugPanel = true

                -- read saved debugPanel values
                local debugPanelValues = pGet( "score.json", "debugPanelStoredValues" )
                if debugPanelValues[1] == true then
                    debugOptions.god = true
                    gameDebugGodBtnSym.text = "X"
                end

                if debugPanelValues[2] == true then
                    debugOptions.godSpeed = true
                    gameDebugSpeedBtnSym.text = "X"

                    speedDecreaseBtnGroup.alpha = 1
                    speedIncreaseBtnGroup.alpha = 1
                end

                if debugPanelValues[3] == true then
                    debugOptions.godCycle = true
                    gameDebugCycleBtnSym.text = "X"

                    modeDecreaseBtnGroup.alpha = 1
                    modeIncreaseBtnGroup.alpha = 1
                end

                gameDebugGroup.alpha = 1
                gameDebugPanelInner.alpha = 1
                gameDebugPanelOuter.alpha = 1
                paceRect.alpha = 0.6

                print("open panel")
            else
                debugOptions.debugPanel = false

                -- disable god, godSpeed, godCycle
                debugOptions.god = false
                debugOptions.godSpeed = false
                debugOptions.godCycle = false

                speedDecreaseBtnGroup.alpha = 0
                speedIncreaseBtnGroup.alpha = 0
                modeDecreaseBtnGroup.alpha = 0
                modeIncreaseBtnGroup.alpha = 0

                gameDebugGroup.alpha = 0
                gameDebugPanelInner.alpha = 0
                gameDebugPanelOuter.alpha = 0
                paceRect.alpha = 0
                print("close panel")
            end
        end
        return true
    end
end

-- DELETE
-- local waterMask
-- local mapMask
local water

function adjustWidthsAfterResize( event )

    game_W = display.actualContentWidth
    game_H = display.actualContentHeight

    local bigRed = display.newRect(display.screenOriginX, 0, game_W, game_H)
    bigRed.anchorX = 0
    bigRed.anchorY = 0
    bigRed:setFillColor( 0.9, 0, 0 )
    transition.to(bigRed, {time=200, alpha=0, onComplete = function() display.remove(bigRed) end})

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

-- create a function to handle all of the system events
local onSystemEvent = function( event )
    if event.type == "applicationStart" then
        print("start")
    elseif event.type == "applicationExit" then
        print("exit")
    elseif event.type == "applicationSuspend" then
        print("applicationSuspend called")
        paceRect.isMoving = false
        transition.pause()
        timer.pause( setFlagTimer )
        for i = 1, #spawnTable do
            if spawnTable[i] ~= 0 then
                spawnTable[i].isPaletteActive = false
            end
        end
        composer.showOverlay( "pauseoverlay", { effect = "fade", isModal = true } )
    elseif event.type == "applicationResume" then
        print("resume")
    end
end
Runtime:addEventListener( "system", onSystemEvent )

local function setupScoreboard()

    local colorFillArray = CFColor(78, 173, 34)
    local colorShadowArray = CFColor(96, 212, 42)
    local scoreboardColor = { colorFillArray.r, colorFillArray.g, colorFillArray.b }
    -- scoreboardColor = { .2, .9, .4 }
    local scoreboardEmbossColor = {
        highlight = { r = 0, g = 0, b = 0 },
        shadow = { r = colorShadowArray.r, g = colorShadowArray.g, b = colorShadowArray.b }
    }
    local scoreboardFont = "ChaparralPro-SemiboldIt"
    -- local scoreboardFont2 = "ChaparralPro-Bold"

    local scoreboardOffsetFromLeft = 14
    local scoreboardOffsetFromEachOther = 70
    local scoreboardOffsetIncDecBtns = 1.2

    local scoreTextGroupAnchorX = scoreboardOffsetFromLeft
    local scoreTextGroupAnchorY = _H/2

    scoreTextGroup = display.newGroup()
    scoreTextDesc = display.newEmbossedText("score", scoreTextGroupAnchorX, scoreTextGroupAnchorY, scoreboardFont, 22)
    scoreTextDesc:setFillColor(unpack(scoreboardColor))
    scoreTextDesc:setEmbossColor(scoreboardEmbossColor)
    scoreTextDesc.anchorX = 0
    scoreTextDesc.anchorY = 1
    scoreTextGroup:insert(scoreTextDesc)

    scoreText = display.newEmbossedText(score, scoreTextGroupAnchorX + (scoreTextDesc.width/2), scoreTextGroupAnchorY + scoreTextDesc.height, scoreboardFont, 30)
    scoreText:setFillColor(unpack(scoreboardColor))
    scoreText:setEmbossColor(scoreboardEmbossColor)
    scoreText.anchorY = 1
    scoreTextGroup:insert(scoreText)

    local speedTextGroupAnchorX = scoreboardOffsetFromLeft + scoreboardOffsetFromEachOther
    local speedTextGroupAnchorY = _H/2

    speedTextGroup = display.newGroup()

    speedTextDesc = display.newEmbossedText("speed", speedTextGroupAnchorX, speedTextGroupAnchorY, scoreboardFont, 22)
    speedTextDesc:setFillColor(unpack(scoreboardColor))
    speedTextDesc:setEmbossColor(scoreboardEmbossColor)
    speedTextDesc.anchorX = 0
    speedTextDesc.anchorY = 1
    speedTextGroup:insert(speedTextDesc)
    speedTextDesc:toBack()
    speedText = display.newEmbossedText("???", speedTextGroupAnchorX + (speedTextDesc.width/2), speedTextGroupAnchorY + speedTextDesc.height, scoreboardFont, 30)
    speedText:setFillColor(unpack(scoreboardColor))
    speedText:setEmbossColor(scoreboardEmbossColor)
    speedText.anchorY = 1
    speedTextGroup:insert(speedText)


    speedDecreaseBtnGroup = display.newGroup()
    speedDecreaseBtnGroup.name = "speedDecrease"
    speedDecreaseBtnFill = display.newRoundedRect(speedDecreaseBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2) - 11, speedTextGroupAnchorY - speedTextDesc.height * scoreboardOffsetIncDecBtns, 20, 20, 0)
    speedDecreaseBtnFill:setFillColor(.4, .4, .4)
    speedDecreaseBtnFill.anchorY = 1
    speedDecreaseBtnSym = display.newText(speedDecreaseBtnGroup, "-", speedDecreaseBtnFill.x, speedDecreaseBtnFill.y - (speedDecreaseBtnFill.height/2), "PTMono-Bold", 18)
    speedDecreaseBtnSym.anchorX = .5
    speedDecreaseBtnSym.anchorY = .5
    speedTextGroup:insert(speedDecreaseBtnGroup)
    speedDecreaseBtnGroup.alpha = 0
    speedDecreaseBtnGroup:addEventListener("touch", onOptionsTouch)

    speedIncreaseBtnGroup = display.newGroup()
    speedIncreaseBtnGroup.name = "speedIncrease"
    speedIncreaseBtnFill = display.newRoundedRect(speedIncreaseBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2) + 11, speedTextGroupAnchorY - speedTextDesc.height * scoreboardOffsetIncDecBtns, 20, 20, 0)
    speedIncreaseBtnFill:setFillColor(.4, .4, .4)
    speedIncreaseBtnFill.anchorY = 1
    speedIncreaseBtnSym = display.newText(speedIncreaseBtnGroup, "+", speedIncreaseBtnFill.x, speedIncreaseBtnFill.y - (speedIncreaseBtnFill.height/2), "PTMono-Bold", 18)
    speedIncreaseBtnSym.anchorX = .5
    speedIncreaseBtnSym.anchorY = .5
    speedTextGroup:insert(speedIncreaseBtnGroup)
    speedIncreaseBtnGroup.alpha = 0
    speedIncreaseBtnGroup:addEventListener("touch", onOptionsTouch)

    local modeTextGroupAnchorX = scoreboardOffsetFromLeft + (scoreboardOffsetFromEachOther*2)
    local modeTextGroupAnchorY = _H/2

    modeTextGroup = display.newGroup()
    modeTextDesc = display.newEmbossedText("mode", modeTextGroupAnchorX, modeTextGroupAnchorY, scoreboardFont, 22)
    modeTextDesc:setFillColor(unpack(scoreboardColor))
    modeTextDesc:setEmbossColor(scoreboardEmbossColor)
    modeTextDesc.anchorX = 0
    modeTextDesc.anchorY = 1
    modeTextGroup:insert(modeTextDesc)

    modeText = display.newEmbossedText("???", modeTextGroupAnchorX + (modeTextDesc.width/2), modeTextGroupAnchorY + modeTextDesc.height, scoreboardFont, 30)
    modeText:setFillColor(unpack(scoreboardColor))
    modeText:setEmbossColor(scoreboardEmbossColor)
    modeText.anchorY = 1
    modeTextGroup:insert(modeText)

    modeDecreaseBtnGroup = display.newGroup()
    modeDecreaseBtnGroup.name = "modeDecrease"
    modeDecreaseBtnFill = display.newRoundedRect(modeDecreaseBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2) - 11, modeTextGroupAnchorY - modeTextDesc.height * scoreboardOffsetIncDecBtns, 20, 20, 0)
    modeDecreaseBtnFill:setFillColor(.4, .4, .4)
    modeDecreaseBtnFill.anchorY = 1
    modeDecreaseBtnSym = display.newText(modeDecreaseBtnGroup, "-", modeDecreaseBtnFill.x, modeDecreaseBtnFill.y - (modeDecreaseBtnFill.height/2), "PTMono-Bold", 18)
    modeDecreaseBtnSym.anchorX = .5
    modeDecreaseBtnSym.anchorY = .5
    modeTextGroup:insert(modeDecreaseBtnGroup)
    modeDecreaseBtnGroup.alpha = 0
    modeDecreaseBtnGroup:addEventListener("touch", onOptionsTouch)

    modeIncreaseBtnGroup = display.newGroup()
    modeIncreaseBtnGroup.name = "modeIncrease"
    modeIncreaseBtnFill = display.newRoundedRect(modeIncreaseBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2) + 11, modeTextGroupAnchorY - modeTextDesc.height * scoreboardOffsetIncDecBtns, 20, 20, 0)
    modeIncreaseBtnFill:setFillColor(.4, .4, .4)
    modeIncreaseBtnFill.anchorY = 1
    modeIncreaseBtnSym = display.newText(modeIncreaseBtnGroup, "+", modeIncreaseBtnFill.x, modeIncreaseBtnFill.y - (modeIncreaseBtnFill.height/2), "PTMono-Bold", 18)
    modeIncreaseBtnSym.anchorX = .5
    modeIncreaseBtnSym.anchorY = .5
    modeTextGroup:insert(modeIncreaseBtnGroup)
    modeIncreaseBtnGroup.alpha = 0
    modeIncreaseBtnGroup:addEventListener("touch", onOptionsTouch)

    gameDebugGroup = display.newGroup()

    local gameDebugGroupAnchorY = gameMechanics.heightModeLow - 70
    local newScoreboardOffsetFromEachOther = 40
    gameDebugPanelToggle = display.newEmbossedText("debug >", scoreTextDesc.x + scoreTextDesc.width/2, gameDebugGroupAnchorY, "ChaparralPro-SemiboldIt", 22)
    gameDebugPanelToggle.name = "gameDebugPanel"
    gameDebugPanelToggle:setFillColor(unpack(scoreboardColor))
    gameDebugPanelToggle:setEmbossColor(scoreboardEmbossColor)
    gameDebugPanelToggle.anchorX = 0.5
    gameDebugPanelToggle.anchorY = 1
    gameDebugPanelToggle:addEventListener("touch", onOptionsTouch)

    local gameDebugGodAnchorX = speedTextDesc.x
    gameDebugGodBtnGroup = display.newGroup()
    gameDebugGodBtnGroup.name = "gameDebugGod"
    local textParams =
    {
        text = "god?",
        x = gameDebugGodAnchorX,
        y = gameDebugGroupAnchorY,
        font = "PTMono-Bold",
        fontSize = 8,
        align = "center"
    }
    gameDebugGodBtnDesc = display.newEmbossedText(textParams)
    gameDebugGodBtnDesc:setFillColor(unpack(scoreboardColor))
    gameDebugGodBtnDesc:setEmbossColor(scoreboardEmbossColor)
    gameDebugGodBtnDesc.anchorX = .5
    gameDebugGodBtnDesc.anchorY = 0
    gameDebugGroup:insert(gameDebugGodBtnDesc)
    gameDebugGodBtnFill = display.newRoundedRect(gameDebugGodBtnGroup, gameDebugGodAnchorX, gameDebugGroupAnchorY, 30, 30, 0)
    gameDebugGodBtnFill:setFillColor(.2, .2, .2)
    gameDebugGodBtnFill.anchorY = 1
    gameDebugGodBtnSym = display.newText(gameDebugGodBtnGroup, "", gameDebugGodBtnFill.x, gameDebugGodBtnFill.y - (gameDebugGodBtnFill.height/2), "PTMono-Bold", 30)
    if debugOptions.god == true then
        gameDebugGodBtnSym.text = "X"
    end
    gameDebugGodBtnGroup:addEventListener("touch", onOptionsTouch)
    gameDebugGroup:insert(gameDebugGodBtnGroup)

    local gameDebugSpeedAnchorX = gameDebugGodAnchorX + newScoreboardOffsetFromEachOther
    gameDebugSpeedBtnGroup = display.newGroup()
    gameDebugSpeedBtnGroup.name = "gameDebugSpeed"
    textParams =
    {
        text = "speed?",
        x = gameDebugSpeedAnchorX,
        y = gameDebugGroupAnchorY,
        font = "PTMono-Bold",
        fontSize = 8,
        align = "center"
    }
    gameDebugSpeedBtnDesc = display.newEmbossedText(textParams)
    gameDebugSpeedBtnDesc:setFillColor(unpack(scoreboardColor))
    gameDebugSpeedBtnDesc:setEmbossColor(scoreboardEmbossColor)
    gameDebugSpeedBtnDesc.anchorX = .5
    gameDebugSpeedBtnDesc.anchorY = 0
    gameDebugGroup:insert(gameDebugSpeedBtnDesc)
    gameDebugSpeedBtnFill = display.newRoundedRect(gameDebugSpeedBtnGroup, gameDebugSpeedAnchorX, gameDebugGroupAnchorY, 30, 30, 0)
    gameDebugSpeedBtnFill:setFillColor(.2, .2, .2)
    gameDebugSpeedBtnFill.anchorY = 1
    gameDebugSpeedBtnSym = display.newText(gameDebugSpeedBtnGroup, "", gameDebugSpeedBtnFill.x, gameDebugSpeedBtnFill.y - (gameDebugSpeedBtnFill.height/2), "PTMono-Bold", 30)
    if debugOptions.godSpeed == true then
        gameDebugSpeedBtnSym.text = "X"
    end
    gameDebugSpeedBtnGroup:addEventListener("touch", onOptionsTouch)
    gameDebugGroup:insert(gameDebugSpeedBtnGroup)

    local gameDebugCycleAnchorX = gameDebugSpeedAnchorX + newScoreboardOffsetFromEachOther
    gameDebugCycleBtnGroup = display.newGroup()
    gameDebugCycleBtnGroup.name = "gameDebugCycle"
    textParams =
    {
        text = "modes?",
        x = gameDebugCycleAnchorX,
        y = gameDebugGroupAnchorY,
        font = "PTMono-Bold",
        fontSize = 8,
        align = "center"
    }
    gameDebugCycleBtnDesc = display.newEmbossedText(textParams)
    gameDebugCycleBtnDesc:setFillColor(unpack(scoreboardColor))
    gameDebugCycleBtnDesc:setEmbossColor(scoreboardEmbossColor)
    gameDebugCycleBtnDesc.anchorX = .5
    gameDebugCycleBtnDesc.anchorY = 0
    gameDebugGroup:insert(gameDebugCycleBtnDesc)
    gameDebugCycleBtnFill = display.newRoundedRect(gameDebugCycleBtnGroup, gameDebugCycleAnchorX, gameDebugGroupAnchorY, 30, 30, 0)
    gameDebugCycleBtnFill:setFillColor(.2, .2, .2)
    gameDebugCycleBtnFill.anchorY = 1
    gameDebugCycleBtnSym = display.newText(gameDebugCycleBtnGroup, "", gameDebugCycleBtnFill.x, gameDebugCycleBtnFill.y - (gameDebugCycleBtnFill.height/2), "PTMono-Bold", 30)
    if debugOptions.godCycle == true then
        gameDebugCycleBtnSym.text = "X"
    end
    gameDebugCycleBtnGroup:addEventListener("touch", onOptionsTouch)
    gameDebugGroup:insert(gameDebugCycleBtnGroup)

    gameDebugPanelInner = display.newRoundedRect(gameDebugSpeedAnchorX, gameDebugGroupAnchorY - 10, gameDebugGroup.width + 10, gameDebugGroup.height, 0)
    gameDebugPanelInner:setFillColor(.7, .2, .4)
    gameDebugGroup:insert(gameDebugPanelInner)
    gameDebugPanelOuter = display.newRoundedRect(gameDebugSpeedAnchorX, gameDebugGroupAnchorY - 10, gameDebugGroup.width + 2, gameDebugGroup.height + 1, 1)
    gameDebugPanelOuter:setFillColor(.8, .6, .1)
    gameDebugGroup:insert(gameDebugPanelOuter)
    gameDebugPanelInner:toBack()
    gameDebugPanelOuter:toBack()

    if debugOptions.debugPanel == true then
        -- read saved debugPanel values
        local debugPanelValues = pGet( "score.json", "debugPanelStoredValues" )
        if debugPanelValues[1] == true then
            debugOptions.god = true
            gameDebugGodBtnSym.text = "X"
        end

        if debugPanelValues[2] == true then
            debugOptions.godSpeed = true
            gameDebugSpeedBtnSym.text = "X"

            speedDecreaseBtnGroup.alpha = 1
            speedIncreaseBtnGroup.alpha = 1
        end

        if debugPanelValues[3] == true then
            debugOptions.godCycle = true
            gameDebugCycleBtnSym.text = "X"

            modeDecreaseBtnGroup.alpha = 1
            modeIncreaseBtnGroup.alpha = 1
        end

        gameDebugGroup.alpha = 1
        gameDebugPanelInner.alpha = 1
        gameDebugPanelOuter.alpha = 1
        paceRect.alpha = 0.6
        print("start game with debug panel")
    else
        speedDecreaseBtnGroup.alpha = 0
        speedIncreaseBtnGroup.alpha = 0
        modeDecreaseBtnGroup.alpha = 0
        modeIncreaseBtnGroup.alpha = 0

        gameDebugGroup.alpha = 0
        gameDebugPanelInner.alpha = 0
        gameDebugPanelOuter.alpha = 0
        paceRect.alpha = 0
        print("start game with no debug panel")
    end
end

-- SAM: combine functions speedUp() and resetSpawnTable()
speedUp = function()
    if levelsIndex ~= #levelsArray then
        levelsIndex = levelsIndex + 1
        if fps == 30 then
            speed = levelsArray[levelsIndex].speed
        else
            speed = levelsArray[levelsIndex].speed / 2
        end
        -- speed = levelsArray[levelsIndex].speed
        timeVar = levelsArray[levelsIndex].timeVar
        speedText.text = levelsArray[levelsIndex].speed
        speedText:toFront()
    elseif finalChallenge == false then
        finalChallenge = true
    end
end

speedDown = function()
    if levelsIndex ~= #levelsArray then
        levelsIndex = levelsIndex - 1
        if fps == 30 then
            speed = levelsArray[levelsIndex].speed
        else
            speed = levelsArray[levelsIndex].speed / 2
        end
        -- speed = levelsArray[levelsIndex].speed
        timeVar = levelsArray[levelsIndex].timeVar
        speedText.text = levelsArray[levelsIndex].speed
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
    -- SAM: merge with countriesCompleted counted?
    gameMechanics.firstPalette = true
    currentColor = nil    --reset bonus score gameMechanics.modes for new flag
    previousColor = nil

    -- SAM: bonusText activity
    if bonusText ~= nil then
        bonusText:removeSelf()
        bonusText = nil
    end

    if debugOptions.godCycle == false then
        --decide what gameMechanics.mode is next
        if gameMechanics.mode == 1 then
            gameMechanics.mode = 2
            --levelsIndex = levelsIndex + 1
        elseif gameMechanics.mode == 2 then
            gameMechanics.mode = 3
            --levelsIndex = levelsIndex / 2 - 1
            --levelsIndex = math.round(levelsIndex)
        elseif gameMechanics.mode == 3 then
            gameMechanics.mode = 1
            --levelsIndex = (levelsIndex) * 2
        end
    end

    --ERROR: crashes, let the game run
    -- speed = levels[levelsIndex].speed
    -- timeVar = levels[levelsIndex].timeVar

    speedText.text = levelsArray[levelsIndex].speed
    speedText:toFront()
end

local function endGame(self)
    display.remove(self)
    choice = choice + 1
    if choice == numDeaths then
        if score > pGet("score.json", "highScore") then
            pSet( "score.json", "highScore" , score )
        end
        paceRect.isMoving = false
        composer.gotoScene("gameover")
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

-- Boundary Handler
local function boundaryElimination(e)
    for i = 1, #spawnTable do
        --junk paletts go away
        if spawnTable[i] ~= 0 and spawnTable[i].dead ~= true then
            spawnTable[i].isPaletteActive = false
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

-- Boundary Handler
local function boundaryCheck(e)
    local temp
    local breakLoop = false
    --breakLoop ensures this outerloop will break after it finds the bad pallete
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
                                        if lookupCode(code, spawnTable[i]) == 1 then
                                            spawnTable[i]:removeEventListener("touch", objTouch)
                                            spawnTable[i].dead = true
                                            numDeaths = numDeaths + 1
                                        else
                                            spawnTable[i].dead = false
                                        end
                                    end

                                    print("effects for palettes within bounds")
                                    if gameMechanics.mode == 3 and spawnTable[i].dead ~= true  then
                                        transition.to(spawnTable[i], {time = 300, alpha = 0})
                                    end

                                    print("reverse motion for death effect")
                                    -- replace with Corner implementation
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

local function paletteGrow(self)
    if gameMechanics.growSpeedIndependance == true then
        transition.to(self, {time = 200, xScale = 1, yScale = 1})
    else
        -- SAM: originally timeVar * timeVarMultiplier
        transition.to(self, {time = timeVar * timeVarMultiplier, xScale = 1, yScale = 1})
        -- transition.to(self, {time = timeVar, xScale = 1, yScale = 1})
    end
end

-- PALETTES
local function spawnPalette(params)

    -- SAM: spawned pad's color
    -- print(params.type)

    local object = display.newRoundedRect(0, 0, 80, 60, 3)

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
            transition.to(object, {time = timeVar * timeVarMultiplier, xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * timeVarMultiplier, xScale = .01, yScale = .01, onComplete = paletteGrow})
            if spawnTable[object.index - 2] ~= 0 then
                spawnTable[object.index - 2]:toFront()
            end
        end
    elseif gameMechanics.mode == 3 then
        if object.index == 1 or object.index == 2 or object.index == 3 or object.index == 4 then
            transition.to(object, {time = timeVar * timeVarMultiplier, xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * timeVarMultiplier, xScale = .01, yScale = .01, onComplete = paletteGrow})
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
        transition.to(flag, {time = 30, rotation = -10, onComplete = flagRotate1})
        for i = 1, #spawnTable do
            if spawnTable[i] ~= 0 and spawnTable[i] ~= nil then
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
        if lineTableCount > 0 then
            audio.play( SFXArray.lightning[math.random(1, SFXArray.lightningSize)] )
            lightningCount = lightningCount - 1
        end
    end
    lightningIcons()
end

local function trackLightningScore()
    print("spread from trackLightningScore:", spread)
    -- SAM: my lightning tracker. keeping things simple
    if spread == 0 then
        lightningScore = 0
    elseif spread >= 1 and lightningCount <= 4 then
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
        speedText.text = levelsArray[levelsIndex].speed
        speedText:toFront()
    end
end

local function nextMove()
    pointAnimation:pause()
    pointAnimation:toBack()
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

local countryFillBounceTimer
local countryFillBounce
local function triggercountryFillBounce()
    countryFillBounceTimer = timer.performWithDelay( 1000, countryFillBounce, 1 )
end
countryFillBounce = function()
    transition.to( fxBG.fill.effect, { time=10, angle=0, onComplete=
    function()
        transition.to( fxBG.fill.effect, { time=1390, angle=20, transition=easing.continuousLoop})
    end
})
transition.to( fxBG, { tag="moveNeedle", delay=50, time=1350, rotation=fxBG.rotation+90, transition = easing.inOutQuad, onComplete=function()
    triggercountryFillBounce()
end
})
end

previousCountry = nil
previouscountryFill = nil
-- READYOBJ: setCountryParameters
setCountryParameters = function(restartCountry)
    -- don't increase speed every new country, change modes or randomize modes.
    if debugOptions.godSpeed == false and gameMechanics.overrideFlag == false and countriesCompleted > 0 then
        speedUp()
    end

    -- wrap in a function.. this can all be in the speedUp() function?
    if fps == 30 then
        speed = levelsArray[levelsIndex].speed
    else
        speed = levelsArray[levelsIndex].speed / 2
    end

    timeVar = levelsArray[levelsIndex].timeVar
    speedText.text = levelsArray[levelsIndex].speed
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
            previouscountryFill = countryFill
        end

        newCountry()

        -- SAM: calling of finishScale
        -- sideTimer = timer.performWithDelay(gameMechanics.transitionToCountryDuration, finishScale, 1)
        sideTimer = timer.performWithDelay(1, finishScale, 1)

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

        if(countriesCompleted == 0) then
            print(country.name)
            xCoord=(0)-(country.coords.x + (countryFill.width/2))
            yCoord=(0)-(country.coords.y + (countryFill.height/2))

            mapGroup[1].x = xCoord
            mapGroup[1].y = yCoord

            transition.to( newGroup, {delay=40, time=200, alpha=1} )
        else
            cameraEvent.focus(
            gameMechanics.transitionToCountryDuration,
            country,
            countryFill,
            previousCountry,
            previouscountryFill,
            mapGroup
        )
    end

    -- old style. Currently working on function to handle transitions to zoom in and out!
    -- mapTimer = transition.to( mapGroup, { time=gameMechanics.transitionToCountryDuration, x=xCoord, y=yCoord, xScale=1*zoomMultiplier, yScale=1*zoomMultiplier})
else
    paceTimer = timer.performWithDelay(10, delayPace, 1)
end
end

-- READYOBJ: newCountry
newCountry = function()

    -- SAM: change to countries? All country data is kept in here.. reference to cf_game_settings.lua
    local randomCountry = math.random(CFGameSettings:getLength())
    country = CFGameSettings:getItemByID(randomCountry)

    local subGroup = display.newGroup()
    local options
    options = {
        text = country.printedName,
        x = flagFrame.x - flagFrame.width / 2,
        y = flagFrame.y + flagFrame.height / 2,
        width = flagFrame.width,
        font = "fonts/kefa.fnt",
        fontSize = 22,
        align = "left",
    }

    if bmpText ~= nil then
        display.remove(bmpText)
        bmpText = nil
    end

    -- Uses pretty much the same options as display.newText
    bmpText = ponyfont.newText(options)
    bmpText.anchorY = 0
    bmpText.anchorX = 0.5
    subGroup:insert(bmpText.raw) -- use the .raw to get to the displaygroup for inserting


    -- You can set the properties without calling any update() function
    -- uncomment the lines below to see how the text reacts
    --bmpText.text = "This is updated text in the same displayObject..."
    --bmpText.fontSize = 60
    bmpText.align = "center"

    -- Demo looping through each letter
    for i = 1, bmpText.numChildren do
        transition.from ( bmpText[i], { delay = 100 + (i*25), time = 250, xScale = 2, yScale = 2, alpha = 0, transition = easing.outBounce })
    end

    inclusiveColorsArray = adherenceToFlagColors(0)

    --SAM: should i put this outside the countries() function? Or is no need for it to be in a function?
    function destroyStuff()

        if(countryFill ~= nil) then
            countryFill:removeSelf()
            countryFill = nil
        end

        -- print(mapGroup.numChildren)
        if(fapGroup) then
            for j=fapGroup.numChildren, 1, -1 do
                if(fapGroup[j].id == "fxGroup") then
                    for k=fapGroup[j].numChildren, 1, -1 do
                        local child = fapGroup[j][k]
                        print("fxGroup item")
                        print(child.fill)
                        child:removeSelf()
                        child = nil
                    end
                    print("remove group: ", fapGroup[j].id )
                    fapGroup[j]:removeSelf()
                end
            end
        end
    end
    destroyStuff()

    countryFill = display.newSprite( countryFillSheet, {frames={countryFillSheetCoords:getFrameIndex(country.name)}} )

    -- print("country width:", countryFill.width, "country height:", countryFill.height)

    -- SAM: zoom to country
    --[[
    if countryFill.width < _W/2 and countryFill.height < _H/2 then
end
]]--

-- SAM: countryFill scaling
countryFillWidthMultiplier = display.pixelHeight/display.contentWidth
countryFillHeightMultiplier = display.pixelWidth/display.contentHeight
-- print("pixelHeight / contentWidth: ", countryFillWidthMultiplier)
-- print("pixelWidth / contentHeight: ", countryFillHeightMultiplier)
countryFill:scale(1/countryFillWidthMultiplier, 1/countryFillHeightMultiplier)

-- SAM: originally a local variable
fxGroup = display.newGroup()
fxGroup.id = "fxGroup"

-- print("countryFill.width:" .. countryFill.width, "countryFill.height" .. countryFill.height)

local fxSize
if(countryFill.width > countryFill.height) then
    -- delete?
    -- fxSize = math.ceil(countryFill.width * countryFill.xScale) + 120
    fxSize = math.ceil(countryFill.width) + 120
else
    -- delete?
    -- fxSize = math.ceil(countryFill.height * countryFill.yScale) + 120
    fxSize = math.ceil(countryFill.width) + 120
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
-- SAM: understand this a bit more. Should these values be returned to their defaults as soon as implementing this fxgroup.png texture?
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

    fxGroup:insert(fxBG)

    newTex = graphics.newTexture( { type="canvas", width=fxSize, height=fxSize } )
    newTex:draw(countryFill)
    newTex:invalidate()

    -- SAM: masks fxBG (newCircle) with country outline
    mask = graphics.newMask(newTex.filename, newTex.baseDir)
    fxGroup:setMask(mask)
    canvasObj.alpha = 0

    fxGroup.x=(map.x)-(map.x-country.coords.x-(countryFill.width/2))
    fxGroup.y=(map.y)-(map.y-country.coords.y-(countryFill.height/2))

    fapGroup:insert(fxGroup)


    if(countriesCompleted == 0) then
        countryFillBounce()
    end

    flag=display.newSprite(nationalFlags1Sheet,nationalFlagsSeq, 100, 10)
    flag:setSequence(country.name)
    flag.x = _W - flagFrameOptions.flagOffset
    flag.y = _H/2
    flag.width = 500
    flag.height = 333
    flag.xScale = .3
    flag.yScale = .3 * .7
    flag.anchorX = 1
    flag.anchorY = 0.5

    -- SAM: figure out a better solution for this! Groups (flag, flagFrame, and lightningIcons)?
    lightningIcon1:toFront()
    lightningIcon2:toFront()
    lightningIcon3:toFront()
    lightningIcon4:toFront()
    lightningIcon5:toFront()

    flag:addEventListener("tap", lightningButton)
    lightningIcons()

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

    music = audio.loadStream("anthems/" .. country.name .. ".wav")

    local function offsetIncomingAnthem(outgoingAnthem, incomingAnthem)
        local function listener(event)
            audio.stop(outgoingAnthem)
            lastReservedChannel = incomingAnthem
            audio.stop(lastReservedChannel)
            audio.setVolume( .5, { channel = lastReservedChannel } )
            audioReservedChannels[lastReservedChannel] = audio.play(music, {channel = lastReservedChannel, loops=-1, onComplete=function(event)
                print("finished streaming anthem on channel " .. event.channel)
            end})
        end
        timer.performWithDelay ((timeVar * timeVarMultiplier)/2, listener)
    end

    local function offsetIncomingAnthemWithFade(outgoingAnthem, incomingAnthem)
        audio.fadeOut( { channel=outgoingAnthem, time=500 } )
        lastReservedChannel = incomingAnthem
        audio.stop(lastReservedChannel)
        audio.setVolume( .5, { channel = lastReservedChannel } )
        audioReservedChannels[lastReservedChannel] = audio.play(music, {channel=lastReservedChannel, loops=-1, fadein=500})
    end


    if countriesCompleted ~= 0 then
        if lastReservedChannel ~= nil then
            if lastReservedChannel == 1 then
                offsetIncomingAnthemWithFade(1, 2)
            elseif lastReservedChannel == 2 then
                offsetIncomingAnthemWithFade(2, 1)
            end
        end
    else
        if lastReservedChannel ~= nil then
            if lastReservedChannel == 1 then
                audio.stop(lastReservedChannel)
                lastReservedChannel = 2
                audio.stop(lastReservedChannel)
                audio.setVolume( .5, { channel = lastReservedChannel } )
                audioReservedChannels[lastReservedChannel] = audio.play(music, {channel = lastReservedChannel, loops=-1} )
            elseif lastReservedChannel == 2 then
                audio.stop(lastReservedChannel)
                lastReservedChannel = 1
                audio.stop(lastReservedChannel)
                audio.setVolume( .5, { channel = lastReservedChannel } )
                audioReservedChannels[lastReservedChannel] = audio.play(music, {channel = lastReservedChannel, loops=-1} )
            end
        else
            lastReservedChannel = 1
            audio.stop(lastReservedChannel)
            audio.setVolume( .5, { channel = lastReservedChannel } )
            audioReservedChannels[lastReservedChannel] = audio.play(music, {channel = lastReservedChannel, loops=-1} )
        end
    end
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
    flag:removeEventListener("tap", lightningButton)
    flag:removeSelf()
    flag = nil
end

-- SAM: Can we somehow arrange the finishScale() function after the setCountryParameters() function, its importance is pretty relevant to setCountryParameters() ?? Maybe merge all functions pertaining to setCountryParameters and flag enlargement into one neat function
-- SAM: seems as though the only game-mechanic related part of this function a call to lightningEnable()
-- no longer using topBar and lowBar

finishScale = function()

    transition.to(flag, {time = 1000, alpha = 1})

    -- SAM: delete?
    -- flagLightningReady = timer.performWithDelay(1000, lightningEnable, 1)

    -- SAM: delete this? used for offsetting when speedUp() occurs - can happen in during midst of a country
    -- timerSpeed = timer.performWithDelay(9500, speedUp, 1)

    countriesCompleted = countriesCompleted + 1
    -- print("end of finishScale() function")
    controller:incrementCountriesCompleted()
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
            paceRect.x = paceRect.x + levelsArray[levelsIndex].speed
        else
            paceRect.x = paceRect.x + (levelsArray[levelsIndex].speed / 2)
        end
        --reset PaceRect, call readyObjects() to create a new palette or flag
        readyObject()

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
end

-- SAM: rename this, calls newFlag(), resets the palettes, and a whole lot more
-- READYOBJ: readyObject
readyObject = function(firstCountry)
    if firstCountry then
        gameMechanics.countriesSpawned = gameMechanics.countriesSpawned + 1
        setCountryParameters()
        setFlagTimer = timer.performWithDelay(gameMechanics.playCountryDuration, setFlag, 1)
        return
    end

    -- SAM: added 3rd OR (gameMechanics.firstPalette == true) condition
    -- print("new spacing determined when " .. paceRect.x .. " > " .. 85)
    if paceRect.x > gameMechanics.paletteSpawnDelay or gameMechanics.overrideFlag == true or gameMechanics.firstPalette == true then
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
                    end
                end
                resetSpawnTable()
                setCountryParameters()
                timer.cancel(setFlagTimer)
                setFlagTimer = timer.performWithDelay(gameMechanics.playCountryDuration, setFlag, 1)
            end
        else

            createPalette()
            if gameMechanics.firstPalette == true then
                gameMechanics.firstPalette = false
            elseif gameMechanics.firstPalette == false then
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

function objTouch(self, e)
    if e.phase == "began" and e.target.isPaletteActive == true then
        -- animatePaletteDestroy(spawnTable[self.index].x, spawnTable[self.index].y, spawnTable[self.index].isTopLeft)

        audio.play( SFXArray.poof[math.random(1, SFXArray.poofSize)] )

        if lookupCode(code, e.target) == 0 then   --You are Dead --color does not match
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

function scene:create(e)
    --SAM: determine objects to be managed by scene:create()
    w1 = 1;w2 = 1;w3 = 1
    k1 = 0;k2 = 0;k3 = 0
    r1 = 1;r2 = 0;r3 = 0
    o1 = 1;o2 = .502;o3 = 0
    y1 = 1;y2 = 1;y3 = 0
    g1 = 0;g2 = .4;g3 = 0
    b1 = 0;b2 = 0;b3 = 1
	local paint = {
	    type = "gradient",
	    color1 = { .6, .6, .6, 1 },
	    color2 = { .2, .2, .2, 1 },
	    direction = "down"
	}

	whiteBackground = display.newRect( _W/2, _H/2, _W, _H )
	whiteBackground.fill = paint
    whiteBackground.alpha = 0
    self.view:insert(whiteBackground)
    paletteBarTop = display.newSprite( paletteBarSheet , {frames={paletteBarSheetCoords:getFrameIndex("palette_bar_top")}} )
    paletteBarBtm = display.newSprite( paletteBarSheet , {frames={paletteBarSheetCoords:getFrameIndex("palette_bar_btm")}} )
    paletteBarTop.alpha = 1
    paletteBarBtm.alpha = 1
    self.view:insert(paletteBarTop)
    self.view:insert(paletteBarBtm)

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
    self.view:insert(waterGroup)

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
    fapGroup = display.newGroup()
    map = display.newImageRect("images/worldmap_2017_300.png", 8191, 4084)
    map.anchorX = 0
    map.anchorY = 0
    map.name = "map"
    map.x = 0
    map.y = 0
    fapGroup:insert(map)
    mapGroup:insert(fapGroup)
    mapGroup.x = _W/2
    mapGroup.y = _H/2
    mapGroup.xScale = 1 * zoomMultiplier
    mapGroup.yScale = 1 * zoomMultiplier

    newGroup = display.newGroup()
    newGroup:insert(mapGroup)
    self.view:insert(newGroup)
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
        xScale = .3,
        yScale = .3 * .7,
        anchorX = 1,
        anchorY = .5,
        flagPadding = 1,
        flagOffset = .5
    }

    -- rename flagFrame to flagFrame
    flagFrame = display.newRect(flagFrameOptions.x, flagFrameOptions.y, flagFrameOptions.width * flagFrameOptions.xScale + flagFrameOptions.flagPadding, flagFrameOptions.height * flagFrameOptions.yScale + flagFrameOptions.flagPadding)
    flagFrame.anchorX = flagFrameOptions.anchorX
    flagFrame.anchorY = flagFrameOptions.anchorY
    flagFrame:setFillColor(0, 0, 0)

    -- flagFrameAnchorX and flagFrameAnchorY are derived from flagFrameOptions (used by flagFrame) to place GUI objects pertaining and bound to flag area
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
    local function jitterEvent( event )
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

    paceRect = display.newRoundedRect(0, 0, 80, 6, 3)
    paceRect:setFillColor(1, 1, 1)
    paceRect.anchorX = 0
    paceRect.anchorY = 1
    paceRect.x = 0
    paceRect.y = _H - (gameMechanics.heightModeTop*2)
    paceRect.isTopLeft = false
    paceRect.isMoving = false
    paceRect.alpha = 0.6

    setupScoreboard()
end

function scene:focusGame()
	print("re-focus game.lua")
    paceRect.isMoving = true
    transition.resume()
    timer.resume( setFlagTimer )
    for i = 1, #spawnTable do
        if spawnTable[i] ~= 0 then
            spawnTable[i].isPaletteActive = true
        end
    end
end

function scene:focusGameAndQuit()
    -- Death Palette Animation
    for i = 1, #spawnTable do
        if spawnTable[i] ~= 0 then
            spawnTable[i]:removeEventListener("touch", objTouch)
            transition.to(spawnTable[i], {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
        end
    end
    Runtime:removeEventListener("enterFrame", boundaryCheck)
    Runtime:removeEventListener("enterFrame", moveObject)
    composer.gotoScene("menu")
end

function scene:show(e)
    if (e.phase == "will") then
        -- print("SHOWWILL")

    elseif (e.phase == "did") then
        print("did")
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
        timer.cancel(countryFillBounceTimer)
        Runtime:removeEventListener( "enterFrame", water )

        display.remove(background)

        display.remove(gameDebugGroup)
        display.remove(speedTextGroup)
        display.remove(scoreTextGroup)
        display.remove(modeTextGroup)
        display.remove(gameDebugPanelToggle)

        display.remove(paletteBarTop)
        display.remove(paletteBarBtm)
        display.remove(waterGroup)
        display.remove(newGroup)

        display.remove(flag)
        display.remove(flagFrame)
        display.remove(bmpText)
        display.remove(paceRect)
        -- what about mask applied to fxGroup
        display.remove(fxGroup)
        display.remove(piece)
        display.remove(mapGroup)
        display.remove(topBar)
        display.remove(lowBar)
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
        Runtime:removeEventListener( "system", onSystemEvent )
        Runtime:removeEventListener( "resize", onResize )
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
