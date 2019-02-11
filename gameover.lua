local composer=require("composer")
local scene = composer.newScene()

local pGet = ssk.persist.get
local pSet = ssk.persist.set

audio.stop()

music=nil
bobby=nil

if(audioReservedChannel2 == nil) then
    audioReservedChannel2 = audio.play(musicGameOver, {channel=2,loops=-1})
end

local highScore
local gameScore
local shakeTextRight = true
local shakeTextTimer
local shakeText
local cloudsBG1
local cloudsBG2
local cloudsFG1
local cloudsFG2

local bg
-- fills transparent brick cracks. Try some hot fx here!
local brickCracks

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
local menuNiceTry
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
local scoreText
local highScoreText
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
-- local flagSetX = {}

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

-- local flagSet1X = function()
--     local offsetArray = {}
--     local flagPoleSpacingSpacing = math.random(42,119)
--     local flagPoleSpacingSpacingMiddleOffset = function()
--         local offset = math.random(20)
--         if math.random() > .5 then
--             offset = -offset
--         end
--         return offset
--     end
--
--     offsetArray = {
--         (_W/4),
--         (_W/4) + (flagPoleSpacingSpacing/2) + flagPoleSpacingSpacingMiddleOffset(),
--         (_W/4) + flagPoleSpacingSpacing
--     }
--
--     return offsetArray
-- end

-- print(table.getn(flagSet1HorizontalPositions))

local menuSeq = {
    { name = "normalRun", start=1, count=2, time=800 },
    { name = "again", frames={1,2}, time=500 },
    { name = "quit", frames={3,4}, time=500 },
    { name = "share", frames={5,6}, time=500 },

}

local niceTrySpriteCoords = require("lua-sheets.opts-nicetry")
local niceTrySheet = graphics.newImageSheet( "images/opts-nicetry.png", niceTrySpriteCoords:getSheet() )

local niceTrySeq = {
    { name = "nicetry", frames={1,2,3,4,5,6,7,8,9}, time=680, loopCount=0},

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

function listFonts()
    local systemFonts = native.getFontNames()

    -- Set the string to query for (part of the font name to locate)
    local searchString = "pt"

    -- Display each font in the Terminal/console
    for i, fontName in ipairs( systemFonts ) do

        local j, k = string.find( string.lower(fontName), string.lower(searchString) )

        if ( j ~= nil ) then
            print( "Font Name = " .. tostring( fontName ) )
        end
    end
end
--listFonts()

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

-- SAM: only using Big and Med flagwave sprites. remove Small Flag sprites all together?
-- Small Flag
-- randomFlag6=display.newSprite(flagWave34Sheet,randomFlagSeq)
-- randomFlag6.x=flagX[6]+23
-- randomFlag6.y=(_H/2)+flagHeights[1]
-- randomFlag6:setSequence( "randomflagseq".. math.random(1,1) )
-- randomFlag6:play()

-- local flag4SheetData = { width=83,height=55,numFrames=4,sheetContentWidth=332,sheetContentHeight=55}
-- local flag4Sheet=graphics.newImageSheet("images/china_wave_55h.png",flag4SheetData)
-- local flag4Sequence={name="flag3ani",start=1,count=4,time=700}
-- local flag4Animation=display.newSprite(flag4Sheet,flag4Sequence)
--       flag4Animation.anchorX=0
--       flag4Animation.anchorY=0
--       flag4Animation.x=130
--       flag4Animation.y=20
--       flag4Animation:play()




-- local function buttonHit(event)
--   local goto = event.target.gotoScene
--   composer.gotoScene ( goto, { effect = defaultTransition } )
--   return true
-- end

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
   cloudFadeTransition2 = transition.to( self, {time=3920, alpha=.28,onComplete=function()
        cloudFadeTransition1 = transition.to( self, {time=2360, alpha=.57,onComplete=cloudFade})
    end
    })
end

local function setScene()

    print("High score: ", pGet( "score.json", "highScore" ) )

    bg = display.newRect(_W/2, _H/2, _W, _H)
    bg:setFillColor(0,.6,1)

    -- SAM: what was i doing here?
    --[[
    local group = display.newGroup()

    brickCracks = display.newRect(group, 0, 0, 568, 94)
    brickCracks:setFillColor(0,.6,1)
    --brickCracks:setStrokeColor(1,0,0)
    --brickCracks.strokeWidth = 2
    brickCracks.anchorX=0.5
    brickCracks.anchorY=0.5
    brickCracks.x=_W/2
    brickCracks.y= _H + (brickCracks.height/2)
    brickCracks.fill.effect = "generator.radialGradient"
    brickCracks.fill.effect.color1 = {0,1,0}
    brickCracks.fill.effect.color2 = {0,0,1}
    brickCracks.fill.effect.center_and_radiuses = {0.5,0.5,0.5,.75}
    brickCracks.fill.effect.aspectRatio = 1

    local mask = graphics.newMask("images/mask.png")
    group:setMask(mask)

    --brickCracks.maskX = brickCracks.maskScaleX
    group.maskScaleX = brickCracks.width
    group.maskScaleY = brickCracks.height/2
    --group.maskX = group.maskScaleX+(group.x/2)
    --group.maskY = _H
    group.maskX = _W
    group.maskY = _H

    local reverse = 1

    local function rockRect()
        if ( reverse == 0 ) then
            reverse = 1
            transition.to( brickCracks, { rotation=-25, time=500, transition=easing.inOutCubic } )
        else
            reverse = 0
            transition.to( brickCracks, { rotation=25, time=500, transition=easing.inOutCubic } )
        end
    end

    timer.performWithDelay( 600, rockRect, 0 )  -- Repeat forever
    ]]--

    -- SAM: rename all this
    killScreen = display.newImageRect( "images/bricks_trans_cracks.png", _W, 94)
    killScreen:setFillColor( .9, .55, .8, 1 )
    killScreen.alpha = 0.33
    killScreen.name="killScreen"
    killScreen.anchorX=0.5
    killScreen.anchorY=1
    killScreen.x=_W/2
    killScreen.y=_H

    killScreen.fill.effect = "filter.linearWipe"

    killScreen.fill.effect.direction = { 0, 1 }
    killScreen.fill.effect.smoothness = 1
    killScreen.fill.effect.progress = 0.5

    menuNiceTry = display.newSprite(niceTrySheet,niceTrySeq)
    menuNiceTry.x=_W/2; menuNiceTry.y=70
    menuNiceTry:setSequence("nicetry")
    menuNiceTry:play()
    menuNiceTry:addEventListener("sprite", niceTryPop)

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
    killScreen:toBack()
    bg:toBack()

    -- SAM: what was i doing here?
    --group:toBack()
end

local function newHighScore()
whatBackground = "images/bricks-sunken-w-bg_blue.png"
setScene()
end

local function noHighScore()
  cloudsBG1 = display.newImage( "images/clouds_bg_2.png", 568, 320 )
  cloudsBG1.name="cloudsBG1"
  cloudsBG1.alpha=.57
  cloudsBG1.x=_W/2 ;cloudsBG1.y=_H/2
  cloudsBG1.speed = 1

  cloudsBG2 = display.newImage( "images/clouds_bg_2.png", 568, 320 )
  cloudsBG2.name="cloudsBG2"
  cloudsBG2.alpha=.57
-- cloudsBG2 = display.newRect( 0,0,568,320 )
-- cloudsBG2:setFillColor(1.0, 1.0, 0.0)
-- cloudsBG2.alpha = .5
  cloudsBG2.x=_W/2+568 ;cloudsBG2.y=_H/2
  cloudsBG2.speed = 1

  offsetCloudFG = 20

  cloudsFG1 = display.newImage( "images/clouds_fg4_large.png", 568, 350 )
  cloudsFG1.name="cloudsFG1"
  -- cloudsFG1:setFillColor( 1, 1, 0 )
  cloudsFG1.x=_W/2-(offsetCloudFG) ;cloudsFG1.y=_H/2
  cloudsFG1.speed = 2
  cloudsFG2 = display.newImage( "images/clouds_fg4_large.png", 568, 350 )
  cloudsFG2.name="cloudsFG2"
  -- cloudsFG2:setFillColor( 1, 1, 0 )
  cloudsFG2.x=_W/2+(_W-offsetCloudFG) ;cloudsFG2.y=_H/2
  cloudsFG2.speed = 2

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

  highScoreText = display.newText("BEST " .. highScore, _W/2, _H/2+_H*(1/4)+2, native.systemFont, 16)
  highScoreText:setFillColor( 1, 1, 1 )
  highScoreText:toFront()

  menuNiceTry = display.newSprite(niceTrySheet,niceTrySeq)
  menuNiceTry.x=_W/2; menuNiceTry.y=70
  menuNiceTry:setSequence("nicetry")
  menuNiceTry:play()
  menuNiceTry:addEventListener("sprite", niceTryPop)
  whatBackground = "images/bricks-sunken-w-bg.png"
  setScene()
end

local function scoreSave(tempScore)
   local path = system.pathForFile( "CFscorefile.txt", system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      local contents = tostring(tempScore )
      file:write( tempScore )
      io.close( file )
      return true
   else
      print( "Error: could not read ", "CFscorefile.txt", "." )
      return false
   end
end

local function scoreLoad()
   local path = system.pathForFile( "CFscorefile.txt", system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
      -- Read all contents of file into a string
      local contents = file:read( "*a" )
      local score = tonumber(contents);
      io.close( file )
      return score
   else
      print( "Error: could not read scores from ", "CFscorefile.txt", "." )
   end
   return nil
end

local function scoreCheck()

    local loadedHighScore=scoreLoad()
    if loadedHighScore == nil then
      scoreSave(gameScore)
      highScore=gameScore
      newHighScore()
    elseif loadedHighScore ~= nil then
      if loadedHighScore >= gameScore then
         highScore=loadedHighScore
         noHighScore()
      elseif loadedHighScore < gameScore then
         scoreSave(gameScore)
         highScore=gameScore
         newHighScore()
      end
    end
end

-- transition.to( self, { time=4000, y=200, transition=easing.continuousLoop } )

local function shakeText()

     if shakeTextRight == true then
        transition.to( scoreText, { time=150, rotation=-10 , onComplete=shakeText } )
        shakeTextRight=false
      elseif shakeTextRight == false then
        transition.to( scoreText, { time=150, rotation=10 , onComplete=shakeText } )
        shakeTextRight=true
     end

end

function scene:create(e)
end

function scene:show(e)
  if e.phase == "will" then

        if overrideScore==true then
          gameScore=5
         highScore=6
        elseif setScore == false then
          gameScore=e.params.saveScore
        end

        local color =
        {
            highlight = { r=1, g=1, b=1 },
            shadow = { r=0, g=0, b=0 }
        }

        --align to center of "share" btn
        scoreText = display.newEmbossedText( pGet( "score.json", "highScore" ), _W/2+20, _H/2,"PTMono-Bold", 38 )
        scoreText:setFillColor( 1, .9, .4)
        scoreText:setEmbossColor( color )

        shakeText()
        self.view:insert(scoreText)

        if overrideScore== true then
          if highScore>gameScore then
         newHighScore()
          elseif highScore<=gameScore then
          noHighScore()
        end
        elseif overrideScore==false then
           scoreCheck()

        end
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
  display.remove(cloudsFG1)
  display.remove(cloudsFG2)

  display.remove(bg)

  display.remove(killScreen)
  display.remove(cloudsBG1)
  display.remove(cloudsBF2)
  display.remove(flagPole1)
  display.remove(flagPole2)
  display.remove(flagPole3)
  display.remove(flagPole4)
  display.remove(flagPole5)
  display.remove(flagPole6)
  display.remove(menuNiceTry)
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
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
