display.setDefault("textureWrapX", "clampToEdge")
display.setDefault("textureWrapY", "clampToEdge")

local composer=require("composer")
local scene = composer.newScene()

local pGet = ssk.persist.get
local pSet = ssk.persist.set

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
    result = loadSkeleton("nicetry-spine.atlas", "nicetry-spine.json", _W/5, _H/5 , 0.25, "animation")
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

music=nil
bobby=nil

if lastReservedChannel ~= nil then
	if lastReservedChannel == 1 then
		audio.stop(lastReservedChannel)
		lastReservedChannel = 2
		audioReservedChannels[lastReservedChannel] = audio.play( musicGameOver, {channel=lastReservedChannel,loops=-1} )
	elseif lastReservedChannel == 2 then
		audio.stop(lastReservedChannel)
		lastReservedChannel = 1
		audioReservedChannels[lastReservedChannel] = audio.play( musicGameOver, {channel=lastReservedChannel,loops=-1} )
	end
else
	lastReservedChannel = 1
	audioReservedChannels[lastReservedChannel] = audio.play( musicGameOver, {channel=lastReservedChannel,loops=-1} )
end

local myFunctionKill
local scoreTextGroup
local scoreText
local scoreTextDesc

local highScore
local gameScore

local cloudsBG1
local cloudsBG2
local cloudsFG1
local cloudsFG2

local bg

local whatBackground
local killScreen
local cloud1
local cloud2
local cloud3
local cloud4
local flagPole1
local flagPole2
local flagPole3
local flagPole4
local flagPole5
local flagPole6
local flagPole7
local flagPole8
local menuAgain
local menuShare
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
local cloudFadeTransition1
local cloudFadeTransition2

local currentObject
local isLoading = false
local touchInsideBtn = false
local isBtnAnim = false

-- for randomFlags1-8
-- local flagX = {20, 98, 69, 500, 525, 100, 480, 534}

-- SAM: make into a nicer function. break up this array into 2 arrays each containing 3 random flags Big, Med, Big. improve the randomFlag naming scheme
local flagPoleSpacingSpacing = math.random(42,119)
local flagPoleSpacingSpacingMiddleOffset = function()
    local offset = math.random(20)
    if math.random() > .5 then
        offset = -offset
    end
    return offset
end

local flagX = {
    (_W/4),
    (_W/4) + (flagPoleSpacingSpacing/2) + flagPoleSpacingSpacingMiddleOffset(),
    (_W/4) + flagPoleSpacingSpacing,
    (_W/4)*3,
    (_W/4)*3 + 50,
    (_W/4)*3 + 100,
}
local flagSetX = {}

local function makeFlagXArray(start)
    local offsetArray = {}
    local flagPoleSpacingSpacing = math.random(82,110)
    local flagPoleSpacingSpacingMiddleOffset = function()
        local offset = math.random(20)
        if math.random() > .5 then
            offset = -offset
        end
        return offset
    end

    offsetArray = {
        start - (flagPoleSpacingSpacing/2),
        start + flagPoleSpacingSpacingMiddleOffset(),
        start + (flagPoleSpacingSpacing/2)
    }

    return offsetArray
end

local flagSet1HorizontalPositions = makeFlagXArray((_W/4)-44)
local flagSet2HorizontalPositions = makeFlagXArray((_W-(_W/4) + 44))

local menuSeq = {
    { name = "normalRun", start=1, count=2, time=800 },
    { name = "again", frames={1,2}, time=500 },
    { name = "quit", frames={3,4}, time=500 },
    { name = "share", frames={5,6}, time=500 },

}

-- GLOBALIZE
local btnsSheetCoords = require("lua-sheets.buttons")
local btnsSheet = graphics.newImageSheet("images/buttons.png", btnsSheetCoords:getSheet())

local btnsSeq = {
    {
        name = "again",
        frames = {
            btnsSheetCoords:getFrameIndex("Again3"),
            btnsSheetCoords:getFrameIndex("Again5")
        },
        time = 500
    },
    {
        name = "again_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Again2"),
            btnsSheetCoords:getFrameIndex("Again3"),
            btnsSheetCoords:getFrameIndex("Again4"),
            btnsSheetCoords:getFrameIndex("Again5")
        },
        time = 500
    },
    {
        name = "share",
        frames = {
            btnsSheetCoords:getFrameIndex("Share3"),
            btnsSheetCoords:getFrameIndex("Share5")
        },
        time = 500
    },
    {
        name = "share_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Share2"),
            btnsSheetCoords:getFrameIndex("Share3"),
            btnsSheetCoords:getFrameIndex("Share4"),
            btnsSheetCoords:getFrameIndex("Share5")
        },
        time = 500
    },
    {
        name = "quit",
        frames = {
            btnsSheetCoords:getFrameIndex("Quit3"),
            btnsSheetCoords:getFrameIndex("Quit5")
        },
        time = 500
    },
    {
        name = "quit_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Quit2"),
            btnsSheetCoords:getFrameIndex("Quit3"),
            btnsSheetCoords:getFrameIndex("Quit4"),
            btnsSheetCoords:getFrameIndex("Quit5")
        },
        time = 500
    },
}

local btnsAgain
local btnsAgainSheetCoords = require("lua-sheets.btns_again")
local btnsAgainSheet = graphics.newImageSheet("images/btns_again.png", btnsAgainSheetCoords:getSheet())

local btnsShare
local btnsShareSheetCoords = require("lua-sheets.btns_share")
local btnsShareSheet = graphics.newImageSheet("images/btns_share.png", btnsShareSheetCoords:getSheet())

local btnsQuit
local btnsQuitSheetCoords = require("lua-sheets.btns_quit")
local btnsQuitSheet = graphics.newImageSheet("images/btns_quit.png", btnsQuitSheetCoords:getSheet())


function niceTryPop(event)
    local thisAnimation = event.target
    if (thisAnimation.frame == 1) then
        thisAnimation.alpha = .9
    elseif (thisAnimation.frame == 3) then
        thisAnimation.alpha=1
    elseif ( event.phase == "loop" ) then
        thisAnimation.alpha = .3
    end
end

local menuSpriteCoords = require("lua-sheets.btns-gameover")
local menuAgainSheet = graphics.newImageSheet( "images/btns-gameover.png", menuSpriteCoords:getSheet() )
local menuShareSheet = graphics.newImageSheet( "images/btns-gameover.png", menuSpriteCoords:getSheet() )
local menuQuitSheet = graphics.newImageSheet( "images/btns-gameover.png", menuSpriteCoords:getSheet() )

local flagWave40Coords = require("lua-sheets.flagwave40")
local flagWave40Sheet = graphics.newImageSheet( "images/flagwave40.png", flagWave40Coords:getSheet() )

local flagWave35Coords = require("lua-sheets.flagwave35")
local flagWave35Sheet = graphics.newImageSheet( "images/flagwave35.png", flagWave35Coords:getSheet() )

local flagWave34Coords = require("lua-sheets.flagwave34")
local flagWave34Sheet = graphics.newImageSheet( "images/flagwave34.png", flagWave34Coords:getSheet() )

function selectRandomFlags()

    local worldFlags = {
        1,
        7,
        13,
        19,
        25,
        31,
        37,
        43,
        49,
        55,
        61,
        67,
        73,
        79,
        85,
        91,
        97,
        103,
        109,
        115,
        121,
        127,
        133,
        139,
        145,
        151,
        157,
        163,
        169,
        175,
        181,
        187,
        193,
        199,
        205,
        211,
        217,
        223,
        229,
        235,
        241,
        247,
        253,
        259,
        265,
        271,
        277,
        283,
        289,
        313,
        319,
        325
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
        local randomFlagSeq={
            {name="randomflagseq1",frames={worldFlags[i],(worldFlags[i]+1),(worldFlags[i]+2),(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4),(worldFlags[i]+3), (worldFlags[i]+2), (worldFlags[i]+1)},time=860},
            {name="randomflagseq2",frames={worldFlags[i]+3,(worldFlags[i]+2),(worldFlags[i]+1),(worldFlags[i]+2),(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4)},time=1021},
            {name="randomflagseq3",frames={worldFlags[i]+4,(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4),(worldFlags[i]+3),(worldFlags[i]+2),(worldFlags[i]+1)},time=820 },
            {name="randomflagseq4",frames={worldFlags[i]+5,(worldFlags[i]+4),(worldFlags[i]+3),(worldFlags[i]+2),(worldFlags[i]+1),(worldFlags[i]),(worldFlags[i]+1),(worldFlags[i]+2)},time=902},
            {name="randomflagseq5",frames={worldFlags[i]+2,(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4),(worldFlags[i]+3),(worldFlags[i]+2),(worldFlags[i]+1)},time=896}
        }
        randomFlagSequenceArray[i] = {
            {
                name="randomflagseq1",
                frames={
                    worldFlags[i],
                    worldFlags[i]+1,
                    worldFlags[i]+2,
                    worldFlags[i]+3,
                    worldFlags[i]+4,
                    worldFlags[i]+5,
                    worldFlags[i]+4,
                    worldFlags[i]+3,
                    worldFlags[i]+2,
                    worldFlags[i]+1
                },
                time=860
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

function setUpRandomFlags()
    -- Big Flag
    randomFlag1 = display.newSprite(flagWave40Sheet, randomFlagSequenceArray[1])
    randomFlag1.x = flagSet1HorizontalPositions[1]+21 -- SAM: +21 refers to flagwave sprite width
    randomFlag1.y = (_H - killScreen.height) - 70
    randomFlag1:setSequence("randomflagseq1")
    -- randomFlag1:setFrame( math.random(1,5) )

    randomFlag1:play()

    -- Med Flag
    randomFlag2 = display.newSprite(flagWave34Sheet, randomFlagSequenceArray[2])
    randomFlag2.x = flagSet1HorizontalPositions[2] + 18
    randomFlag2.y = (_H - killScreen.height) - 58
    randomFlag2:setSequence("randomflagseq1")
    -- randomFlag2:setFrame( math.random(1,2) )
    randomFlag2:toBack()
    randomFlag2.alpha = 0.65

    randomFlag2:play()

    -- Big Flag
    randomFlag3 = display.newSprite(flagWave40Sheet, randomFlagSequenceArray[3])
    randomFlag3.x = flagSet1HorizontalPositions[3] + 21
    randomFlag3.y = (_H - killScreen.height) - 70
    randomFlag3:setSequence("randomflagseq1")
    -- randomFlag3:setFrame( math.random(1,2) )

    randomFlag3:play()

    -- Big Flag
    randomFlag4 = display.newSprite(flagWave40Sheet, randomFlagSequenceArray[4])
    randomFlag4.x = flagSet2HorizontalPositions[1] + 21
    randomFlag4.y = (_H - killScreen.height) - 70
    randomFlag4:setSequence("randomflagseq1")
    -- randomFlag4:setFrame( math.random(1,5) )

    randomFlag4:play()

    -- Med Flag
    randomFlag5 = display.newSprite(flagWave34Sheet, randomFlagSequenceArray[5])
    randomFlag5.x = flagSet2HorizontalPositions[2] + 18
    randomFlag5.y = (_H - killScreen.height) - 58
    randomFlag5:setSequence("randomflagseq1")
    -- randomFlag5:setFrame( math.random(1,2) )
    randomFlag5:toBack()
    randomFlag5.alpha = 0.65
    -- randomFlag5:setFrame( 2 )

    randomFlag5:play()

    -- Big Flag
    randomFlag6 = display.newSprite(flagWave40Sheet, randomFlagSequenceArray[6])
    randomFlag6.x = flagSet2HorizontalPositions[3] + 21
    randomFlag6.y = (_H - killScreen.height) - 70
    randomFlag6:setSequence("randomflagseq1")
    -- randomFlag6:setFrame( math.random(1,2) )

    randomFlag6:play()
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
                if currentObject.name == "again" then
                    currentObject:setSequence("again")
                elseif currentObject.name == "share" then
                    currentObject:setSequence("share")
                elseif currentObject.name == "quit" then
                    currentObject:setSequence("quit")
                end
            else
                if currentObject.name == "again" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "share" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "quit" then
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
                    if currentObject.name == "again" then
                        currentObject:setSequence("again_anim")
                    elseif currentObject.name == "share" then
                        currentObject:setSequence("share_anim")
                    elseif currentObject.name == "quit" then
                        currentObject:setSequence("quit_anim")
                    end
                    currentObject:play()
                else
                    if currentObject.name == "again" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "share" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "quit" then
                        currentObject:setFrame(2)
                    end
                end
            end
            touchInsideBtn = true
        end
    end
end

local function scrollCloudsBG(self, event)

    if self.x < -284 then -- 477
        self.x = _W/2+566 -- 480

    else


        self.x = self.x - self.speed
    end
end

local function scrollCloudsFG(self, event)

    -- transition.to( self, { time=4000, y=200, transition=easing.continuousLoop } )
    if self.x < -284 then -- 477
        self.x = _W/2+568 -- 480
    else

        self.x = self.x - self.speed
    end
end

local function cloudCirculate(self)
    local myPusa=self.name
    self:toFront( )
    if myPusa == "cloudsFG1" then

        FG1Transition4= transition.to(self, {time=200, y=self.y-2, onComplete=function()
            FG1Transition3 = transition.to(
            self, {time=1400, y=self.y+10, onComplete=function()
                FG1Transition2 = transition.to(
                self, {time=200, y=self.y+2, onComplete=function()

                    FG1Transition1 = transition.to(
                    self, {time=1400, y=self.y-10, onComplete=cloudCirculate})
                end
            })
        end
    })
end
})
elseif myPusa == "cloudsFG2" then

    FG2Transition4 =  transition.to(self, {time=200, y=self.y+2, onComplete=function()
        FG2Transition3 = transition.to(
        self, {time=1400, y=self.y-10, onComplete=function()
            FG2Transition2 = transition.to(
            self, {time=200, y=self.y-2,  onComplete=function()

                FG2Transition1 = transition.to(
                self, {time=1400, y=self.y+10, onComplete=cloudCirculate})
            end
        })
    end
})
end
})
end
end

local function cloudFade(self)
    cloudFadeTransition2 = transition.to( self, {time=3920, alpha=.35,onComplete=function()
        cloudFadeTransition1 = transition.to( self, {time=4460, alpha=.20,onComplete=cloudFade})
    end
})
end

local function setScene()
    bg = display.newRect(_W/2, _H/2, _W, _H)
    bg:setFillColor(0,0,0)

    local embossColor = {
        highlight = {r = 1, g = 1, b = 1},
        shadow = {r = 0, g = 0, b = 0}
    }
    -- print(M.skeleton.group.x)
    local scoreboardOffsetFromLeft = _W/2+20
    local scoreboardOffsetFromEachOther = 60
    local scoreboardOffsetIncDecBtns = 1.2

    local scoreTextGroupAnchorX = scoreboardOffsetFromLeft
    local scoreTextGroupAnchorY = 18

    -- SAM: rotate scoreText
    --[[
    scoreTextGroup = display.newGroup()
    scoreTextDesc = display.newEmbossedText("your score:", scoreTextGroupAnchorX, scoreTextGroupAnchorY, "PTMono-Bold", 14)
    scoreTextDesc:setFillColor( 1, .9, .4)
    scoreTextDesc:setEmbossColor(embossColor)
    scoreTextDesc.anchorX = 0.5
    scoreTextDesc.anchorY = 0
    scoreTextGroup:insert(scoreTextDesc)

    scoreText = display.newEmbossedText(pGet( "score.json", "highScore" ), scoreTextGroupAnchorX, scoreTextGroupAnchorY + scoreTextDesc.height, "PTMono-Bold", 28)
    scoreText:setFillColor( 1, .9, .4)
    scoreText:setEmbossColor(embossColor)
    scoreText.anchorX = 0.5
    scoreText.anchorY = 0
    scoreTextGroup:insert(scoreText)

    local function shiftAnchor()
       local ax = 0.5
       local ay = 0.5

       local sx, sy = scoreText:localToContent( scoreText.width*ax, scoreText.height*ay )

       scoreText.anchorX = ax
       scoreText.anchorY = ay

       scoreText.x = sx - (scoreText.width/2)
       scoreText.y = sy - (scoreText.height/2)

       transition.to( scoreText, { time = 2000, rotation = 10, onComplete = function()
           transition.to( scoreText, { time=2000, rotation=0, onComplete = function()
               transition.to( scoreText, { time=2000, rotation=-10, onComplete = function()
                   transition.to( scoreText, { time=2000, rotation=0, onComplete = shiftAnchor })
               end })
           end })
       end })
    end
    shiftAnchor()
    ]]--

    -- SAM: rotate scoreTextGroup
    scoreTextGroup = display.newGroup()
    scoreTextDesc = display.newEmbossedText("your score:", 0, 0, "PTMono-Bold", 14)
    scoreTextDesc:setFillColor( 1, .9, .4)
    scoreTextDesc:setEmbossColor(embossColor)
    scoreTextDesc.anchorX = 0.5
    scoreTextDesc.anchorY = 0
    scoreTextGroup:insert(scoreTextDesc)

    scoreText = display.newEmbossedText(pGet( "score.json", "highScore" ), 0, 0 + scoreTextDesc.height, "PTMono-Bold", 28)
    scoreText:setFillColor( 1, .9, .4)
    scoreText:setEmbossColor(embossColor)
    scoreText.anchorX = 0.5
    scoreText.anchorY = 0
    scoreTextGroup:insert(scoreText)
    scoreTextGroup.x = scoreTextGroupAnchorX
    scoreTextGroup.y = 18

    local function shiftAnchorGroup()
       local ax = 0.5
       local ay = 0.5

       local sx, sy = scoreTextGroup:localToContent( scoreTextGroup.width*ax, scoreTextGroup.height*ay )

       scoreTextGroup.anchorX = ax
       scoreTextGroup.anchorY = ay

       scoreTextGroup.x = sx - (scoreTextGroup.width/2)
       scoreTextGroup.y = sy - (scoreTextGroup.height/2)
       -- transition.cancel(self)
       transition.to( scoreTextGroup, { time = 2000, rotation = 2, onComplete = function()
           transition.to( scoreTextGroup, { time=2000, rotation=0, onComplete = function()
               transition.to( scoreTextGroup, { time=2000, rotation=-2, onComplete = function()
                   transition.to( scoreTextGroup, { time=2000, rotation=0, onComplete=shiftAnchorGroup, tag="rotateScoreText" })
               end })
           end })
       end })
    end
    shiftAnchorGroup()

    -- SAM: rename all this
    killScreen = display.newImageRect( "images/bricks_trans_cracks.png", _W, 94)
    killScreen:setFillColor( .9, .55, .8, 1 )
    killScreen.alpha = .8
    killScreen.name="killScreen"
    killScreen.anchorX=0.5
    killScreen.anchorY=1
    killScreen.x=_W/2
    killScreen.y=_H

    killScreen.fill.effect = "filter.linearWipe"

    killScreen.fill.effect.direction = { 0, 1 }
    killScreen.fill.effect.smoothness = 1
    killScreen.fill.effect.progress = 0.4

    flagPole1 = display.newImage( "images/flagpole-102.png", 18,142)
    flagPole1.anchorX=0.5
    flagPole1.anchorY=1
    flagPole1.name="flagPole1" -- SAM: is flagPole1.name ever used?
    flagPole1.x=flagSet1HorizontalPositions[1]
    flagPole1.y= _H - killScreen.height

    flagPole2 = display.newImage( "images/flagpole-90.png", 18,110)
    flagPole2.anchorX=0.5
    flagPole2.anchorY=1
    flagPole2.name="flagPole2"
    flagPole2.x=flagSet1HorizontalPositions[2]
    flagPole2.y= _H - killScreen.height
    flagPole2.alpha=0.30

    flagPole3 = display.newImage( "images/flagpole-102.png", 18,142)
    flagPole3.anchorX=0.5
    flagPole3.anchorY=1
    flagPole3.name="flagPole3"
    flagPole3.x=flagSet1HorizontalPositions[3]
    flagPole3.y= _H - killScreen.height

    flagPole4 = display.newImage( "images/flagpole-102.png", 18,142)
    flagPole4.anchorX=0.5
    flagPole4.anchorY=1
    flagPole4.name="flagPole4"
    flagPole4.x=flagSet2HorizontalPositions[1]
    flagPole4.y= _H - killScreen.height

    flagPole5 = display.newImage( "images/flagpole-90.png", 18,110)
    flagPole5.anchorX=0.5
    flagPole5.anchorY=1
    flagPole5.name="flagPole5"
    flagPole5.x=flagSet2HorizontalPositions[2]
    flagPole5.y= _H - killScreen.height
    flagPole5.alpha=0.30

    flagPole6 = display.newImage( "images/flagpole-102.png", 18,142)
    flagPole6.anchorX=0.5
    flagPole6.anchorY=1
    flagPole6.name="flagPole6"
    flagPole6.x=flagSet2HorizontalPositions[3]
    flagPole6.y= _H - killScreen.height

    -- fab=display.newSprite(myImageSheet2,fabSeq)

    local offsetY = _H/4 - 40


    btnsAgain = display.newSprite( btnsAgainSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsAgain.isHitTestMasked = false
    btnsAgain.name = "again"
    btnsAgain.anchorY = .5
    btnsAgain.x=88
    btnsAgain.y=_H-offsetY
    btnsAgain:setSequence("again")
    btnsAgain:setFrame(1)
    btnsAgain.alpha=0
    btnsAgain.gotoScene="game"
    -- btnsAgain:scale(.8,.8)
    transition.to( btnsAgain, {time = 200, alpha=1})

    btnsShare = display.newSprite( btnsShareSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsShare.isHitTestMasked = false
    btnsShare.name = "share"
    btnsShare.anchorY = .5
    btnsShare.x=_W/2+20
    btnsShare.y=_H-offsetY-1
    btnsShare:setSequence("game")
    btnsShare:setFrame(1)
    btnsShare.alpha=0
    btnsShare.gotoScene="menu"
    -- btnsShare:scale(.8,.8)
    transition.to( btnsShare, {time = 200, alpha=1})

    btnsQuit = display.newSprite( btnsQuitSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsQuit.isHitTestMasked = false
    btnsQuit.name = "quit"
    btnsQuit.anchorY = .5
    btnsQuit.x=_W-69
    btnsQuit.y=_H-offsetY
    btnsQuit:setSequence("game")
    btnsQuit:setFrame(1)
    btnsQuit.alpha=0
    btnsQuit.gotoScene="menu"
    -- btnsQuit:scale(.8,.8)
    transition.to( btnsQuit, {time = 200, alpha=1})

    selectRandomFlags()
    setUpRandomFlags()
    -- bg:toBack()

    cloudsBG1 = display.newImage( "images/clouds_bg_2.png", 568, 320 )
    cloudsBG1.name="cloudsBG1"
    cloudsBG1.alpha=.1
    cloudsBG1.x=_W/2
    cloudsBG1.y=_H/2
    cloudsBG1.speed = 1
    cloudsBG1:toBack()

    cloudsBG2 = display.newImage( "images/clouds_bg_2.png", 568, 320 )
    cloudsBG2.name="cloudsBG2"
    cloudsBG2.alpha=.1
    -- cloudsBG2 = display.newRect( 0,0,568,320 )
    -- cloudsBG2:setFillColor(1.0, 1.0, 0.0)
    -- cloudsBG2.alpha = .5
    cloudsBG2.x=_W/2+568
    cloudsBG2.y=_H/2
    cloudsBG2.speed = 1
    cloudsBG2:toBack()

    offsetCloudFG = 20

    cloudsFG1 = display.newImage( "images/clouds_fg4_large.png", 568, 350 )
    cloudsFG1.name="cloudsFG1"
    -- cloudsFG1:setFillColor( 1, 1, 0 )
    cloudsFG1.x=_W/2-(offsetCloudFG)
    cloudsFG1.y=_H/2
    cloudsFG1.speed = 2
    cloudsFG1.alpha=0
    cloudsFG2 = display.newImage( "images/clouds_fg4_large.png", 568, 350 )
    cloudsFG2.name="cloudsFG2"
    -- cloudsFG2:setFillColor( 1, 1, 0 )
    cloudsFG2.x=_W/2+(_W-offsetCloudFG)
    cloudsFG2.y=_H/2
    cloudsFG2.speed = 2
    cloudsFG2.alpha=0


    -- ISSUES WITH THESE RECYCLING (JUMPING TO BEHIND ONE ANOTHER) IMAGES FOR:
    --   1. SIMULATOR, NON IPHONE 5
    --   2. ON DEVICES THEMSELVES (INCLUDING IPHONE 5)

    cloudsBG1.enterFrame = scrollCloudsBG
    Runtime:addEventListener("enterFrame", cloudsBG1)
    cloudsBG2.enterFrame = scrollCloudsBG
    Runtime:addEventListener("enterFrame", cloudsBG2)

    cloudsFG1.enterFrame = scrollCloudsFG
    Runtime:addEventListener("enterFrame", cloudsFG1)
    cloudsFG2.enterFrame = scrollCloudsFG
    Runtime:addEventListener("enterFrame", cloudsFG2)

    cloudCirculate(cloudsFG1)
    cloudCirculate(cloudsFG2)

    cloudFade(cloudsBG1)
    cloudFade(cloudsBG2)

    bg:toBack()
end

function scene:create(e)
end

function scene:show(e)
    if e.phase == "will" then
        -- SAM: Notice transition
        local color =
        {
            highlight = { r=1, g=1, b=1 },
            shadow = { r=0, g=0, b=0 }
        }

        -- highScoreText = display.newText("BEST " .. highScore, _W/2, _H/2+_H*(1/4)+2, native.systemFont, 16)
        -- highScoreText:setFillColor( 1, 1, 1 )
        -- highScoreText:toFront()

        setScene()
        -- issues
        -- noHighScore()

    elseif e.phase== "did" then
        btnsAgain:addEventListener( "touch", myTouchListener )
        btnsAgain:addEventListener( "touch", doFunction )
        btnsShare:addEventListener( "touch", myTouchListener )
        btnsShare:addEventListener( "touch", doFunction )
        btnsQuit:addEventListener( "touch", myTouchListener )
        btnsQuit:addEventListener( "touch", doFunction )
    end
end

function scene:hide(e)
    if e.phase == "will" then
        Runtime:removeEventListener("enterFrame", cloudsBG1)
        Runtime:removeEventListener("enterFrame", cloudsBG2)
        Runtime:removeEventListener("enterFrame", cloudsFG1)
        Runtime:removeEventListener("enterFrame", cloudsFG2)
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
        display.remove(randomFlag4)
        display.remove(randomFlag5)
        display.remove(randomFlag6)
        display.remove(title)
        display.remove(highScoreText)

        display.remove(bg)
        transition.cancel(scoreTextGroup)
        display.remove(scoreTextGroup)

        display.remove(killScreen)
        display.remove(cloudsBG1)
        display.remove(cloudsBG2)
        display.remove(cloudsFG1)
        display.remove(cloudsFG2)
        display.remove(flagPole1)
        display.remove(flagPole2)
        display.remove(flagPole3)
        display.remove(flagPole4)
        display.remove(flagPole5)
        display.remove(flagPole6)

        display.remove(M.skeleton.group)
        display.remove(btnsAgain)
        display.remove(btnsShare)
        display.remove(btnsQuit)
        btnsAgain:removeEventListener( "touch", myTouchListener )
        btnsAgain:removeEventListener( "touch", doFunction )
        btnsShare:removeEventListener( "touch", myTouchListener )
        btnsShare:removeEventListener( "touch", doFunction )
        btnsQuit:removeEventListener( "touch", myTouchListener )
        btnsQuit:removeEventListener( "touch", doFunction )
        composer.removeScene("gameover")
    end
end

function scene:destroy(e)
    stopAnim()
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
