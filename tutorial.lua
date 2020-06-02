local composer=require("composer")
local scene = composer.newScene()

local navigateTutorial

local t1
local t2
local t3
local t4
local phase = 1

-- RENAME VARS

local btnsX
local btnsXSheetCoords = require("lua-sheets.btns_x")
local btnsXSheet = graphics.newImageSheet("images/btns_x.png", btnsXSheetCoords:getSheet())

local btnsLeftArrow
local btnsLeftArrowSheetCoords = require("lua-sheets.btns_left_arrow")
local btnsLeftArrowSheet = graphics.newImageSheet("images/btns_left_arrow.png", btnsLeftArrowSheetCoords:getSheet())

local btnsRightArrow
local btnsRightArrowSheetCoords = require("lua-sheets.btns_right_arrow")
local btnsRightArrowSheet = graphics.newImageSheet("images/btns_right_arrow.png", btnsRightArrowSheetCoords:getSheet())

local currentObject
local touchInsideBtn = false

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
        if currentObject.name == "btnsLeftArrow" then
            currentObject:setSequence("btnsLeftArrow") -- these are the same
        elseif currentObject.name == "btnsRightArrow" then
            currentObject:setSequence("btnsRightArrow") -- these are the same
        elseif currentObject.name == "btnsX" then
            currentObject:setSequence("btnsX")
        end

        if touchInsideBtn == true then

            print("touch OFF. inside")
            -- composer.removeScene("start")

            if(currentObject.name == "btnsX") then
                composer.gotoScene ( "menu", { effect = defaultTransition } )
            elseif(currentObject.name == "btnsLeftArrow" or currentObject.name == "btnsRightArrow") then
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
            if currentObject.name == "btnsLeftArrow" then
                currentObject:setFrame(1)
            elseif currentObject.name == "btnsRightArrow" then
                currentObject:setFrame(1)
            elseif currentObject.name == "btnsX" then
                currentObject:setFrame(1)
            end
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if currentObject.name == "btnsLeftArrow" then
                    currentObject:setFrame(2)
                elseif currentObject.name == "btnsRightArrow" then
                    currentObject:setFrame(2)
                elseif currentObject.name == "btnsX" then
                    currentObject:setFrame(2)
                end
            end
            touchInsideBtn = true
        end
    end
end

navigateTutorial = function(e)
    if e=="btnsLeftArrow" then
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
    elseif e=="btnsRightArrow" then
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
        btnsRightArrow:toFront()
    end
    if phase ~= 1 then
        btnsLeftArrow:toFront()
    end
    btnsX:toFront()
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

    btnsLeftArrow = display.newSprite( btnsLeftArrowSheet, {frames={1,2}} )
    btnsLeftArrow.name = "btnsLeftArrow"
    btnsLeftArrow.anchorX=0
    btnsLeftArrow.anchorY=0
    btnsLeftArrow.x = margins
    btnsLeftArrow.y = _H - btnsLeftArrow.height - margins

    btnsRightArrow = display.newSprite( btnsRightArrowSheet, {frames={1,2}} )
    btnsRightArrow.name = "btnsRightArrow"
    btnsRightArrow.anchorX=1
    btnsRightArrow.anchorY=0
    btnsRightArrow.x = _W - margins
    btnsRightArrow.y = _H - btnsRightArrow.height - margins

    btnsX = display.newSprite( btnsXSheet, {frames={1,2}} )
    btnsX.name = "btnsX"
    btnsX.anchorX=0
    btnsX.anchorY=0
    btnsX.x = 0 + margins
    btnsX.y = 0 + margins
    btnsX.gotoScene = "menu"

    self.view:insert(t4)
    self.view:insert(t3)
    self.view:insert(t2)
    self.view:insert(t1)
    self.view:insert(btnsX)
    self.view:insert(btnsLeftArrow)
    self.view:insert(btnsRightArrow)
end


function scene:show( event )

    local group = self.view
    if event.phase == "will" then
        btnsLeftArrow:toBack()
    elseif event.phase=="did" then
        btnsLeftArrow:addEventListener("touch", myTouchListener)
        btnsLeftArrow:addEventListener("touch", doFunction)
        btnsRightArrow:addEventListener("touch", myTouchListener)
        btnsRightArrow:addEventListener("touch", doFunction)
        btnsX:addEventListener("touch", myTouchListener)
        btnsX:addEventListener("touch", doFunction)
    end
end

function scene:hide( event )
    if event.phase == "will" then
        btnsLeftArrow:removeEventListener("touch", myTouchListener)
        btnsLeftArrow:removeEventListener("touch", doFunction)
        btnsRightArrow:removeEventListener("touch", myTouchListener)
        btnsRightArrow:removeEventListener("touch", doFunction)
        btnsX:removeEventListener("touch", myTouchListener)
        btnsX:removeEventListener("touch", doFunction)

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
