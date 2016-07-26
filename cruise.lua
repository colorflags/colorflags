
-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html 

local CreateText = require("cf_text")

--game.lua
local composer = require("composer")
local scene = composer.newScene()
--media.playSound('yancy.mp3')
--local physics = require("physics")
--physics.start()

--SAM: we probebly want a global flag var
local flagGroup

--local xBtn
--local fwBtn
local canQuit=false

--media.playSound('Brazil.mid')
local touchFlagReady
local infoPic
local info
local infoTimer
--local idx=25
local localGroup = display.newGroup()
local infoMode = false
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

local sideTimer
local pieceTimer
local mapTimer
local flagTimer
local paceTimer
local killBarsTimer
local resetTimer
local flag3Timer
local newFlagTimer

local rotationTimer

local line


local map
local lastFlag = 0
local rep=false
local random
local thisRoll=0
local lastRoll=0
local e=0

local countryText
local country


local boycha = 1 -- FOR TESTING PURPOSES.
local nationalFlags1Coords = require("lua-sheets.national-flags1")
local nationalFlags1Sheet = graphics.newImageSheet( "images/national-flags1.png", nationalFlags1Coords:getSheet() )

local nationalFlags2Coords = require("lua-sheets.national-flags2")
local nationalFlags2Sheet = graphics.newImageSheet( "images/national-flags2.png", nationalFlags2Coords:getSheet() )

local nationalFlags3Coords = require("lua-sheets.national-flags3")
local nationalFlags3Sheet = graphics.newImageSheet( "images/national-flags3.png", nationalFlags3Coords:getSheet() )

local nationalFlagsSeq = {
    { name="Andorra", sheet=nationalFlags1Sheet, frames={1} },
    { name="Argentina", sheet=nationalFlags1Sheet, frames={2} },
    { name="Australia", sheet=nationalFlags1Sheet, frames={3} },
    { name="Austria", sheet=nationalFlags1Sheet, frames={4} },
    { name="Belgium", sheet=nationalFlags1Sheet, frames={5} },
    { name="Brazil", sheet=nationalFlags1Sheet, frames={6} },
    { name="Canada", sheet=nationalFlags1Sheet, frames={7} },
    { name="Chile", sheet=nationalFlags1Sheet, frames={8} },
    { name="China", sheet=nationalFlags1Sheet, frames={9} },
    { name="Croatia", sheet=nationalFlags1Sheet, frames={10} },
    { name="Cyprus", sheet=nationalFlags1Sheet, frames={11} },
    { name="CzechRepublic", sheet=nationalFlags1Sheet, frames={12} },
    { name="Denmark", sheet=nationalFlags1Sheet, frames={13} },
    { name="Egypt", sheet=nationalFlags1Sheet, frames={14} },
    { name="Estonia", sheet=nationalFlags1Sheet, frames={15} },
    { name="Finland", sheet=nationalFlags1Sheet, frames={16} },
    { name="France", sheet=nationalFlags1Sheet, frames={17} },
    { name="Germany", sheet=nationalFlags1Sheet, frames={18} },
    { name="Greece", sheet=nationalFlags1Sheet, frames={19} },
    { name="Hungary", sheet=nationalFlags1Sheet, frames={20} },
    { name="Iceland", sheet=nationalFlags1Sheet, frames={21} },
    { name="India", sheet=nationalFlags1Sheet, frames={22} },
    { name="Indonesia", sheet=nationalFlags1Sheet, frames={23} },
    { name="Ireland", sheet=nationalFlags1Sheet, frames={24} },
    { name="Isreal", sheet=nationalFlags2Sheet, frames={1} },  
    { name="Italy", sheet=nationalFlags2Sheet, frames={2} },
    { name="Japan", sheet=nationalFlags2Sheet, frames={3} },
    { name="Lithuania", sheet=nationalFlags2Sheet, frames={4} },
    { name="Luxembourg", sheet=nationalFlags2Sheet, frames={5} },   
    { name="Malaysia", sheet=nationalFlags2Sheet, frames={6} },   
    { name="Malta", sheet=nationalFlags2Sheet, frames={7} },   
    { name="Mexico", sheet=nationalFlags2Sheet, frames={8} }, 
    { name="Netherlands", sheet=nationalFlags2Sheet, frames={9} }, 
    { name="NewZealand", sheet=nationalFlags2Sheet, frames={10} },
    { name="Norway", sheet=nationalFlags2Sheet, frames={11} },
    { name="Philippines", sheet=nationalFlags2Sheet, frames={12} },
    { name="Poland", sheet=nationalFlags2Sheet, frames={13} },
    { name="Portugal", sheet=nationalFlags2Sheet, frames={14} },   
    { name="Russia", sheet=nationalFlags2Sheet, frames={16} },    
    { name="SanMarino", sheet=nationalFlags2Sheet, frames={17} },    
    { name="Singapore", sheet=nationalFlags2Sheet, frames={18} },    
    { name="Slovakia", sheet=nationalFlags2Sheet, frames={19} },    
    { name="Slovenia", sheet=nationalFlags2Sheet, frames={20} },        
    { name="SouthAfrica", sheet=nationalFlags2Sheet, frames={21} },    
    { name="SouthKorea", sheet=nationalFlags2Sheet, frames={22} },    
    { name="Spain", sheet=nationalFlags2Sheet, frames={23} },    
    { name="SriLanka", sheet=nationalFlags2Sheet, frames={24} },    
    { name="Sweden", sheet=nationalFlags3Sheet, frames={1} }, 
    { name="Switzerland", sheet=nationalFlags3Sheet, frames={2} }, 

    -- SAM: IS THIS OKAY!?
    { name="Taiwan", sheet=nationalFlags2Sheet, frames={15} }, 
    { name="Thailand", sheet=nationalFlags3Sheet, frames={3} }, 
    { name="Turkey", sheet=nationalFlags3Sheet, frames={4} }, 
    { name="UnitedArabEmirates", sheet=nationalFlags3Sheet, frames={5} }, 
    { name="UnitedKingdom", sheet=nationalFlags3Sheet, frames={6} }, 
    { name="UnitedStates", sheet=nationalFlags3Sheet, frames={7} }, 
              
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


local function setFlag()
   setTheFlag=true
  end

local function touchFlagNext(e)
     print("YOOOOO")
    flag:removeEventListener( "tap", touchFlagNext ) 
    setTheFlag=true

end  


local function touchFlagFunction()
    
    flag:addEventListener( "tap", touchFlagNext ) 
    canQuit=true

end


local function finishScale()
            flag2Timer=transition.to( flag, { time=1000, xScale=1, yScale=1})
            touchFlagReady=timer.performWithDelay( 1000, touchFlagFunction, 1 )
      
end



local function nextMove()
              pointAnimation:pause()
              pointAnimation:toBack()
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
    local e = math.random(56)
    country = CFGameSettings:getItemByID(e)
    print("country : ", e)
    print(country.name)
    
    -- SAM: what is this? not needed anymore?
    code = country.code
   
    info="images/infoBrazil.png"
    
    flagGroup = display.newGroup()
    flagGroup.x = (_W/2)/2.5
    flagGroup.y = _H/2

    flag=display.newSprite(nationalFlags1Sheet,nationalFlagsSeq, 200, 100)
    flag.alpha = 1
    flag:setSequence(country.name)
    flag.anchorX = 0.5
    flag.anchorY = 0.5

    blurBox=display.newRect(0, 0, flag.width*2.5, flag.height*1.5)
    blurBox:setFillColor(1, 1, 1)
    blurBox.anchorX = 0.5
    blurBox.anchorY = 0.5
    
    blurBox.fill.effect = "generator.radialGradient"

    blurBox.fill.effect.color1 = { 0, 0, 0, .25}
    blurBox.fill.effect.color2 = { 0.2, 0.2, 0.2, 0 }
    blurBox.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
    blurBox.fill.effect.aspectRatio  = 1

    flagGroup:insert(blurBox)
    flagGroup:insert(flag)

    if(country.colors.r) then
        r1= country.colors.r.r
        r2= country.colors.r.g
        r3= country.colors.r.b
        print(r1,r2,r3)
    end
    if(country.colors.w) then 
        w1= country.colors.w.r
        w2= country.colors.w.g
        w3= country.colors.w.b
        print(w1,w2,w3)
    end
    if(country.colors.y) then 
        y1= country.colors.y.r
        y2= country.colors.y.g
        y3= country.colors.y.b
        print(y1,y2,y3)
    end
    if(country.colors.g) then 
        g1= country.colors.g.r
        g2= country.colors.g.g
        g3= country.colors.g.b
        print(g1,g2,g3)
    end 
    if(country.colors.b) then 
        b1= country.colors.b.r
        b2= country.colors.b.g
        b3= country.colors.b.b
        print(b1,b2,b3)
    end
    if(country.colors.o) then 
        o1= country.colors.o.r
        o2= country.colors.o.g
        o3= country.colors.o.b
        print(o1,o2,o3)
    end
    if(country.colors.k) then 
        k1= country.colors.k.r
        k2= country.colors.k.g
        k3= country.colors.k.b
        print(k1,k2,k3)
    end

    xCoord=350
    yCoord=442
    
    -- if check.. when first flag appear. there will be no music. !!!
    audio.stop( bobby )
    music = audio.loadStream( "anthems/" .. country.name .. ".mp3" )
    bobby = audio.play(music,{loops=-1})
    
    piece = display.newImage( "images/andorra104x102.png", 529,229)

    --flagGroup.width=200
    --flagGroup.height=100
end

local function newFlag() 
            music=nil
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
          
          flagGroup.alpha=1
           --delay start of color squares

           --flagGroup:scale(0,0)


              if state==3 then
          sideTimer=timer.performWithDelay(1500,finishScale,1)
          pieceTimer=transition.to( piece, { time=2000, x=_W/2, y=_H/2 }) 
          mapTimer=transition.to( map, { time=2000, x=xCoord, y=yCoord })                     
          flagTimer=transition.to( flagGroup, { time=2000, xScale=.2, yScale=.2})  
          paceTimer=timer.performWithDelay(0,delayPace,1)       
          else

          sideTimer=timer.performWithDelay(1500,finishScale,1)
          pieceTimer=transition.to( piece, { time=1500, x=_W/2, y=_H/2 }) 
          mapTimer=transition.to( map, { time=1500, x=xCoord, y=yCoord })                     
          flagTimer=transition.to( flagGroup, { time=1500, xScale=.2, yScale=.2})  
          paceTimer=timer.performWithDelay(900,delayPace,1)         
          end  
          flagGroup:toFront()       
end    

local function removeFlag()         
              flagGroup:removeSelf()
              flagGroup = nil  
  end            

local function readyObject (e)

  if setTheFlag==true then     --START A NEW FLAG 
  canQuit=false
  transition.to( piece, { time=490, alpha=0,onComplete=killPiece})
    setTheFlag=false

  
    if infoMode == true then
     infoTimer=transition.to(infoPic, {time=500, alpha=0}) 
    end

    flag3Timer=transition.to( flag, { time=500, alpha=0, onComplete=removeFlag   })    --remove flag
    newFlagTimer=timer.performWithDelay(600,newFlag)

  end
end    

local function setupVariables()
      map = display.newImage( "images/world.png", 2048,1038)
      map.alpha=0.65
      map.anchorX=0.5
      map.anchorY=0.5
      map.name="map"
      map.x=0 ;map.y=0;                
end


local function buttonHit(e)     
    if canQuit==true then
        if e.target.type=="fwBtn" then           
           setTheFlag = true
        elseif e.target.type=="xBtn" then
           composer.gotoScene ( "menu", { effect = defaultTransition } )   
        end
        return true
    end
end

------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
function scene:create(e)
    --[[
    fwBtn = display.newImageRect( "images/greenArrow.png", 70, 70 )
    fwBtn.type = "fwBtn"
    fwBtn.anchorX=0.5
    fwBtn.anchorY=0.5
    fwBtn.x = 120
    fwBtn.y = 40
    fwBtn:toBack() 
    xBtn = display.newImageRect( "images/greenX.png", 70, 70 )
    xBtn.type = "xBtn"
    xBtn.anchorX=0.5
    xBtn.anchorY=0.5
    xBtn.x = 40
    xBtn.y = 40 
    xBtn.gotoScene = "menu"
    self.view:insert(fwBtn)  
    self.view:insert(xBtn)  
    ]]--
end

function scene:show(e)
    if (e.phase == "will") then
      print("SHOWWILL")
      setupVariables()
      random = math.randomseed( os.time() )
   

    elseif (e.phase == "did") then
 
   --    system.activate( "multitouch" )  
      --xBtn:addEventListener("tap",buttonHit)
      --fwBtn:addEventListener("tap",buttonHit)
      Runtime:addEventListener("enterFrame", readyObject)  
    --   setTimer=timer.performWithDelay(20000, setFlag, 0)
     --  timer.performWithDelay(15000, checkMemory,0)
       newFlag()
    end
end

function scene:hide(e)
  print("HIDE")
  if e.phase == "will" then
    display.remove(background)
    display.remove(flag)
    display.remove(deadText)
    display.remove(piece)
    display.remove(map)
    display.remove(flag)
    --display.remove(xBtn)
    --display.remove(fwBtn)
    display.remove(countryText)
    display.remove(country)
    display.remove(infoPic)
    print("quit")
    if timerSpeed~=nil then
      timer.cancel(timerSpeed)
    end
 --   xBtn:RemoveEventListener("tap",buttonHit)
   -- fwBtn:RemoveEventListener("tap",buttonHit)
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
