local composer=require("composer")
local scene = composer.newScene()

local navigateTutorial

local t1
local t2
local t3
local t4
local phase = 1

-- RENAME VARS

local bkBtn
local fwBtn
local xBtn

local currentObject
local touchInsideBtn = false
local isBtnAnim = false

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

-- New
-- SAM: add a variable so that setSequence() can be set more easily. Unnecessary if statements
local function myTouchListener(event)
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    print(currentObject.name) 
    if event.phase == "began" then
        print("touch ON. inside")          
    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "bkBtn" then
            currentObject:setSequence("fwBtn") -- these are the same
        elseif currentObject.name == "fwBtn" then
            currentObject:setSequence("fwBtn") -- these are the same
        elseif currentObject.name == "xBtn" then
            currentObject:setSequence("xBtn")
        end

        if touchInsideBtn == true then 

            print("touch OFF. inside")
            -- composer.removeScene("start")
            
            if(currentObject.name == "xBtn") then
                composer.gotoScene ( "menu", { effect = defaultTransition } )
            elseif(currentObject.name == "bkBtn" or currentObject.name == "fwBtn") then
                navigateTutorial(currentObject.name)
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
                if currentObject.name == "bkBtn" then
                    currentObject:setSequence("fwBtn") -- these are the same
                elseif currentObject.name == "fwBtn" then
                    currentObject:setSequence("fwBtn") -- these are the same
                elseif currentObject.name == "xBtn" then
                    currentObject:setSequence("xBtn")
                end
            else 
                if currentObject.name == "bkBtn" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "fwBtn" then
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
                    if currentObject.name == "bkBtn" then
                        currentObject:setSequence("fwBtn_anim") -- these are the same
                    elseif currentObject.name == "fwBtn" then
                        currentObject:setSequence("fwBtn_anim") -- these are the same
                    elseif currentObject.name == "xBtn" then
                        currentObject:setSequence("xBtn_anim")
                    end
                    currentObject:play()
                else
                    if currentObject.name == "bkBtn" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "fwBtn" then
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

navigateTutorial = function(e)         
    if e=="bkBtn" then          
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
    elseif e=="fwBtn" then           
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
    end
    if phase ~= 4 then
        fwBtn:toFront() 
    end
    if phase ~= 1 then      
        bkBtn:toFront()
    end
    xBtn:toFront()   
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

    bkBtn = display.newSprite(btnsSheet, btnsSeq)
    bkBtn:setSequence("fwBtn")
    bkBtn.type = "bkBtn"
    bkBtn.name = "bkBtn"
    bkBtn.anchorX=0
    bkBtn.anchorY=0
    bkBtn.x = margins
    bkBtn.y = _H - bkBtn.height - margins 
    
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

    --[[
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
    ]]--
    self.view:insert(t4)
    self.view:insert(t3) 
    self.view:insert(t2)    
    self.view:insert(t1)
    self.view:insert(xBtn)
    self.view:insert(bkBtn)
    self.view:insert(fwBtn)
end


function scene:show( event )
  
    local group = self.view
    if event.phase == "will" then
        bkBtn:toBack()
    elseif event.phase=="did" then
        bkBtn:addEventListener("touch", myTouchListener)
        bkBtn:addEventListener("touch", doFunction)
        fwBtn:addEventListener("touch", myTouchListener)
        fwBtn:addEventListener("touch", doFunction)
        xBtn:addEventListener("touch", myTouchListener)
        xBtn:addEventListener("touch", doFunction)
    end
end

function scene:hide( event )
    if event.phase == "will" then
        bkBtn:removeEventListener("touch", myTouchListener)
        bkBtn:removeEventListener("touch", doFunction)
        fwBtn:removeEventListener("touch", myTouchListener)
        fwBtn:removeEventListener("touch", doFunction)
        xBtn:removeEventListener("touch", myTouchListener)
        xBtn:removeEventListener("touch", doFunction)
          --samBack:removeEventListener("tap", buttonHit)
          --samFwd:removeEventListener("tap",buttonHit)
          --samX:removeEventListener("tap",buttonHit)  
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
