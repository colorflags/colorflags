local composer=require("composer")
local scene = composer.newScene()

local t1
local t2
local t3
local t4
local phase = 1

-- RENAME VARS

local samBack
local samFwd
local samX

local buttonSheetInfo = require("lua-sheets.back_buttons")
local buttonSheet = graphics.newImageSheet( "images/back_buttons.png", buttonSheetInfo:getSheet() )

local function buttonHit(e)         
   
        if e.target.type=="bkBtn" then          
            if phase == 2 then
                t1:toFront()
                phase = phase - 1
            elseif phase == 3 then
                t2:toFront()
                phase = phase - 1
            elseif phase == 4 then
                t3:toFront()
                phase = phase - 1
            end
            
        elseif e.target.type=="fwBtn" then           
            if phase == 1 then 
                t2:toFront()
                phase = phase + 1
            elseif phase == 2 then
                t3:toFront()
                phase = phase + 1
            elseif phase == 3 then
                t4:toFront()
                phase = phase + 1
            end
            
        elseif e.target.type=="xBtn" then
           composer.gotoScene ( "menu", { effect = defaultTransition } )   
         
        end
    if phase ~= 4 then
      samFwd:toFront()
    end
    
    if phase ~= 1 then      
      samBack:toFront()
    end
    samX:toFront()   
    return true
end

function scene:create( event )

    t4 = display.newImageRect( "images/T4.png", 580, 320 )
    t4.alpha = 1
    t4.anchorX=0.5
    t4.anchorY=0.5
    t4.x = _W/2
    t4.y = _H/2  
    t3 = display.newImageRect( "images/T3.png", 580, 320 )
    t3.alpha = 1
    t3.anchorX=0.5
    t3.anchorY=0.5
    t3.x = _W/2
    t3.y = _H/2  
    t2 = display.newImageRect( "images/T2.png", 580, 320 )
    t2.alpha = 1
    t2.anchorX=0.5
    t2.anchorY=0.5
    t2.x = _W/2
    t2.y = _H/2  
    t1 = display.newImageRect( "images/T1.png", 580, 320 )
    t1.alpha = 1
    t1.anchorX=0.5
    t1.anchorY=0.5
    t1.x = _W/2
    t1.y = _H/2  

    local margins = 6
    
    samBack = display.newSprite( buttonSheet, {frames={buttonSheetInfo:getFrameIndex("TextButtons_--Btn")}} )
    samBack.type = "bkBtn"
    samBack.anchorX=0
    samBack.anchorY=0
    samBack.x = margins
    samBack.y = _H - samBack.height - margins
    samBack:toBack() 

    
    samFwd = display.newSprite( buttonSheet, {frames={buttonSheetInfo:getFrameIndex("TextButtons_--Btn")}} )
    samFwd.type = "fwBtn"
    samFwd.xScale = -1
    samFwd.anchorX=0
    samFwd.anchorY=0
    samFwd.x = _W - margins
    samFwd.y = _H - samFwd.height - margins 
    
    samX = display.newSprite( buttonSheet, {frames={buttonSheetInfo:getFrameIndex("TextButtons_xBtn")}} )
    samX.type = "xBtn"
    samX.anchorX=0
    samX.anchorY=0
    samX.x = 0 + margins
    samX.y = 0 + margins
    samX.gotoScene = "menu"

    self.view:insert(t4)
    self.view:insert(t3) 
    self.view:insert(t2)    
    self.view:insert(t1)
    self.view:insert(samBack)
    self.view:insert(samFwd)
    self.view:insert(samX)
end


function scene:show( event )
  
    local group = self.view
    if event.phase == "will" then

    elseif event.phase=="did" then
       samBack:addEventListener("tap", buttonHit)
       samFwd:addEventListener("tap",buttonHit)
       samX:addEventListener("tap", buttonHit)
    end
end

function scene:hide( event )
    if event.phase == "will" then
          samBack:removeEventListener("tap", buttonHit)
          samFwd:removeEventListener("tap",buttonHit)
          samX:removeEventListener("tap",buttonHit)  
          composer.removeScene("tutorial",false)   
    elseif event.phase == "did" then
    end
end

function scene:destroy( event )
    local group = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
