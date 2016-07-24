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


local xBtn
local fwBtn
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



        --[[    
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
            audio.stop( bobby )
            music = audio.loadStream( 'anthems/Singapore.mp3' ) 
            bobby = audio.play(music,{loops=-1})
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
            audio.stop( bobby )
            music = audio.loadStream( 'anthems/Slovakia.mp3' ) 
            bobby = audio.play(music,{loops=-1})
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
            audio.stop( bobby )
            music = audio.loadStream( 'anthems/Slovenia.mp3' ) 
            bobby = audio.play(music,{loops=-1})
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
            audio.stop( bobby )
            music = audio.loadStream( 'anthems/SouthAfrica.mp3' ) 
            bobby = audio.play(music,{loops=-1})
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
          
            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/SouthKorea.mp3' )
            bobby = audio.play(music,{loops=-1})

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
            
            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/Spain.mp3' )
            bobby = audio.play(music,{loops=-1})
            
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

            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/SriLanka.mp3' )
            bobby = audio.play(music,{loops=-1})

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
            
            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/Sweden.mp3' )
            bobby = audio.play(music,{loops=-1})
            
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

            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/Switzerland.mp3' )
            bobby = audio.play(music,{loops=-1})
            
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
            
            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/Taiwan.mp3' )
            bobby = audio.play(music,{loops=-1})
            

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
            
            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/Thailand.mp3' )
            bobby = audio.play(music,{loops=-1})
            

            
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

            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/UnitedArabEmirates.mp3' )
            bobby = audio.play(music,{loops=-1})
            

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

            audio.stop( bobby )  
            music = audio.loadStream( 'anthems/UnitedKingdom.mp3' )
            bobby = audio.play(music,{loops=-1})
            
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
        ]]--
        flag.width=200
        flag.height=100

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

end

function scene:show(e)
    if (e.phase == "will") then
      print("SHOWWILL")
      setupVariables()
      random = math.randomseed( os.time() )
   

    elseif (e.phase == "did") then
 
   --    system.activate( "multitouch" )  
      xBtn:addEventListener("tap",buttonHit)
      fwBtn:addEventListener("tap",buttonHit)
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
    display.remove(xBtn)
    display.remove(fwBtn)
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
