local composer=require("composer")
local scene = composer.newScene()

-- These can be deleted right?? 
-- The scene:create(event) function now takes care of creating these variables within its scope

local background
local phaseGroup=display.newGroup()  

local menuStart
local menuCruise
local menuTutorial

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

local menuSpriteCoords = require("lua-sheets.playgame-menu")
local menuStartSheet = graphics.newImageSheet( "images/playgame-menu.png", menuSpriteCoords:getSheet() )

-- New
local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    
    if event.phase == "began" then
        print("touch ON. inside")          
    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "pg" then
            currentObject:setSequence("playgame")
        elseif currentObject.name == "opt" then
            currentObject:setSequence("options")
        elseif currentObject.name == "abt" then
            currentObject:setSequence("about")
        end
        
        -- redundant ?? 
        -- currentObject:setFrame(1)
        
        if touchInsideBtn == true and isLoading == false then 
            print("touch OFF. inside")
            -- composer.removeScene("start")
            
            -- prevents scenes from firing twice!!
            isLoading = true
            
            local goto = currentObject.gotoScene
            if goto == "start" and event.target == startBtnsPlayGame then
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
    menuStart:removeEventListener( "touch", myTouchListener )
    menuStart:removeEventListener( "touch", doFunction )
    menuTutorial:removeEventListener( "touch", myTouchListener )
    menuTutorial:removeEventListener( "touch", doFunction )    
    menuCruise:removeEventListener( "touch", myTouchListener )
    menuCruise:removeEventListener( "touch", doFunction ) 
    composer.hideOverlay()
end

local function initFunction()
    catchAll:addEventListener("tap",catchAllTaps) 
    background:addEventListener("tap",doNothing)
    menuStart:addEventListener( "touch", myTouchListener )
    menuStart:addEventListener( "touch", doFunction )
    menuTutorial:addEventListener( "touch", myTouchListener )
    menuTutorial:addEventListener( "touch", doFunction )    
    menuCruise:addEventListener( "touch", myTouchListener )
    menuCruise:addEventListener( "touch", doFunction )    
end

function scene:create( event )
    local sceneGroup=self.view
     catchAll=display.newRect(0,0,_W,_H)
     catchAll.alpha=0.8
     catchAll.anchorX=0
     catchAll.anchorY=0

    local offsetStartBtns = _H/2.2
    local btnSpacing = 58

    btnHeight1 = offsetStartBtns
    btnHeight2 = offsetStartBtns+btnSpacing
    btnHeight3 = offsetStartBtns+(btnSpacing*2)
    
    background=display.newRoundedRect(50, 50, _W-95, 0, 20)
    background:setFillColor(120/255,115/255,115/255)   
    --background:setStrokeColor( 25/255, 1 ,20/255 )
    --background.strokeWidth = 5
    background.anchorY = 0  
    background.x=_W/2
    background.y=offsetStartBtns
    background.alpha=0
    transition.to( background, {time = 200, alpha=1})

    menuStart = display.newSprite(btnsSheet, btnsSeq)
    menuStart.name = "start"
    --menuStart:addEventListener("touch", myTouchListener)
    menuStart.anchorY = 0
    menuStart.x=_W/2 
    menuStart.y=offsetStartBtns
    menuStart:setSequence( "start" )
    menuStart:setFrame( 1 )
    menuStart.alpha=0
    menuStart.gotoScene="game" 
    menuStart:scale(.8,.8)
    transition.to( menuStart, {time = 200, alpha=1})
 
    menuCruise = display.newSprite(btnsSheet, btnsSeq)
    menuCruise.name = "cruise"
    --menuCruise:addEventListener("touch", myTouchListener)
    menuCruise.anchorY = 0
    menuCruise.x=_W/2 
    menuCruise.y=offsetStartBtns+btnSpacing
    menuCruise:setSequence( "cruise" )
    menuCruise:setFrame( 1 )
    menuCruise.alpha=0
    menuCruise.gotoScene="cruise" 
    menuCruise:scale(.8,.8)
    transition.to( menuCruise, {time = 200, alpha=1})
    
    menuTutorial = display.newSprite(btnsSheet, btnsSeq)
    menuTutorial.name = "tutorial"
    --menuTutorial:addEventListener("touch", myTouchListener)
    menuTutorial.anchorY = 0
    menuTutorial.x=_W/2 
    menuTutorial.y=offsetStartBtns+(btnSpacing*2)
    menuTutorial:setSequence( "tutorial" )
    menuTutorial:setFrame( 1 )
    menuTutorial.alpha=0
    menuTutorial.gotoScene="tutorial" 
    menuTutorial:scale(.8,.8)
    transition.to( menuTutorial, {time = 200, alpha=1})

    background.height = (menuTutorial.y+menuTutorial.height) - menuStart.y
    background.y = background.y-4

    --Duplicates of objs' addEventListener
    --menuStart:addEventListener("touch",doFunction)
    --menuCruise:addEventListener("touch",doFunction)
    --menuTutorial:addEventListener("touch",doFunction)
    
    -- What does this do?
    timer.performWithDelay(300,initFunction)

    catchAll:toBack()
    sceneGroup:insert(catchAll)
    sceneGroup:insert(background)
    sceneGroup:insert(menuStart)
    sceneGroup:insert(menuTutorial)              
    sceneGroup:insert(menuCruise)

    phaseGroup:insert(catchAll)
    phaseGroup:insert(background)
    phaseGroup:insert(menuStart)
    phaseGroup:insert(menuTutorial)
    phaseGroup:insert(menuCruise)
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
