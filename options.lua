local composer=require("composer")
local scene = composer.newScene()

local currentObject
local touchInsideBtn = false
local isBtnAnim = false

local backBtn

local phaseGroup = display.newGroup()

local options = {}
options.music = true

local optionsMusicGroup
local optionsMusicBtn
local optionsMusicStatus

local jamBtn = {}
local stopBtn = {}
local playBtn = {}

local font
local arialFont = "Arial Rounded MT Bold"

local musicOff

local btnsSheetCoords = require("lua-sheets.buttons")

local btnsSheet = graphics.newImageSheet("images/buttons.png", btnsSheetCoords:getSheet())

local btnsSeq = {
    {
        name = "backBtn",
        frames = {
            btnsSheetCoords:getFrameIndex("backArrowBtn3"),
            btnsSheetCoords:getFrameIndex("backArrowBtn5")
        },
        time = 500
    },
    {
        name = "backBtn_anim",
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
local function myTouchListener(event)
    currentObject = event.target
    display.getCurrentStage():setFocus(currentObject)
    print(currentObject.name)
    if event.phase == "began" then
        print("touch ON. inside")
    elseif event.phase == "ended" or event.phase == "cancelled" then

        -- setSequence() below redundant ?? Isn't this handled in the doFunction()
        if currentObject.name == "backBtn" then
            currentObject:setSequence("backBtn")
        end

        if touchInsideBtn == true then

            print("touch OFF. inside")
            -- composer.removeScene("start")

            if(currentObject.name == "backBtn") then
                composer.gotoScene("menu", { effect = defaultTransition })
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
                if currentObject.name == "backBtn" then
                    currentObject:setSequence("backBtn")
                end
            else
                if currentObject.name == "backBtn" then
                    currentObject:setFrame(1)
                end
            end
            -- redundant ??
            -- currentObject:setFrame(1)
            touchInsideBtn = false
        else
            if touchInsideBtn == false then
                if(isBtnAnim) then
                    if currentObject.name == "backBtn" then
                        currentObject:setSequence("backBtn_anim")
                    end
                    currentObject:play()
                else
                    if currentObject.name == "backBtn" then
                        currentObject:setFrame(2)
                    end
                end
            end
            touchInsideBtn = true
        end
    end
end

function createText(text, x, y, font, size)
    -- SAM: delete
    local textArray = {}
    -- purplish
    local textForeground = display.newText(text, x, y, font, size)
    textForeground:setFillColor( 189/255, 177/255, 255/255 )
    local textBackground = display.newText(text, x, y, font, size)
    textBackground:setFillColor( 47/255, 44/255, 64/255)

    -- SAM: delete
    textArray[1] = textForeground
    textArray[2] = textBackground
    return textArray
end

-- phase2 and phase3 are used for button click animation
local function phase2(e)
    transition.to(e,{time=50, xScale=1,yScale=1,onComplete=phase3})
end
local function phase3(e)
    transition.to(e,{time=50, xScale=1,yScale=1})
end

-- phaseA and phaseB are used for info icon animation
local function phaseA(e)
    transition.to(e,{time=50, xScale=.35,yScale=.35,onComplete=phaseB})
end
local function phaseB(e)
    transition.to(e,{time=50, xScale=.4,yScale=.4})
end

-- SAM: Rename
local function buttonHit(e)
    local group = e.target
    -- SAM: backBtn check NOT NEEDED
    if group == optionsMusicGroup then
        if options.music == true then
            optionsMusicStatus.text = "OFF"
            optionsMusicStatus:setFillColor(0,1,0)
            options.music = false
        elseif options.music == false then
            optionsMusicStatus.text = "ON"
            optionsMusicStatus:setFillColor(1,0,0)
            options.music = true
        end
        transition.to(group[2], {time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
    end
    return true
end

function scene:create( event )
    local margins = 6
	titleLogo = display.newImageRect( "images/options_menu.png", _W, _H )
    titleLogo.alpha = 1
	titleLogo.anchorX=0.5
	titleLogo.anchorY=0.5
	titleLogo.x = _W/2
	titleLogo.y = _H/2
    self.view:insert(titleLogo)

	backBtn = display.newSprite(btnsSheet, btnsSeq)
    backBtn:setSequence("backBtn")
    backBtn.name = "backBtn"
    backBtn.anchorX = 0
    backBtn.anchorY = 1
    backBtn.x = 0 + margins
    backBtn.y = _H - backBtn.y - margins
	backBtn.gotoScene = "menu"
    backBtn:setFillColor(224/225,96/225,224/225)

    self.view:insert(backBtn)
end


function scene:show( event )

    local group = self.view
    if event.phase == "will" then

        local optionsAnchorX = _W * (1/2)
        local optionsAnchorY = _H * (1/5)

        optionsMusicGroup = display.newGroup()
        optionsMusicBtn = display.newRoundedRect(optionsMusicGroup, optionsAnchorX, optionsAnchorY, _W/3, 34, 1)
        optionsMusicBtn:setFillColor(.2, .2, .2)
        optionsMusicBtn.alpha = 0
        optionsMusicBtn.isHitTestable = true

        jamBtn = createText("Music", optionsAnchorX, optionsMusicBtn.y, arialFont, 28 )
        optionsMusicGroup:insert(jamBtn[2])
        optionsMusicGroup:insert(jamBtn[1])

        optionsMusicStatus = display.newText(optionsMusicGroup, "", optionsAnchorX + optionsMusicBtn.width/2, optionsMusicBtn.y + 4, arialFont, 16)
        if options.music == true then
            optionsMusicStatus.text = "ON"
            optionsMusicStatus:setFillColor(1,0,0)
        elseif options.music == false then
            optionsMusicStatus.text = "OFF"
            optionsMusicStatus:setFillColor(0,1,0)
        end
        optionsMusicStatus.alpha = 1
        optionsMusicStatus.anchorX = 1

        optionsMusicGroup:addEventListener("tap", buttonHit)

    elseif event.phase=="did" then
        backBtn:addEventListener("touch", myTouchListener)
        backBtn:addEventListener("touch", doFunction)
    end
end

function scene:hide( event )
    if event.phase == "will" then
        display.remove(optionsMusicGroup)
        optionsMusicGroup:removeEventListener("tap", buttonHit)
        backBtn:removeEventListener("touch", myTouchListener)
        backBtn:removeEventListener("touch", doFunction)
        composer.removeScene("options",false)
    elseif event.phase == "did" then
      --  composer.gotoScene("menu", {effect=defaultTransition} )
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
