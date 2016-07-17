local composer=require("composer")
local scene = composer.newScene()

-- These can be deleted right?? 
-- The scene:create(event) function now takes care of creating these variables within its scope

-- local menuStart
-- local menuTutorial
-- local menuCruise

-- local startBtn
-- local tutorialBtn
-- local cruiseBtn

local background
local phaseGroup=display.newGroup()  
  
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


local currentObject
local isLoading = false
local touchInsideBtn = false

local function myTouchListener( event )
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    
    if event.phase == "began" then
        -- print("touch ON. inside")          
    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "menuStart" then
            currentObject:setSequence("start")
        elseif currentObject.name == "menuTutorial" then
            currentObject:setSequence("tutorial")
        elseif currentObject.name == "menuCruise" then
            currentObject:setSequence("cruise")
        end
        
        -- redundant ?? 
        -- currentObject:setFrame(1)
        
        if touchInsideBtn == true and isLoading == false then 
            -- print("touch OFF. inside")
            -- composer.removeScene("start")
            
            -- prevents scenes from firing twice!!
            isLoading = true
            
            local goto = currentObject.gotoScene
            composer.gotoScene( goto, { effect = defaultTransition } )
            
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
 
            if currentObject.name == "menuStart" then
                currentObject:setSequence("start")
            elseif currentObject.name == "menuTutorial" then
                currentObject:setSequence("tutorial")
            elseif currentObject.name == "menuCruise" then
                currentObject:setSequence("cruise")
            end
            
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if currentObject.name == "menuStart" then
                    currentObject:setSequence("start_anim")
                elseif currentObject.name == "menuTutorial" then
                    currentObject:setSequence("tutorial_anim")
                elseif currentObject.name == "menuCruise" then
                    currentObject:setSequence("cruise_anim")
                end
                currentObject:play()
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

     background=display.newRoundedRect(50,50,_W-250,_H-125,20)
     background:setFillColor(120/255,115/255,115/255)   
     --background:setStrokeColor( 25/255, 1 ,20/255 )
    -- background.strokeWidth = 5
     background.x=_W/2
     background.y=_H/2
     background.alpha=0
     transition.to( background, {time = 200, alpha=1})
      
    menuStart = display.newSprite( menuStartSheet, menuSeq )
    menuStart.x=_W/2 
    menuStart.y=_H/2 - 50
    menuStart:setSequence( "start" )
    menuStart:setFrame( 1 )
    menuStart.name = "menuStart"
    menuStart.gotoScene="game" 
    menuStart.alpha=0
    transition.to( menuStart, {time = 200, alpha=1})
 
    menuTutorial = display.newSprite( menuStartSheet, menuSeq )
    menuTutorial.x=_W/2 
    menuTutorial.y=_H/2
    menuTutorial:setSequence( "tutorial" )
    menuTutorial:setFrame( 1 )
    menuTutorial.name = "menuTutorial"
    menuTutorial.gotoScene="tutorial" 
    menuTutorial.alpha=0
    transition.to( menuTutorial, {time = 200, alpha=1})

    menuCruise = display.newSprite( menuStartSheet, menuSeq )
    menuCruise.x=_W/2 
    menuCruise.y=_H/2 + 50
    menuCruise:setSequence( "cruise" )
    menuCruise:setFrame( 1 )
    menuCruise.name = "menuCruise"
    menuCruise.gotoScene="cruise"
    menuCruise.alpha=0
    transition.to( menuCruise, {time = 200, alpha=1}) 
    
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
     end
end

function scene:destroy( event )
  local sceneGroup=self.view
  composer.hideOverlay("start")
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
