local composer=require("composer")
local scene = composer.newScene()

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

music=nil
bobby=nil

audio.stop( )            
music = audio.loadStream( 'anthems/magee-gameover.mp3' ) 
bobby = audio.play(music,{loops=-1})

-- local flagHeights = {24, 23, -46}
-- local flagX = {20, 98, 44, 515, 525, 100, 480, 534}




local flagHeights = {24, -18, -46}
local flagX = {20, 98, 69, 500, 525, 100, 480, 534}

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

    local worldFlags = {1, 7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85, 91, 97, 103, 109, 115, 121, 127, 133, 139, 145, 151, 157, 163, 169, 175, 181, 187, 193, 199, 205, 211, 217, 223, 229, 235, 241, 247, 253, 259, 265, 271, 277, 283, 289, 313, 319, 325}

    local function shuffle(t)
        local iterations = #t
        local j

        for i = iterations, 2, -1 do
            j = math.random(i)
            t[i], t[j] = t[j], t[i]
        end
    end
    shuffle(worldFlags)

    for i=1, 8 do 
        local randomFlagSeq={
            {name="randomflagseq1",frames={worldFlags[i],(worldFlags[i]+1),(worldFlags[i]+2),(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4),(worldFlags[i]+3), (worldFlags[i]+2), (worldFlags[i]+1)},time=860},

            {name="andorra-test",frames={1,2,3,4,5,6},time=860},

            {name="randomflagseq2",frames={worldFlags[i]+3,(worldFlags[i]+2),(worldFlags[i]+1),(worldFlags[i]+2),(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4)},time=1021},
            {name="randomflagseq3",frames={worldFlags[i]+4,(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4),(worldFlags[i]+3),(worldFlags[i]+2),(worldFlags[i]+1)},time=820 },
            {name="randomflagseq4",frames={worldFlags[i]+5,(worldFlags[i]+4),(worldFlags[i]+3),(worldFlags[i]+2),(worldFlags[i]+1),(worldFlags[i]),(worldFlags[i]+1),(worldFlags[i]+2)},time=902},
            {name="randomflagseq5",frames={worldFlags[i]+2,(worldFlags[i]+3),(worldFlags[i]+4),(worldFlags[i]+5),(worldFlags[i]+4),(worldFlags[i]+3),(worldFlags[i]+2),(worldFlags[i]+1)},time=896}
        }

    
    -- ["Flag_of_Ireland1"] = 127,
    -- ["Flag_of_Ireland2"] = 128,
    -- ["Flag_of_Ireland3"] = 129,
    -- ["Flag_of_Ireland4"] = 130,
    -- ["Flag_of_Ireland5"] = 131,
    -- ["Flag_of_Ireland6"] = 132,        

        if i==1 then
            -- Big Flag
            randomFlag1=display.newSprite(flagWave40Sheet,randomFlagSeq)
            randomFlag1.x=flagX[1]+21; randomFlag1.y=(_H/2)+flagHeights[3]
            randomFlag1:setSequence("randomflagseq1")
            randomFlag1:setFrame( math.random(1,5) )

            randomFlag1:play() 
        end
        if i==2 then
            -- Big Flag          
            randomFlag2=display.newSprite(flagWave40Sheet,randomFlagSeq)
            randomFlag2.x=flagX[2]+21; randomFlag2.y=(_H/2)+flagHeights[3]
            randomFlag2:setSequence("randomflagseq1")
            randomFlag2:setFrame( math.random(1,2) )

            randomFlag2:play() 
        end
        if i==3 then
            -- Med Flag
            randomFlag3=display.newSprite(flagWave34Sheet,randomFlagSeq)
            randomFlag3.x=flagX[3]+18; randomFlag3.y=(_H/2)+flagHeights[2]
            randomFlag3:setSequence("randomflagseq1")
            randomFlag3:setFrame( math.random(1,2) )
            randomFlag3.alpha=0.65


            randomFlag3:play() 
        end
        if i==4 then
            -- Med Flag          
            randomFlag4=display.newSprite(flagWave34Sheet,randomFlagSeq)
            randomFlag4.x=flagX[4]+18; randomFlag4.y=(_H/2)+flagHeights[2]
            randomFlag4:setSequence("randomflagseq1")
            randomFlag4:setFrame( math.random(1,2) )
            randomFlag4.alpha=0.65
            randomFlag4:setFrame( 2 )

            randomFlag4:play() 
        end
        if i==5 then
            -- Small Flag
            -- randomFlag5=display.newSprite(flagWave34Sheet,randomFlagSeq)
            -- randomFlag5.x=flagX[5]+23; randomFlag5.y=(_H/2)+flagHeights[1]
            -- randomFlag5:setSequence( "randomflagseq".. math.random(1,1) )            
            -- randomFlag5:play() 
        end
        if i==6 then
            -- Small Flag
            -- randomFlag6=display.newSprite(flagWave34Sheet,randomFlagSeq)
            -- randomFlag6.x=flagX[6]+23; randomFlag6.y=(_H/2)+flagHeights[1]
            -- randomFlag6:setSequence( "randomflagseq".. math.random(1,1) )            
            -- randomFlag6:play() 
        end  
        if i==7 then
            -- Big Flag          
            randomFlag7=display.newSprite(flagWave40Sheet,randomFlagSeq)
            randomFlag7.x=flagX[7]+21; randomFlag7.y=(_H/2)+flagHeights[3]
            randomFlag7:setSequence("randomflagseq1") 
            randomFlag7:setFrame( math.random(1,5) )

            randomFlag7:play() 
        end
        if i==8 then
            -- Big Flag          
            randomFlag8=display.newSprite(flagWave40Sheet,randomFlagSeq)
            randomFlag8.x=flagX[8]+21; randomFlag8.y=(_H/2)+flagHeights[3]
            randomFlag8:setSequence("randomflagseq1")    
            randomFlag8:setFrame( math.random(1,2) )

            randomFlag8:play() 
        end                                                    
    end
end

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

local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    
    if event.phase == "began" then
        -- print("touch ON. inside")          
    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "again" then
            currentObject:setSequence("again")
        elseif currentObject.name == "share" then
            currentObject:setSequence("share")
        elseif currentObject.name == "quit" then
            currentObject:setSequence("quit")
        end
        
        -- redundant ?? 
        -- currentObject:setFrame(1)
        
        if touchInsideBtn == true and isLoading == false then 
            -- print("touch OFF. inside")
            -- composer.removeScene("start")
            
            -- prevents scenes from firing twice!!
            isLoading = true
            
            local goto = currentObject.gotoScene
            composer.gotoScene( goto, { effect = defaultTransition } )
            
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
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
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
    bg = display.newRect(0, 0, 568, 320)
    bg:setFillColor(0,.6,1)
    bg.x = _W/2
    bg.y = _H/2
    
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
    killScreen = display.newImage( "images/bricks_trans_cracks.png", 568, 94)
    killScreen.name="killScreen"
    killScreen.anchorX=0.5
    killScreen.anchorY=1
    killScreen.x=_W/2
    killScreen.y=_H
    
    killScreen:toBack()
    --group:toBack()
    bg:toBack()

    flagPole1 = display.newImage( "images/flagpole-142.png", 18,142)
    flagPole1.anchorX=0.5
    flagPole1.anchorY=1
    flagPole1.name="flagPole1"
    flagPole1.x=flagX[1] ;flagPole1.y=_H/2+66


    flagPole2 = display.newImage( "images/flagpole-142.png", 18,142)
    flagPole2.anchorX=0.5
    flagPole2.anchorY=1
    flagPole2.name="flagPole2"
    flagPole2.x=flagX[2] ;flagPole2.y=_H/2+66

    flagPole3 = display.newImage( "images/flagpole-110.png", 18,110)
    flagPole3.anchorX=0.5
    flagPole3.anchorY=1
    flagPole3.name="flagPole3"
    flagPole3.x=flagX[3] ;flagPole3.y=_H/2+66
    flagPole3.alpha=0.30

    flagPole4 = display.newImage( "images/flagpole-110.png", 18,110)
    flagPole4.anchorX=0.5
    flagPole4.anchorY=1
    flagPole4.name="flagPole4"
    flagPole4.x=flagX[4] ;flagPole4.y=_H/2+66
    flagPole4.alpha=0.30

    -- flagPole5 = display.newImage( "images/flagpole-sm.png", 18,75)
    -- flagPole5.anchorX=0.5
    -- flagPole5.anchorY=1
    -- flagPole5.name="flagPole5"
    -- flagPole5.x=flagX[5] ;flagPole5.y=_H/2+66

    -- flagPole6 = display.newImage( "images/flagpole-sm.png", 18,75)
    -- flagPole6.anchorX=0.5
    -- flagPole6.anchorY=1
    -- flagPole6.name="flagPole6"
    -- flagPole6.x=flagX[6];flagPole6.y=_H/2+66

    flagPole7 = display.newImage( "images/flagpole-142.png", 18,142)
    flagPole7.anchorX=0.5
    flagPole7.anchorY=1
    flagPole7.name="flagPole7"
    flagPole7.x=flagX[7] ;flagPole7.y=_H/2+66

    flagPole8 = display.newImage( "images/flagpole-142.png", 18,142)
    flagPole8.anchorX=0.5
    flagPole8.anchorY=1
    flagPole8.name="flagPole8"
    flagPole8.x=flagX[8] ;flagPole8.y=_H/2+66      

    -- fab=display.newSprite(myImageSheet2,fabSeq)

    menuAgain = display.newSprite(btnsSheet, btnsSeq)
    menuAgain.name = "again"
    menuAgain:addEventListener( "touch", myTouchListener )
    menuAgain.x=88 ;menuAgain.y=_H-36
    menuAgain:setSequence( "again" )
    menuAgain:setFrame( 1 )
    menuAgain.gotoScene="game"


    menuShare= display.newSprite(btnsSheet, btnsSeq)
    menuShare.name = "share"
    menuShare:addEventListener( "touch", myTouchListener )
    menuShare.x=_W/2+20 ;menuShare.y=_H-39
    menuShare:setSequence( "share" )
    menuShare:setFrame( 1 )
    menuShare.gotoScene="options"

    menuQuit= display.newSprite(btnsSheet, btnsSeq)
    menuQuit.name = "quit"
    menuQuit:addEventListener( "touch", myTouchListener )
    menuQuit.x=_W-69 ;menuQuit.y=_H-37
    menuQuit:setSequence( "quit" )
    menuQuit:setFrame( 1 )
    menuQuit.gotoScene="menu"



    selectRandomFlags()

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
        scoreText = display.newText(gameScore, _W/2, _H/2, native.systemFont, 80)
        scoreText:setFillColor( 1, 0, 0 )
        scoreText:toFront()

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
        menuAgain:addEventListener( "touch", doFunction )
        menuQuit:addEventListener( "touch", doFunction )
        menuShare:addEventListener( "touch", doFunction )
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
  display.remove(randomFlag7)
  display.remove(randomFlag8)
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
  display.remove(flagPole7)
  display.remove(flagPole8)
  display.remove(menuNiceTry)
  display.remove(menuAgain)
  display.remove(menuShare)
  display.remove(menuQuit)
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
