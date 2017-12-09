
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

local activeCountry

local xBtn
local fwBtn

local canSkip = false
local currentObject
local touchInsideBtn = false
local isBtnAnim = false

local gotoDeath = false    --for testing purposes. if true, go to GameOver screen.
local lightningCount = 1  --correct default is set to 1, bump up to test for more lightnings
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

local countryOutlineSheetCoords = require("lua-sheets.country_outline")
local countryOutlineSheet = graphics.newImageSheet("images/country_outline_mask.png", countryOutlineSheetCoords:getSheet())
local countryOutline
local countryOutlineTest

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

local background = display.newRect(0, 0, _W, _H)
background:setFillColor(1, 1, 1)
background.anchorX = 0.5
background.anchorY = 0.5
background.name = "background"
background.x = _W / 2 ;background.y = _H / 2
background:toBack()

-- New
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
                setTheFlag = true
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

-- SAM: better name for this
local function countries(test)
    -- local largerCountries = {2, 3, 6, 7, 9, 55}
    -- local e = largerCountries[math.random(table.getn(largerCountries))]

    -- SAM: change to countries? All country data is kept in here.. reference to cf_game_settings.lua
    local randomCountry = math.random(CFGameSettings:getLength())
    country = CFGameSettings:getItemByID(randomCountry)

    print("current country: ", country.name)


    --SAM: Should i put this outside the countries() function?
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
    --SAM: countryOutline scaling
    countryOutlineWidthMultiplier = display.pixelHeight/display.contentWidth
    countryOutlineHeightMultiplier = display.pixelWidth/display.contentHeight
    -- print("pixelHeight / contentWidth: ", countryOutlineWidthMultiplier)
    -- print("pixelWidth / contentHeight: ", countryOutlineHeightMultiplier)
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

    --print("xCoord", xCoord, "yCoord", yCoord)

    local function animateCountry()
        transition.to( fxBG.fill.effect, { time=10, angle=0, onComplete=
            function() transition.to( fxBG.fill.effect, { time=1390, angle=20, transition=easing.continuousLoop}) end
        })
        transition.to( fxBG, { tag="moveNeedle", delay=50, time=1350, rotation=fxBG.rotation+90, transition = easing.inOutQuad } )
    end

    info="images/infoBrazil.png"

    flag = display.newSprite(nationalFlags1Sheet,nationalFlagsSeq, 100, 10)
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
    -- flag.y = _H/2 + math.random(100)

	-- if check.. when first flag appear. there will be no music. !!!
    if countriesCompleted ~= 0 then
        audio.stop(bobby)
    end

    music = audio.loadStream("anthems/" .. country.name .. ".mp3")
    bobby = audio.play(music, {loops=-1, onComplete=function(event)
        print("finished streaming ANTHEM on channel ", event.channel)
    end})
end


--MIKE: Can we somehow arrange the finishScale() function after the newFlag() function, its importance is pretty relevant to newFlag() ?? Maybe merge all functions pertaining to newFlag and flag enlargement into one neat function
local function finishScale()
    canSkip=true

    transition.to(flag, {time = 1000, alpha = 1})

    flagLightningReady = timer.performWithDelay(1000, lightningEnable, 1)
    --SAM: delete this? used for offsetting when speedUp() occurs - can happen in during midst of a country
    -- timerSpeed = timer.performWithDelay(9500, speedUp, 1)

    countriesCompleted = countriesCompleted + 1
end


local function newFlag(e)

    music = nil

    if countriesCompleted > 0 then
        print(type(flag)) -- flag var type seems to be a table?
        flag:removeSelf()
        flag = nil
    end

    countries(e)

    xBtn:toFront()
    fwBtn:toFront()

    --[[
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
    ]]--

    sideTimer = timer.performWithDelay(1500, finishScale, 1)
    paceTimer=timer.performWithDelay(900,delayPace,1)
    transition.to( map, { time=1500, alpha=1 })
    mapTimer=transition.to( mapGroup, { time=1500, x=xCoord, y=yCoord })

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

    -- SAM: this sort of countriesCompleted == 0 checking should be done in countries()
--    if(countriesCompleted == 0) then
--         without scale
--			mapTimer = transition.to(map, {time = 1500, alpha = 1, x=xCoord, y=yCoord})
--			transition.to(fxGroup, {time = 1500, alpha = 1, x=_W/2, y=_H/2})
--    end

--     without scale
--		mapTimer = transition.to(mapGroup, {time = 1500, x=xCoord, y=yCoord})
--		transition.to(fxGroup, {time = 1500, x=_W/2, y=_H/2})

end

local function readyObject(e)
    if setTheFlag==true then     --START A NEW FLAG
            print("ga")
        if activeCountry < CFGameSettings:getLength() then
            activeCountry = activeCountry + 1
        else
            activeCountry = 1
        end

        newFlag(activeCountry)
        setTheFlag=false
    end
end

local function nextFlag()
    -- flag:removeSelf()
    if setTheFlag==true then     --START A NEW FLAG
        if activeCountry < CFGameSettings:getLength() then
            activeCountry = activeCountry + 1
        else
            activeCountry = 1
        end

        newFlag(activeCountry)
        setTheFlag=false
    end
end

--local function setupVariables()
--    mapGroup = display.newGroup()

--    map = display.newImage("images/newmap_export_nopolar.png", 2031, 851)
--    map.alpha = 0
--    map.anchorX = 0
--    map.anchorY = 0
--    map.name = "map"
--    map.x = 0
--    map.y = 0

--	mapGroup:insert(map)
--end

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
    activeCountry = chosenWithCountryPicker
    newFlag(activeCountry)
end
------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
function scene:create(e)

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
end

function scene:show(e)
    local sceneGroup = self.view

    if (e.phase == "will") then
        print("SHOWWILL")
--        setupVariables()

        mapGroup = display.newGroup()

        map = display.newImage("images/newmap_export_nopolar.png", 2031, 851)
        map.alpha = 0
        map.anchorX = 0
        map.anchorY = 0
        map.name = "map"
        map.x = 0
        map.y = 0

        mapGroup:insert(map)
        sceneGroup:insert(mapGroup)

--        TEMP COUNTRY PICKER FOR SAM
--        countryPicker()

        random = math.randomseed( os.time() )
    elseif (e.phase == "did") then
        system.activate( "multitouch" )
        Runtime:addEventListener("enterFrame", readyObject)
--        setTimer=timer.performWithDelay(20000, setFlag, 0)
--        timer.performWithDelay(15000, checkMemory,0)
        print("when does this happen")
        activeCountry = math.random(CFGameSettings:getLength())
        newFlag(activeCountry)
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
    display.remove(flag)
    display.remove(xBtn)
    display.remove(fwBtn)
    display.remove(countryText)
    display.remove(country)
    display.remove(infoPic)
    print("quit")
    Runtime:removeEventListener("enterFrame", readyObject)

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
