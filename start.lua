local composer=require("composer")
local scene = composer.newScene()

-- These can be deleted right??
-- The scene:create(event) function now takes care of creating these variables within its scope

local background
local phaseGroup=display.newGroup()

-- local menuStart
-- local btnsCruise
-- local btnsTutorial

local btnsStart
local btnsStartSheetCoords = require("lua-sheets.btns_start")
local btnsStartSheet = graphics.newImageSheet("images/btns_start.png", btnsStartSheetCoords:getSheet())

local btnsCruise
local btnsCruiseSheetCoords = require("lua-sheets.btns_cruise")
local btnsCruiseSheet = graphics.newImageSheet("images/btns_cruise.png", btnsCruiseSheetCoords:getSheet())

local btnsTutorial
local btnsTutorialSheetCoords = require("lua-sheets.btns_tutorial")
local btnsTutorialSheet = graphics.newImageSheet("images/btns_tutorial.png", btnsTutorialSheetCoords:getSheet())

local currentObject
local isLoading = false
local touchInsideBtn = false
local isBtnAnim = false

-- GLOBALIZE
local btnsSheetCoords = require("lua-sheets.buttons")
local btnsSheet = graphics.newImageSheet("images/buttons.png", btnsSheetCoords:getSheet())

local btnsSeq = {
    {
        name = "start",
        frames = {
            btnsSheetCoords:getFrameIndex("Start3"),
            btnsSheetCoords:getFrameIndex("Start5")
        },
        time = 500
    },
    {
        name = "start_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Start2"),
            btnsSheetCoords:getFrameIndex("Start3"),
            btnsSheetCoords:getFrameIndex("Start4"),
            btnsSheetCoords:getFrameIndex("Start5")
        },
        time = 500
    },
    {
        name = "cruise",
        frames = {
            btnsSheetCoords:getFrameIndex("Cruise3"),
            btnsSheetCoords:getFrameIndex("Cruise5")
        },
        time = 500
    },
    {
        name = "cruise_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Cruise2"),
            btnsSheetCoords:getFrameIndex("Cruise3"),
            btnsSheetCoords:getFrameIndex("Cruise4"),
            btnsSheetCoords:getFrameIndex("Cruise5")
        },
        time = 500
    },
    {
        name = "tutorial",
        frames = {
            btnsSheetCoords:getFrameIndex("Tutorial3"),
            btnsSheetCoords:getFrameIndex("Tutorial5")
        },
        time = 500
    },
    {
        name = "tutorial_anim",
        frames = {
            btnsSheetCoords:getFrameIndex("Tutorial2"),
            btnsSheetCoords:getFrameIndex("Tutorial3"),
            btnsSheetCoords:getFrameIndex("Tutorial4"),
            btnsSheetCoords:getFrameIndex("Tutorial5")
        },
        time = 500
    },
}

local menuSeq = {
    { name = "start", frames = {6}, time = 500 },
    { name = "start_anim", frames = {7, 8, 9, 10}, time = 500 },
    { name = "cruise", frames = {1}, time = 500 },
    { name = "cruise_anim", frames = {2, 3, 4, 5}, time = 500 },
    { name = "tutorial", frames = {11}, time = 500 },
    { name = "tutorial_anim", frames = {12, 13, 14, 15}, time = 500 }
}

-- local menuSpriteCoords = require("lua-sheets.Start-menu")
-- local menuStartSheet = graphics.newImageSheet( "images/Start-menu.png", menuSpriteCoords:getSheet() )

-- New
local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)

    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then

        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "pg" then
            currentObject:setSequence("Start")
        elseif currentObject.name == "opt" then
            currentObject:setSequence("Cruise")
        elseif currentObject.name == "abt" then
            currentObject:setSequence("Tutorial")
        end

        -- redundant ??
        -- currentObject:setFrame(1)

        if touchInsideBtn == true and isLoading == false then
            print("touch OFF. inside")
            -- composer.removeScene("start")

            -- prevents scenes from firing twice!!
            isLoading = true

            local goto = currentObject.gotoScene
            if goto == "start" and event.target == btnsStart then
                composer.showOverlay( goto, { isModal= true})
            else
                composer.gotoScene ( goto, { effect = defaultTransition } )
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
                if currentObject.name == "start" then
                    currentObject:setSequence("start")
                elseif currentObject.name == "cruise" then
                    currentObject:setSequence("cruise")
                elseif currentObject.name == "tutorial" then
                    currentObject:setSequence("tutorial")
                end
            else
                if currentObject.name == "start" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "cruise" then
                    currentObject:setFrame(1)
                elseif currentObject.name == "tutorial" then
                    currentObject:setFrame(1)
                end
            end
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if(isBtnAnim) then
                    if currentObject.name == "start" then
                        currentObject:setSequence("start_anim")
                    elseif currentObject.name == "cruise" then
                        currentObject:setSequence("cruise_anim")
                    elseif currentObject.name == "tutorial" then
                        currentObject:setSequence("tutorial_anim")
                    end
                    currentObject:play()
                else
                    if currentObject.name == "start" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "cruise" then
                        currentObject:setFrame(2)
                    elseif currentObject.name == "tutorial" then
                        currentObject:setFrame(2)
                    end
                end
            end
            touchInsideBtn = true
        end
    end
end

local function removeIt(e)
       display.remove(e)
end

local function doNothing(e)
  return true
end

local function catchAllTaps(e)
    catchAll:removeEventListener("tap",catchAllTaps)
    background:removeEventListener("tap",doNothing)
    btnsStart:removeEventListener( "touch", myTouchListener )
    btnsStart:removeEventListener( "touch", doFunction )
    btnsTutorial:removeEventListener( "touch", myTouchListener )
    btnsTutorial:removeEventListener( "touch", doFunction )
    btnsCruise:removeEventListener( "touch", myTouchListener )
    btnsCruise:removeEventListener( "touch", doFunction )
    composer.hideOverlay()
end

local function initFunction()
    catchAll:addEventListener("tap",catchAllTaps)
    background:addEventListener("tap",doNothing)
    btnsStart:addEventListener( "touch", myTouchListener )
    btnsStart:addEventListener( "touch", doFunction )
    btnsTutorial:addEventListener( "touch", myTouchListener )
    btnsTutorial:addEventListener( "touch", doFunction )
    btnsCruise:addEventListener( "touch", myTouchListener )
    btnsCruise:addEventListener( "touch", doFunction )
end

function scene:create( event )
    local sceneGroup=self.view
     catchAll=display.newRect(0,0,_W,_H)
     catchAll.alpha=0.8
     catchAll.anchorX=0
     catchAll.anchorY=0

    -- rename
    local offsetStartBtns = _H/1.5 + 9

    background=display.newRoundedRect(50, 50, _W/2, 0, 20)
    background:setFillColor(120/255,115/255,115/255)
    --background:setStrokeColor( 25/255, 1 ,20/255 )
    --background.strokeWidth = 5
    background.anchorY = 0
    background.x=_W/2
    background.y=offsetStartBtns
    background.alpha=0
    transition.to( background, {time = 200, alpha=1})



    btnsStart = display.newSprite( btnsStartSheet, {frames={1,2,3,4}} ) -- use btnsSeq
    btnsStart.name = "start"
    btnsStart.anchorY = .5
    btnsStart.x=_W/2
    btnsStart.y=offsetStartBtns
    btnsStart:setSequence( "start" )
    btnsStart:setFrame( 1 )
    btnsStart.alpha=0
    btnsStart.gotoScene="game"
    btnsStart:scale(.8,.8)
    transition.to( btnsStart, {time = 200, alpha=1})

    local btnSpacing = btnsStart.height + 4

    btnsCruise = display.newSprite(btnsCruiseSheet, {frames={1,2,3,4}} )
    btnsCruise.name = "cruise"
    --btnsCruise:addEventListener("touch", myTouchListener)
    btnsCruise.anchorY = .5
    btnsCruise.x = _W/2
    btnsCruise.y = offsetStartBtns+btnSpacing
    btnsCruise:setSequence( "cruise" )
    btnsCruise:setFrame( 1 )
    btnsCruise.alpha=0
    btnsCruise.gotoScene="cruise"
    btnsCruise:scale(.8,.8)
    transition.to( btnsCruise, {time = 200, alpha=1})

    btnsTutorial = display.newSprite(btnsTutorialSheet, {frames={1,2,3,4}} )
    btnsTutorial.name = "tutorial"
    --btnsTutorial:addEventListener("touch", myTouchListener)
    btnsTutorial.anchorY = .5
    btnsTutorial.x = _W/2
    btnsTutorial.y = offsetStartBtns+(btnSpacing*2)
    btnsTutorial:setSequence( "tutorial" )
    btnsTutorial:setFrame( 1 )
    btnsTutorial.alpha=0
    btnsTutorial.gotoScene="tutorial"
    btnsTutorial:scale(.8,.8)
    transition.to( btnsTutorial, {time = 200, alpha=1})

    background.height = btnsTutorial.y - btnsStart.y + (btnsStart.height)
    background.y = background.y - btnsStart.height/2

    --Duplicates of objs' addEventListener
    --menuStart:addEventListener("touch",doFunction)
    --btnsCruise:addEventListener("touch",doFunction)
    --btnsTutorial:addEventListener("touch",doFunction)

    -- What does this do?
    timer.performWithDelay(300,initFunction)

    catchAll:toBack()
    sceneGroup:insert(catchAll)
    sceneGroup:insert(background)
    sceneGroup:insert(btnsStart)
    sceneGroup:insert(btnsTutorial)
    sceneGroup:insert(btnsCruise)

    phaseGroup:insert(catchAll)
    phaseGroup:insert(background)
    phaseGroup:insert(btnsStart)
    phaseGroup:insert(btnsTutorial)
    phaseGroup:insert(btnsCruise)
    phaseGroup:toFront()
end

function scene:show( event )
    local sceneGroup=self.view
    local phase = event.phase
    if event.phase == "will" then
    elseif event.phase=="did" then
    end
end

function scene:hide( event )
    local sceneGroup=self.view
    local phase = event.phase
    if event.phase=="will" then
        transition.to(phaseGroup, {time=0, alpha=0,onComplete=removeIt})
    elseif event.phase == "did" then
        local parent = event.parent
        parent:focusMenu()
    end
end

function scene:destroy( event )
  local sceneGroup=self.view

  -- Do we need this? We already have a removeIt() function
  composer.hideOverlay("start")
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
