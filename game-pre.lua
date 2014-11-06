local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--media.playSound('yancy.mp3')  
--local physics = require("physics")
--physics.start()
--media.playSound('Brazil.mid')  

local _W = display.contentWidth; -- Get the width of the screen
local _H = display.contentHeight; -- Get the height of the screen

local motionx = 0 -- Variable used to move character along x axis
--local speed = 5 --
local speed=3
local pace=0
--local PaceHolder=18
local PaceHolder=30
local level=0
local localGroup = display.newGroup()
local spawnTable = {}   --Create a table to hold our spawns
local currState="first"
local prevState="first"
local GameOver=0
local deadText=nil
local off=0
local coin=1
local state=3
local hold=0
local moveCube=true
local createCube=true
local startVar=0
    local mapData = { width=480,height=320,numFrames=10,sheetContentWidth=4800,sheetContentHeight=320}
      local mapSheet=graphics.newImageSheet("background.png",mapData)
      local mapSequence={name="normalRun",start=1,count=10,time=1000}
      local mapAnimation=display.newSprite(mapSheet,mapSequence)
            mapAnimation.x=_W/2 mapAnimation.y=_H/2




local function moveObject (event)



  if moveCube==true then

  

  if state==1 then  
  if #spawnTable >0 then
        for i = 1, #spawnTable do
         if spawnTable[i]~=0 then  
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
         if spawnTable[i]~=0 then  
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
         if spawnTable[i]~=0 then  
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

local function killObject (event)
  if #spawnTable >0 then
    for i = 1, #spawnTable do 
      if spawnTable[i]~=0 then 
--        if spawnTable[i].isLeft==true then
          if spawnTable[i].x < -40 or spawnTable[i].x > _W+40 then
            if lookupCode(code,spawnTable[i])==1 then
              print("dead")
             -- GameOver=1
             if deadText==nil then
             deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
             deadText:setFillColor( 0, 0, 0 )
             end
              --deadText.alpha=1
              --timer.performWithDelay(2000,removeText(deadText),1)
            spawnTable[i]:removeSelf()
            spawnTable[i]=0

          end              
        end 
      end   
    end
  end 
end    


local function holdFunction()

   if startVar==3 then
   moveCube=true
   createCube=true
   end
  startVar=startVar+1
end


local function spawn(params)
  
    local object = display.newRect(0,0,80,60)
            object.anchorY=0.5
            object.anchorX=0.5
             object.isBodyActive = true  
    object.objTable = params.objTable   --Set the objects table to a table passed in by parameters
    object.index = #object.objTable + 1    --Automatically set the table index to be inserted into the next available table index
    object.myName = "Object: " .. object.index  --Give the object a custom name
    object.isLeft=params.isLeft
    object.isBottomLeft=params.isBottomLeft
    object.type=params.type
 
  if state==1 then
    if object.isLeft==false then 
    object.x=0-40
    object.y=_H-45
    elseif object.isLeft==true then 
    object.x=_W+40
    object.y=45 
    end  
  elseif state==2 then
    if object.isLeft==false then 
    object.x=_W+40
    object.y=_H-45
    elseif object.isLeft==true then 
    object.x=0-40
    object.y=45 
    end
  elseif state==3 then
     if object.isLeft==false then 
    object.x=_W/2+40
    object.y=45
    elseif object.isLeft==true then 
    object.x=_W/2-40
    object.y=45 
    elseif object.isBottomLeft==false then 
    object.x=_W/2+40
    object.y=_H-45
    elseif object.isBottomLeft==true then 
    object.x=_W/2-40
    object.y=_H-45   
    end

    if startVar==0 then
      moveCube=false
      createCube=false
     -- Runtime:removeEventListener("enterFrame", moveObject)  
    end  

    --if startVar==3 then
      --Runtime:removeEventListener("enterFrame", createObject)
    --  createCube=false
    --end  

    if startVar<=3 then
   object.xScale=.01
   object.yScale=.01
    object.alpha=0
    transition.to(object,{time=700,xScale=1,yScale=1,alpha=1,onComplete=holdFunction})


    end
  end   



--    print(params.type)
    if params.type=="white" then 
        object:setFillColor(w1,w2,w3)
    elseif params.type=="black" then 
       object:setFillColor(k1,k2,k3)
     --  object.strokeWidth=1
      -- object:setStrokeColor(255,255,255)
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
      object.objTable[object.index] = object --Insert the object into the table at the specified index

    return object
end




local function createObject (event)
  --[[      if state==3 then
          PaceHolder=45
        else
          PaceHolder=30
        end  
--]]
      if createCube==true then
        if pace == PaceHolder then
          pace=0
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
             starVar=false
          end
        end 
     pace=pace+1
   end
end


local function removeStuff(self)
     if self.name~="sky" and self~=nil and spawnTable[self.index]~=0 then
          self:removeSelf(self)
         spawnTable[self.index]=0
         off=0
    end
end

local function finishAlpha()
              transition.to( flag, { time=500, alpha=1 })
 end 


local function stopAnimation()

             mapAnimation:pause()
 end            
            

local function increaseSpeed()
  if state==3 then
              level=level+1 
              if level == 1 then
                speed=3
                PaceHolder=30
              elseif level==2 then 
                speed=4
                PaceHolder=22                
              else
                speed=5
                PaceHolder=18
              end 
              state=1 
    elseif state==1 then 
              if level == 1 then
                speed=3
                PaceHolder=30
              elseif level==2 then 
                speed=4
                PaceHolder=22                
              else 
                speed=5
                PaceHolder=18
              end 
              state=2  
    elseif state==2 then 
              if level == 1 then
                speed=2
                PaceHolder=45
              elseif level==2 then 
                speed=3
                PaceHolder=30                
              else 
                speed=4
                PaceHolder=22
              end 
              state=3 
             end
          pace=0   
end

local function newFlag() 

            increaseSpeed()


            print("speed:" .. speed)
            if firstFlag==false then
                  off=1
              for i = 1, #spawnTable do 
                if spawnTable[i]~=0 then 
                  spawnTable[i].type="win"
                  transition.to( spawnTable[i], { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff   })   
                end 
              end 

              flag:removeSelf()
              flag  = nil 
            end

            firstFlag=false
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
     
            flag = display.newImageRect( "andorra.png", 200,100)   
            flag.anchorX=0.5
            flag.anchorY=0.5
            code=1 
            flag.x=_W/2 ;flag.y=_H/2 
            r1=.816;r2=.063;r3=.227;
            y1=.996;y2=.914;y3=0
            b1=0;b2=.094;b3=.659
          elseif e==2 then
            flag = display.newImageRect( "australia.png", 200,100)    
            flag.anchorX=0.5
            flag.anchorY=0.5  
            code=2
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1
            r1=1;r2=0;r3=0
            b1=0;b2=0;b3=.545
          elseif e==3 then
            flag = display.newImageRect( "brazil.png", 200,100)  
           flag.anchorX=0.5
            flag.anchorY=0.5   
            code=3 
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1
            y1=.996;y2=.875;y3=0
            g1=0;g2=.608;g3=.227
            b1=0;b2=.153;b3=.463
          elseif e==4 then
            flag = display.newImageRect( "canada.png", 200,100)  
            flag.anchorX=0.5
            flag.anchorY=0.5 
            code=4
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1   
            r1=1;r2=0;r3=0
          elseif e==5 then
            flag = display.newImageRect( "mexico.png", 200,100) 
            flag.anchorX=0.5
            flag.anchorY=0.5
            code=5
            flag.x=_W/2 ;flag.y=_H/2
            w1=1;w2=1;w3=1  
            r1=.808;r2=.067;r3=.149
            g1=0;g2=.408;g3=.278
          end 


--             mapAnimation:play()
  --           timer.performWithDelay( 1000 , stopAnimation,1)

            if coin==1 then
              flag.xScale=0.01
              flag.yScale=0.01
              transition.to( flag, { time=1500, xScale=1, yScale=1 })
            coin=2
              elseif coin==2 then 
              flag.alpha=0.01
              flag.alpha=0.01
              transition.to( flag, { time=1000, alpha=.5, onComplete=finishAlpha })
              coin=1
         end     
     
         startVar=0
    

    end           

local function setupVariables()

      firstFlag=true
      w1=1;w2=1;w3=1
      k1=0;k2=0;k3=0
      r1=1;r2=0;r3=0
      o1=1;o2=.502;o3=0
      y1=1;y2=1;y3=0

      g1=0;g2=.4;g3=0
      b1=0;b2=0;b3=1
       newFlag()
end


function objTouch(self,event)
if event.phase=="began" and self.isBodyActive==true and self.name~="sky" and off==0 then


            if lookupCode(code,self)==0 and self.type~="win" then
              print("dead touch")
   --           deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
       --       deadText:setFillColor( 0, 0, 0 )
             if deadText==nil then
             deadText = display.newText("DEAD", _W*(4/5), _H*(2/3), native.systemFont, 28)
             deadText:setFillColor( 0, 0, 0 )
           --   deadText.alpha=1
            end
   

            transition.to( self, { time=500, rotation=400, xScale=5, yScale=5, onComplete=removeStuff    })   
                
            self.isBodyActive=false

            elseif self.type~="win" then
 --           transition.to( self, { time=300, rotation=400, xScale=.0, yScale=0})  

            transition.to( self, { time=500, rotation=400, xScale=0.01, yScale=0.01, onComplete=removeStuff  })  
                       
            self.isBodyActive=false
            print(currState)
            print(prevState)
            currState=self.type
            if currState==prevState then
              spread=spread*2
              print("double")
              if bonusText ~= nil then
               bonusText:removeSelf()
              end 
              text="x"..spread
              bonusText = display.newText(text, _W*(4/5), _H*(1/3), native.systemFont, 28)
              bonusText:setFillColor( 0, 0, 0 )

            else
              spread=1
              currState=nil
              prevState=nil
              if bonusText~=nil then
              bonusText:removeSelf()
              bonusText=nil
            end
            end


              prevState=self.type

              scoreText:removeSelf()
              score=score+spread
              startScore="Score: "..score
              scoreText = display.newText(startScore, _W*(4/5), _H/2, native.systemFont, 28)
              scoreText:setFillColor( 0, 0, 0 )
            end  
   


end
end


local function stop (event)
  if event.phase =="ended" then
  end   
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
      local group1 = self.view

      math.randomseed( os.time() ) 


      local sky = display.newImage( "background.png", 580,320)
      --sky:setReferencePoint(display.CenterLeftReferencePoint) 
      sky.anchorX=0
      sky.anchorY=0.5
      sky.name="sky"
      sky.x=0 ;sky.y=_H/2

  
      

  

 



   score=0

  startScore="Score:"..score
  scoreText = display.newText(startScore, _W*(4/5), _H/2, native.systemFont, 28)
  scoreText:setFillColor( 0, 0, 0 )


     
     group1:insert(sky)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view 



Runtime:addEventListener("enterFrame", createObject)
Runtime:addEventListener("enterFrame", killObject)
Runtime:addEventListener("enterFrame", moveObject)
Runtime:addEventListener("touch", stop )
    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end

function scene:willEnterScene(event)
    local group2 = self.view


  timer.performWithDelay(0,setupVariables,1)

    --timer.performWithDelay(0, createObject, 1)
 
  timer.performWithDelay(10000, newFlag, 0)
 -- timer.performWithDelay(8000, increaseSpeed, 2)
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
    --Runtime:removeEventListener("touch",touchScreen)
    end
-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view
end

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
scene:addEventListener( "willEnterScene",scene)
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
-----------------------------------------------------------------------------------------
return scene    
    


