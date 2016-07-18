local composer=require("composer")
local scene = composer.newScene()

local t1
local t2
local t3
local t4
local bkBtn
local fwBtn
local xBtn
local phase = 1

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
      fwBtn:toFront()
    end
    
    if phase ~= 1 then      
      bkBtn:toFront()
    end
    xBtn:toFront()   
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
    bkBtn = display.newImageRect( "images/greenArrow.png", 70, 70 )
    bkBtn.type = "bkBtn"
    bkBtn.xScale = -1
    bkBtn.anchorX=0.5
    bkBtn.anchorY=0.5
    bkBtn.x = 40
    bkBtn.y = _H/2  
    bkBtn:toBack() 
    fwBtn = display.newImageRect( "images/greenArrow.png", 70, 70 )
    fwBtn.type = "fwBtn"
    fwBtn.anchorX=0.5
    fwBtn.anchorY=0.5
    fwBtn.x = _W-40
    fwBtn.y = _H/2  
    xBtn = display.newImageRect( "images/greenX.png", 70, 70 )
    xBtn.type = "xBtn"
    xBtn.anchorX=0.5
    xBtn.anchorY=0.5
    xBtn.x = 40
    xBtn.y = 40 
    xBtn.gotoScene = "menu"
    self.view:insert(bkBtn)
    self.view:insert(t4)
    self.view:insert(t3) 
    self.view:insert(t2)    
    self.view:insert(t1)
    self.view:insert(fwBtn)
    self.view:insert(xBtn)    
end


function scene:show( event )
  
    local group = self.view
    if event.phase == "will" then

    elseif event.phase=="did" then
       bkBtn:addEventListener("tap",buttonHit)  
       fwBtn:addEventListener("tap",buttonHit)
       xBtn:addEventListener("tap",buttonHit)  
    end
end

function scene:hide( event )
    if event.phase == "will" then
          bkBtn:removeEventListener("tap",buttonHit)  
          fwBtn:removeEventListener("tap",buttonHit)
          xBtn:removeEventListener("tap",buttonHit)  
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
