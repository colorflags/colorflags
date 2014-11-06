local composer = require("composer")

--local storyboard = require( "storyboard" )
local scene = composer.newScene()
--media.playSound('yancy.mp3')
--local physics = require("physics")
--physics.start()
--media.playSound('Brazil.mid')

local _W = display.contentWidth; -- Get the width of the screen
local _H = display.contentHeight; -- Get the height of the screen

local motionx = 0 -- Variable used to move character along x axis
--local speed = 5 --
local speed
local level=0
local localGroup = display.newGroup()
local spawnTable = {}   --Create a table to hold our spawns
local currState="first"
local prevState="first"
local GameOver=0
local deadText=nil

local coin=1
local state=3
local count=1
local firstObject=true
local setTheFlag=false
local xSize=2000
local ySize=1012
local xCoord
local yCoord
local topBar
local lowBar






--      local sky = display.newImage( "images/map2000x880.png", 2000,880)
local sky = display.newImage( "images/alpha2048_1.png", 2048,1038)
      sky.anchorX=0.5
      sky.anchorY=0.5
      sky.name="sky"
      sky.x=_W/2 ;sky.y=_H/2
     -- sky:toBack()

        local score=0
      local startScore="Score:"..score
      local scoreText = display.newText(startScore, _W*(4/5), _H/2, native.systemFont, 28)
      scoreText:setFillColor( 1, 0, 0 )




local bonusSheetData = { width=150,height=100,numFrames=6,sheetContentWidth=900,sheetContentHeight=100}
local bonusSheet=graphics.newImageSheet("images/text_shatter_1.png",bonusSheetData)
local bonusSequence={name="bonusAni", frames={6,6,6,6,5,4,3,2,1},time=700, loopCount=1}
local bonusAnimation=display.newSprite(bonusSheet,bonusSequence)
      bonusAnimation.anchorX=0.5
      bonusAnimation.anchorY=0.5
      bonusAnimation.x=_W/2
      bonusAnimation.y=_H/2
      bonusAnimation:toBack()




 

local pheetData = { width=80, height=60, numFrames=10, sheetContentWidth=800, sheetContentHeight=60 }

-- local mySheet = graphics.newImageSheet( "images/runningcat-full.png", sheetData )

local mySheet = graphics.newImageSheet( "images/chocho4.png", pheetData )

local sequenceData = {
    { name = "normalRun", start=7, count=8, time=800 },
    { name = "fastRun", frames={ 1,2,4,3,5 }, time=250, loopCount = 1 },
    { name = "paletteDestroy1", frames={ 1,3,4,6,8,9,10 }, time=250, loopCount = 1 },
    { name = "paletteDestroy2", frames={ 1,3,4,6,8,9,10 }, time=250, loopCount = 1 },

    { name = "paletteDestroy3", frames={ 2,3,2,5,7,6,3 }, time=250, loopCount = 1 },
    { name = "paletteDestroy4", frames={ 2,3,2,5,7,6,3 }, time=250, loopCount = 1 },

    { name = "paletteDestroy5", frames={ 8,5,4,1,8,7,6 }, time=250, loopCount = 1 },
    { name = "paletteDestroy6", frames={ 8,5,4,1,8,7,6 }, time=250, loopCount = 1 }    
}






local function animatePaletteDestroy (alignX, alignY, type)
    -- local animation = display.newSprite( mySheet, sequenceData )
    -- animation.x = display.contentWidth/2  --center the sprite horizontally
    -- animation.y = display.contentHeight/2  --center the sprite vertically
    local animation = display.newSprite( mySheet, sequenceData )

    print(alignX .. " " .. alignY .. " ")

    if type==true then
        print("shacordova")
        animation.x = alignX --center the sprite horizontally
        animation.y = alignY  --center the sprite vertically
    else
        print("wii wii. shacordova")
        animation.x = alignX  --center the sprite horizontally
        animation.y = alignY  --center the sprite vertically
    end

    callPaletteDestroySeq= "paletteDestroy" .. math.random(1, 6)

    animation:setSequence( callPaletteDestroySeq)
    animation:play()

    local function mySpriteListener( event )

        if ( event.phase == "ended" ) then
            animation:removeSelf()
            animation = nil
        end
    end
    animation:addEventListener( "sprite", mySpriteListener )

end


local function executeRemoveObject(obj)
    obj:removeSelf()
    obj=nil
end

local function bonusTextTracking( event )
    if myText.isLeft==true then
        myText.x=myText.x-speed
    elseif myText.isLeft==false then
        myText.x=myText.x+speed
    end
    -- print(myText.bonusTextDir)
    -- print("SHIIIII")
end

local function animateBonusText (alignX, alignY, type, spread)

    local currentBonus = "X " .. spread
    -- print("accumulateBonus: ", accumulateBonus)

    if type==true then
        myText = display.newText( currentBonus, 100, 200, native.systemFont, 22 )
        myText:setFillColor( 1, 0, 0 )
        myText.isLeft = type

        myText.x = alignX --center the sprite horizontally
        myText.y = alignY  --center the sprite vertically

        Runtime:addEventListener( "enterFrame", bonusTextTracking )

        transition.to(myText,{ time=450, alpha=1,onComplete=
            function()
                Runtime:removeEventListener( "enterFrame", bonusTextTracking )
                executeRemoveObject(myText)
            end
        })
    else
        myText = display.newText( currentBonus, 100, 200, native.systemFont, 22 )
        myText:setFillColor( 1, 0, 0 )
        myText.isLeft = type

        myText.x = alignX  --center the sprite horizontally
        myText.y = alignY  --center the sprite vertically

        Runtime:addEventListener( "enterFrame", bonusTextTracking )

        transition.to(myText,{ time=450, alpha=1,onComplete=
            function()

                -- NOTE: if two bonus are quickly called back to back, errors will occur. Either we need to come up with temporary bonus names: bonus1 bonus2, which will become available to reuse once the bonus is deleted. Or we need a checking protocal, or w/e. 
                Runtime:removeEventListener( "enterFrame", bonusTextTracking )
                executeRemoveObject(myText)
            end
        })       
    end


end



     
--[[
    local mapData = { width=480,height=320,numFrames=10,sheetContentWidth=4800,sheetContentHeight=320}
      local mapSheet=graphics.newImageSheet("images/background.png",mapData)
      local mapSequence={name="normalRun",start=1,count=10,time=1000}
      local mapAnimation=display.newSprite(mapSheet,mapSequence)
            mapAnimation.x=_W/2 mapAnimation.y=_H/2

--]]
      local paceRect = display.newRect( 0, 0, 80, 60 )
      paceRect:setFillColor( 1,0,0 )
      paceRect.anchorX=0
      paceRect.anchorY=0.5
      paceRect.x=0 ; paceRect.y=_H/2
      paceRect.isLeft=false
      paceRect.isReady=false
--paceRect.type="pace"
    paceRect:toBack()



local function moveObject (event)
    -- print(#spawnTable)
if paceRect.isReady==true then    
       paceRect.x=paceRect.x+speed
 end
if state==1 then
  if #spawnTable >0 then
    for i = 1, #spawnTable do
         if spawnTable[i]~=0 and spawnTable[i].isReady==true then
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
         if spawnTable[i]~=0 and spawnTable[i].isReady==true then
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
         if spawnTable[i]~=0 and spawnTable[i].isReady==true then
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

  if code == 1 then
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


local function removeText(text)
  text:removeSelf()
end



local function killObject (e)
  if #spawnTable >0 then
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 then
--        if spawnTable[i].isLeft==true then
          if spawnTable[i].x < -40 or spawnTable[i].x > _W+40 then
            if lookupCode(code,spawnTable[i])==1 then
             --print("dead")
             -- GameOver=1
             if deadText==nil then
             deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
             deadText:setFillColor( 1, 0, 0 )
             end
              --deadText.alpha=1
              --timer.performWithDelay(2000,removeText(deadText),1)
              --   print("killed" .. spawnTable[i].myName) 
            spawnTable[i]:removeEventListener("touch",objTouch)
            spawnTable[i]:removeSelf()
            spawnTable[i]=0

          end            
        end
      end 
    end
  end
end  


local function scaleBox(self)
         transition.to(self,{time=325,xScale=1,yScale=1})
end










local function spawn(params)
  local object = display.newRoundedRect(0,0,80,60,1)
   -- local object = display.newRect(0,0,80,60)
            object.anchorY=0.5
            object.anchorX=0.5
             object.isBodyActive = true
    object.objTable = params.objTable   --Set the objects table to a table passed in by parameters
    object.index = #object.objTable + 1    --Automatically set the table index to be inserted into the next available table index
    object.myName = "Object: " .. object.index  --Give the object a custom name
    object.isLeft=params.isLeft
   -- print("Created" .. object.myName)
    object.isBottomLeft=params.isBottomLeft
    object.type=params.type
    print("created" .. object.myName)
  if state==1 then
    if object.isLeft==false then
    object.x=0+40
    object.y=_H-35
    elseif object.isLeft==true then
    object.x=_W-40
    object.y=35
    end
  elseif state==2 then
    if object.isLeft==false then
    object.x=_W-40
    object.y=_H-35
    elseif object.isLeft==true then
    object.x=0+40
    object.y=35
    end
  elseif state==3 then
     if object.isLeft==false then
    object.x=_W/2+40
    object.y=35
    elseif object.isLeft==true then
    object.x=_W/2-40
    object.y=35
    elseif object.isBottomLeft==false then
    object.x=_W/2+40
    object.y=_H-35
    elseif object.isBottomLeft==true then
    object.x=_W/2-40
    object.y=_H-35 
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
        --object.strokeWidth=1
     --  object:setStrokeColor(0,0,0)  


      object.touch=objTouch
      object:addEventListener("touch",object)
      object.objTable[object.index] = object --Insert the object into the table at the specified index

     -- object:toFront()
       object:scale(0,0)
    --  object.xScale=.01
    --  object.yScale=.01
 
      if object.index==1 then
     -- Runtime:addEventListener("enterFrame", readyObject) 
      end

    if state==1 or state==2 then

      if object.index==1 or object.index==2 then
         object.isReady=false
         transition.to(object,{time=910,xScale=1,yScale=1})
      else      
        object.isReady=false
        transition.to(object,{time=910,xScale=1,yScale=1})
        if spawnTable[object.index-2]~=0 then
        spawnTable[object.index-2]:toFront()
        end
      end  

    elseif state==3 then

      if object.index==1 or object.index==2 or object.index==3 or object.index==4 then
         object.isReady=false
         transition.to(object,{time=910,xScale=1,yScale=1})
      else      
        object.isReady=false
        transition.to(object,{time=910,xScale=1,yScale=1})
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





local function removeStuff(x)
  
     if spawnTable[x.index]~=0 then

          x:removeSelf()
         spawnTable[x.index]=0
               x:removeEventListener("touch",objTouch)
      end   


end







local function finishAlpha()
              transition.to( flag, { time=500, alpha=1 })
             
 end



local function finishScale()
 -- sky:toFront()

 topBar=display.newImage("images/side.png",580,100)
-- topBar = display.newRect(0,0,590,80)
          topBar:setFillColor(0,0,0)
            topBar.yScale=-1
            topBar.anchorY=0.5
            topBar.anchorX=0.5
            topBar.x=_W/2
            topBar.y=37.5
            topBar.yScale=-0.01
            topBar.alpha=0
              transition.to(topBar,{time=1300, yScale=-.8}) 
         --   transition.to(topBar,{time=800, y=80})
              transition.to(topBar,{time=1300, alpha=.6})
--lowBar = display.newRect(0,0,590,80)
 lowBar=display.newImage("images/side.png",580,100)
            lowBar:setFillColor(0,0,0)
            lowBar.anchorY=0.5
            lowBar.anchorX=0.5
            lowBar.x=_W/2
            lowBar.y=_H-37.5
            lowBar.yScale=0.01
            lowBar.alpha=0
            transition.to(lowBar,{time=1300, yScale=0.8}) 
        --   transition.to(lowBar,{time=800, y=_H-80})            
             transition.to(lowBar,{time=1300,alpha=.6}) 


--[[
 topBar=display.newImage("images/side.png",580,100)
-- topBar = display.newRect(0,0,590,80)
          topBar:setFillColor(0,0,0)
            topBar.yScale=-1
            topBar.anchorY=0
            topBar.anchorX=0.5
            topBar.x=_W/2
            topBar.y=0
            topBar.alpha=0
            transition.to(topBar,{time=800, y=80})
            transition.to(topBar,{time=1500, alpha=.7})
--lowBar = display.newRect(0,0,590,80)
 lowBar=display.newImage("images/side.png",580,100)
            lowBar:setFillColor(0,0,0)
            lowBar.anchorY=0
            lowBar.anchorX=0.5
            lowBar.x=_W/2
            lowBar.y=_H
            lowBar.alpha=0
           transition.to(lowBar,{time=800, y=_H-80})            
          transition.to(lowBar,{time=1500,alpha=.7}) 

--]]
  transition.to( flag, { time=1000, xScale=1, yScale=1})

end


--local function stopAnimation()

 --            mapAnimation:pause()
-- end          
          

local function increaseSpeed()
            if state==3 then
              level=level+1
              if level == 1 then
                speed=3
              elseif level==2 then
                speed=3
              end
              state=1
            elseif state==1 then
              if level == 1 then
                speed=3
              elseif level==2 then
                speed=3
              end
              state=2
            elseif state==2 then
              if level == 1 then
                speed=3
              elseif level==2 then
                speed=3
              end
              state=3
             end
end



local function setFlag()
   setTheFlag=true
  end


local function delayPace()
   paceRect.isReady=true
end    

local function newFlag()
 
            increaseSpeed()

            
            if deadText~=nil then
            deadText:removeSelf()
            deadText=nil

              if bonusText ~= nil then
               bonusText:removeSelf()
               bonusText=nil
               spread=1
               prevState=nil
               currState=nil
              end
          end

        local e = math.random(1,5)

        

          if e==1 then
   
            flag = display.newImageRect( "images/andorra.png", 200,100) 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code=1
            flag.x=_W/2 ;flag.y=_H/2
            r1=.816;r2=.063;r3=.227;
            y1=.996;y2=.914;y3=0
            b1=0;b2=.094;b3=.659
            xCoord=340
            yCoord=450
          elseif e==2 then
            flag = display.newImageRect( "images/australia.png", 200,100)  
            flag.anchorX=0.5
            flag.anchorY=0.5
            code=2
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1
            r1=1;r2=0;r3=0
            b1=0;b2=0;b3=.545
           -- xCoord=.202 * xSize * -1
            --yCoord=.02 * ySize * 1
            xCoord=-415
            yCoord=-10
          elseif e==3 then
            flag = display.newImageRect( "images/brazil.png", 200,100)
           flag.anchorX=0.5
            flag.anchorY=0.5 
            code=3
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1
            y1=.996;y2=.875;y3=0
            g1=0;g2=.608;g3=.227
            b1=0;b2=.153;b3=.463
            xCoord=620
            yCoord=100
          elseif e==4 then
            flag = display.newImageRect( "images/canada.png", 200,100)
            flag.anchorX=0.5
            flag.anchorY=0.5
            code=4
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1 
            r1=1;r2=0;r3=0
            xCoord=920
            yCoord=530
          elseif e==5 then
            flag = display.newImageRect( "images/mexico.png", 200,100)
            flag.anchorX=0.5
            flag.anchorY=0.5
            code=5
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1
            r1=.808;r2=.067;r3=.149
            g1=0;g2=.408;g3=.278
            xCoord=920
            yCoord=300
          end
              flag.alpha=1
              transition.to( sky, { time=1500, x=xCoord, y=yCoord })
              if firstFlag==false then            

              firstFlag=false
             end

              timer.performWithDelay(900,delayPace)            --delay start of color squares

     --       if coin==1 then
                flag:scale(0,0)
          --    flag.xScale=0.01
           --   flag.yScale=0.01
              transition.to( flag, { time=1500, xScale=.2, yScale=.2, onComplete=finishScale })
     --       coin=2
         --     elseif coin==2 then
         --     flag.alpha=0.01
           --   flag.alpha=0.01
           ---   transition.to( flag, { time=1000, alpha=.5, onComplete=finishAlpha })
            --  coin=1
        -- end  
            
    end     

local function resetSpawn()
   spawnTable={}
   count=1
  -- paceRect.x=0
    firstObject=true

    currState=nil    --reset bonus score states for new flag
    prevState=nil

             if bonusText ~= nil then
                 bonusText:removeSelf()
                 bonusText=nil
               end

 end  


local function killBars()

transition.to( lowBar, { time=800, y=_H, alpha=0 })
 transition.to( topBar, { time=800, y=0 , alpha=0})
--transition.to( topBar, { time=400, alpha=0 })
      
end


local function removeFlag()
                flag:removeSelf()
              flag  = nil
             -- sky:toFront()
  end            



local function readyObject (e)
if paceRect.x>85 then
  paceRect.x=0
  paceRect.isReady=false
  if setTheFlag==true then     --START A NEW FLAG
    setTheFlag=false
    paceRect.isReady=false
    for i = 1, #spawnTable do
      if spawnTable[i]~=0 then
        spawnTable[i].win=true
        transition.to( spawnTable[i], { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff   }) 

      end
    end
    timer.performWithDelay(500,killBars)
    timer.performWithDelay(540,resetSpawn)
    transition.to( flag, { time=500, alpha=0, onComplete=removeFlag   })    --remove flag
    timer.performWithDelay(600,newFlag)
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

     -- firstFlag=true
      w1=1;w2=1;w3=1
      k1=0;k2=0;k3=0
      r1=1;r2=0;r3=0
      o1=1;o2=.502;o3=0
      y1=1;y2=1;y3=0

      g1=0;g2=.4;g3=0
      b1=0;b2=0;b3=1
       newFlag()
end

local function myFunction()
  bonusAnimation:toBack()
end


function objTouch(self,e)
  print("YOOO")
if e.phase=="began" and e.target.isBodyActive==true then
print("HERYYY")
-- animatePaletteDestroy(spawnTable[self.index].x, spawnTable[self.index].y, spawnTable[self.index].isLeft)

            if lookupCode(code,e.target)==0 then   --You are Dead

              if bonusText ~= nil then
               bonusText:removeSelf()
               bonusText=nil
              end

              if deadText==nil then
                deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
                deadText:setFillColor( 1, 0, 0 )
              end
             -- self.strokeWidth=0
              transition.to( e.target, { time=500, rotation=400, xScale=5, yScale=5, onComplete=removeStuff    }) 
              e.target.isBodyActive=false

            else      --You are Alive
               e.target.isBodyActive=false
              if e.target.win==true then 
                e.target:removeSelf()
                spawnTable[e.target.index]=0          
              else      
              transition.to( e.target, { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff  })    
              end
              currState=e.target.type
              --bonus score
            if currState==prevState then
               spread=spread+1
                --animateBonusText(spawnTable[self.index].x, spawnTable[self.index].y, spawnTable[self.index].isLeft, spread)
            
            --  print("double")
               if bonusText ~= nil then
                 bonusText:removeSelf()
                 bonusText=nil
               end
               text="+"..spread
               bonusText = display.newText(text, _W*(4/5), _H*(1/3), native.systemFont, 28)
               bonusText:setFillColor( 1, 0, 0 )
                     bonusAnimation:toFront()
                     bonusAnimation:play()
                    timer.performWithDelay(700,myFunction,1)
            else
              spread=1
              currState=nil
              prevState=nil
              if bonusText~=nil then
                bonusText:removeSelf()
                bonusText=nil
              end
            end
              prevState=e.target.type
              scoreText:removeSelf()
              score=score+spread
              startScore="Score: "..score
              scoreText = display.newText(startScore, _W*(4/5), _H/2, native.systemFont, 28)
              scoreText:setFillColor( 1, 0, 0 )
            end
            --return
end
end









-- Called when the scene's view does not exist:
function scene:create(event)

      local sceneGroup=self.view
 
   

      local background = display.newRect(0,0,580,320)
      background:setFillColor( 1,1,1 )
      background.anchorX=0.5
      background.anchorY=0.5
      background.name="background"
      background.x=_W/2 ;background.y=_H/2
      background:toBack()

 sceneGroup:insert(background)

      
     


end

-- Called immediately after scene has moved onscreen:
function scene:show( e )
      local sceneGroup=self.view


     if (e.phase == "did") then
 

            timer.performWithDelay(0,setupVariables,1) 
      timer.performWithDelay(15000, setFlag, 0)
end
end


-- Called when scene is about to move offscreen:
function scene:hide( e )
    local group = self.view -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)

    end

          scene:addEventListener("enterFrame", killObject)
      scene:addEventListener("enterFrame", moveObject)
      scene:addEventListener("enterFrame", readyObject)

scene:addEventListener( "create", scene)
scene:addEventListener( "show"  , scene)
scene:addEventListener( "hide"  , scene)
-----------------------------------------------------------------------------------------
return scene    
