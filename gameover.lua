local composer=require("composer")
local scene = composer.newScene()


local cloudsBG1
local cloudsBG2
local cloudsFG1
local cloudsFG2
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

menuNiceTry = display.newSprite(niceTrySheet,niceTrySeq)
menuNiceTry.x=_W/2; menuNiceTry.y=70
menuNiceTry:setSequence("nicetry")
menuNiceTry:play()

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



menuNiceTry:addEventListener("sprite", niceTryPop)

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

local currentObject
local boundaryCheck = false

local function myTouchListener( event )
    if event.phase == "began" then      
        print("began phase")
        -- event.target.alpha = 0.5
        -- event.target:setFrame( 1 )
        currentObject = event.target

        display.getCurrentStage():setFocus(currentObject)
    elseif event.phase == "ended" or event.phase == "cancelled" then
        print("end phase")
        -- event.target.alpha = 1
        
        if boundaryCheck == true then 
            local goto = event.target.gotoScene
            composer.gotoScene ( goto, { effect = defaultTransition } )
        end

        currentObject:setFrame(1)
        currentObject = nil
        
        display.getCurrentStage():setFocus(nil) 
    end
end


local function doFunction(e)
    if currentObject ~= nil then
        if e.x < currentObject.contentBounds.xMin or
            e.x > currentObject.contentBounds.xMax or
            e.y < currentObject.contentBounds.yMin or
            e.y > currentObject.contentBounds.yMax then
            
            currentObject:setFrame( 1 )
            -- print("Its out")
            boundaryCheck = false
        else
            currentObject:setFrame( 2 )
            -- print("Its in")
            boundaryCheck = true
        end   
    end     
end






--local function buttonHit(e)
  --local goto = e.target.gotoScene
  --composer.gotoScene ( goto, { effect = defaultTransition } )
  --return true
--end

function scene:create(e)  
  killScreen = display.newImage( "images/bricks-sunken-w-bg.png", 568,320)
  killScreen.name="killScreen"
  killScreen.x=_W/2 ;killScreen.y=_H/2

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

local offsetCloudFG = 20

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

  function scrollCloudsBG(self, event)
    
    if self.x < -284 then -- 477
      self.x = _W/2+566 -- 480
    -- print(self.x)      
    else
    -- print(self.x)      

      self.x = self.x - self.speed
    end
  end

  function scrollCloudsFG(self, event)

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

        transition.to(self, {time=200, y=self.y-2, onComplete=function()
            transition.to(
                self, {time=1400, y=self.y+10, onComplete=function()
                    transition.to(
                        self, {time=200, y=self.y+2, onComplete=function()

                            transition.to(
                                self, {time=1400, y=self.y-10, onComplete=cloudCirculate})
                        end
                        })
                end
                })
        end
        })
    elseif myPusa == "cloudsFG2" then

        transition.to(self, {time=200, y=self.y+2, onComplete=function()
            transition.to(
                self, {time=1400, y=self.y-10, onComplete=function()
                    transition.to(
                        self, {time=200, y=self.y-2,  onComplete=function()

                            transition.to(
                                self, {time=1400, y=self.y+10, onComplete=cloudCirculate})
                        end
                        })
                end
                })
        end
        })
    end
end

function cloudFade(self)
    transition.to( self, {time=3920, alpha=.28,onComplete=function()
        transition.to( self, {time=2360, alpha=.57,onComplete=cloudFade})
    end
    })
end


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
  -- cloud1 = display.newImage( "images/cloud150x74.png", 150,74)
  -- cloud1.anchorX=0.5
  -- cloud1.anchorY=1
  -- cloud1.name="cloud1"
  -- cloud1.x=_W/2+130 ;cloud1.y=_H/2

  -- cloud2 = display.newImage( "images/cloud2150x74.png", 150,74)
  -- cloud2.anchorX=0.5
  -- cloud2.anchorY=1
  -- cloud2.name="cloud2"
  -- cloud2.x=_W/2-130 ;cloud2.y=_H/2-50

  -- cloud3 = display.newImage( "images/cloud3150x96.png", 150,96)
  -- cloud3.anchorX=0.5
  -- cloud3.anchorY=1
  -- cloud3.name="cloud3"
  -- cloud3.x=_W/2+190 ;cloud3.y=90

  -- cloud4 = display.newImage( "images/cloud4100x62.png", 100,62)
  -- cloud4.anchorX=0.5
  -- cloud4.anchorY=1
  -- cloud4.name="cloud4"
  -- cloud4.x=50 ;cloud4.y=70    
  -- cloud5 = display.newImage( "images/cloud5100x72.png", 100,72)
  -- cloud5.anchorX=0.5
  -- cloud5.anchorY=1
  -- cloud5.name="cloud1"
  -- cloud5.x=_W-50 ;cloud5.y=_H/2+50          

  -- add a base for the flag pole ! get it to rest behind ?

    selectRandomFlags()


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

menuAgain = display.newSprite( menuAgainSheet, menuSeq )
menuAgain:addEventListener( "touch", myTouchListener )
menuAgain.x=88 ;menuAgain.y=_H-36
menuAgain:setSequence( "again" )
menuAgain:setFrame( 1 )
menuAgain.gotoScene="game"


menuShare= display.newSprite( menuShareSheet, menuSeq )
menuShare:addEventListener( "touch", myTouchListener )
menuShare.x=_W/2+20 ;menuShare.y=_H-39
menuShare:setSequence( "share" )
menuShare:setFrame( 1 )
menuShare.gotoScene="options"

menuQuit= display.newSprite( menuQuitSheet, menuSeq )
menuQuit:addEventListener( "touch", myTouchListener )
menuQuit.x=_W-69 ;menuQuit.y=_H-37
-- menuQuit.x=_W/2+10 ;menuQuit.y=_H-40
menuQuit:setSequence( "quit" )
menuQuit:setFrame( 1 )
menuQuit.gotoScene="menu"


--  local againBtn = makeTextButton("Again", 100, _H-50, {listener=buttonHit, group=group, fontSize=36})
  --againBtn.gotoScene = "game"
--  local shareBtn = makeTextButton("Share", _W/2, _H-50, {listener=buttonHit, group=group,fontSize=36})
  --shareBtn.gotoScene = "menu"
--  local quitBtn = makeTextButton("Quit",_W-100, _H-50, {listener=buttonHit, group=group,fontSize=36})
--  quitBtn.gotoScene = "menu"    
  

  -- self.view:insert(cloud1)
  -- self.view:insert(cloud2)
  -- self.view:insert(cloud3)
  -- self.view:insert(cloud4)
  -- self.view:insert(cloud5)


  -- self.view:insert(flagPole1)
  -- self.view:insert(flagPole2)

  -- self.view:insert(flagPole7)
  -- self.view:insert(flagPole8)  



  -- IMPORTANT IMPORTANT IMPORTANT IMPORTANT

  -- why are flagPole objects being added to this scene but not flagWaves?
  -- I what I'm doing with the ordering (toFront and toBack), determining the ordering ok to do it here? I had troubles doing it before all the objects were insterted (I needed to put the below code after lines 348 to 353)



  -- ADD RANDOMFLAGS AFTER FLAGPOLES !

    -- THIS ORDERING IS IMPORTANT. ITS THE KEY




  -- self.view:insert(cloudsBG1)
  -- self.view:insert(cloudsBG2)


    -- cloudsFG1:toBack( )
    -- cloudsFG2:toBack( )



  self.view:insert(killScreen)

  self.view:insert(flagPole3) 
  self.view:insert(flagPole4)  
    -- flagPole3:toBack( )
    -- flagPole4:toBack( )
  self.view:insert(randomFlag3) 
  self.view:insert(randomFlag4)  
    -- randomFlag3:toBack( )
    -- randomFlag4:toBack( )



  -- cloudsBG1:toBack( )
  -- cloudsBG2:toBack( )

  self.view:insert(menuNiceTry)  

  self.view:insert(flagPole1)
  self.view:insert(flagPole2)

  self.view:insert(flagPole7)
  self.view:insert(flagPole8)  

  self.view:insert(randomFlag1)
  self.view:insert(randomFlag2)

  self.view:insert(randomFlag7)
  self.view:insert(randomFlag8) 

  self.view:insert(cloudsBG1)
  self.view:insert(cloudsBG2)

  self.view:insert(cloudsFG1)
  self.view:insert(cloudsFG2)




  -- killScreen:toBack( )
   

  -- self.view:insert(flagPole5)
  -- self.view:insert(flagPole6)   
 
  self.view:insert(menuAgain)
  self.view:insert(menuShare)
  self.view:insert(menuQuit)           
 -- self.view:insert(againBtn)
 -- self.view:insert(shareBtn)
 -- self.view:insert(quitBtn)
end

function scene:show(e) 
  if e.phase == "will" then
       print(e.params.saveScore)
        scoreText = display.newText(e.params.saveScore, _W/2, _H/2, native.systemFont, 28)
        scoreText:setFillColor( 1, 0, 0 )
        scoreText:toFront()
        self.view:insert(scoreText)


  elseif e.phase== "did" then
 

menuAgain:addEventListener( "touch", doFunction )
menuQuit:addEventListener( "touch", doFunction )
menuShare:addEventListener( "touch", doFunction )
-- menuAgain:addEventListener( "tap", buttonHit )
-- menuQuit:addEventListener( "tap", buttonHit )
-- menuShare:addEventListener( "tap", buttonHit )
  end

  
end

function scene:hide(e)
  if e.phase == "will" then
  display.remove(randomFlag1)
  display.remove(randomFlag2)
  display.remove(randomFlag3)
  display.remove(randomFlag4)
  display.remove(randomFlag5)
  display.remove(randomFlag6)
  display.remove(randomFlag7)
  display.remove(randomFlag8)
  display.remove(title)

  
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
