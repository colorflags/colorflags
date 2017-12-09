local composer=require("composer")
local scene = composer.newScene()

local infoYesBtn = {}
local infoNoBtn = {}
local infoIcon

local backBtn

local currentObject
local touchInsideBtn = false
local isBtnAnim = false

local jamBtn = {}
local stopBtn = {}
local playBtn ={}
-- local jamBtn ??

local phasePic
local phaseNarrowBtn = {}
local phaseWideBtn = {}
local phaseFullBtn
local phaseGroup=display.newGroup()

local ffBtn
local rwBtn

local pauseTimer
local refreshTimer
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
    local textArray = {}
    local offset = size / (size / 2)
    local textForeground = display.newText(text, x, y, (font), size)
    local textBackground = display.newText(text, x+offset, y+offset, (font), size)
    textForeground:setFillColor( 189/255, 177/255, 255/255 )
    textBackground:setFillColor( 47/255, 44/255, 64/255)
    -- self:insert(shadow)
    -- self:insert(label)
    textArray[1] = textForeground
    textArray[2] = textBackground
    return textArray
end

-- phase2 and phase3 are used for button click animation
local function phase2(e)
    transition.to(e,{time=50, xScale=.8,yScale=.8,onComplete=phase3})
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

local function buttonHit(e)

    print(e.target.type)
    if e.target==backBtn then
        -- back button
        local goto = e.target.gotoScene
	    composer.gotoScene ( goto, { effect = defaultTransition } )
    elseif e.target==ffBtn then
        -- >>
        transition.to(ffBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
    elseif e.target==rwBtn then
        -- <<
        transition.to(rwBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
    else
        -- all other buttons
        display.remove(ffBtn)
        display.remove(rwBtn)

        if e.target.type=="music" then
            -- display.remove(stopBtn)
            -- display.remove(jamBtn)
            -- display.remove(playBtn)

            if e.target==playBtn[1] then
                -- play
                -- stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), arialFont, 30 )
                -- jamBtn = display.newText("Music",_W*(1/4)-15, _H*(4/5) , arialFont, 35 )
                if soundOn==false then
                    media.playSound(music)
                    soundOn=true
                    print("music")
                end
            -- playBtn = display.newText("Anthem", _W/2-10, _H*(4/5), arialFont, 35 )
            transition.to(playBtn[1],{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})

            elseif e.target==stopBtn[1] then
                -- stop
                -- playBtn = display.newText("Anthem", _W/2-10, _H*(4/5), arialFont, 35 )
                -- jamBtn = display.newText("Music", _W*(1/4)-15, _H*(4/5), arialFont, 35 )
                if soundOn==true then
                    media.stopSound(music)
                    music=nil
                    soundOn=false
                    print("stop")
                end
                -- stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), arialFont, 35 )
                transition.to(stopBtn[1],{time=50, xScale=1.2,yScale=1.2, font=50,onComplete=phase2})
            elseif e.target==jamBtn[1] then
                -- anthem
                -- stopBtn = display.newText("Mute", _W*(3/4)+10, _H*(4/5), arialFont, 35 )
                -- playBtn = display.newText("Anthem", _W/2-10, _H*(4/5), arialFont, 35 )
                -- jamBtn = display.newText("Music", _W*(1/4)-15, _H*(4/5), arialFont, 35 )
                ffBtn = display.newText(">>", (_W*(1/6))+60, _H*(2/3), arialFont, 35 )
                rwBtn = display.newText("<<", _W*(1/6), _H*(2/3), arialFont, 35 )
                ffBtn:setFillColor( 0,0,0 )
                rwBtn:setFillColor( 0,0,0 )
                transition.to(ffBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
                transition.to(rwBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
                transition.to(jamBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
                phaseGroup:insert(ffBtn)
                phaseGroup:insert(rwBtn)
                ffBtn:addEventListener("tap",buttonHit)
                rwBtn:addEventListener("tap",buttonHit)
            end

             playBtn:setFillColor(0,0,0)
             jamBtn:setFillColor(0,0,0)
             stopBtn:setFillColor(0,0,0)
             jamBtn.type="music"
             stopBtn.type="music"
             playBtn.type="music"
             phaseGroup:insert(jamBtn)
             phaseGroup:insert(stopBtn)
             phaseGroup:insert(playBtn)
             jamBtn:addEventListener("tap",buttonHit)
             stopBtn:addEventListener("tap",buttonHit)
             playBtn:addEventListener("tap",buttonHit)

        elseif e.target.type=="phase" then
            -- display.remove(phaseWideBtn)
            -- display.remove(phaseNarrowBtn)
            display.remove(phasePic)

            if e.target==phaseWideBtn[1] then
                -- wide
                phasePic = display.newImage("images/widePic.png", 585,337)
                heightModeTop=35
                heightModeLow=_H-35
                lightningY=90
                -- phaseNarrowBtn = display.newText("Narrow", _W*(3/4) ,_H*(1/6), arialFont, 35 )
                -- phaseWideBtn = display.newText("Wide", _W*(1/5), _H*(1/6) , arialFont, 35 )
                transition.to(phaseWideBtn[1],{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
            elseif e.target==phaseNarrowBtn[1] then
                -- narrow
                phasePic = display.newImage("images/narrowPic.png", 585,337)
                heightModeTop=70
                heightModeLow=_H-70
                lightningY=16
                -- phaseWideBtn = display.newText("Wide", _W*(1/5) ,_H*(1/6) , arialFont, 35 )
                -- phaseNarrowBtn = display.newText("Narrow",_W*(3/4) ,_H*(1/6), arialFont, 35 )
                transition.to(phaseNarrowBtn[1],{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
            end

            phasePic.x = _W/2
            phasePic.y = _H*(1/6)
            phasePic.xScale = .2
            phasePic.yScale = .2
            phaseGroup:insert(phasePic)

            -- phaseNarrowBtn:setFillColor(0,0,0)
            -- phaseWideBtn:setFillColor(0,0,0)
            -- phaseWideBtn.type="phase"
            -- phaseNarrowBtn.type="phase"
            -- phaseGroup:insert(phaseWideBtn)
            -- phaseGroup:insert(phaseNarrowBtn)
            -- phaseWideBtn:addEventListener("tap",buttonHit)
            -- phaseNarrowBtn:addEventListener("tap",buttonHit)
       print(e.target.type)
        elseif e.target.type=="info" then
            display.remove(infoIcon)
            if e.target==infoYesBtn[1] then
                -- Yes
                transition.to(infoYesBtn[1],{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
                infoMode=true
                infoIcon = display.newImage("images/info.png",256,256)

            elseif e.target==infoNoBtn[1] then
                -- No
                transition.to(infoNoBtn[1],{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
                infoMode=false
                infoIcon = display.newImage("images/infoGray.png",256,256)
            end

        infoIcon.x = _W/2
        infoIcon.y = _H/2
        infoIcon.xScale = .4
        infoIcon.yScale = .4
        phaseGroup:insert(infoIcon)
        -- transition.to(infoIcon,{time=50, xScale=0.45,yScale=0.45,onComplete=phaseA})
        end
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

        phaseNarrowBtn = createText("Narrow", _W*(3/4), _H*(1/6), arialFont, 35 )
        phaseWideBtn = createText("Wide", _W*(1/5), _H*(1/6), arialFont, 35 )

        if heightModeTop == 35 then
            phasePic = display.newImage("images/widePic.png", 585,337)
        else
            phasePic = display.newImage("images/narrowPic.png", 585,337)

        end

        phasePic.x = _W/2
        phasePic.y = _H*(1/6)
        phasePic.xScale = .2
        phasePic.yScale = .2

        infoNoBtn = createText("No", _W*(3/4),_H*(1/2), arialFont, 35)
        infoYesBtn = createText("Yes", _W*(1/5),_H*(1/2), arialFont, 35)

        if infoMode == true then
            infoIcon = display.newImage("images/info.png",256,256)
        else
            infoIcon = display.newImage("images/infoGray.png",256,256)
        end

        infoIcon.x = _W/2
        infoIcon.y = _H/2
        infoIcon.xScale = .4
        infoIcon.yScale = .4

        playBtn = createText("Anthem", _W/2-10, _H*(4/5), arialFont, 35 )
        stopBtn = createText("Mute", _W*(3/4)+10, _H*(4/5), arialFont, 35 )
        jamBtn = createText("Music", _W*(1/4)-15, _H*(4/5), arialFont, 35 )

        phaseNarrowBtn[1].type="phase"
        phaseWideBtn[1].type="phase"

        infoNoBtn[1].type="info"
        infoYesBtn[1].type="info"

        playBtn[1].type="music"
        stopBtn[1].type="music"
        jamBtn[1].type="music"

        -- transition.to(phaseNarrowBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        -- transition.to(phaseWideBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        -- transition.to(infoYesBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        -- transition.to(infoNoBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})

        -- transition.to(playBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        -- transition.to(stopBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})
        -- transition.to(jamBtn,{time=50, xScale=1.2,yScale=1.2,onComplete=phase2})

        -- Add these insert() into the createText() function?
        phaseGroup:insert(phaseNarrowBtn[1])
        phaseGroup:insert(phaseNarrowBtn[2])
        phaseGroup:insert(phaseWideBtn[1])
        phaseGroup:insert(phaseWideBtn[2])

        phaseGroup:insert(phasePic)
        phaseGroup:insert(infoIcon)

        phaseGroup:insert(infoYesBtn[1])
        phaseGroup:insert(infoYesBtn[2])
        phaseGroup:insert(infoNoBtn[1])
        phaseGroup:insert(infoNoBtn[2])

        phaseGroup:insert(jamBtn[1])
        phaseGroup:insert(jamBtn[2])
        phaseGroup:insert(playBtn[1])
        phaseGroup:insert(playBtn[2])
        phaseGroup:insert(stopBtn[1])
        phaseGroup:insert(stopBtn[2])

        phaseNarrowBtn[1]:addEventListener("tap",buttonHit)
        phaseWideBtn[1]:addEventListener("tap",buttonHit)

        infoYesBtn[1]:addEventListener("tap",buttonHit)
        infoNoBtn[1]:addEventListener("tap",buttonHit)

        jamBtn[1]:addEventListener("tap",buttonHit)
        playBtn[1]:addEventListener("tap",buttonHit)
        stopBtn[1]:addEventListener("tap",buttonHit)

        --[[
            transition.to(playBtn, {time=25,x= _W/2-10,y=_H*(17/24)+5 })
            transition.to(stopBtn, {time=25,x=_W*(3/4)+10 ,y= _H*(19/24)-10 })
            transition.to(jamBtn, {time=25,x=_W*(1/4)-15 ,y= _H*(15/24) })
            transition.to(phaseNarrowBtn, {time=25,x=_W*(1/4)+30 ,y=_H*(7/24) })
            transition.to(phaseWideBtn, {time=25, x= _W*(3/4)-10 ,y=_H*7/24 })
        --]]
    elseif event.phase=="did" then
        backBtn:addEventListener("touch", myTouchListener)
        backBtn:addEventListener("touch", doFunction)
    end
end

function scene:hide( event )
    if event.phase == "will" then
        display.remove(phaseGroup)
        -- SAM: what about removing all the other listeners added in scene:show ???
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
