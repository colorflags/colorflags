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

local btnsStartGiga
local btnsStartGigaSheetCoords = require("lua-sheets.btns_start_giga")
local btnsStartGigaSheet = graphics.newImageSheet("images/btns_start_giga.png", btnsStartGigaSheetCoords:getSheet())

local btnsCruise
local btnsCruiseSheetCoords = require("lua-sheets.btns_cruise")
local btnsCruiseSheet = graphics.newImageSheet("images/btns_cruise.png", btnsCruiseSheetCoords:getSheet())

local btnsCruiseGiga
local btnsCruiseGigaSheetCoords = require("lua-sheets.btns_cruise_giga")
local btnsCruiseGigaSheet = graphics.newImageSheet("images/btns_cruise_giga.png", btnsCruiseGigaSheetCoords:getSheet())

local btnsTutorial
local btnsTutorialSheetCoords = require("lua-sheets.btns_tutorial")
local btnsTutorialSheet = graphics.newImageSheet("images/btns_tutorial.png", btnsTutorialSheetCoords:getSheet())

local btnsTutorialGiga
local btnsTutorialGigaSheetCoords = require("lua-sheets.btns_tutorial_giga")
local btnsTutorialGigaSheet = graphics.newImageSheet("images/btns_tutorial_giga.png", btnsTutorialGigaSheetCoords:getSheet())

local currentObject
local isLoading = false
local touchInsideBtn = false

-- New
local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)

    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then

        if touchInsideBtn == true and isLoading == false then
            print("touch OFF. inside")
            -- composer.removeScene("start")

            -- prevents scenes from firing twice!!
            isLoading = true

            local gotoo = currentObject.gotoScene
            if gotoo == "start" and event.target == btnsStart then
                composer.showOverlay( gotoo, { isModal= true})
            else
                composer.gotoScene ( gotoo, { effect = defaultTransition } )
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
            if currentObject.name == "start" then
                currentObject:setFrame(1)
            elseif currentObject.name == "cruise" then
                currentObject:setFrame(1)
            elseif currentObject.name == "tutorial" then
                currentObject:setFrame(1)
            end
        -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if currentObject.name == "start" then
                    currentObject:setFrame(2)
                elseif currentObject.name == "cruise" then
                    currentObject:setFrame(2)
                elseif currentObject.name == "tutorial" then
                    currentObject:setFrame(2)
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
     catchAll=display.newRect( 0, 0, _W, _H )
     catchAll.anchorX=0
     catchAll.anchorY=0
     catchAll.isHitTestable = true
     catchAll.alpha=0

     local menuBtnsGroup = event.params.menuBtnsGroup

    -- rename
    local offsetStartBtns = _H/2

	local paint = {
	    type = "gradient",
	    color1 = { .6, .6, .6, 1 },
	    color2 = { .2, .2, .2, 1 },
	    direction = "down"
	}

    background=display.newRoundedRect(50, 50, _W/2, 0, 20)
    background:setFillColor(.45,.4,.4)
    background:setStrokeColor( 0, 0, 0 )
    background.strokeWidth = 1
    background.x=_W/2
    background.alpha=0
    background.fill = paint
    transition.to( background, {time = 200, alpha=1})

    local btnsGroup = display.newGroup()

    btnsStart = display.newSprite( btnsStartGigaSheet, {frames={1,2}} ) -- use btnsSeq
    btnsStart.name = "start"
    btnsStart.anchorY = .5
    btnsStart.x=_W/2
    -- btnsStart.y=offsetStartBtns
    btnsStart:setSequence( "start" )
    btnsStart:setFrame( 1 )
    btnsStart.alpha=0
    btnsStart.gotoScene="game"
    -- btnsStart:scale(.8,.8)
    transition.to( btnsStart, {time = 200, alpha=.9})
    btnsGroup:insert(btnsStart)

    local btnSpacing = btnsStart.height + 4

    btnsCruise = display.newSprite(btnsCruiseGigaSheet, {frames={1,2}} )
    btnsCruise.name = "cruise"
    --btnsCruise:addEventListener("touch", myTouchListener)
    btnsCruise.anchorY = .5
    btnsCruise.x = _W/2
    btnsCruise.y = btnSpacing
    btnsCruise:setSequence( "cruise" )
    btnsCruise:setFrame( 1 )
    btnsCruise.alpha=0
    btnsCruise.gotoScene="cruise"
    -- btnsCruise:scale(.8,.8)
    transition.to( btnsCruise, {time = 200, alpha=.9})
    btnsGroup:insert(btnsCruise)

    btnsTutorial = display.newSprite(btnsTutorialGigaSheet, {frames={1,2}} )
    btnsTutorial.name = "tutorial"
    --btnsTutorial:addEventListener("touch", myTouchListener)
    btnsTutorial.anchorY = .5
    btnsTutorial.x = _W/2
    btnsTutorial.y = btnSpacing * 2
    btnsTutorial:setSequence( "tutorial" )
    btnsTutorial:setFrame( 1 )
    btnsTutorial.alpha=0
    btnsTutorial.gotoScene="tutorial"
    -- btnsTutorial:scale(.8,.8)
    transition.to( btnsTutorial, {time = 200, alpha=.9})
    btnsGroup:insert(btnsTutorial)
    btnsGroup.y = _H - btnsGroup.height

    background.height = btnsGroup.height
    background.y = btnsGroup.y + btnsCruise.y


    --Duplicates of objs' addEventListener
    --menuStart:addEventListener("touch",doFunction)
    --btnsCruise:addEventListener("touch",doFunction)
    --btnsTutorial:addEventListener("touch",doFunction)

    -- What does this do?
    timer.performWithDelay(300, initFunction)

    catchAll:toBack()
    sceneGroup:insert(catchAll)
    sceneGroup:insert(background)

    phaseGroup:insert(catchAll)
    phaseGroup:insert(background)

    phaseGroup:insert(btnsGroup)
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
