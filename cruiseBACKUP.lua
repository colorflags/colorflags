
-- http://forums.coronalabs.com/topic/53926-sounds-audio-and-memory-leaks/?hl=audio
-- http://docs.coronalabs.com/api/library/display/newSprite.html 

local CreateText = require("cf_text")

--game.lua
local composer = require("composer")
local scene = composer.newScene()
local flagGroup     --SAM:GLOBAL FLAG VAR?

local countryPicker

local xBtn
local fwBtn

local canQuit=false
local currentObject
local touchInsideBtn = false
local isBtnAnim = false

local infoPic
local info
local infoTimer
local infoMode = false
local setTheFlag=false
local xCoord=0
local yCoord=0
local flag
local pieceTimer
local mapTimer
local flagScaleTimer
local flagRemoveTimer
local newFlagTimer
local map
local random
local thisRoll=0
local lastRoll=0
local tempRoll=0

local countryText
local country

local buttonSheetInfo = require("lua-sheets.back_buttons")
local buttonSheet = graphics.newImageSheet( "images/back_buttons.png", buttonSheetInfo:getSheet() )

local boycha = 1 -- FOR TESTING PURPOSES.
local nationalFlags1Coords = require("lua-sheets.national-flags1")
local nationalFlags1Sheet = graphics.newImageSheet( "images/national-flags1.png", nationalFlags1Coords:getSheet() )

local nationalFlags2Coords = require("lua-sheets.national-flags2")
local nationalFlags2Sheet = graphics.newImageSheet( "images/national-flags2.png", nationalFlags2Coords:getSheet() )

local nationalFlags3Coords = require("lua-sheets.national-flags3")
local nationalFlags3Sheet = graphics.newImageSheet( "images/national-flags3.png", nationalFlags3Coords:getSheet() )

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
    { name="czechrepublic", sheet=nationalFlags1Sheet, frames={12} },
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
    { name="israel", sheet=nationalFlags2Sheet, frames={1} },  
    { name="italy", sheet=nationalFlags2Sheet, frames={2} },
    { name="japan", sheet=nationalFlags2Sheet, frames={3} },
    { name="lithuania", sheet=nationalFlags2Sheet, frames={4} },
    { name="luxembourg", sheet=nationalFlags2Sheet, frames={5} },   
    { name="malaysia", sheet=nationalFlags2Sheet, frames={6} },   
    { name="malta", sheet=nationalFlags2Sheet, frames={7} },   
    { name="mexico", sheet=nationalFlags2Sheet, frames={8} }, 
    { name="netherlands", sheet=nationalFlags2Sheet, frames={9} }, 
    { name="newzealand", sheet=nationalFlags2Sheet, frames={10} },
    { name="norway", sheet=nationalFlags2Sheet, frames={11} },
    { name="philippines", sheet=nationalFlags2Sheet, frames={12} },
    { name="poland", sheet=nationalFlags2Sheet, frames={13} },
    { name="portugal", sheet=nationalFlags2Sheet, frames={14} },   
    { name="russia", sheet=nationalFlags2Sheet, frames={16} },    
    { name="sanmarino", sheet=nationalFlags2Sheet, frames={17} },    
    { name="singapore", sheet=nationalFlags2Sheet, frames={18} },    
    { name="slovakia", sheet=nationalFlags2Sheet, frames={19} },    
    { name="slovenia", sheet=nationalFlags2Sheet, frames={20} },        
    { name="southafrica", sheet=nationalFlags2Sheet, frames={21} },    
    { name="southkorea", sheet=nationalFlags2Sheet, frames={22} },    
    { name="spain", sheet=nationalFlags2Sheet, frames={23} },    
    { name="sriLanka", sheet=nationalFlags2Sheet, frames={24} },    
    { name="sweden", sheet=nationalFlags3Sheet, frames={1} }, 
    { name="switzerland", sheet=nationalFlags3Sheet, frames={2} }, 
    -- SAM: Taiwan flag out of order in sprite/atlas because originally named Republic of China
    { name="taiwan", sheet=nationalFlags2Sheet, frames={15} }, 
    { name="thailand", sheet=nationalFlags3Sheet, frames={3} }, 
    { name="turkey", sheet=nationalFlags3Sheet, frames={4} }, 
    { name="unitedarabemirates", sheet=nationalFlags3Sheet, frames={5} }, 
    { name="unitedkingdom", sheet=nationalFlags3Sheet, frames={6} }, 
    { name="unitedstates", sheet=nationalFlags3Sheet, frames={7} } 
}

local piece = display.newImage( "images/australia259x229.png", 529,229)
      piece.anchorX=0.5
      piece.anchorY=0.5
      piece.alpha=0

local background = display.newRect(0,0,580,320)
      background:setFillColor( 1,1,1 )
      background.anchorX=0.5
      background.anchorY=0.5
      background.name="background"
      background.x=_W/2 ;background.y=_H/2
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

        if touchInsideBtn == true and canQuit == true then 

            print("touch OFF. inside")
            -- composer.removeScene("start")
            
            if(currentObject.name == "xBtn") then
                composer.gotoScene ( "menu", { effect = defaultTransition } )
            elseif(currentObject.name == "fwBtn") then
                setTheFlag=true
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

local function finishScale()
  transition.to( xBtn, { time=250, alpha=1 }) 
  transition.to( fwBtn, { time=250, alpha=1 }) 
  xBtn:toFront()
  fwBtn:toFront()   
  canQuit=true
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
    local e = math.random(55)
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
            lastRoll=tempRoll
            while thisRoll==lastRoll do
               -- tempRoll = math.random(1,5)
                tempRoll = math.random(1,56)
                thisRoll=tempRoll
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

           --flagGroup:scale(0,0)

          pieceTimer=transition.to( piece, { time=1500, x=_W/2, y=_H/2 }) 
          mapTimer=transition.to( map, { time=1500, x=xCoord, y=yCoord })                     
          flagScaleTimer=transition.to( flagGroup, { time=1500, xScale=.2, yScale=.2 , onComplete=finishScale})   

          flagGroup:toFront()       
end    

local function removeFlag()         
              flagGroup:removeSelf()
              flagGroup = nil  
end            

local function readyObject(e)

  if setTheFlag==true then     --START A NEW FLAG 
    transition.to( xBtn, { time=250, alpha=0 }) 
    transition.to( fwBtn, { time=250, alpha=0 }) 

  canQuit=false
  transition.to( piece, { time=490, alpha=0,onComplete=killPiece})
    setTheFlag=false

  
    if infoMode == true then
     infoTimer=transition.to(infoPic, {time=500, alpha=0}) 
    end

    flagRemoveTimer=transition.to( flag, { time=500, alpha=0, onComplete=removeFlag   })    --remove flag
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
            map:toBack()
      background:toBack() 
      xBtn.alpha=0 ; fwBtn.alpha=0     
end


local function countryPicker()
    composer.showOverlay("tableView", { isModal=true})
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
    if (e.phase == "will") then
      print("SHOWWILL")
      setupVariables()
      -- TEMP COUNTRY PICKER FOR SAM
      countryPicker()
      random = math.randomseed( os.time() )
    elseif (e.phase == "did") then
   --    system.activate( "multitouch" )  
      Runtime:addEventListener("enterFrame", readyObject)  
    --   setTimer=timer.performWithDelay(20000, setFlag, 0)
     --  timer.performWithDelay(15000, checkMemory,0)
      newFlag()
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
    display.remove(flagGroup)
    display.remove(piece)
    display.remove(map)
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
