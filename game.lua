-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html 

local CreateText = require("textclass")

--game.lua
local composer = require("composer")
local scene = composer.newScene()
--media.playSound('yancy.mp3')
--local physics = require("physics")
--physics.start()

--media.playSound('Brazil.mid')

--for testing purposes. if true, go to GameOver screen.
local gotoDeath=true

local state=1
local speed=2
local timeVar=1250
local levels
local score=0
local scoreSave
local numDeaths=0
local temp
local idx=3
local infoPic
local info
local infoTimer
--local idx=25
local localGroup = display.newGroup()
local spawnTable = {}   --Create a table to hold our spawns
local currState="first"
local prevState="first"
local GameOver=0
local deadText=nil
local motion
local coin=1
local options
local choice=0
local timerSpeed
local flag2Timer
local finalChallenge=false
local thatsIt=false
local count=1
local firstObject=true
local setTheFlag=false
local xCoord=0
local yCoord=0
local topBar1
local topBar2
local lowBar1
local lowBar2
local sideTimer
local pieceTimer
local mapTimer
local flagTimer
local paceTimer
local setTimer
local killBarsTimer
local resetTimer
local flag3Timer
local newFlagTimer
local killLowTimer
local killTopTimer
local isPausing=false

local paceRect

local map
local lastFlag = 0
local rep=false
local random
local thisRoll=0
local lastRoll=0
local e=0

local bonusText
local scoreText
local speedText

local countryText
local country
--local lowBar
--local topBar

--composer.recycleOnSceneChange = true

local boycha = 1 -- FOR TESTING PURPOSES.
local nationalFlags1Coords = require("lua-sheets.national-flags1")
local nationalFlags1Sheet = graphics.newImageSheet( "images/national-flags1.png", nationalFlags1Coords:getSheet() )

local nationalFlags2Coords = require("lua-sheets.national-flags2")
local nationalFlags2Sheet = graphics.newImageSheet( "images/national-flags2.png", nationalFlags2Coords:getSheet() )

local nationalFlags3Coords = require("lua-sheets.national-flags3")
local nationalFlags3Sheet = graphics.newImageSheet( "images/national-flags3.png", nationalFlags3Coords:getSheet() )


local nationalFlagsSeq = {
    { name="andorra", sheet=nationalFlags1Sheet, frames={1} },
    { name="argentina", sheet=nationalFlags1Sheet, frames={2} },
    { name="australia", sheet=nationalFlags1Sheet, frames={3} },
    { name="austria", sheet=nationalFlags1Sheet, frames={4} },
    { name="belgium", sheet=nationalFlags1Sheet, frames={5} },
    { name="brazil", sheet=nationalFlags1Sheet, frames={6} },
    { name="canada", sheet=nationalFlags1Sheet, frames={7} },
    { name="chile", sheet=nationalFlags1Sheet, frames={8} },
    { name="china", sheet=nationalFlags1Sheet, frames={9} },
    { name="croatia", sheet=nationalFlags1Sheet, frames={10} },
    { name="cyprus", sheet=nationalFlags1Sheet, frames={11} },
    { name="czech_republic", sheet=nationalFlags1Sheet, frames={12} },
    { name="denmark", sheet=nationalFlags1Sheet, frames={13} },
    { name="egypt", sheet=nationalFlags1Sheet, frames={14} },
    { name="estonia", sheet=nationalFlags1Sheet, frames={15} },
    { name="finland", sheet=nationalFlags1Sheet, frames={16} },
    { name="france", sheet=nationalFlags1Sheet, frames={17} },
    { name="germany", sheet=nationalFlags1Sheet, frames={18} },
    { name="greece", sheet=nationalFlags1Sheet, frames={19} },
    { name="hungary", sheet=nationalFlags1Sheet, frames={20} },
    { name="iceland", sheet=nationalFlags1Sheet, frames={21} },
    { name="india", sheet=nationalFlags1Sheet, frames={22} },
    { name="indonesia", sheet=nationalFlags1Sheet, frames={23} },
    { name="ireland", sheet=nationalFlags1Sheet, frames={24} },

    { name="isreal", sheet=nationalFlags2Sheet, frames={1} },  
    { name="italy", sheet=nationalFlags2Sheet, frames={2} },
    { name="japan", sheet=nationalFlags2Sheet, frames={3} },
    { name="lithuania", sheet=nationalFlags2Sheet, frames={4} },
    { name="luxembourg", sheet=nationalFlags2Sheet, frames={5} },   
    { name="malaysia", sheet=nationalFlags2Sheet, frames={6} },   
    { name="malta", sheet=nationalFlags2Sheet, frames={7} },   
    { name="mexico", sheet=nationalFlags2Sheet, frames={8} }, 
    { name="netherlands", sheet=nationalFlags2Sheet, frames={9} }, 
    { name="new_zealand", sheet=nationalFlags2Sheet, frames={10} },
    { name="norway", sheet=nationalFlags2Sheet, frames={11} },
    { name="philippines", sheet=nationalFlags2Sheet, frames={12} },
    { name="poland", sheet=nationalFlags2Sheet, frames={13} },
    { name="portugal", sheet=nationalFlags2Sheet, frames={14} },
    { name="republic_of_china", sheet=nationalFlags2Sheet, frames={15} },    
    { name="russia", sheet=nationalFlags2Sheet, frames={16} },    
    { name="san_marino", sheet=nationalFlags2Sheet, frames={17} },    
    { name="singapore", sheet=nationalFlags2Sheet, frames={18} },    
    { name="slovakia", sheet=nationalFlags2Sheet, frames={19} },    
    { name="slovenia", sheet=nationalFlags2Sheet, frames={20} },        
    { name="south_africa", sheet=nationalFlags2Sheet, frames={21} },    
    { name="south_korea", sheet=nationalFlags2Sheet, frames={22} },    
    { name="spain", sheet=nationalFlags2Sheet, frames={23} },    
    { name="sri_lanka", sheet=nationalFlags2Sheet, frames={24} },    
    { name="sweden", sheet=nationalFlags3Sheet, frames={1} }, 
    { name="switzerland", sheet=nationalFlags3Sheet, frames={2} }, 
    { name="thailand", sheet=nationalFlags3Sheet, frames={3} }, 
    { name="turkey", sheet=nationalFlags3Sheet, frames={4} }, 
    { name="united_arab_emirates", sheet=nationalFlags3Sheet, frames={5} }, 
    { name="united_kingdom", sheet=nationalFlags3Sheet, frames={6} }, 
    { name="united_states", sheet=nationalFlags3Sheet, frames={7} }, 
              
    -- { name="argentina", sheet=nationalFlags1Sheet, frames={2} }
}

local topBtmBarSpriteCoords = require("lua-sheets.TopBtmBar")
local topBtmBarSheet = graphics.newImageSheet( "images/TopBtmBar.png", topBtmBarSpriteCoords:getSheet() )

local topBtmBarSeq = {
    {name="top", frames={1,2,3,4,5,6,7,8,9,10}, time=1000, loopCount=0},
    {name="btm", frames={6,7,8,9,10,1,2,3,4,5}, time=1000, loopcount=0},
}

local bonusImplodeSpriteCoords1 = require("lua-sheets.bonus-implode1")
local bonusImplodeSheet1 = graphics.newImageSheet( "images/bonus-implode1.png", bonusImplodeSpriteCoords1:getSheet() )

local bonusImplodeSpriteCoords2 = require("lua-sheets.bonus-implode2")
local bonusImplodeSheet2 = graphics.newImageSheet( "images/bonus-implode2.png", bonusImplodeSpriteCoords2:getSheet() )

local bonusImplodeSeq={
    {name="2x", sheet=bonusImplodeSheet1, frames={1,2,3,4,5,6},time=800, loopCount=1},
    {name="3x", sheet=bonusImplodeSheet2, frames={1,2,3,4,5,6},time=800, loopCount=1},
    {name="4x", sheet=bonusImplodeSheet1, frames={7,8,9,10,11,12},time=800, loopCount=1},
    {name="5x", sheet=bonusImplodeSheet2, frames={7,8,9,10,11,12},time=800, loopCount=1},
    {name="6x", sheet=bonusImplodeSheet1, frames={13,14,15,16,17,18},time=800, loopCount=1},
    {name="7x", sheet=bonusImplodeSheet1, frames={19,20,21,22,23,24},time=800, loopCount=1},
    {name="8x", sheet=bonusImplodeSheet1, frames={25,26,27,28,29,30},time=800, loopCount=1},
    {name="9x", sheet=bonusImplodeSheet2, frames={13,14,15,16,17,18},time=800, loopCount=1},

}

local bonusImplode=display.newSprite(bonusImplodeSheet1,bonusImplodeSeq)
bonusImplode.alpha=0 --start with 0

local function myImplodeListener( event )
    local thisSprite = event.target
    if ( event.phase == "ended" ) then
        thisSprite.alpha = 0
        thisSprite:pause()
    end
end

--bonusImplode:addEventListener( "sprite", myImplodeListener )

scoreText = CreateText.new( score, "Arial Rounded MT Bold", 30, _W*(4/5), _H/2 )
scoreText:ToFront()
--if gotoDeath==false then

speedText = CreateText.new( speed, "Arial Rounded MT Bold", 30, _W*(1/5), _H/2 )
speedText:ToFront()

--end
--[[
local bonusSheetData = { width=150,height=100,numFrames=6,sheetContentWidth=900,sheetContentHeight=100}
local bonusSheet=graphics.newImageSheet("images/text_shatter_1.png",bonusSheetData)
local bonusSequence={name="bonusAni", frames={6,6,6,6,5,4,3,2,1},time=2000, loopCount=1}
local bonusAnimation=display.newSprite(bonusSheet,bonusSequence)
      bonusAnimation.anchorX=0.5
      bonusAnimation.anchorY=0.5
      bonusAnimation.x=_W/2
      bonusAnimation.y=_H/2
      bonusAnimation:toBack()
      --]]
 


  







local piece = display.newImage( "images/australia259x229.png", 529,229)
      piece.anchorX=0.5
      piece.anchorY=0.5
      piece.alpha=0

local      background = display.newRect(0,0,580,320)
      background:setFillColor( 1,1,1 )
      background.anchorX=0.5
      background.anchorY=0.5
      background.name="background"
      background.x=_W/2 ;background.y=_H/2
      background:toBack()










local function speedUp()
 
  if idx~= #levels then
    idx=idx+1
    speed=levels[idx].speed
    timeVar=levels[idx].timeVar
    --print(levels[idx].speed)
    --if gotoDeath==false then
    
       --display.remove(speedText)
       speedText:Text(speed)
       speedText:ToFront()

   -- end   
  elseif finalChallenge==false then
     finalChallenge=true
  end
end   

local function resetSpawn()
  if music~= nil then
    media.stopSound(music)
  
    music=nil
end

   spawnTable={}
   count=1
    firstObject=true
    currState=nil    --reset bonus score states for new flag
    prevState=nil

             if bonusText ~= nil then
                 bonusText:Remove()
                 bonusText=nil
             end

     --      timer.cancel(timerSpeed)


            if state==3 then
              if finalChallenge==false then
                state=1
                idx=(idx)*2

              end 
            elseif state==1 then
              state=2
              idx=idx+1
            elseif state==2 then
              state=3

             idx=idx/2-1
             idx=math.round(idx)

             end
             speed=levels[idx].speed
             timeVar=levels[idx].timeVar
        speedText:Text(speed)
        speedText:ToFront() 
end  
   



local function dieNow(e)

  display.remove(e)
   choice=choice+1
  if choice==numDeaths then
local   options={effect = defaultTransition, params={saveScore=score} }

paceRect.isReady=false
  composer.gotoScene( "gameover", options )

end
end



local function moveObject (e)
if paceRect.isReady==true then    
       paceRect.x=paceRect.x+speed
 end
if state==1 then
  if #spawnTable >0 then
    for i = 1, #spawnTable do
         if spawnTable[i]~=0 and spawnTable[i].isReady==true and thatsIt==false then
           if spawnTable[i].isLeft==true then
             spawnTable[i].x=spawnTable[i].x-speed
           elseif spawnTable[i].isLeft==false then
                 spawnTable[i].x=spawnTable[i].x+speed
           end    
         end
    end
  end  
elseif state==2 then  
  if #spawnTable >0 then
    for i = 1, #spawnTable do
         if spawnTable[i]~=0 and spawnTable[i].isReady==true and thatsIt==false then
           if spawnTable[i].isLeft==true then
             spawnTable[i].x=spawnTable[i].x+speed
           elseif spawnTable[i].isLeft==false then
                 spawnTable[i].x=spawnTable[i].x-speed
           end    
         end
    end 
  end 
elseif state==3 then

  if #spawnTable >0 then
 
    for i = 1, #spawnTable do
         if spawnTable[i]~=0 and spawnTable[i].isReady==true and thatsIt==false then
           if spawnTable[i].isLeft==true or spawnTable[i].isBottomLeft==true then
             spawnTable[i].x=spawnTable[i].x-speed
           elseif spawnTable[i].isLeft==false or spawnTable[i].isBottomLeft==false then
                 spawnTable[i].x=spawnTable[i].x+speed
           end    
         end
    end 
  end 
end
end         

local function lookupCode(code,spawn)
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
    if spawn.type=="red" or spawn.type=="yellow" or spawn.type=="blue" then
      return 1
    end
  elseif code ==2 then
    if spawn.type=="red" or spawn.type=="white" or spawn.type=="blue" then  
      return 1
    end
  elseif code == 3 then
    if spawn.type=="yellow" or spawn.type=="white" or spawn.type=="blue" or spawn.type=="green" then  
      return 1
    end
  elseif code == 4 then
    if spawn.type=="red" or spawn.type=="white" then  
      return 1
    end  
  elseif code == 5 then
    if spawn.type=="red" or spawn.type=="white" or spawn.type=="green" then  
      return 1
    end
  end
  return 0
end



local function removeStuff(self)
  
     if spawnTable[self.index]~=0 and spawnTable[self.index]~=nil then

            self:removeSelf()
         spawnTable[self.index]=0
               self:removeEventListener("touch",objTouch)
      end   


end



local function removeText(text)
  text:removeSelf()
end


local function finalElimination(e)
              for i = 1, #spawnTable do
                 if spawnTable[i]~=0 and spawnTable[i].dead~=true then
                  spawnTable[i].isBodyActive=false
                  spawnTable[i]:removeEventListener("touch",objTouch)
                  transition.to( spawnTable[i], { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff   }) 
                 elseif spawnTable[i]~=0 and spawnTable[i].dead==true then
            
                   if numDeaths==1 then
                     transition.to( spawnTable[i], { time=900, rotation=400, x=_W/2, y=_H/2, xScale=8, yScale=8, onComplete=dieNow    })
                  
                   elseif numDeaths == 2 then
                     if spawnTable[i].isLeft==true or spawnTable[i].isBottomLeft==true then
                       transition.to( spawnTable[i], { time=900, rotation=400, x=_W*(1/3), y=_H/2, xScale=6, yScale=6, onComplete=dieNow    })
                     else
                       transition.to( spawnTable[i], { time=900, rotation=400, x=_W*(2/3), y=_H/2, xScale=6, yScale=8, onComplete=dieNow    })  
                     end
                   else
                     if spawnTable[i].isLeft==true or spawnTable[i].isBottomLeft==true then
                       if spawnTable[i].y < _W/2 then
                         transition.to( spawnTable[i], { time=900, rotation=400, x=_W*(1/3), y=_H*(1/3), xScale=6, yScale=6, onComplete=dieNow    })
                       elseif spawnTable[i].y > _W/2 then
                         transition.to( spawnTable[i], { time=900, rotation=400, x=_W*(1/3), y=_H*(2/3), xScale=6, yScale=6, onComplete=dieNow    })
                       end  
                     else
                       if spawnTable[i].y < _W/2 then
                         transition.to( spawnTable[i], { time=900, rotation=400, x=_W*(2/3), y=_H*(1/3), xScale=6, yScale=6, onComplete=dieNow    })
                       elseif spawnTable[i].y > _W/2 then
                         transition.to( spawnTable[i], { time=900, rotation=400, x=_W*(2/3), y=_H*(2/3), xScale=6, yScale=6, onComplete=dieNow    })
                       end 
                     end
                   end  
                 end
              end   
end










local function gotoPause(e)
    Runtime:removeEventListener("enterFrame", moveObject) 


 -- if topBar1~=nil then
    transition.pause(topBar1) 
     transition.pause(lowBar1)    
 --- end  
--  if topBar2~= nil then
     transition.pause(topBar2) 
     transition.pause(lowBar2)  
--  end
     if sideTimer~= nil then
     timer.pause(sideTimer)
   end
     transition.pause(pieceTimer)
     transition.pause(mapTimer)
     transition.pause(flagTimer)
     transition.pause(paceTimer)
     if timerSpeed~=nil then
     timer.pause(timerSpeed)
     end
     transition.pause(flag2Timer)
     transition.pause(killLowTimer)
     transition.pause(killTopTImer)


    if killBarsTimer~=nil then
    timer.pause(killBarsTimer)
  end
  if resetTimer~= nil then
    timer.pause(resetTimer)
  end
    transition.pause(flag3Timer)   
    if newFlagTimer ~=nil then
    timer.pause(newFlagTimer)
  end






  isPausing=true
  if setTimer~=nil then
  timer.pause(setTimer)  
  end          
  paceRect.isReady=false
  --    flag:toBack()
 -- if piece ~= nil then    
 -- piece:toBack()
--end
-- map:toBack() 
--if scoreText~=nil and scoreText~=0 then
--scoreText:toBack() 
--end
background:toBack()
--map:toFront()
  if #spawnTable >0 then
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 then
      
       --if spawnTable[i].pauseIt~=true then
          transition.pause(spawnTable[i])
        -- end 


        spawnTable[i].isBodyActive=false

      end

    end  
  end  
  Runtime:removeEventListener("enterFrame", killObject)





local   options={effect = "zoomOutIn", time=100, isModal=true}


 -- composer.gotoScene( "options", options )


 --if #spawnTable >0 then
  --  for i = 1, #spawnTable do
   --   if spawnTable[i]~=0 then
   --       options.params.i=spawnTable[i]
   --   end
   --  end
--end


         flag:removeEventListener( "tap", gotoPause ) 



          --    Runtime:removeEventListener("enterFrame", readyObject)  
composer.showOverlay("pause",  options)

end  


local function killObject (e)
  if #spawnTable >0 then
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 and spawnTable[i].x ~=nil then
          if spawnTable[i].x < -40 or spawnTable[i].x > _W+40 then
            if lookupCode(code,spawnTable[i])==1 then
             if bonusText ~= nil then
               bonusText:Remove()
               bonusText=nil
             end 
             if deadText==nil then
               deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
               deadText:setFillColor( 1, 0, 0 )
             end
   
             if gotoDeath==true then
               thatsIt=true
               paceRect.isReady=false
               spawnTable[i].dead=true
               spawnTable[i]:toFront() 
               spawnTable[i].isBodyActive=false
               spawnTable[i]:removeEventListener("touch",objTouch)
               Runtime:removeEventListener("enterFrame", killObject)
    
               Runtime:removeEventListener("enterFrame", readyObject)
               for i = 1, #spawnTable do
                 if spawnTable[i]~=0 then
                    spawnTable[i].isBodyActive=false

                    spawnTable[i]:removeEventListener("touch",objTouch)


                --    spawnTable[i]:removeEventListener("enterFrame", moveObject)
                      if spawnTable[i].x < -40 or spawnTable[i].x > _W+40 then
                        if lookupCode(code,spawnTable[i])==1 then               --you are dead

                          spawnTable[i].dead=true 
                          numDeaths=numDeaths+1
               
                        else
                          spawnTable[i].dead=false
                        end  
                      end
                      if state==3 and spawnTable[i].dead~=true then
                        transition.to(spawnTable[i], {time=300,alpha=0})
                      end                                     
                      
                      if spawnTable[i].isLeft==true or spawnTable[i].isBottomLeft==true then
                        temp=spawnTable[i].x
                        if state ==1 or state == 3 then
                          transition.to(spawnTable[i], {time=2000,x=temp+90})
                        elseif state == 2 then
                          transition.to(spawnTable[i], {time=2000,x=temp-90})
                        end  
                      else
                        temp=spawnTable[i].x
                        if state == 1 or state == 3 then
                          transition.to(spawnTable[i], {time=2000,x=temp-90}) 
                        elseif state == 2 then
                          transition.to(spawnTable[i], {time=2000,x=temp+90}) 
                        end  
                      end 



                 end
                    if state ~= 3 and spawnTable[i]~=0 then
                    if spawnTable[i].isReady==false then
                      spawnTable[i]:removeSelf()
                      spawnTable[i]=0
                    end
                  end

               end
                
          --     if flag~= nil then
               flag:removeEventListener( "tap", gotoPause ) 
            --   end 
               timer.performWithDelay(2000,finalElimination,1)
               return
             end
            spawnTable[i]:removeEventListener("touch",objTouch)
            spawnTable[i]:removeSelf()
            spawnTable[i]=0
          end            
        end
      end 
    end
  end
end  



local function delayScale(self)
         transition.to(self,{time=timeVar*(.5),xScale=1,yScale=1})
end  

local function spawn(params)
  local object = display.newRoundedRect(0,0,80,60,3)
   -- local object = display.newRect(0,0,80,60)
            object.anchorY=0.5
            object.anchorX=0.5
             object.isBodyActive = true
    object.objTable = params.objTable   --Set the objects table to a table passed in by parameters
    object.index = #object.objTable + 1    --Automatically set the table index to be inserted into the next available table index
    object.myName = "Object: " .. object.index  --Give the object a custom name
    object.isLeft=params.isLeft
    object.isBottomLeft=params.isBottomLeft
    object.type=params.type
   -- print("created" .. object.myName)
  if state==1 then
    if object.isLeft==false then
    object.x=0+40
    object.y=heightModeLow
    object.isTop=false
    elseif object.isLeft==true then
    object.x=_W-40
    object.y=heightModeTop
    object.isTop=true
    end
  elseif state==2 then
    if object.isLeft==false then
    object.x=_W-40
    object.y=heightModeLow
    object.isTop=false
    elseif object.isLeft==true then
    object.x=0+40
    object.y=heightModeTop
    object.isTop=true
    end
  elseif state==3 then
     if object.isLeft==false then
    object.x=_W/2+40
    object.y=heightModeTop
    object.isTop=true
    elseif object.isLeft==true then
    object.x=_W/2-40
    object.y=heightModeTop
    object.isTop=true
    elseif object.isBottomLeft==false then
    object.x=_W/2+40
    object.y=heightModeLow
    object.isTop=false
    elseif object.isBottomLeft==true then
    object.x=_W/2-40
    object.y=heightModeLow
    object.isTop=false
    end
  end 

    if params.type=="white" then
        object:setFillColor(w1,w2,w3)
     
    elseif params.type=="black" then
       object:setFillColor(k1,k2,k3)
         
    --   object.strokeWidth=1
    --  object:setStrokeColor(1,1,1) 
  
    elseif params.type=="red" then
         object:setFillColor(r1,r2,r3)
    elseif params.type=="orange" then
       object:setFillColor(o1,o2,o3)
    elseif params.type=="yellow" then
         object:setFillColor(y1,y2,y3)
    elseif params.type=="green" then
       object:setFillColor(g1,g2,g3)
    elseif params.type=="blue" then
       object:setFillColor(b1,b2,b3)
    end
      object.touch=objTouch
      object:addEventListener("touch",object)
      --object:addEventListener("enterFrame", moveObject)
      object.objTable[object.index] = object --Insert the object into the table at the specified index
       object:scale(0,0)

     --new pallets are being scaled to full size as they appear

    if state==1 or state==2 then

      if object.index==1 or object.index==2 then
         object.isReady=false
         transition.to(object,{time=timeVar*(.5),xScale=.01,yScale=.01,onComplete=delayScale})
      else      
        object.isReady=false
        transition.to(object,{time=timeVar*(.5),xScale=.01,yScale=.01,onComplete=delayScale})  
        if spawnTable[object.index-2]~=0 then
        spawnTable[object.index-2]:toFront()
        end
      end  

    elseif state==3 then

      if object.index==1 or object.index==2 or object.index==3 or object.index==4 then
         object.isReady=false
         transition.to(object,{time=timeVar*(.5),xScale=.01,yScale=.01,onComplete=delayScale})           
      else     
        object.isReady=false 
         transition.to(object,{time=timeVar*(.5),xScale=.01,yScale=.01,onComplete=delayScale})  
       if spawnTable[object.index-4]~=0 then
        spawnTable[object.index-4]:toFront()
       end 
      end  
    end 
     paceRect.isReady=true

    return object
end




local function createObject (e)

          local e = math.random(7) 
          if e==1 then
            local spawns = spawn({ objTable = spawnTable, type="white", group = localGroup, isLeft=false   })
          elseif e==2 then
            local spawns = spawn({ objTable = spawnTable, type="black", group = localGroup, isLeft=false  }) 
          elseif e==3 then
            local spawns = spawn({ objTable = spawnTable, type="red", group = localGroup, isLeft=false })
          elseif e==4 then
            local spawns = spawn({ objTable = spawnTable, type="orange", group = localGroup, isLeft=false })
          elseif e==5 then
            local spawns = spawn({ objTable = spawnTable, type="yellow", group = localGroup, isLeft=false })
          elseif e==6 then
            local spawns = spawn({ objTable = spawnTable, type="green", group = localGroup, isLeft=false })         
          elseif e==7 then
            local spawns = spawn({ objTable = spawnTable, type="blue", group = localGroup, isLeft=false })  
          end
      
          local f = math.random(7)  
          if f==1 then
            local spawns = spawn({ objTable = spawnTable, type="white", group = localGroup,isLeft=true  })
          elseif f==2 then
            local spawns = spawn({ objTable = spawnTable, type="black", group = localGroup,isLeft=true  }) 
          elseif f==3 then
            local spawns = spawn({ objTable = spawnTable, type="red", group = localGroup,isLeft=true  })
          elseif f==4 then
            local spawns = spawn({ objTable = spawnTable, type="orange", group = localGroup,isLeft=true  })
          elseif f==5 then
            local spawns = spawn({ objTable = spawnTable, type="yellow", group = localGroup,isLeft=true  })
          elseif f==6 then
            local spawns = spawn({ objTable = spawnTable, type="green", group = localGroup,isLeft=true  })         
          elseif f==7 then
            local spawns = spawn({ objTable = spawnTable, type="blue", group = localGroup,isLeft=true  })  
          end
           if state==3 then
            local g = math.random(7) 
            if g==1 then
              local spawns = spawn({ objTable = spawnTable, type="white", group = localGroup, isBottomLeft=false   })
            elseif g==2 then
              local spawns = spawn({ objTable = spawnTable, type="black", group = localGroup, isBottomLeft=false  }) 
            elseif g==3 then
              local spawns = spawn({ objTable = spawnTable, type="red", group = localGroup, isBottomLeft=false })
            elseif g==4 then
              local spawns = spawn({ objTable = spawnTable, type="orange", group = localGroup, isBottomLeft=false })
            elseif g==5 then
              local spawns = spawn({ objTable = spawnTable, type="yellow", group = localGroup, isBottomLeft=false })
            elseif g==6 then
              local spawns = spawn({ objTable = spawnTable, type="green", group = localGroup, isBottomLeft=false })         
            elseif g==7 then
              local spawns = spawn({ objTable = spawnTable, type="blue", group = localGroup, isBottomLeft=false })  
            end
      
            local h = math.random(7)  
            if h==1 then
              local spawns = spawn({ objTable = spawnTable, type="white", group = localGroup,isBottomLeft=true  })
            elseif h==2 then
              local spawns = spawn({ objTable = spawnTable, type="black", group = localGroup,isBottomLeft=true  }) 
            elseif h==3 then
              local spawns = spawn({ objTable = spawnTable, type="red", group = localGroup,isBottomLeft=true  })
            elseif h==4 then
              local spawns = spawn({ objTable = spawnTable, type="orange", group = localGroup,isBottomLeft=true  })
            elseif h==5 then
              local spawns = spawn({ objTable = spawnTable, type="yellow", group = localGroup,isBottomLeft=true  })
            elseif h==6 then
              local spawns = spawn({ objTable = spawnTable, type="green", group = localGroup,isBottomLeft=true  })         
            elseif h==7 then
              local spawns = spawn({ objTable = spawnTable, type="blue", group = localGroup,isBottomLeft=true  })  
            end
          end
end

















    
local function finishScale()
    --topBar = display.newImage("images/sidebar.png", 580, 150)
    topBar = display.newSprite(topBtmBarSheet, topBtmBarSeq)
            topBar:setSequence("top")
            topBar:play()
            topBar:setFillColor(0,0,0)
            topBar.yScale=-1
            topBar.anchorY=0.5
            topBar.anchorX=0.5
            topBar.x=_W/2
            topBar.y=heightModeTop
            topBar.yScale=-0.01
            topBar.alpha=0
            topBar:toFront()
            topBar1=transition.to(topBar,{time=1300, yScale=-.8})       
            topBar2=transition.to(topBar,{time=1300, alpha=.72})
    lowBar = display.newSprite(topBtmBarSheet, topBtmBarSeq)
            lowBar:setSequence("btm")
            lowBar:play()
            lowBar:setFillColor(0,0,0)
            lowBar.anchorY=0.5
            lowBar.anchorX=0.5
            lowBar.x=_W/2
            lowBar.y=heightModeLow
            lowBar.yScale=0.01
            lowBar.alpha=0
            topBar:toFront()
            lowBar1=transition.to(lowBar,{time=1300, yScale=0.8})          
            lowBar2=transition.to(lowBar,{time=1300,alpha=.72}) 
            flag2Timer=transition.to( flag, { time=1000, xScale=1, yScale=1})
      --      if state ~= 3 then
              timerSpeed=timer.performWithDelay(9500,speedUp,1)
         --   else
       --       timerSpeed=timer.performWithDelay(3000,speedUp,2)
           -- end  
end

          


local function setFlag()
   setTheFlag=true
  end


local function delayPace()
     paceRect.isReady=true
     --print(levels[idx].speed)
   --  if gotoDeath==false then
       if speedText~=0 and speedText~=nil then
        --display.remove(speedText)
      -- speedText:removeSelf()
      -- speedtext=nil
        speedText:Text(speed)
        speedText:ToFront()
    end  
end    


local function nextMove()

              pointAnimation:pause()
              pointAnimation:toBack()
end


local function pract2()
flag:toFront()
paceRect.isReady=true
end



function scene:testF()
 if #spawnTable >0 then
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 then
        if spawnTable[i].isTop ==true then
          spawnTable[i].y=heightModeTop
        else
          spawnTable[i].y=heightModeLow
        end
      end
    end  
  end  
end


function returnFunction()
      Runtime:addEventListener("enterFrame", moveObject)  
       flag:addEventListener( "tap", gotoPause ) 


--flag:toFront()
  --flag:addEventListener("tap",gotoPause)
--if piece ~= nil then
--piece:toFront()
--end
--==background:toBack()


 if #spawnTable >0 then
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 then
        if spawnTable[i].pauseIt~= true then
          transition.resume(spawnTable[i])
         end 
        spawnTable[i]:toFront() 
        spawnTable[i].isBodyActive=true
     -- spawnTable[i]:removeEventListener("touch",objTouch)
      end

    end  
  end  

      Runtime:addEventListener("enterFrame", killObject)
      isPausing=false  
      if setTimer ~= nil then
      timer.resume(setTimer) 
      end 
     -- if topBar1~=nil then
       transition.resume(topBar1) 
       transition.resume(lowBar1)    
    --  end  
     -- if topBar2~= nil then
        transition.resume(topBar2) 
        transition.resume(lowBar2)  
    --  end      


          if sideTimer~=nil then
           timer.resume(sideTimer)
         end
     transition.resume(pieceTimer)
     transition.resume(mapTimer)
     transition.resume(flagTimer)
     transition.resume(paceTimer)
      transition.resume(killLowTimer)
     transition.resume(killTopTImer)



    if killBarsTimer~=nil then
    timer.resume(killBarsTimer)
  end
  if resetTimer~= nil then
    timer.resume(resetTimer)
  end
    transition.resume(flag3Timer)   
    if newFlagTimer ~=nil then
    timer.resume(newFlagTimer)
  end


     if timerSpeed~= nil then
     timer.resume(timerSpeed)
   end
     transition.resume(flag2Timer)     
            -- Runtime:addEventListener("enterFrame", readyObject)  
     timer.performWithDelay(6000, pract2(),1)
     paceRect:toFront()
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

local function countries(test)
        -- TESTING FOR SAM
        info="images/infoBrazil.png"
        music="music/brazil.mid"  
        country="    BRAZIL,\nSouth America"   
        flag=display.newSprite(nationalFlags1Sheet,nationalFlagsSeq, 100, 10)
        audio.stop( bobby )
        music = audio.loadStream( 'anthems/canada.mp3' )
        bobby = audio.play(music,{loops=-1})
            
        -- Set e here to pick a specific flag to go to. Otherwise, e=random
        e=9
        
        if e==1 then
            -- flag = display.newImageRect( "images/andorra.png", 200,100)
            -- flag = display.newSprite( nationalFlagsSheet , {frames={nationalFlags1Coords:getFrameIndex("andorra")}} )

            country="Andorra"
            flag:setSequence("andorra")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ryb"
            flag.x=_W/2 ;flag.y=_H/2
            r1=208/255;
            r2=16/255;
            r3=58/255;
            
            y1=254/255;
            y2=223/255;
            y3=0/255
            
            b1=0/255;
            b2=24/255;
            b3=168/255;
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/andorra.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Argentina
        elseif e==2 then
            country="Argentina"
            flag:setSequence("argentina")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            w1=255/255
            w2=255/255
            w3=255/255

            b1=116/255
            b2=172/225
            b3=223/225

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/argentina.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Australia
        elseif e==3 then
            country="Australia"
            flag:setSequence("australia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=255/255
            r2=0/255
            r3=0/255
            
            b1=0/255
            b2=04/255
            b3=139/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/australia.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Austria
        elseif e==4 then
            country="Austria"
            flag:setSequence("austria")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=237/255
            r2=41/255
            r3=57/255

            w1=255/255
            w2=255/255
            w3=255/255     

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/austria.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Belgium
        elseif e==5 then
            country="Belgium"
            flag:setSequence("belgium")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ryk"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=237/255
            r2=41/255
            r3=57/255

            y1=250/255
            y2=224/255
            y3=66/255

            k1=0/255
            k2=0/255
            k3=0/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/belgium.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Brazil
        elseif e==6 then
            country="Brazil"
            flag:setSequence("brazil")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ygbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            y1=254/255
            y2=233/255
            y3=0/255

            g1=0/255
            g2=155/255
            g3=58/255

            b1=0/255
            b2=39/255
            b3=118/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            -- end

            -- if check.. when first flag appear. there will be no music. !!!
            audio.stop( bobby )
            music = audio.loadStream( 'anthems/brazil.mp3' )
            bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Canada
        elseif e==7 then
            country="Canada"
            flag:setSequence("canada")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2

            r1=255/255
            r2=0/255
            r3=0/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/canada.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Chile
        elseif e==8 then
            country="Chile"
            flag:setSequence("chile")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2; flag.y=_H/2 
            r1=213/255
            r2=43/255
            r3=30/255

            b1=0/255
            b2=57/255
            b3=166/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/chile.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- China
        elseif e==9 then
            country="China"
            flag:setSequence("china")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ry"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=213/255
            r2=43/255
            r3=30/255
            
            y1=255/255
            y2=222/255
            y3=0/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            -- audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/china.mp3' )
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)

        -- Croatia
        elseif e==10 then        
            country="Croatia"
            flag:setSequence("croatia") 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=255/255
            r2=0/255
            r3=0/255

            b1=23/255
            b2=23/255
            b3=150/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/croatia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

            -- Cypress
            elseif e==11 then        
                country="Cypress"
            flag:setSequence("cypress")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ogw"
            flag.x=_W/2 ;flag.y=_H/2
            
            o1=216
            o2=217
            o3=3

            g1=47
            g2=71
            g3=18

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/cypress.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Czech Republic
        elseif e==12 then        
            country="Czech Republic"
            flag:setSequence("czech_republic")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            b1=17/255
            b2=69/255
            b3=126/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/czech_republic.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Denmark
        elseif e==13 then        
            country="Denmark"
            flag:setSequence("denmark")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=215/255
            r2=20/255
            r3=26/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/denmark.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Egypt
        elseif e==14 then        
            country="Egypt"
            flag:setSequence("egypt")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=206/255
            r2=17/255
            r3=38/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/egypt.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Estonia
        elseif e==15 then        
            country="Estonia"
            flag:setSequence("estonia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            b1=72/255
            b2=145/255
            b3=217/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/estonia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Finland
        elseif e==16 then        
            country="Finland"
            flag:setSequence("finland")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            b1=0/255
            b2=53/255
            b3=128/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/finland.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

            -- France
        elseif e==18 then        
            country="France"
            flag:setSequence("france")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2

            r1=237/255
            r2=41/255
            r3=57/255

            b1=0/255
            b2=35/255
            b3=149/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/france.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Germany
        elseif e==19 then   
            country="Germany"
            flag:setSequence("germany") 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ryk"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=221/255
            r2=0/255
            r3=0/255

            y1=255/255
            y2=206/255
            y3=0/255

            k1=0/255
            k2=0/255
            k3=0/255

            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/germany.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Greece
        elseif e==20 then        
            country="Greece"
            flag:setSequence("greece")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            b1=13/255
            b2=94/255
            b3=175/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/greece.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Hungary
        elseif e==21 then        
            country="Hungary"
            flag:setSequence("hungary")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rgw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=205/255
            r2=42/255
            r3=62/255

            y1=67/255
            y2=111/255
            y3=77/255

            w1=255/255
            w2=255/255
            w3=255/255

            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/Brazil.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Iceland
        elseif e==22 then        
            country="Iceland"
            flag:setSequence("iceland") 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=215/255
            r2=40/255
            r3=40/255

            b1=0/255
            b2=56/255
            b3=151/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/iceland.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- India
        elseif e==23 then        
            country="India"
            flag:setSequence("india")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ogbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            o1=255/255
            o2=153/255
            o3=51/255

            g1=18/255
            g2=136/255
            g3=7/255

            b1=0/255
            b2=0/255
            b3=0/255

            w1=255/255
            w2=255/255
            w3=255/255
 
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/india.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Indonesia
        elseif e==24 then        
            country="Indonesia"
            flag:setSequence("indonesia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
           
            r1=206/255
            r2=17/255
            r3=38/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/indonesia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Ireland
        elseif e==25 then        
            country="Ireland"
            flag:setSequence("ireland")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ogw"
            flag.x=_W/2 ;flag.y=_H/2
            
            o1=255/255
            o2=121/255
            o3=0/255

            g1=0/255
            g2=155/255
            g3=72/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/ireland.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Isreal
        elseif e==26 then        
            country="Isreal"
            flag:setSequence("isreal")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            b1=0/255
            b2=56/255
            b3=184/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/israel.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Italy
        elseif e==27 then        
            country="Italy"
            flag:setSequence("italy")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rgw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=206/255
            r2=43/255
            r3=55/255
           
            g1=0/255
            g2=146/255
            g3=70/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/italy.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Japan
        elseif e==28 then        
            country="Japan"
            flag:setSequence("japan")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=188/255
            r2=0/255
            r3=45/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/japan.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Lithuania
        elseif e==29 then        
            country="Lithuania"
            flag:setSequence("lithuania")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ryg"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=139/255
            r2=39/255
            r3=45/255

            y1=253/255
            y2=185/255
            y3=19/255

            g1=0/255
            g2=106/255
            g3=68/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/lithuania.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Luxembourg
        elseif e==30 then        
            country="Luxembourg"
            flag:setSequence("luxembourg")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=237/255
            r2=41/255
            r3=57/255

            b1=0/255
            b2=161/255
            b3=222/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/luxembourg.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Malaysia
        elseif e==31 then        
            country="Malaysia"
            flag:setSequence("malaysia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rybw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=204/255
            r2=0/255
            r3=1/255

            y1=255/255
            y2=204/255
            y3=0/255

            b1=1/255
            b2=0/255
            b3=102/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/malaysia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Malta
        elseif e==32 then        
            country="Malta"
            flag:setSequence("malta")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=207/255
            r2=20/255
            r3=43/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/malta.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Mexico
        elseif e==33 then        
            country="Mexico"
            flag:setSequence("mexico")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rgw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=206/255
            r2=17/255
            r3=38/255

            g1=0/255
            g2=104/255
            g3=71/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/mexico.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Netherland
        elseif e==34 then        
            country="Netherland"
            flag:setSequence("netherland")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=174/255
            r2=28/255
            r3=40/255

            b1=33/255
            b2=70/255
            b3=139/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/netherland.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- New Zealand
        elseif e==35 then        
            country="New Zealand"
            flag:setSequence("new_zealand")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=204/255
            r2=20/255
            r3=43/255

            b1=0/255
            b2=36/255
            b3=125/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/new_zealand.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Norway
        elseif e==36 then        
            country="Norway"
            flag:setSequence("norway")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=239/255
            r2=43/255
            r3=45/255

            b1=0/255
            b2=40/255
            b3=104/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/norway.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Philippines
        elseif e==37 then        
            country="Philippines"
            flag:setSequence("philippines")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rybw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=206/255
            r2=17/255
            r3=38/255

            y1=252/255
            y2=209/255
            y3=22/255

            b1=0/255
            b2=56/255
            b3=168/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/philippines.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Poland
        elseif e==38 then        
            country="Poland"
            flag:setSequence("poland") 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=220/255
            r2=20/255
            r3=60/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/poland.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Portugal
        elseif e==39 then        
            country="Portugal"
            flag:setSequence("portugal")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rg"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=255/255
            r2=0/255
            r3=0/255
            
            g1=0/255
            g2=102/255
            g3=0/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/portugal.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Russia
        elseif e==40 then        
            country="Russia"
            flag:setSequence("russia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
           
            r1=213/255
            r2=43/255
            r3=30/255
            
            b1=0/255
            b2=57/255
            b3=166/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/russia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- San Marino
        elseif e==41 then        
            country="San Marino"
            flag:setSequence("san_marino") 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="bw"
            flag.x=_W/2 ;flag.y=_H/2
            
            b1=94/255
            b2=182/255
            b3=228/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/san_marino.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Singapore
        elseif e==42 then        
            country="Singapore"
            flag:setSequence("singapore")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2

            w1=237/255
            w2=41/255
            w3=57/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/singapore.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Slovakia
        elseif e==43 then        
            country="Slovakia"
            flag:setSequence("slovakia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=238/255
            r2=28/255
            r3=37/255
            
            b1=11/255
            b2=78/255
            b3=162/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/slovakia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Slovenia
        elseif e==44 then        
            country="Slovenia"
            flag:setSequence("slovenia")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=237/255
            r2=28/255
            r3=36/255
            
            b1=0/255
            b2=93/255
            b3=164/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/slovenia.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- South Africa
        elseif e==45 then        
            country="South Africa"
            flag:setSequence("south_africa")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rygbwk"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=222/255
            r2=56/255
            r3=49/255

            y1=255/255
            y2=182/255
            y3=18/255
            
            g1=0/255
            g2=122/255
            g3=77/255

            b1=0/255
            b2=35/255
            b3=149/255

            w1=255/255
            w2=255/255
            w3=255/255

            k1=0/255
            k2=0/255
            k3=0/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/south_africa.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- South Korea
        elseif e==46 then        
            country="South Korea"
            flag:setSequence("south_korea")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbwk"
            flag.x=_W/2 ;flag.y=_H/2
            
           r1=198/255
           r2=12/255
           r3=48/255

           b1=0/255
           b2=52/255
           b3=120/255
           
           w1=255/255
           w2=255/255
           w3=255/255
           
           k1=0/255
           k2=0/255
           k3=0/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/south_korea.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Spain
        elseif e==47 then        
            country="Spain"
            flag:setSequence("spain")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="ry"
            flag.x=_W/2 ;flag.y=_H/2

            r1=198/255
            r2=11/255
            r3=30/255

            y1=255/255
            y2=196/255
            y3=0/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/spain.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Sri Lanka
        elseif e==48 then        
            country="Sri Lanka"
            flag:setSequence("sri_lanka")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="royg"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=141/255
            r2=32/255
            r3=41/255

            o1=255/255
            o2=91/255
            o3=0/255

            y1=255/255
            y2=183/255
            y3=0/255
            
            g1=0/255
            g2=86/255
            g3=65/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/sri_lanka.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Sweden
        elseif e==49 then        
            country="Sweden"
            flag:setSequence("sweden")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="yb"
            flag.x=_W/2 ;flag.y=_H/2
            
            y1=255/255
            y2=183/255
            y3=0/255
            
            b1=0/255
            b2=106/255
            b3=167/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/sweden.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Switzerland
        elseif e==50 then        
            country="Switzerland"
            flag:setSequence("switzerland")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=213/255
            r2=43/255
            r3=30/255

            w1=255/255
            w2=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/switzerland.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Taiwan (Republic of China)
        elseif e==51 then        
            country="Taiwan"
            flag:setSequence("taiwan")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=254/255
            r2=0/255
            r3=0/255

            b1=0/255
            b2=0/255
            b3=149/255
            
            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/taiwan.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Thailand
        elseif e==52 then        
            country="Thailand"
            flag:setSequence("thailand")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=237/255
            r2=28/255
            r3=36/255

            b1=36/255
            b2=29/255
            b3=79/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/thailand.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- Turkey
        elseif e==53 then        
            country="Turkey"
            flag:setSequence("turkey")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=227/255
            r2=10/255
            r3=23/255
            
            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/turkey.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- United Arab Emirates
        elseif e==54 then        
            country="United Arab Emirates"
            flag:setSequence("united_arab_emirates")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rgwk"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=255/255
            r2=0/255
            r3=0/255

            g1=0/255
            g2=115/255
            g3=47/255

            w1=255/255
            w2=255/255
            w3=255/255

            k1=0/255
            k2=0/255
            k3=0/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/united_arab_emirates.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- United Kingdom
        elseif e==55 then        
            country="United Kingdom"
            flag:setSequence("united_kingdom")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=207/255
            r2=20/255
            r3=43/255

            b1=0/255
            b2=36/255
            b3=125/255

            w1=255/255
            w2=255/255
            w3=255/255
            
            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/united_kingdom.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              

        -- United States
        elseif e==56 then        
            country="United States"
            flag:setSequence("united_states")
            flag.anchorX=0.5
            flag.anchorY=0.5
            code="rbw"
            flag.x=_W/2 ;flag.y=_H/2
            
            r1=178/255
            r2=34/255
            r3=52/255

            b1=60/255
            b2=59/255
            b3=110/255

            w1=255/255
            w2=255/255
            w3=255/255

            xCoord=350
            yCoord=442
            -- if music == nil and soundOn==true then
            --   music="anthems/Brazil.mp3"
            --   audio.play(music, {loops = -1})
            --   end

            -- if check.. when first flag appear. there will be no music. !!!
            --   audio.stop( bobby )
            -- music = audio.loadStream( 'anthems/united_states.mp3' ) 
            -- bobby = audio.play(music,{loops=-1})
            piece = display.newImage( "images/andorra104x102.png", 529,229)              
        end

        flag.width=200
        flag.height=100
end

local function newFlag() 
            music=nil
            if deadText~=nil then
            display.remove(deadText)
              if bonusText ~= nil then
               bonusText:Remove()
               bonusText=nil
               spread=1
               prevState=nil
               currState=nil
              end
          end
            lastRoll=e
            while thisRoll==lastRoll do

               -- e = math.random(1,5)

                e = math.random(1,56)
                thisRoll=e
            end

          countries(1)

          if infoMode == true then
            infoPic = display.newImage(info,165,77)
            infoPic.x = _W/6
            infoPic.y = _H/2
            infoPic.alpha=0   
            timer.performWithDelay(2000,infoAppear,1 )        
          end  

          countryText = display.newText(country, _W/2, _H/2, native.systemFont, 50)
          countryText.anchorX=0.5
          countryText.anchorY=0.5
          countryText:setFillColor( 0, 0, 0 )
          countryText:toFront()
   
         timer.performWithDelay(2000,countryScale,1)


          piece.x=-xCoord+_W/2+map.x
          piece.y=-yCoord+_H/2+map.y
          piece.alpha=1

          flag.alpha=1

           --delay start of color squares
          flag:scale(0,0)



          if state==3 then
          sideTimer=timer.performWithDelay(1500,finishScale,1)

          pieceTimer=transition.to( piece, { time=2000, x=_W/2, y=_H/2 }) 
          mapTimer=transition.to( map, { time=2000, x=xCoord, y=yCoord })                     
          flagTimer=transition.to( flag, { time=2000, xScale=.2, yScale=.2})  
          paceTimer=timer.performWithDelay(0,delayPace,1)       
          else

          sideTimer=timer.performWithDelay(1500,finishScale,1)
          pieceTimer=transition.to( piece, { time=1500, x=_W/2, y=_H/2 }) 
          mapTimer=transition.to( map, { time=1500, x=xCoord, y=yCoord })                     
          flagTimer=transition.to( flag, { time=1500, xScale=.2, yScale=.2})  
          paceTimer=timer.performWithDelay(900,delayPace,1)         
          end  
          flag:toFront()
       --   flag:addEventListener( "tap", gotoPause )           
end    


local function killBars()

killLowTimer=transition.to( lowBar, { time=800, y=_H, alpha=0 })
 killTopTimer=transition.to( topBar, { time=800, y=0 , alpha=0})
--transition.to( topBar, { time=400, alpha=0 })
      
end

local function killPiece()
          --      if piece~=nil then
            piece:removeSelf()
            piece=nil

end
local function removeFlag()
                flag:removeSelf()
              flag  = nil
     
  end            



local function readyObject (e)
if paceRect.x>85 then
  paceRect.x=0
  paceRect.isReady=false
  if setTheFlag==true and isPausing==false then     --START A NEW FLAG
  transition.to( piece, { time=490, alpha=0,onComplete=killPiece})
    setTheFlag=false
    paceRect.isReady=false
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 then
        spawnTable[i].win=true
        transition.to( spawnTable[i], { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff   }) 

      end
    end
    killBarsTimer=timer.performWithDelay(500,killBars)
    resetTimer=timer.performWithDelay(540,resetSpawn)
  
    if infoMode == true then
     infoTimer=transition.to(infoPic, {time=500, alpha=0}) 
    end

    flag3Timer=transition.to( flag, { time=500, alpha=0, onComplete=removeFlag   })    --remove flag
    newFlagTimer=timer.performWithDelay(600,newFlag)


          
  else                      --CREATE A NEW COLOR SQUARE
    createObject()
    if firstObject==true then
      firstObject=false  
    elseif firstObject==false then
      if state==1 or state ==2 then
        if spawnTable[count]~=0 then 
          spawnTable[count].isReady=true  
        end
        if spawnTable[count+1]~=0 then
        spawnTable[count+1].isReady=true  
        end
        count=count+2
      end
      if state==3 then
        if spawnTable[count]~=0 then
          spawnTable[count].isReady=true
        end
        if spawnTable[count+1]~=0 then
          spawnTable[count+1].isReady=true
        end
        if spawnTable[count+2]~=0 then
          spawnTable[count+2].isReady=true
        end
        if spawnTable[count+3]~=0 then
          spawnTable[count+3].isReady=true
        end
        count=count+4
      end
    end
  end
end
end    





local function setupVariables()
      w1=1;w2=1;w3=1
      k1=0;k2=0;k3=0
      r1=1;r2=0;r3=0
      o1=1;o2=.502;o3=0
      y1=1;y2=1;y3=0
      g1=0;g2=.4;g3=0
      b1=0;b2=0;b3=1 

     

      map = display.newImage( "images/alpha2048_1.png", 2048,1038)
      map.anchorX=0.5
      map.anchorY=0.5
      map.name="map"
      map.x=0 ;map.y=0;


   levels = {
               { speed=1, timeVar=2550},{ speed=1.5, timeVar=1700},{ speed=2, timeVar=1250},{ speed=2.5, timeVar=1000},{ speed=3, timeVar=910},{ speed=3.5, timeVar=750},
               { speed=4, timeVar=700},{ speed=4.5, timeVar=600},{ speed=5, timeVar=550},{ speed=5.5, timeVar=450},{ speed=6, timeVar=420},{ speed=6.5, timeVar=400},
               { speed=7, timeVar=380},{ speed=7.5, timeVar=365},{ speed=8, timeVar=345},{ speed=8.5, timeVar=335},{ speed=9, timeVar=305},{ speed=9.5, timeVar=280},
               { speed=10, timeVar=260},{ speed=10.5, timeVar=240},{ speed=11, timeVar=220},{ speed=11.5, timeVar=200},{ speed=12, timeVar=190},{ speed=12.5, timeVar=185},
               { speed=13, timeVar=175},{ speed=13.5, timeVar=170},{ speed=14, timeVar=170},{ speed=14.5, timeVar=165},{ speed=15, timeVar=165},{ speed=15.5, timeVar=160},
               { speed=16, timeVar=155},{ speed=16.5, timeVar=155},{ speed=17, timeVar=150},{ speed=17.5, timeVar=145},{ speed=18, timeVar=145},{ speed=19, timeVar=140},
               { speed=20, timeVar=135},{ speed=21, timeVar=125},{ speed=22, timeVar=120},{ speed=23, timeVar=110}}          




end


local function removeFinal(x)

       --  display.remove(x)
          x:removeSelf()
         spawnTable[x.index]=0
           x:removeEventListener("touch",objTouch)
      


end

local bonusTimer
local eventTimer
local t = {}
function t:timer( event )
   local count = event.count
   if count ~= 9 then
        bonusShatter.x = bonusShatter.x-50
   else
       bonusShatter.alpha = 0
       --bonusShatter:pause()
       timer.cancel(event.source)
   end
end

local function cancelTimerBonusImplode()
    bonusImplode.alpha=0
    bonusImplode:pause()
end


function objTouch(self,e)
if e.phase=="began" and e.target.isBodyActive==true then
-- animatePaletteDestroy(spawnTable[self.index].x, spawnTable[self.index].y, spawnTable[self.index].isLeft)

            if lookupCode(code,e.target)==0 then   --You are Dead
              
              if bonusText ~= nil then
                  bonusText:Remove()
                  bonusText=nil
              end
              
              if deadText==nil then
                deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
                deadText:setFillColor( 1, 0, 0 )
              end       
              if gotoDeath==true then
              thatsIt=true
              self:toFront()  
              self.isBodyActive=false
              self:removeEventListener("touch",objTouch)
              
              -- Death Palette Animation
              for i = 1, #spawnTable do
                if spawnTable[i]~=0 then
                spawnTable[i].isBodyActive=false
               -- spawnTable[i]:removeEventListener("enterFrame", moveObject)
                end
                if spawnTable[i]~=0 and spawnTable[i]~=e.target then
        
                spawnTable[i]:removeEventListener("touch",objTouch)
                transition.to( spawnTable[i], { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff   }) 
                end
              end
              numDeaths=1
              transition.to( e.target, { time=700, rotation=400, x=_W/2, y=_H/2, xScale=8, yScale=8, onComplete=dieNow    })
              Runtime:removeEventListener("enterFrame", killObject)
  
              Runtime:removeEventListener("enterFrame", readyObject)
                flag:removeEventListener( "tap", gotoPause ) 
              return
              end
             if e.target.win==true then   --if canceled
              transition.cancel( self )
              transition.to( e.target, { time=500, rotation=400, xScale=5, yScale=5, onComplete=removeFinal    }) 
            else                           --not cancelled
              transition.to( e.target, { time=500, rotation=400, xScale=5, yScale=5, onComplete=removeStuff    })
              end 
              e.target.isBodyActive=false

            else      --You are Alive
               e.target.isBodyActive=false
              if e.target.win==true then 
                e.target:removeSelf()
                spawnTable[e.target.index]=0          
              else      
                  if self.x < 1 or self.x > _W-1 then
                 transition.to( e.target, { time=100, rotation=0, xScale=0.01, yScale=0.01, onComplete=removeStuff  }) 
       
        
                   else
                   transition.to( e.target, { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff  })    
                   end
              end     
              currState=e.target.type
              --bonus score
            if currState==prevState then
               spread=spread+1
               if bonusText ~= nil then
                 bonusText:Remove()
                   bonusText=nil
               end

               text="+"..spread

               bonusText = CreateText.new( text, "Arial Rounded MT Bold", 30, _W*(4/5), _H*(1/3) )
               print("Spread =" .. spread)
               if motion~=nil then
                 timer.cancel(motion)
                 motion=nil
               end
               if spread==2 then
                      bonusImplode:setSequence("2x")
               elseif spread==3 then
                      bonusImplode:setSequence("3x")
               elseif spread==4 then
                      bonusImplode:setSequence("4x")
               elseif spread==5 then
                      bonusImplode:setSequence("5x")
               elseif spread==6 then
                      bonusImplode:setSequence("6x")
               elseif spread==7 then
                      bonusImplode:setSequence("7x")
               elseif spread==8 then
                      bonusImplode:setSequence("8x")
               elseif spread==9 then
                      bonusImplode:setSequence("9x")                       
               end 
               bonusImplode.alpha=1
               bonusImplode:toFront()
               bonusImplode:play()
               
               --bonusImplode.anchorX = 0 
               bonusImplode.x = _W*(4/5)
               bonusImplode.y = _H/2
               --[[ 
               if eventTimer~=nil then   
                   --print("cancel bonus timer")
                   timer.cancel(eventTimer)
               end
               eventTimer = timer.performWithDelay(100, t, 0)
               ]]--
               motion= timer.performWithDelay(800,cancelTimerBonusImplode,1)      
            else
              spread=1
              currState=nil
              prevState=nil
              if bonusText~=nil then
                   bonusText:Remove()
                   bonusText=nil
               end
          end
              prevState=e.target.type
              
              scoreText:Text(score+spread) 
                
              score=score+spread

              -- why startScore?
              startScore=score
              --scoreText = display.newText(startScore, _W*(4/5), _H/2, native.systemFont, 28)
              --scoreText:setFillColor( 1, 0, 0 )
          end
      
  end
end

function scene:create(e)
      print("CREATE")


   

     -- self.view:insert(background)
 
    --  self.view:insert(paceRect)   
end

function scene:show(e)
    if (e.phase == "will") then
      print("SHOWWILL")
      setupVariables()
      random = math.randomseed( os.time() )

      paceRect = display.newRect( 0, 0, 80, 60 )
      paceRect:setFillColor( 1,0,0 )
      paceRect.anchorX=0
      paceRect.anchorY=0.5
      paceRect.x=0 ; paceRect.y=_H/2
      paceRect.isLeft=false
      paceRect.isReady=false
      paceRect.alpha=0

   
    self.view:insert(paceRect)



    elseif (e.phase == "did") then
       Runtime:addEventListener("enterFrame", killObject)
       Runtime:addEventListener("enterFrame", moveObject)

       Runtime:addEventListener("enterFrame", readyObject)
       system.activate( "multitouch" )       
       setTimer=timer.performWithDelay(20000, setFlag, 0)
     --  timer.performWithDelay(15000, checkMemory,0)
    
       newFlag()

    end
end

function scene:hide(e)

  print("HIDE")
if e.phase == "will" then


--print(#spawnTable)
display.remove(background)

scoreText:RemoveDisplay()
speedText:RemoveDisplay()

display.remove(flag)
display.remove(deadText)
display.remove(piece)
display.remove(map)
display.remove(topBar)
display.remove(lowBar)
display.remove(infoPic)
if timerSpeed~=nil then
timer.cancel(timerSpeed)
end
--end

--background=removeSelf()
--background=nil


                  Runtime:removeEventListener("enterFrame", killObject)
       Runtime:removeEventListener("enterFrame", moveObject)

       Runtime:removeEventListener("enterFrame", readyObject)


    composer.removeScene("game",false)

  
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
