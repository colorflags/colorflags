local composer = require("composer")
local scene = composer.newScene()

local catchAllTaps

local background
local phaseGroup=display.newGroup()

local resume = 0
local btnsResume
local btnsQuit

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
            if event.target == btnsResume then
                resume = 0
            else
                resume = 1
            end
            catchAllTaps()
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
            if touchInsideBtn == true then
                currentObject.xScale = 1
                currentObject.yScale = 1
                print("finger down, outside button: ", currentObject.name)
            end
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                currentObject.xScale = 1.05
                currentObject.yScale = 1.05
                print("finger down, outside button: ", currentObject.name)
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

catchAllTaps = function(e)
    catchAll:removeEventListener("tap",catchAllTaps)
    background:removeEventListener("tap",doNothing)
    btnsResume:removeEventListener( "touch", myTouchListener )
    btnsResume:removeEventListener( "touch", doFunction )
    btnsQuit:removeEventListener( "touch", myTouchListener )
    btnsQuit:removeEventListener( "touch", doFunction )
    composer.hideOverlay()
end

local function initFunction()
    catchAll:addEventListener("tap",catchAllTaps)
    background:addEventListener("tap",doNothing)
    btnsResume:addEventListener( "touch", myTouchListener )
    btnsResume:addEventListener( "touch", doFunction )
    btnsQuit:addEventListener( "touch", myTouchListener )
    btnsQuit:addEventListener( "touch", doFunction )
end

 function catchBackgroundOverlay(event)
	return true
end

function scene:create( event )
    local sceneGroup=self.view
	catchAll=display.newRect( 0, 0, _W, _H )
	catchAll.anchorX=0
	catchAll.anchorY=0
	catchAll.isHitTestable = true
	catchAll.alpha=0.8

    -- local x = 1 menuBtnsGroup = event.params.menuBtnsGroup
    local offsetStartBtns = _H/2

	local paint = {
	    type = "gradient",
	    color1 = { .6, .6, .6, 1 },
	    color2 = { .2, .2, .2, 1 },
	    direction = "down"
	}

    background=display.newRoundedRect(50, 50, _W/4, _H/4, 20)
    background:setFillColor(.45,.4,.4)
    background:setStrokeColor( 0, 0, 0 )
    background.strokeWidth = 1
    background.fill = paint
	background.x= _W/2
	background.y = _H/2

    local btnsGroup = display.newGroup()

    local colorFillArray = CFColor(78, 173, 34)
    local colorShadowArray = CFColor(96, 212, 42)
    local scoreboardColor = { colorFillArray.r, colorFillArray.g, colorFillArray.b }
    local scoreboardEmbossColor = {
        highlight = { r = 0, g = 0, b = 0 },
        shadow = { r = colorShadowArray.r, g = colorShadowArray.g, b = colorShadowArray.b }
    }

    local font = "fonts/chaparralpro-semiboldit.otf"

    btnsResume = display.newEmbossedText("Resume", _W/2, background.y - (background.height/4), font, 22)
    btnsResume:setFillColor(unpack(scoreboardColor))
    btnsResume:setEmbossColor(scoreboardEmbossColor)
    btnsResume.anchorY = 0
    btnsGroup:insert(btnsResume)

    btnsQuit = display.newEmbossedText("Quit", _W/2, btnsResume.y, font, 22)
    btnsQuit:setFillColor(unpack(scoreboardColor))
    btnsQuit:setEmbossColor(scoreboardEmbossColor)
    btnsQuit.y = btnsQuit.y + 22
    btnsQuit.anchorY = 0
    btnsGroup:insert(btnsQuit)

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
        if resume == 0 then
            parent:focusGame()
        else
            parent:focusGameAndQuit()
        end
    end
end

function scene:destroy( event )
  local sceneGroup=self.view
  print("destroy pauseoverlay")

  -- Do we need this? We already have a removeIt() function
  composer.hideOverlay("pauseoverlay")
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
