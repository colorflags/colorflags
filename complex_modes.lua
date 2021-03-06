-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html
local composer = require("composer")
local scene = composer.newScene()
local gotoDeath = false
local lightningCount = 1
local state = 5
local stateFour = 0
local stateFourGrow = 0
local speed = 2
local timeVar = 1250
local levels
local score = 0
local numDeaths = 0
local idx = 3

-- checks if game just started
local countriesCompleted = 0

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
local flagLightningReady
local flagLightningActive = false
local rotationTimer
local lightningIcon1
local lightningIcon2
local lightningIcon3
local lightningIcon4
local lightningIcon5
local lightningIcon6
local lightningIcon7
local lightningIcon8
local lightningIcon9
local lightningIcon10
local lightningIcon11
local lightningIcon12
local lightningIcon13
local lightningIcon14
local lightningScore = 0
local lightningMultiplier = 1
local line
local paceRect
local map
local mapGroup
local flag
local random

local bonusText

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

local deathScenario2Array = {}

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
    {name = "sriLanka", sheet = nationalFlags2Sheet, frames = {24}},
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

local bonusImplode = display.newSprite(bonusImplodeSheet1, bonusImplodeSeq)
bonusImplode.alpha = 0 --start with 0

local countryOutlineSheetCoords = require("lua-sheets.country_outline")
local countryOutlineSheet = graphics.newImageSheet("images/country_outline_mask.png", countryOutlineSheetCoords:getSheet())
local countryOutline
local countryOutlineTest

local fxGroup
local fxBG
local fxAnim
-- SAM: redunant

--countryOutline.fill = { 1, 0, 0.5, 0.3 }
--countryOutline.anchorX=.5
--countryOutline.anchorY=.5
--countryOutline.x = _W/2
--countryOutline.y = _H/2

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

local background = display.newRect(0, 0, _W, _H)
background:setFillColor(1, 1, 1)
background.anchorX = 0.5
background.anchorY = 0.5
background.name = "background"
background.x = _W / 2 ;background.y = _H / 2
background:toBack()

local function setupScoreboard()

    local scoreboardColor = {
        highlight = {r = 1, g = 1, b = 1},
        shadow = {r = 0, g = 0, b = 0}
    }

    local speedTextGroupAnchorX = 2
    local speedTextGroupAnchorY = _H/2 - 20

    speedTextGroup = display.newGroup()

    speedTextDesc = display.newEmbossedText("speed:", speedTextGroupAnchorX, speedTextGroupAnchorY, "PTMono-Bold", 18)
    speedTextDesc:setFillColor(.2, .9, .4)
    speedTextDesc:setEmbossColor(scoreboardColor)
    speedTextDesc.anchorX = 0
    speedTextDesc.anchorY = 1
    speedTextGroup:insert(speedTextDesc)

    speedText = display.newEmbossedText(speed, speedTextGroupAnchorX + (speedTextDesc.width/2), speedTextGroupAnchorY, "PTMono-Bold", 22)
    speedText:setFillColor(.2, .9, .4)
    speedText:setEmbossColor(scoreboardColor)
    speedText.anchorY = 0
    speedTextGroup:insert(speedText)

    speedDecreaseBtnGroup = display.newGroup()
    speedDecreaseBtnFill = display.newRoundedRect(speedDecreaseBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2) - 6, speedTextGroupAnchorY - speedTextDesc.height, 10, 10, 1)
    speedDecreaseBtnFill:setFillColor(.4, .4, .4)
    speedDecreaseBtnFill.anchorY = 1
    speedDecreaseBtnSym = display.newText(speedDecreaseBtnGroup, "-", speedDecreaseBtnFill.x, speedDecreaseBtnFill.y - (speedDecreaseBtnFill.height/2), "PTMono-Bold", 14)
    speedDecreaseBtnSym.anchorX = .5
    speedDecreaseBtnSym.anchorY = .5
    speedTextGroup:insert(speedDecreaseBtnGroup)

    speedIncreaseBtnGroup = display.newGroup()
    speedIncreaseBtnFill = display.newRoundedRect(speedIncreaseBtnGroup, speedTextGroupAnchorX + (speedTextDesc.width/2) + 6, speedTextGroupAnchorY - speedTextDesc.height, 10, 10, 1)
    speedIncreaseBtnFill:setFillColor(.4, .4, .4)
    speedIncreaseBtnFill.anchorY = 1
    speedDecreaseBtnSym = display.newText(speedIncreaseBtnGroup, "+", speedIncreaseBtnFill.x, speedIncreaseBtnFill.y - (speedIncreaseBtnFill.height/2), "PTMono-Bold", 14)
    speedDecreaseBtnSym.anchorX = .5
    speedDecreaseBtnSym.anchorY = .5
    speedTextGroup:insert(speedIncreaseBtnGroup)

    local scoreTextGroupAnchorX = 2
    local scoreTextGroupAnchorY = (_H/2) + 45

    scoreTextGroup = display.newGroup()
    scoreTextDesc = display.newEmbossedText("score:", scoreTextGroupAnchorX, scoreTextGroupAnchorY, "PTMono-Bold", 18)
    scoreTextDesc:setFillColor(.2, .9, .4)
    scoreTextDesc:setEmbossColor(scoreboardColor)
    scoreTextDesc.anchorX = 0
    scoreTextDesc.anchorY = 1
    scoreTextGroup:insert(scoreTextDesc)

    scoreText = display.newEmbossedText(score, scoreTextGroupAnchorX + (scoreTextDesc.width/2), scoreTextGroupAnchorY, "PTMono-Bold", 22)
    scoreText:setFillColor(.2, .9, .4)
    scoreText:setEmbossColor(scoreboardColor)
    scoreText.anchorY = 0
    scoreTextGroup:insert(scoreText)

    scoreDecreaseBtnGroup = display.newGroup()
    scoreDecreaseBtnFill = display.newRoundedRect(scoreDecreaseBtnGroup, scoreTextGroupAnchorX + (scoreTextDesc.width/2) - 6, scoreTextGroupAnchorY - scoreTextDesc.height, 10, 10, 1)
    scoreDecreaseBtnFill:setFillColor(.4, .4, .4)
    scoreDecreaseBtnFill.anchorY = 1
    scoreDecreaseBtnSym = display.newText(scoreDecreaseBtnGroup, "-", scoreDecreaseBtnFill.x, scoreDecreaseBtnFill.y - (scoreDecreaseBtnFill.height/2), "PTMono-Bold", 14)
    scoreDecreaseBtnSym.anchorX = .5
    scoreDecreaseBtnSym.anchorY = .5
    scoreTextGroup:insert(scoreDecreaseBtnGroup)

    scoreIncreaseBtnGroup = display.newGroup()
    scoreIncreaseBtnFill = display.newRoundedRect(scoreIncreaseBtnGroup, scoreTextGroupAnchorX + (scoreTextDesc.width/2) + 6, scoreTextGroupAnchorY - scoreTextDesc.height, 10, 10, 1)
    scoreIncreaseBtnFill:setFillColor(.4, .4, .4)
    scoreIncreaseBtnFill.anchorY = 1
    scoreDecreaseBtnSym = display.newText(scoreIncreaseBtnGroup, "+", scoreIncreaseBtnFill.x, scoreIncreaseBtnFill.y - (scoreIncreaseBtnFill.height/2), "PTMono-Bold", 14)
    scoreDecreaseBtnSym.anchorX = .5
    scoreDecreaseBtnSym.anchorY = .5
    scoreTextGroup:insert(scoreIncreaseBtnGroup)

    -- print("speedTextGroup width: ", speedTextGroup.width)

    local modeTextGroupAnchorX = 2 + 75
    local modeTextGroupAnchorY = (_H/2) - 20

    modeTextGroup = display.newGroup()
    modeTextDesc = display.newEmbossedText("mode:", modeTextGroupAnchorX, modeTextGroupAnchorY, "PTMono-Bold", 18)
    modeTextDesc:setFillColor(.2, .9, .4)
    modeTextDesc:setEmbossColor(scoreboardColor)
    modeTextDesc.anchorX = 0
    modeTextDesc.anchorY = 1
    modeTextGroup:insert(modeTextDesc)

    modeText = display.newEmbossedText("???", modeTextGroupAnchorX + (modeTextDesc.width/2), modeTextGroupAnchorY, "PTMono-Bold", 22)
    modeText:setFillColor(.2, .9, .4)
    modeText:setEmbossColor(scoreboardColor)
    modeText.anchorY = 0
    modeTextGroup:insert(modeText)

    modeDecreaseBtnGroup = display.newGroup()
    modeDecreaseBtnFill = display.newRoundedRect(modeDecreaseBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2) - 6, modeTextGroupAnchorY - modeTextDesc.height, 10, 10, 1)
    modeDecreaseBtnFill:setFillColor(.4, .4, .4)
    modeDecreaseBtnFill.anchorY = 1
    modeDecreaseBtnSym = display.newText(modeDecreaseBtnGroup, "-", modeDecreaseBtnFill.x, modeDecreaseBtnFill.y - (modeDecreaseBtnFill.height/2), "PTMono-Bold", 14)
    modeDecreaseBtnSym.anchorX = .5
    modeDecreaseBtnSym.anchorY = .5
    modeTextGroup:insert(modeDecreaseBtnGroup)

    modeIncreaseBtnGroup = display.newGroup()
    modeIncreaseBtnFill = display.newRoundedRect(modeIncreaseBtnGroup, modeTextGroupAnchorX + (modeTextDesc.width/2) + 6, modeTextGroupAnchorY - modeTextDesc.height, 10, 10, 1)
    modeIncreaseBtnFill:setFillColor(.4, .4, .4)
    modeIncreaseBtnFill.anchorY = 1
    modeDecreaseBtnSym = display.newText(modeIncreaseBtnGroup, "+", modeIncreaseBtnFill.x, modeIncreaseBtnFill.y - (modeIncreaseBtnFill.height/2), "PTMono-Bold", 14)
    modeDecreaseBtnSym.anchorX = .5
    modeDecreaseBtnSym.anchorY = .5
    modeTextGroup:insert(modeIncreaseBtnGroup)

    --SAM: assign topBar and btmBar variables prior to initrializing deathScenario2Array. That way their height can be referenced. Height = 100, but will vary with adaptive sizing (i.e. 2x and 4x)
    table.insert(deathScenario2Array, display.newEmbossedText("]X", 10, 76, "PTMono-Bold", 14))
    table.insert(deathScenario2Array, display.newEmbossedText("X[", _W - 10, 76, "PTMono-Bold", 14))
    table.insert(deathScenario2Array, display.newEmbossedText("]X", 10, _H - 76, "PTMono-Bold", 14))
    table.insert(deathScenario2Array, display.newEmbossedText("X[", _W - 10, _H - 76, "PTMono-Bold", 14))

    local deathScenario2Color = {
        highlight = {r = 0, g = 0, b = 0},
        shadow = {r = 158/255, g = 13/255, b = 0}
    }

    for i = 1, #deathScenario2Array do
        deathScenario2Array[i]:setFillColor(246/255, 81/255, 0)
        -- deathScenario2Array[i]:setEmbossColor(deathScenario2Color)
        deathScenario2Array[i].alpha = 0
    end
end

--SAM: CFText (advanced color classes), to be re-worked and implemented later

--speedText = CFText.new( speed, "Arial Rounded MT Bold", 30, _W*(1/5), _H/2 )
--speedText:ToFront()

--scoreText = CFText.new( score, "Arial Rounded MT Bold", 30, _W*(4/5), _H/2 )
--scoreText:ToFront()

local function speedUp()
    if idx ~= #levels then
        idx = idx + 1
        speed = levels[idx].speed
        timeVar = levels[idx].timeVar
        speedText.text = speed
        speedText:toFront()
		--SAM: CFText
		--speedText:Text(speed)
		--speedText:ToFront()
    elseif finalChallenge == false then
        finalChallenge = true
    end
end

local function resetSpawnTable()
    if music ~= nil then
        media.stopSound(music)
        music = nil
    end
    spawnTable = {}
    count = 1
    firstObject = true
    currColor = nil    --reset bonus score states for new flag
    prevColor = nil
    if bonusText ~= nil then
        bonusText:removeSelf()
		--bonusText:Remove()
        bonusText = nil
    end
	--decide what state is next
    if state == 4 then
        state = 4
        idx = idx + 1
    elseif state == 3 then
        if finalChallenge == false then
            state = 1
            idx = (idx) * 2
        end
    elseif state == 1 then
        state = 2
        idx = idx + 1
    elseif state == 2 then
        state = 3
        idx = idx / 2 - 1
        idx = math.round(idx)
    end
    speed = levels[idx].speed
    timeVar = levels[idx].timeVar
	--SAM: CFText
    speedText.text = speed
    speedText:toFront()
	--speedText:Text(speed)
	--speedText:ToFront()
end

local function endGame(self)
    display.remove(self)
    choice = choice + 1
    if choice == numDeaths then
        local   options = {effect = defaultTransition, params = {saveScore = score}}
        paceRect.isMoving = false
        composer.gotoScene("gameover", options)
    end
end



local function lookupCode(code, spawn)
    if code == "bw" then
        if spawn.type == "blue" or spawn.type == "white" then
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
        if spawn.type == "red" or spawn.type == "orange" then
            return 1
        end
    elseif code == "yb" then
        if spawn.type == "yellow" or spawn.type == "blue" then
            return 1
        end
    elseif code == "ryb" then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "blue" then
            return 1
        end
    elseif code == "rbw" then
        if spawn.type == "red" or spawn.type == "blue" or spawn.type == "white" then
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
    elseif code == 1 then
        if spawn.type == "red" or spawn.type == "yellow" or spawn.type == "blue" then
            return 1
        end
    elseif code == 2 then
        if spawn.type == "red" or spawn.type == "white" or spawn.type == "blue" then
            return 1
        end
    elseif code == 3 then
        if spawn.type == "yellow" or spawn.type == "white" or spawn.type == "blue" or spawn.type == "green" then
            return 1
        end
    elseif code == 4 then
        if spawn.type == "red" or spawn.type == "white" then
            return 1
        end
    elseif code == 5 then
        if spawn.type == "red" or spawn.type == "white" or spawn.type == "green" then
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

            if state == 4 then

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
--                if state == 1 then
--                    if spawnTable[i].x < -40 then
--                        print("top left death")
--                        print("a")
--                        transition.to( deathScenario2Array[1], { time=5, alpha=1, onComplete=function() transition.to( deathScenario2Array[1], { time=5, alpha=0})end})
--                    elseif spawnTable[i].x > _W + 40 then
--                        print("bottom right death")
--                    end
--                elseif state == 2 then
--                    if spawnTable[i].x > _W + 40 then
--                        print("top right death")
--                    elseif spawnTable[i].x < -40 then
--                        print("bottom left death")
--                    end
--                end
                if spawnTable[i].x < -40 or spawnTable[i].x > _W + 40 then
                    if lookupCode(code, spawnTable[i]) == 1 then    --Out of bound and Palette Matches flag. GameOver

                        breakLoop = true
                        if bonusText ~= nil then
                            bonusText:removeSelf()
							--bonusText:Remove()
                            bonusText = nil
                        end

--                        print("isBottomLeft: ", spawnTable[i].isBottomRight)

                        if gotoDeath == true then
                            paceRect.isMoving = false
                            spawnTable[i]:toFront()
                            Runtime:removeEventListener("enterFrame", boundaryCheck)
                            Runtime:removeEventListener("enterFrame", moveObject)
                            for i = 1, #spawnTable do
								--Check for other palettes that could be out of bounds
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
                                    if state == 4 then
                                        temp = spawnTable[i].x
                                        transition.to(spawnTable[i], {time = 2000, x = temp + 90})

                                    else
                                        if state == 3 and spawnTable[i].dead ~= true  then
                                            transition.to(spawnTable[i], {time = 300, alpha = 0})
                                        end
                                        if spawnTable[i].isTopLeft == true or spawnTable[i].isBottomLeft == true then
                                            temp = spawnTable[i].x
                                            if state == 1 or state == 3 then
                                                transition.to(spawnTable[i], {time = 2000, x = temp + 90})
                                            elseif state == 2 then
                                                transition.to(spawnTable[i], {time = 2000, x = temp - 90})
                                            end
                                        else
                                            temp = spawnTable[i].x
                                            if state == 1 or state == 3 then
                                                transition.to(spawnTable[i], {time = 2000, x = temp - 90})
                                            elseif state == 2 then
                                                transition.to(spawnTable[i], {time = 2000, x = temp + 90})
                                            end
                                        end
                                    end
                                end
                                if state ~= 3 and spawnTable[i] ~= 0 then
                                    if spawnTable[i].isGrown == false then
                                        spawnTable[i]:removeSelf()
                                        spawnTable[i] = 0
                                    end
                                end
                            end
                            timer.performWithDelay(2000, boundaryElimination, 1)
                            return --SAM: why?
                        elseif gotoDeath == false then
                            for i = 1, #spawnTable do
                                if spawnTable[i] ~= 0 then
                                    if spawnTable[i].x < -40 or spawnTable[i].x > _W + 40 then
                                        if state == 1 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                if spawnTable[i].isTopLeft then
                                                    print("FUCKING CUNT")
                                                    transition.to( deathScenario2Array[1], { time=200, alpha=1, transition=easing.outCirc, onComplete=function() transition.to( deathScenario2Array[1], { delay=50, time=200, alpha=0, transition=easing.inCirc})end})
                                                elseif not spawnTable[i].isBottomRight then
                                                    transition.to( deathScenario2Array[4], { time=200, alpha=1, transition=easing.outCirc, onComplete=function() transition.to( deathScenario2Array[4], { delay=50, time=200, alpha=0, transition=easing.inCirc})end})
                                                end

                                                spawnTable[i]:removeEventListener("touch", objTouch)
                                                spawnTable[i]:removeSelf()
                                                spawnTable[i] = 0
                                            end
                                        elseif state == 2 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                if spawnTable[i].isTopLeft then
                                                    transition.to( deathScenario2Array[2], { time=200, alpha=1, transition=easing.outCirc, onComplete=function() transition.to( deathScenario2Array[2], { delay=50, time=200, alpha=0, transition=easing.inCirc})end})
                                                elseif not spawnTable[i].isBottomRight then
                                                    transition.to( deathScenario2Array[3], { time=200, alpha=1, transition=easing.outCirc, onComplete=function() transition.to( deathScenario2Array[3], { delay=50, time=200, alpha=0, transition=easing.inCirc})end})
                                                end

                                                spawnTable[i]:removeEventListener("touch", objTouch)
                                                spawnTable[i]:removeSelf()
                                                spawnTable[i] = 0
                                            end
                                        elseif state == 3 then
                                            if lookupCode(code, spawnTable[i]) == 1 then
                                                if spawnTable[i].isTopLeft == true and spawnTable[i].isBottomRight == nil then
                                                    transition.to( deathScenario2Array[1], { time=200, alpha=1, transition=easing.outCirc, onComplete=function() transition.to( deathScenario2Array[1], { delay=50, time=200, alpha=0, transition=easing.inCirc})end})
                                                elseif not spawnTable[i].isTopLeft and spawnTable[i].isBottomRight == nil then
                                                    transition.to( deathScenario2Array[2], { time=200, alpha=1, transition=easing.outCirc, onComplete=function() transition.to( deathScenario2Array[2], { delay=50, time=200, alpha=0, transition=easing.inCirc})end})
                                                end

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

local function spawnPalette(params)

    --SAM: spawned pad's color
--    print(params.type)

    local object = display.newRoundedRect(0, 0, 80, 60, 3)

    object.isPaletteActive = true
    object.isGrown = false
    object.anchorY = 0.5 ; object.anchorX = 0.5
    object.objTable = params.objTable   --Set the objects table to a table passed in by parameters
    object.index = #object.objTable + 1    --Automatically set the table index to be inserted into the next available table index
    object.myName = "Object: " .. object.index  --Give the object a custom name
    object.isTopLeft = params.isTopLeft
    object.isBottomLeft = params.isBottomLeft
    object.corner = params.corner
    object.type = params.type

	-- print("created" .. object.myName)
    if state == 1 then
        if object.isTopLeft == false then
            object.x = 0 + 40
            object.y = heightModeLow
        elseif object.isTopLeft == true then
            object.x = _W - 40
            object.y = heightModeTop
        end
    elseif state == 2 then
        if object.isTopLeft == false then
            object.x = _W - 40
            object.y = heightModeLow
        elseif object.isTopLeft == true then
            object.x = 0 + 40
            object.y = heightModeTop
        end

    --SAM: understand this! Rename these variable names because they awful and confusing as fuck!
    elseif state == 3 then
        if object.isTopLeft == false then
            object.x = _W / 2 + 40
            object.y = heightModeTop
        elseif object.isTopLeft == true then
            object.x = _W / 2 - 40
            object.y = heightModeTop
        elseif object.isBottomLeft == false then
            object.x = _W / 2 + 40
            object.y = heightModeLow
        elseif object.isBottomLeft == true then
            object.x = _W / 2 - 40
            object.y = heightModeLow
        end
    elseif state == 4 then

        object.x = _W - 40
        if object.isTopLeft == false then
			--   print(object.index)
            object.y = _H * (1 / 5) - 20
        elseif object.isTopLeft == true then
            object.y = _H * (2 / 5) - 10
        elseif object.isBottomLeft == true then
            object.y = _H * (3 / 5) + 10
        elseif object.isBottomLeft == false then
            object.y = _H * (4 / 5) + 20
        end

    elseif state == 5 then
        print("spawning")
        if object.corner == "TopRight" then
            object.x = _W / 2 + 40
            object.y = heightModeTop
        elseif object.corner == "TopLeft" then
            object.x = _W / 2 - 40
            object.y = heightModeTop
        elseif object.corner == "BottomRight" then
            object.x = _W / 2 + 40
            object.y = heightModeLow
        elseif object.corner == "BottomLeft" then
            object.x = _W / 2 - 40
            object.y = heightModeLow
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
    if state == 1 or state == 2 then
        if object.index == 1 or object.index == 2 then
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
            if spawnTable[object.index - 2] ~= 0 then
                spawnTable[object.index - 2]:toFront()
            end
        end
    elseif state == 3 then
        if object.index == 1 or object.index == 2 or object.index == 3 or object.index == 4 then
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
            if spawnTable[object.index - 4] ~= 0 then
                spawnTable[object.index - 4]:toFront()
            end
        end
    elseif state == 4 then
        if object.index == 1 or object.index == 3 or object.index == 6 or object.index == 10 then
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
        else
            transition.to(object, {time = timeVar * (.5), xScale = .01, yScale = .01, onComplete = paletteGrow})
			--    if spawnTable[object.index-4]~=0 then
			--     spawnTable[object.index-4]:toFront()
			--  end
        end
    elseif state == 5 then
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
    if lightningCount == 0 then
        lightningIcon1:toBack()
    elseif lightningCount == 1 then
        lightningIcon1:toFront()
        lightningIcon2:toBack()
    elseif lightningCount == 2 then
        lightningIcon2:toFront()
        lightningIcon3:toBack()
    elseif lightningCount == 3 then
        lightningIcon3:toFront()
        lightningIcon4:toBack()
    elseif lightningCount == 4 then
        lightningIcon4:toFront()
        lightningIcon5:toBack()
    elseif lightningCount == 5 then
        lightningIcon5:toFront()
        lightningIcon6:toBack()
    elseif lightningCount == 6 then
        lightningIcon6:toFront()
        lightningIcon7:toBack()
    elseif lightningCount == 7 then
        lightningIcon7:toFront()
        lightningIcon8:toBack()
    elseif lightningCount == 8 then
        lightningIcon8:toFront()
        lightningIcon9:toBack()
    elseif lightningCount == 9 then
        lightningIcon9:toFront()
        lightningIcon10:toBack()
    elseif lightningCount == 10 then
        lightningIcon10:toFront()
        lightningIcon11:toBack()
    elseif lightningCount == 11 then
        lightningIcon11:toFront()
        lightningIcon12:toBack()
    elseif lightningCount == 12 then
        lightningIcon12:toFront()
        lightningIcon13:toBack()
    elseif lightningCount == 13 then
        lightningIcon13:toFront()
        lightningIcon14:toBack()
    elseif lightningCount == 14 then
        lightningIcon14:toFront()
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

local function lightningButton(e)

    if lightningCount > 0 and e.phase == "began" and paceRect.isMoving == true then
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

    if lightningCount > 0 then
        flag:addEventListener("touch", lightningButton)
        lightningIcons()
    else
        flag:removeEventListener("touch", lightningButton)
    end
end


local function trackLightningScore ()
    if lightningScore >= 10 then
        lightningScore = score - (10 * lightningMultiplier)
        lightningCount = lightningCount + 1
        lightningIcons()
        lightningMultiplier = lightningMultiplier + 1
    end
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
    currColor = self.type
	--bonus score
    if currColor == prevColor then
        spread = spread + 1
        if bonusText ~= nil then
            bonusText:removeSelf()
			--SAM: CFText
			--bonusText:Remove()
            bonusText = nil
        end

        text = "+" .. spread

        bonusText = display.newEmbossedText(text, _W * (1 / 5), _H * (1 / 3), "PTMono-Bold", 38)
        bonusText:setFillColor(1, .9, .4)
        bonusText:setEmbossColor(scoreboardColor)

		--SAM: CFText
		--bonusText = CFText.new( text, "Arial Rounded MT Bold", 30, _W*(4/5), _H*(1/3) )
        if motion ~= nil then
            timer.cancel(motion)
            motion = nil
        end
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
    else
        spread = 1
        currColor = nil
        prevColor = nil
        if bonusText ~= nil then
            bonusText:removeSelf()
			--bonusText:Remove()
            bonusText = nil
        end
    end
    prevColor = self.type

    scoreText.text = score + spread
	--SAM: CFText
	--scoreText:Text(score+spread)

    score = score + spread
    lightningScore = lightningScore + spread
    trackLightningScore()
end

local function setFlag()
    setTheFlag = true
end

local function delayPace()
    paceRect.isMoving = true
    if speedText ~= 0 and speedText ~= nil then
		--SAM: CFText
        speedText.text = speed
        speedText:toFront()
		--speedText:Text(speed)
		--speedText:ToFront()
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

--SAMTEMP
local usToCanada = 1
local function countries(test)

    local largerCountries = {2, 3, 6, 7, 9, 55}
    local e = largerCountries[math.random(table.getn(largerCountries))]

    if usToCanada == 1 then
        e = 55
        usToCanada = 2
    else
        e = 7
        usToCanada = 1
    end

    country = CFGameSettings:getItemByID(e)
    --print("country : ", e)
    --print(country.name)

    function destroyStuff()

        if(countryOutline ~= nil) then
            countryOutline:removeSelf()
            countryOutline = nil
        end

        print(mapGroup.numChildren)
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
    --[[SAM: countryOutline scaling ]]--
    countryOutlineWidthMultiplier = display.pixelHeight/display.contentWidth
    countryOutlineHeightMultiplier = display.pixelWidth/display.contentHeight
    print("pixelHeight / contentWidth: ", countryOutlineWidthMultiplier)
    print("pixelWidth / contentHeight: ", countryOutlineHeightMultiplier)
    countryOutline:scale(1/countryOutlineWidthMultiplier, 1/countryOutlineHeightMultiplier)



    newTex = graphics.newTexture( { type="canvas", width=display.contentWidth, height=display.contentHeight } )
    newTex:draw(countryOutline)
    newTex:invalidate()

    local fxGroup = display.newGroup()
    fxGroup.id = "fxGroup"

    local fxSize
    if(countryOutline.width > countryOutline.height) then
        fxSize = math.ceil(countryOutline.width) + 120
    else
        fxSize = math.ceil(countryOutline.height) + 120
    end

	-- SAM: local?
	fxBG = display.newCircle(0, 0, fxSize)
    fxBG.anchorX = .5
    fxBG.anchorY = .5

    --[[ What does this scaleFactorX and scaleFactorY do?
    ]]--
    local scaleFactorX = 1
	local scaleFactorY = 1

    if (fxBG.width > fxBG.height) then
        scaleFactorY = fxBG.width / fxBG.height
    else
        scaleFactorX = fxBG.height / fxBG.width
    end



    display.setDefault("textureWrapX", "repeat")
    display.setDefault("textureWrapY", "mirroredRepeat")
    fxBG.fill = {type = "image", filename = "images/fxgroup.png"}
    fxBG.fill.scaleX = .5 * scaleFactorX
    fxBG.fill.scaleY = .5 * scaleFactorY
    fxBG.fill.effect = "filter.straighten"
    fxBG.fill.effect.width = 10
    fxBG.fill.effect.height = 50
    fxBG.fill.effect.angle = 20
    fxBG.rotation = 0

    fxGroup.x=(map.x)-(map.x-country.coords.x-(countryOutline.width/2))
    fxGroup.y=(map.y)-(map.y-country.coords.y-(countryOutline.height/2))
    fxGroup:insert(fxBG)

    mask = graphics.newMask(newTex.filename, newTex.baseDir)
    fxGroup:setMask(mask)
    canvasObj.alpha = 0

    mapGroup:insert(fxGroup)

    xCoord=(_W/2)-country.coords.x-(countryOutline.width/2)
    yCoord=(_H/2)-country.coords.y-(countryOutline.height/2)


    print("xCoord", xCoord, "yCoord", yCoord)

    local function animateCountry()
        transition.to( fxBG.fill.effect, { time=10, angle=0, onComplete=
            function() transition.to( fxBG.fill.effect, { time=1390, angle=20, transition=easing.continuousLoop}) end
        })
        transition.to( fxBG, { tag="moveNeedle", delay=50, time=1350, rotation=fxBG.rotation+90, transition = easing.inOutQuad } )
    end

    info="images/infoBrazil.png"

    flag=display.newSprite(nationalFlags1Sheet,nationalFlagsSeq, 100, 10)
    flag:setSequence(country.name)
    flag.anchorX = 0.5 ; flag.anchorY = 0.5

    flag.width = 500
    flag.height = 333
    flag.xScale = .2
    flag.yScale = .2 * .7
    flag.anchorX = 1
    flag.anchorY = 0.5

    flag.x = _W
    flag.y = _H/2

    code = country.code

    if(country.colors.r) then
        r1 = country.colors.r.r
        r2 = country.colors.r.g
        r3 = country.colors.r.b
        print(r1, r2, r3)
    end
    if(country.colors.w) then
        w1 = country.colors.w.r
        w2 = country.colors.w.g
        w3 = country.colors.w.b
        print(w1, w2, w3)
    end
    if(country.colors.y) then
        y1 = country.colors.y.r
        y2 = country.colors.y.g
        y3 = country.colors.y.b
        print(y1, y2, y3)
    end
    if(country.colors.g) then
        g1 = country.colors.g.r
        g2 = country.colors.g.g
        g3 = country.colors.g.b
        print(g1, g2, g3)
    end
    if(country.colors.b) then
        b1 = country.colors.b.r
        b2 = country.colors.b.g
        b3 = country.colors.b.b
        print(b1, b2, b3)
    end
    if(country.colors.o) then
        o1 = country.colors.o.r
        o2 = country.colors.o.g
        o3 = country.colors.o.b
        print(o1, o2, o3)
    end
    if(country.colors.k) then
        k1 = country.colors.k.r
        k2 = country.colors.k.g
        k3 = country.colors.k.b
        print(k1, k2, k3)
    end

	-- if check.. when first flag appear. there will be no music. !!!
    audio.stop(bobby)
    music = audio.loadStream("anthems/" .. country.name .. ".mp3")
    bobby = audio.play(music, {loops = -1})
end

local function killBars()
    killLowTimer = transition.to(lowBar, {time = 800, y = _H, alpha = 0})
    killTopTimer = transition.to(topBar, {time = 800, y = 0, alpha = 0})
end

local function countryTrace()
    countryTrace:removeSelf()
    countryTrace = nil
end

local function removeFlag()
    flag:removeEventListener("touch", lightningButton)
    flag:removeSelf()
    flag  = nil
end
--MIKE: Can we somehow arrange the finishScale() function after the newFlag() function, its importance is pretty relevant to newFlag() ?? Maybe merge all functions pertaining to newFlag and flag enlargement into one neat function
local function finishScale()
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
    transition.to(topBar, {time = 1300, alpha = .3, y = -35})

	lowBar = display.newSprite(topBtmBarSheet, topBtmBarSeq)
    lowBar:setFillColor(0, 0, 0)
	lowBar.anchorX = 0.5
    lowBar.anchorY = 1
	lowBar.x = _W / 2
	lowBar.y = _H + 30
    lowBar.alpha = 0
    topBar:toFront()
    lowBar:setSequence("btm")
    lowBar:play()
	transition.to(lowBar, {time = 1300, alpha = .3, y = _H + 35})

	transition.to(flag, {time = 1000, alpha = 1})

    flagLightningReady = timer.performWithDelay(1000, lightningEnable, 1)
    timerSpeed = timer.performWithDelay(9500, speedUp, 1)

	countriesCompleted = countriesCompleted + 1
end

local function newFlag()
    music = nil

    if bonusText ~= nil then
        bonusText:removeSelf()
        bonusText = nil
        --SAM: delete?
        --bonusText:Remove()

        --SAM: delete?
        spread = 1
        prevColor = nil
        currColor = nil
    end
    countries()
    if infoMode == true then
        infoPic = display.newImage(info, 165, 77)
        infoPic.x = _W / 6
        infoPic.y = _H / 2
        infoPic.alpha = 0
        timer.performWithDelay(2000, infoAppear, 1)
    end
    countryText = display.newText(country, _W / 2, _H / 2, native.systemFont, 50)
    countryText.anchorX = 0.5
    countryText.anchorY = 0.5
    countryText:setFillColor(0, 0, 0)
    countryText:toFront()
    timer.performWithDelay(2000, countryTextScale, 1)

	--FLAG SCALING STARTS HERE
    print("which state???")
    modeText.text = state

    --SAM: reorder these
    if state == 5 then
        sideTimer = timer.performWithDelay(1500, finishScale, 1)
        paceTimer=timer.performWithDelay(900,delayPace,1)
        transition.to( map, { time=1500, alpha=1 })
        mapTimer=transition.to( mapGroup, { time=1500, x=xCoord, y=yCoord })
    elseif state == 4 then
        sideTimer = timer.performWithDelay(1500, finishScale, 1)
        mapTimer = transition.to(map, {time = 1500, x = xCoord, y = yCoord})
        flagTimer = transition.to(flag, {time = 1500, xScale = .2, yScale = .2})
        paceTimer = timer.performWithDelay(900, delayPace, 1)
    elseif state == 3 then
--        sideTimer = timer.performWithDelay(1500, finishScale, 1)
--        mapTimer = transition.to(map, {time = 2000, x = xCoord, y = yCoord})
--        flagTimer = transition.to(flag, {time = 2000, xScale = .2, yScale = .2})
--        paceTimer = timer.performWithDelay(0, delayPace, 1)

        sideTimer = timer.performWithDelay(1500, finishScale, 1)
        paceTimer=timer.performWithDelay(900,delayPace,1)
        transition.to( map, { time=1500, alpha=1 })
        mapTimer=transition.to( mapGroup, { time=1500, x=xCoord, y=yCoord })
    elseif state == 2 or state == 1 then
        sideTimer = timer.performWithDelay(1500, finishScale, 1)
        paceTimer=timer.performWithDelay(900,delayPace,1)
        transition.to( map, { time=1500, alpha=1 })
        mapTimer=transition.to( mapGroup, { time=1500, x=xCoord, y=yCoord })
    end

--[[SAM: countryOutline scaling ]]--
--    TEMP: alternative styles
--    countryTraceTimer=transition.to( countryTrace, { time=1500, x=_W/2, y=_H/2 })

--[[SAM: countryOutline scaling ]]--
--		mapGroup.xScale = .5
--		mapGroup.yScale = .5
--		mapGroup.x = xCoord*.5 + (_W*.25)
--		mapGroup.y = yCoord*.5 + (_H*.25)

--[[SAM: countryOutline scaling ]]--
--     with scale
--		mapTimer = transition.to(map, {time = 500, x=xCoord*.5+(_W*.25), y=yCoord*.5+(_H*.25), xScale = .5, yScale = .5})

--    SAM: what is this?

--    if(countriesCompleted == 0) then
--         without scale
--			mapTimer = transition.to(map, {time = 1500, alpha = 1, x=xCoord, y=yCoord})
--			transition.to(fxGroup, {time = 1500, alpha = 1, x=_W/2, y=_H/2})
--    end

--     without scale
--		mapTimer = transition.to(mapGroup, {time = 1500, x=xCoord, y=yCoord})
--		transition.to(fxGroup, {time = 1500, x=_W/2, y=_H/2})

end

local function createPalette ()
    local e = math.random(7)
    local spawns
    if state == 4 then
        stateFour = stateFour + 1
        if stateFour >= 1 then
            print("ONE")
            if e == 1 then
                spawns = spawnPalette({objTable = spawnTable, type = "white", isTopLeft = false})
            elseif e == 2 then
                spawns = spawnPalette({objTable = spawnTable, type = "black", isTopLeft = false})
            elseif e == 3 then
                spawns = spawnPalette({objTable = spawnTable, type = "red", isTopLeft = false})
            elseif e == 4 then
                spawns = spawnPalette({objTable = spawnTable, type = "orange",  isTopLeft = false})
            elseif e == 5 then
                spawns = spawnPalette({objTable = spawnTable, type = "yellow", isTopLeft = false})
            elseif e == 6 then
                spawns = spawnPalette({objTable = spawnTable, type = "green", isTopLeft = false})
            elseif e == 7 then
                spawns = spawnPalette({objTable = spawnTable, type = "blue", isTopLeft = false})
            end
        end
        if stateFour >= 2 then
            print("TWO")
            local f = math.random(7)
            if f == 1 then
                spawns = spawnPalette({objTable = spawnTable, type = "white", isTopLeft = true})
            elseif f == 2 then
                spawns = spawnPalette({objTable = spawnTable, type = "black", isTopLeft = true})
            elseif f == 3 then
                spawns = spawnPalette({objTable = spawnTable, type = "red", isTopLeft = true})
            elseif f == 4 then
                spawns = spawnPalette({objTable = spawnTable, type = "orange", isTopLeft = true})
            elseif f == 5 then
                spawns = spawnPalette({objTable = spawnTable, type = "yellow", isTopLeft = true})
            elseif f == 6 then
                spawns = spawnPalette({objTable = spawnTable, type = "green", isTopLeft = true})
            elseif f == 7 then
                spawns = spawnPalette({objTable = spawnTable, type = "blue", isTopLeft = true})
            end
        end
        if stateFour >= 3 then
            print("THREE")
            local g = math.random(7)
            if g == 1 then
                spawns = spawnPalette({objTable = spawnTable, type = "white", isBottomLeft = true})
            elseif g == 2 then
                spawns = spawnPalette({objTable = spawnTable, type = "black", isBottomLeft = true})
            elseif g == 3 then
                spawns = spawnPalette({objTable = spawnTable, type = "red", isBottomLeft = true})
            elseif g == 4 then
                spawns = spawnPalette({objTable = spawnTable, type = "orange", isBottomLeft = true})
            elseif g == 5 then
                spawns = spawnPalette({objTable = spawnTable, type = "yellow", isBottomLeft = true})
            elseif g == 6 then
                spawns = spawnPalette({objTable = spawnTable, type = "green", isBottomLeft = true})
            elseif g == 7 then
                spawns = spawnPalette({objTable = spawnTable, type = "blue", isBottomLeft = true})
            end
        end
        if stateFour >= 4 then
            print("FOUR")
            local h = math.random(7)
            if h == 1 then
                spawns = spawnPalette({objTable = spawnTable, type = "white", isBottomLeft = false})
            elseif h == 2 then
                spawns = spawnPalette({objTable = spawnTable, type = "black", isBottomLeft = false})
            elseif h == 3 then
                spawns = spawnPalette({objTable = spawnTable, type = "red", isBottomLeft = false})
            elseif h == 4 then
                spawns = spawnPalette({objTable = spawnTable, type = "orange", isBottomLeft = false})
            elseif h == 5 then
                spawns = spawnPalette({objTable = spawnTable, type = "yellow", isBottomLeft = false})
            elseif h == 6 then
                spawns = spawnPalette({objTable = spawnTable, type = "green", isBottomLeft = false})
            elseif h == 7 then
                spawns = spawnPalette({objTable = spawnTable, type = "blue", isBottomLeft = false})
            end
        end
    elseif state == 1 or state == 2 then
        if e == 1 then
            spawns = spawnPalette({objTable = spawnTable, type = "white", isTopLeft = false})
        elseif e == 2 then
            spawns = spawnPalette({objTable = spawnTable, type = "black", isTopLeft = false})
        elseif e == 3 then
            spawns = spawnPalette({objTable = spawnTable, type = "red", isTopLeft = false})
        elseif e == 4 then
            spawns = spawnPalette({objTable = spawnTable, type = "orange",  isTopLeft = false})
        elseif e == 5 then
            spawns = spawnPalette({objTable = spawnTable, type = "yellow", isTopLeft = false})
        elseif e == 6 then
            spawns = spawnPalette({objTable = spawnTable, type = "green", isTopLeft = false})
        elseif e == 7 then
            spawns = spawnPalette({objTable = spawnTable, type = "blue", isTopLeft = false})
        end

        local f = math.random(7)
        if f == 1 then
            spawns = spawnPalette({objTable = spawnTable, type = "white", isTopLeft = true})
        elseif f == 2 then
            spawns = spawnPalette({objTable = spawnTable, type = "black", isTopLeft = true})
        elseif f == 3 then
            spawns = spawnPalette({objTable = spawnTable, type = "red", isTopLeft = true})
        elseif f == 4 then
            spawns = spawnPalette({objTable = spawnTable, type = "orange", isTopLeft = true})
        elseif f == 5 then
            spawns = spawnPalette({objTable = spawnTable, type = "yellow", isTopLeft = true})
        elseif f == 6 then
            spawns = spawnPalette({objTable = spawnTable, type = "green", isTopLeft = true})
        elseif f == 7 then
            spawns = spawnPalette({objTable = spawnTable, type = "blue", isTopLeft = true})
        end
    elseif state == 3 then
        local g = math.random(7)
        if g == 1 then
            spawns = spawnPalette({objTable = spawnTable, type = "white", isBottomLeft = false})
        elseif g == 2 then
            spawns = spawnPalette({objTable = spawnTable, type = "black", isBottomLeft = false})
        elseif g == 3 then
            spawns = spawnPalette({objTable = spawnTable, type = "red", isBottomLeft = false})
        elseif g == 4 then
            spawns = spawnPalette({objTable = spawnTable, type = "orange", isBottomLeft = false})
        elseif g == 5 then
            spawns = spawnPalette({objTable = spawnTable, type = "yellow", isBottomLeft = false})
        elseif g == 6 then
            spawns = spawnPalette({objTable = spawnTable, type = "green", isBottomLeft = false})
        elseif g == 7 then
            spawns = spawnPalette({objTable = spawnTable, type = "blue", isBottomLeft = false})
        end

        local h = math.random(7)

        if h == 1 then
            spawns = spawnPalette({objTable = spawnTable, type = "white", isBottomLeft = true})
        elseif h == 2 then
            spawns = spawnPalette({objTable = spawnTable, type = "black", isBottomLeft = true})
        elseif h == 3 then
            spawns = spawnPalette({objTable = spawnTable, type = "red", isBottomLeft = true})
        elseif h == 4 then
            spawns = spawnPalette({objTable = spawnTable, type = "orange", isBottomLeft = true})
        elseif h == 5 then
            spawns = spawnPalette({objTable = spawnTable, type = "yellow", isBottomLeft = true})
        elseif h == 6 then
            spawns = spawnPalette({objTable = spawnTable, type = "green", isBottomLeft = true})
        elseif h == 7 then
            spawns = spawnPalette({objTable = spawnTable, type = "blue", isBottomLeft = true})
        end
    elseif state == 5 then
        for i = 1, 4 do
            local random = math.random(7)
            local cornersArray = {"TopLeft", "TopRight", "BottomLeft", "BottomRight"}
            print(i)
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

local function readyObject ()
    if paceRect.x > 85 then
        paceRect.x = 0
        paceRect.isMoving = false
        if setTheFlag == true then    --START A NEW FLAG
			--    transition.to( countryTrace, { time=490, alpha=0,onComplete=killCountryTrace})
            setTheFlag = false
            paceRect.isMoving = false
            for i = 1, #spawnTable do
                if spawnTable[i] ~= 0 then
                    spawnTable[i].isGrown = false
                    spawnTable[i].isPaletteActive = false
                    transition.to(spawnTable[i], {time = 500, rotation = 400, xScale = 0.01, yScale = 0.01, onComplete = removePalette})
                end
            end
            killBarsTimer = timer.performWithDelay(500, killBars)
            resetSpawnTimer = timer.performWithDelay(540, resetSpawnTable)
            if infoMode == true then
                infoTimer = transition.to(infoPic, {time = 500, alpha = 0})
            end
            flag3Timer = transition.to(flag, {time = 500, alpha = 0, onComplete = removeFlag})    --remove flag
            newFlagTimer = timer.performWithDelay(600, newFlag)


        else    --CREATE A NEW COLOR SQUARE
            createPalette()
            if firstObject == true then
                firstObject = false
            elseif firstObject == false then
                if state == 1 or state == 2 then
                    if spawnTable[count] ~= 0 then
						--isGrown means colorPalletes are full size scale=1
                        spawnTable[count].isGrown = true
                    end
                    if spawnTable[count + 1] ~= 0 then
                        spawnTable[count + 1].isGrown = true
                    end
                    count = count + 2

                elseif state == 5 then
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
                elseif state == 5 then
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
                if state == 4 then
                    stateFourGrow = stateFourGrow + 1
                    if stateFourGrow >= 4 then
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
                    elseif stateFourGrow >= 3 then
                        if spawnTable[count] ~= 0 then
                            spawnTable[count].isGrown = true
                        end
                        if spawnTable[count + 1] ~= 0 then
                            spawnTable[count + 1].isGrown = true
                        end
                        if spawnTable[count + 2] ~= 0 then
                            spawnTable[count + 2].isGrown = true
                        end
                        count = count + 3
                    elseif stateFourGrow >= 2 then
                        if spawnTable[count] ~= 0 then
                            spawnTable[count].isGrown = true
                        end
                        if spawnTable[count + 1] ~= 0 then
                            spawnTable[count + 1].isGrown = true
                        end
                        count = count + 2
                    elseif stateFourGrow >= 1 then
                        if spawnTable[count] ~= 0 then
                            spawnTable[count].isGrown = true
                        end
                        count = count + 1
                    elseif state == 5 then
                        stateFourGrow = stateFourGrow + 1
                        if stateFourGrow >= 6 and state == 5 then
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
                            if spawnTable[count + 4] ~= 0 then
                                spawnTable[count + 4].isGrown = true
                            end
                            if spawnTable[count + 5] ~= 0 then
                                spawnTable[count + 5].isGrown = true
                            end
                            count = count + 6
                        elseif stateFourGrow >= 5 and state == 5 then
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
                            if spawnTable[count + 4] ~= 0 then
                                spawnTable[count + 4].isGrown = true
                            end
                            count = count + 5
                            if stateFourGrow >= 4 and state == 5 then
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
                            elseif stateFourGrow >= 3 and state == 5 then
                                if spawnTable[count] ~= 0 then
                                    spawnTable[count].isGrown = true
                                end
                                if spawnTable[count + 1] ~= 0 then
                                    spawnTable[count + 1].isGrown = true
                                end
                                if spawnTable[count + 2] ~= 0 then
                                    spawnTable[count + 2].isGrown = true
                                end
                                count = count + 3
                            elseif stateFourGrow >= 2 and state == 5 then
                                if spawnTable[count] ~= 0 then
                                    spawnTable[count].isGrown = true
                                end
                                if spawnTable[count + 1] ~= 0 then
                                    spawnTable[count + 1].isGrown = true
                                end
                                count = count + 2
                            elseif stateFourGrow >= 1 and state == 5 or state == 4 then
                                if spawnTable[count] ~= 0 then
                                    spawnTable[count].isGrown = true
                                end
                                count = count + 1
                            end
                        end
                    end
					--     print("stateFourGrow    :".. stateFourGrow)
					--     print("COUNT           :" .. count)
                end
            end
        end
    end
end

local function moveObject (e)
    if paceRect.isMoving == true then
        paceRect.x = paceRect.x + speed
		--reset PaceRect, call readyObjects() to create a new palette or flag
        readyObject()
    end
--sets direction of existing color palettes
    if state == 1 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
				--isGrown means is palette full size
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    if spawnTable[i].isTopLeft == true then
                        spawnTable[i].x = spawnTable[i].x - speed
                    elseif spawnTable[i].isTopLeft == false then
                        spawnTable[i].x = spawnTable[i].x + speed
                    end
                end
            end
        end
    elseif state == 2 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    if spawnTable[i].isTopLeft == true then
                        spawnTable[i].x = spawnTable[i].x + speed
                    elseif spawnTable[i].isTopLeft == false then
                        spawnTable[i].x = spawnTable[i].x - speed
                    end
                end
            end
        end
    elseif state == 3 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    if spawnTable[i].isTopLeft == true or spawnTable[i].isBottomLeft == true then
                        spawnTable[i].x = spawnTable[i].x - speed
                    elseif spawnTable[i].isTopLeft == false or spawnTable[i].isBottomLeft == false then
                        spawnTable[i].x = spawnTable[i].x + speed
                    end
                end
            end
        end
    elseif state == 4 then
        if #spawnTable > 0 then
            for i = 1, #spawnTable do
				--       if spawnTable[i]~=0 then
                if spawnTable[i] ~= 0 and spawnTable[i].isGrown == true then
                    spawnTable[i].x = spawnTable[i].x - speed
                end
            end
        end
    elseif state == 5 then
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


local function setupVariables()
    w1 = 1;w2 = 1;w3 = 1
    k1 = 0;k2 = 0;k3 = 0
    r1 = 1;r2 = 0;r3 = 0
    o1 = 1;o2 = .502;o3 = 0
    y1 = 1;y2 = 1;y3 = 0
    g1 = 0;g2 = .4;g3 = 0
    b1 = 0;b2 = 0;b3 = 1

    mapGroup = display.newGroup()

    map = display.newImage("images/newmap_export_nopolar.png", 2031, 851)
    map.alpha = 0
    map.anchorX = 0
    map.anchorY = 0
    map.name = "map"
    map.x = 0
    map.y = 0

	mapGroup:insert(map)

	--[[
	mapMask = graphics.newMask("images/mask.png")
	mapGroup:setMask(mapMask)

	mapGroup.maskScaleX = 200
	mapGroup.maskScaleY = 75
	mapGroup.maskX = _W/2
	mapGroup.maskY = _H/2
	]]--

    levels = {
        {speed = 1, timeVar = 2550}, {speed = 1.5, timeVar = 1700}, {speed = 2, timeVar = 1250}, {speed = 2.5, timeVar = 1000}, {speed = 3, timeVar = 910}, {speed = 3.5, timeVar = 750},
        {speed = 4, timeVar = 700}, {speed = 4.5, timeVar = 600}, {speed = 5, timeVar = 550}, {speed = 5.5, timeVar = 450}, {speed = 6, timeVar = 420}, {speed = 6.5, timeVar = 400},
        {speed = 7, timeVar = 380}, {speed = 7.5, timeVar = 365}, {speed = 8, timeVar = 345}, {speed = 8.5, timeVar = 335}, {speed = 9, timeVar = 305}, {speed = 9.5, timeVar = 280},
        {speed = 10, timeVar = 260}, {speed = 10.5, timeVar = 240}, {speed = 11, timeVar = 220}, {speed = 11.5, timeVar = 200}, {speed = 12, timeVar = 190}, {speed = 12.5, timeVar = 185},
        {speed = 13, timeVar = 175}, {speed = 13.5, timeVar = 170}, {speed = 14, timeVar = 170}, {speed = 14.5, timeVar = 165}, {speed = 15, timeVar = 165}, {speed = 15.5, timeVar = 160},
        {speed = 16, timeVar = 155}, {speed = 16.5, timeVar = 155}, {speed = 17, timeVar = 150}, {speed = 17.5, timeVar = 145}, {speed = 18, timeVar = 145}, {speed = 19, timeVar = 140},
        {speed = 20, timeVar = 135}, {speed = 21, timeVar = 125}, {speed = 22, timeVar = 120}, {speed = 23, timeVar = 110}}

    lightningIcon1 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon1.x = 20
    lightningIcon1.y = lightningY
    lightningIcon2 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon2.x = 60
    lightningIcon2.y = lightningY
    lightningIcon3 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon3.x = 100
    lightningIcon3.y = lightningY
    lightningIcon4 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon4.x = 140
    lightningIcon4.y = lightningY
    lightningIcon5 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon5.x = 180
    lightningIcon5.y = lightningY
    lightningIcon6 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon6.x = 220
    lightningIcon6.y = lightningY
    lightningIcon7 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon7.x = 260
    lightningIcon7.y = lightningY
    lightningIcon8 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon8.x = 300
    lightningIcon8.y = lightningY
    lightningIcon9 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon9.x = 340
    lightningIcon9.y = lightningY
    lightningIcon10 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon10.x = 380
    lightningIcon10.y = lightningY
    lightningIcon11 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon11.x = 420
    lightningIcon11.y = lightningY
    lightningIcon12 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon12.x = 460
    lightningIcon12.y = lightningY
    lightningIcon13 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon13.x = 500
    lightningIcon13.y = lightningY
    lightningIcon14 = display.newImage("images/lightningbolt_sm.png", 18, 31)
    lightningIcon14.x = 540
    lightningIcon14.y = lightningY
    lightningIcon1:toBack()
    lightningIcon2:toBack()
    lightningIcon3:toBack()
    lightningIcon4:toBack()
    lightningIcon5:toBack()
    lightningIcon6:toBack()
    lightningIcon7:toBack()
    lightningIcon8:toBack()
    lightningIcon9:toBack()
    lightningIcon10:toBack()
    lightningIcon11:toBack()
    lightningIcon12:toBack()
    lightningIcon13:toBack()
    lightningIcon14:toBack()
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

        if lookupCode(code, e.target) == 0 then   --You are Dead --color does not match

            if bonusText ~= nil then
                bonusText:removeSelf()
				--bonusText:Remove()
                bonusText = nil
            end

            if gotoDeath == true then
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
                numDeaths = 1
                transition.to(e.target, {time = 700, rotation = 400, x = _W / 2, y = _H / 2, xScale = 8, yScale = 8, onComplete = endGame })
                Runtime:removeEventListener("enterFrame", boundaryCheck)

                Runtime:removeEventListener("enterFrame", moveObject)
                return
            end
            if e.target.isGrown == false then   --if canceled
                transition.cancel(self)
                transition.to(e.target, {time = 500, rotation = 400, xScale = 5, yScale = 5, onComplete = removePalette })
            else                           --not cancelled
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
            currColor = e.target.type
			--BONUS SCORE
            if currColor == prevColor then
                spread = spread + 1
                if bonusText ~= nil then
                    bonusText:removeSelf()
					--bonusText:Remove()
                    bonusText = nil
                end
                text = "+" .. spread

                bonusText = display.newEmbossedText(text, _W * (1 / 5), _H * (1 / 3), "PTMono-Bold", 38)
                bonusText:setFillColor(1, .9, .4)
                bonusText:setEmbossColor(scoreboardColor)

				--SAM: CFText (advanced color classes), to be re-worked and implemented later

				--bonusText = CFText.new( text, "Arial Rounded MT Bold", 30, _W*(4/5), _H*(1/3) )

                if motion ~= nil then
                    timer.cancel(motion)
                    motion = nil
                end
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
            else
                spread = 1
                currColor = nil
                prevColor = nil
                if bonusText ~= nil then
                    bonusText:removeSelf()
					--SAM: CFText
					--bonusText:Remove()
                    bonusText = nil
                end
            end
            prevColor = e.target.type
            scoreText.text = score + spread

			--SAM: CFText
			--scoreText:Text(score+spread)

            score = score + spread
            lightningScore = lightningScore + spread
            trackLightningScore()
        end
    end
    return true
end

------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
function scene:create(e)
    print("CREATE")
end

function scene:show(e)
    if (e.phase == "will") then
        print("SHOWWILL")

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
        Runtime:addEventListener("enterFrame", moveObject)
        system.activate("multitouch")
        setFlagTimer = timer.performWithDelay(20000, setFlag, 0)
		--  timer.performWithDelay(15000, checkMemory,0)
        newFlag()
    end
end

function scene:hide(e)
    print("HIDE")
    if e.phase == "will" then
        display.remove(background)

		display.remove(speedTextDesc)
		display.remove(speedText)
		display.remove(scoreTextDesc)
		display.remove(scoreText)
        display.remove(flag)
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
        display.remove(lightningIcon6)
        display.remove(lightningIcon7)
        display.remove(lightningIcon8)
        display.remove(lightningIcon9)
        display.remove(lightningIcon10)
        display.remove(lightningIcon11)
        display.remove(lightningIcon12)
        display.remove(lightningIcon13)
        display.remove(lightningIcon14)
        if timerSpeed ~= nil then
            timer.cancel(timerSpeed)
        end
        Runtime:removeEventListener("enterFrame", boundaryCheck)
        Runtime:removeEventListener("enterFrame", moveObject)
        composer.removeScene("game", false)
    end
end

function scene:destroy(e)
    print("DESTROY")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-----------------------------------------------------------------------------------------
return scene
