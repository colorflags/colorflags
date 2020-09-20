require("cf_color")
display.setDefault("textureWrapX", "clampToEdge")
display.setDefault("textureWrapY", "clampToEdge")

local composer=require("composer")
local scene = composer.newScene()

local pGet = ssk.persist.get
local pSet = ssk.persist.set

local game_W = display.actualContentWidth -- Get the width of the screen
local game_H = display.actualContentHeight -- Get the height of the screen

--[[
NICE TRY
local spine = require "spine-corona.spine"

local _lastTime = 0
local M = {}

function loadSkeleton(atlasFile, jsonFile, x, y, scale, animation, skin)
    -- to load an atlas, we need to define a function that returns
    -- a Corona paint object. This allows you to resolve images
    -- however you see fit
    local imageLoader = function (path)
        local paint = { type = "image", filename = "data/" .. path }
        return paint
    end

    -- load the atlas
    local atlas = spine.TextureAtlas.new(spine.utils.readFile("data/" .. atlasFile), imageLoader)

    -- load the JSON and create a Skeleton from it
    local json = spine.SkeletonJson.new(spine.AtlasAttachmentLoader.new(atlas))
    json.scale = scale
    local skeletonData = json:readSkeletonDataFile("data/" .. jsonFile)
    local skeleton = spine.Skeleton.new(skeletonData)
    skeleton.scaleY = -1 -- Corona's coordinate system has its y-axis point downwards
    skeleton.group.x = x
    skeleton.group.y = y

    -- Set the skin if we got one
    if skin then skeleton:setSkin(skin) end

    -- create an animation state object to apply animations to the skeleton
    local animationStateData = spine.AnimationStateData.new(skeletonData)
    animationStateData.defaultMix = 0.5
    local animationState = spine.AnimationState.new(animationStateData)

    -- set a name on the group of the skeleton so we can find it during debugging
    skeleton.group.name = jsonFile

    -- set some event callbacks
    animationState.onStart = function (entry)
        -- print(entry.trackIndex.." start: "..entry.animation.name)
    end
    animationState.onInterrupt = function (entry)
        -- print(entry.trackIndex.." interrupt: "..entry.animation.name)
    end
    animationState.onEnd = function (entry)
        -- print(entry.trackIndex.." end: "..entry.animation.name)
    end
    animationState.onComplete = function (entry)
        if M.animation == 0 then
            M.state:setAnimationByName(1, "nt_hold25", false)
            M.animation = 1
        elseif M.animation == 1 then
            M.state:setAnimationByName(1, "nt_backward", false)
            M.animation = 2
        elseif M.animation == 2 then
            M.state:setAnimationByName(1, "nt_hold1", false)
            M.animation = 3
        elseif M.animation == 3 then
            M.state:setAnimationByName(1, "nt_forward", false)
            M.animation = 0
        end
        -- print(entry.trackIndex.." complete: "..entry.animation.name)
    end
    animationState.onDispose = function (entry)
        -- print(entry.trackIndex.." dispose: "..entry.animation.name)
    end
    animationState.onEvent = function (entry, event)
        -- print(entry.trackIndex.." event: "..entry.animation.name..", "..event.data.name..", "..event.intValue..", "..event.floatValue..", '"..(event.stringValue or "").."'" .. ", " .. event.volume .. ", " .. event.balance)
    end

    -- return the skeleton an animation state
    return { skeleton = skeleton, state = animationState }
end

local function playAnim(event)
    local currentTime = event.time / 3000
    local delta = currentTime - _lastTime
    _lastTime = currentTime

    local skeleton = M.skeleton
    local state = M.state
    state:update(delta)
    state:apply(skeleton)

    skeleton:updateWorldTransform()

end

local function startAnim()
    Runtime:addEventListener("enterFrame", playAnim)
    M.state:setAnimationByName(1, "nt_forward", false)
end

local function stopAnim()
    Runtime:removeEventListener("enterFrame", playAnim)
end

function M.load()
    -- local lastTime = 0
    result = loadSkeleton("nicetry-spine.atlas", "nicetry-spine.json", _W/2, _H/4 , 0.25, "animation")
    -- local skeleton = result.skeleton
    -- local state = result.state
    -- local spineData = Skeleton.load("res/game/dice/skeleton", centerX + 120, centerY - 200, 0.5, "shake")
    M.skeleton = result.skeleton
    M.state = result.state
    M.animation = 0
    -- End roll event
    M.state.onEvent = onRollComplete
    -- M.skeleton.group.rotation = 175
    -- M.skeleton.group.alpha = 0

end

M.load()
startAnim()
]]--

music=nil
bobby=nil

if lastReservedChannel ~= nil then
    audio.rewind( musicGameOver )
    if lastReservedChannel == 1 then
        audio.stop(lastReservedChannel)
        lastReservedChannel = 2
        audio.stop(lastReservedChannel)
        audio.setVolume( .5, { channel = lastReservedChannel } )
        audioReservedChannels[lastReservedChannel] = audio.play( musicGameOver, {channel=lastReservedChannel,loops=-1} )
    elseif lastReservedChannel == 2 then
        audio.stop(lastReservedChannel)
        lastReservedChannel = 1
        audio.stop(lastReservedChannel)
        audio.setVolume( .5, { channel = lastReservedChannel } )
        audioReservedChannels[lastReservedChannel] = audio.play( musicGameOver, {channel=lastReservedChannel,loops=-1} )
    end
    lastUsedMusic = "musicGameOver"
else
    lastReservedChannel = 1
    audio.stop(lastReservedChannel)
    audio.setVolume( .5, { channel = lastReservedChannel } )
    audioReservedChannels[lastReservedChannel] = audio.play( musicGameOver, {channel=lastReservedChannel,loops=-1} )
    lastUsedMusic = "musicGameOver"
end

local myFunctionKill
local scoreTextGroup
local scoreText
local scoreTextDesc

local highScore
local gameScore

local brickPlatformBtm
local brickPlatformTop
local brickPlatformSheetCoords = require("lua-sheets.pale_brick_platform")
local brickPlatformSheet = graphics.newImageSheet("images/pale_brick_platform.png", brickPlatformSheetCoords:getSheet())

local cloudsBG1
local cloudsBG1SheetCoords = require("lua-sheets.just_clouds_bg")
local cloudsBG1Sheet = graphics.newImageSheet("images/just_clouds_bg.png", cloudsBG1SheetCoords:getSheet())
local cloudsBG2
local cloudsBG3
local cloudsFG1
local cloudsFG1SheetCoords = require("lua-sheets.just_clouds_fg")
local cloudsFG1Sheet = graphics.newImageSheet("images/just_clouds_fg.png", cloudsFG1SheetCoords:getSheet())
local cloudsFG2

local bg

local whatBackground
local killScreen
local cloud1
local cloud2
local cloud3
local cloud4
local flagPole1
local flagPole1SheetCoords = require("lua-sheets.flagpole_big")
local flagPole1Sheet = graphics.newImageSheet("images/flagpole_big.png", flagPole1SheetCoords:getSheet())
local flagPole2
local flagPole2SheetCoords = require("lua-sheets.flagpole_big")
local flagPole2Sheet = graphics.newImageSheet("images/flagpole_big.png", flagPole2SheetCoords:getSheet())
local flagPole3
local flagPole3SheetCoords = require("lua-sheets.flagpole_big")
local flagPole3Sheet = graphics.newImageSheet("images/flagpole_big.png", flagPole3SheetCoords:getSheet())
local menuAgain
local menuQuit

local randomFlagSequenceArray = {}

local randomFlag1
local randomFlag2
local randomFlag3
local randomFlag4
local randomFlag5
local randomFlag6
local randomFlag7
local randomFlag8

local FG1Transition1
local FG1Transition2
local FG1Transition3
local FG1Transition4
local FG2Transition1
local FG2Transition2
local FG2Transition3
local FG2Transition4
local FG3Transition1
local FG3Transition2
local FG3Transition3
local FG3Transition4
local cloudFadeTransition1
local cloudFadeTransition2

local currentObject
local isLoading = false
local touchInsideBtn = false

local btnsAgain
local btnsAgainSheetCoords = require("lua-sheets.btns_again_giga")
local btnsAgainSheet = graphics.newImageSheet("images/btns_again_giga.png", btnsAgainSheetCoords:getSheet())

local btnsQuit
local btnsQuitSheetCoords = require("lua-sheets.btns_quit_giga")
local btnsQuitSheet = graphics.newImageSheet("images/btns_quit_giga.png", btnsQuitSheetCoords:getSheet())

local flagWave40Coords = require("lua-sheets.flagwave40")
local flagWave40Sheet = graphics.newImageSheet( "images/flagwave40.png", flagWave40Coords:getSheet() )

local flagWave35Coords = require("lua-sheets.flagwave35")
local flagWave35Sheet = graphics.newImageSheet( "images/flagwave35.png", flagWave35Coords:getSheet() )

local flagWave34Coords = require("lua-sheets.flagwave34")
local flagWave34Sheet = graphics.newImageSheet( "images/flagwave34.png", flagWave34Coords:getSheet() )

function selectRandomFlags()
    local worldFlags = {
        1, 7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85, 91, 97, 103, 109, 115, 121, 127, 133, 139, 145, 151, 157, 163, 169, 175, 181, 187, 193, 199, 205, 211, 217, 223, 229, 235, 241, 247, 253, 259, 265, 271, 277, 283, 289, 313, 319, 325
    }
    local function shuffle(t)
        local iterations = #t
        local j
        for i = iterations, 2, -1 do
            j = math.random(i)
            t[i], t[j] = t[j], t[i]
        end
    end
    shuffle(worldFlags)
    for i=1, 6 do
        randomFlagSequenceArray[i] = {
            {
                name="randomflagseq1",
                frames={
                    worldFlags[i], worldFlags[i]+1, worldFlags[i]+2, worldFlags[i]+3, worldFlags[i]+4, worldFlags[i]+5, worldFlags[i]+4, worldFlags[i]+3, worldFlags[i]+2, worldFlags[i]+1
                },
                time=1800
            },
            {
                name="randomflagseq2",
                frames={
                    worldFlags[i]+3, worldFlags[i]+4, worldFlags[i]+5, worldFlags[i]+4, worldFlags[i]+3, worldFlags[i]+2, worldFlags[i]+1, worldFlags[i], worldFlags[i]+1, worldFlags[i]+2
                },
                time=1800
            }
        }
        --[[
        local flagFrames = ""
        for k,v in pairs(randomFlagSequenceArray[i][1].frames) do
            flagFrames = flagFrames .. v .. ", "
        end
        print(flagFrames .. "\n")
        ]]--
    end
end

-- SAM: needs work
local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then

        print(touchInsideBtn, isLoading)
        if touchInsideBtn == true and isLoading == false then

            print("touch OFF. inside")
            -- composer.removeScene("start")

            -- prevents scenes from firing twice!!
            isLoading = true
            print("going to..")
            -- weird shit going on here, don't use the variable name goto

            local gotoo = currentObject.gotoScene
            if gotoo == "start" and event.target == btnsPlayGame then
                composer.showOverlay( gotoo, { isModal= true })
            else
                composer.gotoScene ( gotoo, { effect = defaultTransition } )
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
            if currentObject.name == "again" then
                currentObject:setFrame(1)
            elseif currentObject.name == "share" then
                currentObject:setFrame(1)
            elseif currentObject.name == "quit" then
                currentObject:setFrame(1)
            end
            -- currentObject:setFrame(2)
            -- SAM: wtf. how is this working? do some testing.
            if(touchInsideBtn == true) then
                -- currentObject.xScale = .8
                -- currentObject.yScale = .8
                print("finger down, outside button: ", currentObject.name)
            end
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                print("finger down, inside button: ", currentObject.name)

                -- currentObject.xScale = .8
                -- currentObject.yScale = .8
                -- currentObject.xScale = 1.01
                -- currentObject.yScale = 1.01
                if currentObject.name == "again" then
                    currentObject:setFrame(2)
                elseif currentObject.name == "share" then
                    currentObject:setFrame(2)
                elseif currentObject.name == "quit" then
                    currentObject:setFrame(2)
                end
            end
            touchInsideBtn = true
        end
    end
end

local scrollSpeedBG = 1
local scrollSpeedFG = 0.5

local function moveClouds(event)
    cloudsBG1.x = cloudsBG1.x + scrollSpeedBG
    cloudsBG2.x = cloudsBG2.x + scrollSpeedBG
    cloudsBG3.x = cloudsBG3.x + scrollSpeedBG
    cloudsFG1.x = cloudsFG1.x + scrollSpeedFG
    cloudsFG2.x = cloudsFG2.x + scrollSpeedFG

    if cloudsBG1.x > _W then
        cloudsBG1:translate(-cloudsBG1.width*3, 0)
    end
    if cloudsBG2.x > _W then
        cloudsBG2:translate(-cloudsBG1.width*3, 0)
    end
    if cloudsBG3.x > _W then
        cloudsBG3:translate(-cloudsBG1.width*3, 0)
    end
    if cloudsFG1.x > _W then
        cloudsFG1:translate(-cloudsFG1.width*4, 0)
    end
    if cloudsFG2.x > _W then
        cloudsFG2:translate(-cloudsFG1.width*4, 0)
    end
end

local function cloudCirculate(self)
    local myPusa = self.name
    self:toFront( )
    if myPusa == "cloudsFG1" then
        FG1Transition4= transition.to(self, {time=200, y=self.y-2, onComplete=function()
            FG1Transition3 = transition.to(
            self, {time=1400, y=self.y+10, onComplete=function()
                FG1Transition2 = transition.to(
                self, {time=200, y=self.y+2, onComplete=function()

                    FG1Transition1 = transition.to(
                    self, {time=1400, y=self.y-10, onComplete=cloudCirculate})
                end })
            end })
        end })
    elseif myPusa == "cloudsFG2" then
        FG2Transition4 =  transition.to(self, {time=200, y=self.y+2, onComplete=function()
            FG2Transition3 = transition.to(
            self, {time=1400, y=self.y-10, onComplete=function()
                FG2Transition2 = transition.to(
                self, {time=200, y=self.y-2,  onComplete=function()

                    FG2Transition1 = transition.to(
                    self, {time=1400, y=self.y+10, onComplete=cloudCirculate})
                end })
            end })
        end })
    end
end

local function cloudFade(self)
    cloudFadeTransition2 = transition.to( self, {time=3920, alpha=.35,onComplete=function()
        cloudFadeTransition1 = transition.to( self, {time=4460, alpha=.20,onComplete=cloudFade})
    end })
end

function scene:create(e)
    selectRandomFlags()

    bg = display.newRect(_W/2, _H/2, _W, _H)
    bg:setFillColor(0,0,0)

    local embossColor = {
        highlight = {r = 1, g = 1, b = 1},
        shadow = {r = 0, g = 0, b = 0}
    }

    -- SAM: rename all this
    killScreen = display.newImageRect( "images/bricks_trans_cracks2.png", _W, 70)
--    killScreen:setFillColor( .9, .55, .8, 1 )
--    killScreen.alpha = .8
    killScreen.name="killScreen"
    killScreen.anchorX=0.5
    killScreen.anchorY=1
    killScreen.x=_W/2
    killScreen.y=_H
    killScreen.alpha =0

    killScreen.fill.effect = "filter.linearWipe"

    killScreen.fill.effect.direction = { 0, 1 }
    killScreen.fill.effect.smoothness = .1
    killScreen.fill.effect.progress = 0.9

    local offsetY = _H/4 - 50

    brickPlatformBtm = display.newSprite( brickPlatformSheet, {frames={1}} )
    brickPlatformBtm.x = _W - (_W / 2)
    brickPlatformBtm.anchorY = 1
    brickPlatformBtm.y = _H

    brickPlatformTop = display.newSprite( brickPlatformSheet, {frames={2}} )
    brickPlatformTop.x = _W - (_W / 2)
    brickPlatformTop.anchorY = 1
    brickPlatformTop.y = _H - brickPlatformBtm.height

    flagPole1 = display.newSprite( flagPole1Sheet, {frames={1}} )
    flagPole1.anchorX=0.5
    flagPole1.anchorY=1
    flagPole1.name="flagPole1" -- SAM: is flagPole1.name ever used?
    flagPole1.x= brickPlatformBtm.x  - (brickPlatformBtm.width / 3)
    flagPole1.y= brickPlatformBtm.y - brickPlatformBtm.height

    flagPole2 = display.newSprite( flagPole2Sheet, {frames={1}} )
    flagPole2.anchorX=0.5
    flagPole2.anchorY=1
    flagPole2.name="flagPole2"
    flagPole2.x= brickPlatformBtm.x - 3
    flagPole2.y= brickPlatformTop.y - brickPlatformTop.height
    flagPole2.alpha=0.65

    flagPole3 = display.newSprite( flagPole3Sheet, {frames={1}} )
    flagPole3.anchorX=0.5
    flagPole3.anchorY=1
    flagPole3.name="flagPole3"
    flagPole3.x= brickPlatformBtm.x  + (brickPlatformBtm.width / 3)
    flagPole3.y= brickPlatformBtm.y - brickPlatformBtm.height

    randomFlag1 = display.newSprite(flagWave40Sheet, randomFlagSequenceArray[1])
    randomFlag1.x = flagPole1.x + 20
    randomFlag1.y = (_H - flagPole1.height) + 20
    randomFlag1:setSequence("randomflagseq1")
    randomFlag1:play()

    randomFlag2 = display.newSprite(flagWave34Sheet, randomFlagSequenceArray[2])
    randomFlag2.x = flagPole2.x + 17
    randomFlag2.y = (_H - flagPole2.height) + 10
    randomFlag2:setSequence("randomflagseq2")
    randomFlag2:toBack()
    randomFlag2.alpha = 0.80
    randomFlag2:toFront()
    randomFlag2:play()


    randomFlag3 = display.newSprite(flagWave40Sheet, randomFlagSequenceArray[3])
    randomFlag3.x = flagPole3.x + 20
    randomFlag3.y = (_H - flagPole3.height) + 20
    randomFlag3:setSequence("randomflagseq3")
    randomFlag3:play()

    local colorFillArray = CFColor(78, 173, 34)
    local colorShadowArray = CFColor(96, 212, 42)
    local scoreboardColor = { colorFillArray.r, colorFillArray.g, colorFillArray.b }
    local scoreboardEmbossColor = {
        highlight = { r = 0, g = 0, b = 0 },
        shadow = { r = colorShadowArray.r, g = colorShadowArray.g, b = colorShadowArray.b }
    }

    -- old color
    scoreboardColor = { 1, .9, .4 }
    scoreboardEmbossColor = {
        highlight = { r = 0, g = 0, b = 0 },
        shadow = { r = 1, g = 1, b = 1 }
    }

    local scoreboardOffsetFromLeft = _W/2+20
    local scoreboardOffsetFromEachOther = 60
    local scoreboardOffsetIncDecBtns = 1.2

    local scoreTextGroupAnchorX = scoreboardOffsetFromLeft
    local scoreTextGroupAnchorY = 18

    local font = "fonts/ChaparralPro-SemiboldIt.otf"

    -- SAM: rotate scoreTextGroup
    scoreTextGroup = display.newGroup()
    scoreTextDesc = display.newEmbossedText("your score", 0, 0, font, 22)
    scoreTextDesc:setFillColor(unpack(scoreboardColor))
    scoreTextDesc:setEmbossColor(scoreboardEmbossColor)
    scoreTextDesc.anchorX = 0.5
    scoreTextDesc.anchorY = 1
    scoreTextGroup:insert(scoreTextDesc)

    scoreText = display.newEmbossedText(pGet( "score.json", "highScore" ), 0, 0 + scoreTextDesc.y, font, 45)
    scoreText:setFillColor(unpack(scoreboardColor))
    scoreText:setEmbossColor(scoreboardEmbossColor)
    scoreText.anchorY = 0
    scoreTextGroup:insert(scoreText)
    scoreTextGroup.x = _W / 2
    scoreTextGroup.y = 0 + (scoreTextGroup.height/2)

    local function shiftScoreTextAnchorGroup()
        local ax = 0.5
        local ay = 0.5

        local sx, sy = scoreTextGroup:localToContent( scoreTextGroup.width*ax, scoreTextGroup.height*ay )

        scoreTextGroup.anchorX = ax
        scoreTextGroup.anchorY = ay

        scoreTextGroup.x = sx - (scoreTextGroup.width/2)
        scoreTextGroup.y = sy - (scoreTextGroup.height/2)
        -- transition.cancel(self)
        local scoreTextRotationTime = 4000

        transition.to( scoreTextGroup, { time=scoreTextRotationTime, rotation = 2, onComplete = function()
            transition.to( scoreTextGroup, { time=scoreTextRotationTime, rotation=0, onComplete = function()
                transition.to( scoreTextGroup, { time=scoreTextRotationTime, rotation=-2, onComplete = function()
                    transition.to( scoreTextGroup, { time=scoreTextRotationTime, rotation=0, onComplete=shiftScoreTextAnchorGroup, tag="rotateScoreText" })
                end })
            end })
        end })
    end
    --    shiftScoreTextAnchorGroup()

    local btnAnchorY = _H - (brickPlatformBtm.height+brickPlatformBtm.height) + 14

    btnsQuit = display.newSprite( btnsQuitSheet, {frames={1,2}} ) -- use btnsSeq
    btnsQuit.isHitTestMasked = false
    btnsQuit.name = "quit"
    btnsQuit.anchorX = 1
    btnsQuit.anchorY = 1
    btnsQuit.x= brickPlatformBtm.x - 20
    btnsQuit.y= btnAnchorY
    btnsQuit:setFrame(1)
    btnsQuit.alpha=0
    btnsQuit.gotoScene="menu"
    btnsQuit:scale(1,1)
    btnsQuit:rotate(-4)
    transition.to( btnsQuit, {time = 200, alpha=.9})

    btnsAgain = display.newSprite( btnsAgainSheet, {frames={1,2}} ) -- use btnsSeq
    btnsAgain.isHitTestMasked = false
    btnsAgain.name = "again"
    btnsAgain.anchorX = 0
    btnsAgain.anchorY = 1
    btnsAgain.x= brickPlatformBtm.x + 6
    btnsAgain.y= btnAnchorY + 3
    btnsAgain:setFrame(1)
    btnsAgain.alpha=0
    btnsAgain.gotoScene="game"
    btnsAgain:scale(1,1)
    btnsAgain:rotate(2)
    transition.to( btnsAgain, {time = 200, alpha=.9})

    cloudsBG1 = display.newSprite( cloudsBG1Sheet, {frames={1}} )
    cloudsBG1.name = "cloudsBG1"
    -- cloudsBG1.alpha = 0.5
    cloudsBG1.anchorX = 0
    cloudsBG1.anchorY = 1
    cloudsBG1.x = _W - cloudsBG1.width
    cloudsBG1.y = _H
    cloudsBG1:toBack()

    cloudsBG2 = display.newSprite( cloudsBG1Sheet, {frames={1}} )
    cloudsBG2.name = "cloudsBG2"
    -- cloudsBG2.alpha = 0.5
    cloudsBG2.anchorX = 0
    cloudsBG2.anchorY = 1
    cloudsBG2.x = cloudsBG1.x - cloudsBG1.width
    cloudsBG2.y = _H
    cloudsBG2:toBack()

    cloudsBG3 = display.newSprite( cloudsBG1Sheet, {frames={1}} )
    cloudsBG3.name = "cloudsBG3"
    -- cloudsBG3.alpha = 0.5
    cloudsBG3.anchorX = 0
    cloudsBG3.anchorY = 1
    cloudsBG3.x = cloudsBG2.x - cloudsBG1.width
    cloudsBG3.y = _H
    cloudsBG3:toBack()

    offsetCloudFG = 20

    cloudsFG1 = display.newSprite( cloudsFG1Sheet, {frames={1}} )
    cloudsFG1.name="cloudsFG1"
    -- cloudsFG1:setFillColor( 1, 1, 0 )
    -- cloudsFG1.alpha=0
    cloudsFG1.anchorX = 0
    cloudsFG1.x = 0 - cloudsFG1.width
    cloudsFG1.y = _H/2

    cloudsFG2 = display.newSprite( cloudsFG1Sheet, {frames={1}} )
    cloudsFG2.name="cloudsFG2"
    -- cloudsFG2:setFillColor( 1, 1, 0 )
    -- cloudsFG2.alpha=0
    cloudsFG2.anchorX = 0
    cloudsFG2.x = cloudsFG1.x - cloudsFG1.width * 2
    cloudsFG2.y = _H/2

    Runtime:addEventListener("enterFrame", moveClouds)

    -- cloudCirculate(cloudsFG1)
    -- cloudCirculate(cloudsFG2)

    -- cloudFade(cloudsBG1)
    -- cloudFade(cloudsBG2)

    -- M.skeleton.group:toBack()
    -- M.skeleton.group.alpha = 0
    -- transition.to( M.skeleton.group, { time=1000, delay=10, alpha=1.0 } )

    bg:toBack()
end

function scene:show(e)
    if e.phase == "will" then
        -- SAM: Notice transition
        local color =
        {
            highlight = { r=1, g=1, b=1 },
            shadow = { r=0, g=0, b=0 }
        }

    elseif e.phase== "did" then
        btnsAgain:addEventListener( "touch", myTouchListener )
        btnsAgain:addEventListener( "touch", doFunction )
        btnsQuit:addEventListener( "touch", myTouchListener )
        btnsQuit:addEventListener( "touch", doFunction )
    end
end

function scene:hide(e)
    if e.phase == "will" then
        Runtime:removeEventListener("enterFrame", moveClouds)
        transition.cancel(cloudFadeTransition1)
        transition.cancel(cloudFadeTransition2)
        transition.cancel(FG1Transition1)
        transition.cancel(FG1Transition2)
        transition.cancel(FG1Transition3)
        transition.cancel(FG1Transition4)
        transition.cancel(FG2Transition1)
        transition.cancel(FG2Transition2)
        transition.cancel(FG2Transition3)
        transition.cancel(FG2Transition4)
        display.remove(randomFlag1)
        display.remove(randomFlag2)
        display.remove(randomFlag3)
        display.remove(title)
        display.remove(highScoreText)

        display.remove(bg)
        transition.cancel(scoreTextGroup)
        display.remove(scoreTextGroup)

        display.remove(killScreen)
        display.remove(brickPlatformBtm)
        display.remove(brickPlatformTop)
        display.remove(cloudsBG1)
        display.remove(cloudsBG2)
        display.remove(cloudsBG3)
        display.remove(cloudsFG1)
        display.remove(cloudsFG2)
        display.remove(flagPole1)
        display.remove(flagPole2)
        display.remove(flagPole3)

        -- display.remove(M.skeleton.group)
        display.remove(btnsAgain)
        display.remove(btnsQuit)

        btnsAgain:removeEventListener( "touch", myTouchListener )
        btnsAgain:removeEventListener( "touch", doFunction )
        btnsQuit:removeEventListener( "touch", myTouchListener )
        btnsQuit:removeEventListener( "touch", doFunction )
        composer.removeScene("gameover")
    end
end

function scene:destroy(e)
    -- stopAnim()
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
