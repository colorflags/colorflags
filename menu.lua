require("cf_color")
local composer=require("composer")
local scene = composer.newScene()

local spine = require "spine-corona.spine"

local _lastTime = 0
local M = {}

function loadSkeleton(atlasFile, jsonFile, x, y, scale, animation, skin)
	-- to load an atlas, we need to define a function that returns
	-- a Corona paint object. This allows you to resolve images
	-- however you see fit
	local imageLoader = function (path)
		local paint = { type = "image", filename = "data/" .. path }
		return paint
	end

	-- load the atlas
	local atlas = spine.TextureAtlas.new(spine.utils.readFile("data/" .. atlasFile), imageLoader)

	-- load the JSON and create a Skeleton from it
	local json = spine.SkeletonJson.new(spine.AtlasAttachmentLoader.new(atlas))
	json.scale = scale
	local skeletonData = json:readSkeletonDataFile("data/" .. jsonFile)
	local skeleton = spine.Skeleton.new(skeletonData)
	skeleton.scaleY = -1 -- Corona's coordinate system has its y-axis point downwards
	skeleton.group.x = x
	skeleton.group.y = y

	-- Set the skin if we got one
	if skin then skeleton:setSkin(skin) end

	-- create an animation state object to apply animations to the skeleton
	local animationStateData = spine.AnimationStateData.new(skeletonData)
	animationStateData.defaultMix = 0.5
	local animationState = spine.AnimationState.new(animationStateData)

	-- set a name on the group of the skeleton so we can find it during debugging
	skeleton.group.name = jsonFile

	-- set some event callbacks
	animationState.onStart = function (entry)
		-- print(entry.trackIndex.." start: "..entry.animation.name)
	end
	animationState.onInterrupt = function (entry)
		-- print(entry.trackIndex.." interrupt: "..entry.animation.name)
	end
	animationState.onEnd = function (entry)
		-- print(entry.trackIndex.." end: "..entry.animation.name)
	end
	animationState.onComplete = function (entry)
		if M.animation == 0 then
			M.state:setAnimationByName(1, "cf_hold25", false)
			M.animation = 1
		elseif M.animation == 1 then
			M.state:setAnimationByName(1, "cf_backward", false)
			M.animation = 2
		elseif M.animation == 2 then
			M.state:setAnimationByName(1, "cf_hold1", false)
			M.animation = 3
		elseif M.animation == 3 then
			M.state:setAnimationByName(1, "cf_forward", false)
			M.animation = 0
		end
		-- print(entry.trackIndex.." complete: "..entry.animation.name)
	end
	animationState.onDispose = function (entry)
		-- print(entry.trackIndex.." dispose: "..entry.animation.name)
	end
	animationState.onEvent = function (entry, event)
		-- print(entry.trackIndex.." event: "..entry.animation.name..", "..event.data.name..", "..event.intValue..", "..event.floatValue..", '"..(event.stringValue or "").."'" .. ", " .. event.volume .. ", " .. event.balance)
	end

	-- return the skeleton an animation state
	return { skeleton = skeleton, state = animationState }
end

local function playAnim(event)
	local currentTime = event.time / 3000
	local delta = currentTime - _lastTime
	_lastTime = currentTime

	local skeleton = M.skeleton;
	local state = M.state;
	state:update(delta)
	state:apply(skeleton)

	skeleton:updateWorldTransform();

end;

local function startAnim()
	M.skeleton.group.alpha = 0.85
    Runtime:addEventListener("enterFrame", playAnim);
	M.state:setAnimationByName(1, "cf_forward", false)
end;

local function stopAnim()
    Runtime:removeEventListener("enterFrame", playAnim);
end;

function M.load()
	-- local lastTime = 0
	result = loadSkeleton("colorflags-spine.atlas", "colorflags-spine.json", _W/2, _H/2.8 , 0.5, "animation")
	-- local skeleton = result.skeleton;
	-- local state = result.state;
    -- local spineData = Skeleton.load("res/game/dice/skeleton", centerX + 120, centerY - 200, 0.5, "shake");
    M.skeleton = result.skeleton;
    M.state = result.state;
	M.animation = 0
    -- End roll event
    M.state.onEvent = onRollComplete;
    -- M.skeleton.group.rotation = 175;
	-- M.skeleton.group.alpha = 0;

end;

M.load()
startAnim()

music=nil
bobby=nil

if lastReservedChannel ~= nil then
	audio.rewind( musicMenu )
	if lastUsedMusic ~= "musicMenu" then
		if lastReservedChannel == 1 then
			audio.stop(lastReservedChannel)
			lastReservedChannel = 2
			audio.stop(lastReservedChannel)
	        audio.setVolume( .5, { channel = lastReservedChannel } )
			audioReservedChannels[lastReservedChannel] = audio.play( musicMenu, {channel=lastReservedChannel,loops=-1} )
		elseif lastReservedChannel == 2 then
			audio.stop(lastReservedChannel)
			lastReservedChannel = 1
			audio.stop(lastReservedChannel)
	        audio.setVolume( .5, { channel = lastReservedChannel } )
			audioReservedChannels[lastReservedChannel] = audio.play( musicMenu, {channel=lastReservedChannel,loops=-1} )
		end
		lastUsedMusic = "musicMenu"
	end
else
	lastReservedChannel = 1
	audio.stop(lastReservedChannel)
    audio.setVolume( .5, { channel = lastReservedChannel } )
	audioReservedChannels[lastReservedChannel] = audio.play( musicMenu, {channel=lastReservedChannel,loops=-1} )
	lastUsedMusic = "musicMenu"
end

-- set by options.lua
soundOn=false

local whiteBackground
local titleLogo
local colorFlagsAnimBack

local btnsGroup

local currentObject
local isLoading = false
local touchInsideBtn = false

-- local btnsPlayGame
-- local btnsPlayGameSheetCoords = require("lua-sheets.btns_playgame")
-- local btnsPlayGameSheet = graphics.newImageSheet("images/btns_playgame.png", btnsPlayGameSheetCoords:getSheet())
-- btnsPlayGame = display.newSprite( btnsPlayGameSheet, {frames={2}} )
-- btnsPlayGame.anchorY = .5
-- btnsPlayGame.x=_W/4
-- btnsPlayGame.y=_H - _H/4
-- btnsPlayGame:setFrame( 1 )

local menuSpriteCoords = require("lua-sheets.playgame-menu")
local menuStartSheet = graphics.newImageSheet( "images/playgame-menu.png", menuSpriteCoords:getSheet() )


local startBtnSeq = {
	{ name = "playgame", frames={8,9}, time=500 },
	{ name = "options", frames={5,6}, time=500 },
	{ name = "about", frames={1,2}, time=500 }
}

local btnsPlayGame
local btnsPlayGameSheetCoords = require("lua-sheets.btns_playgame")
local btnsPlayGameSheet = graphics.newImageSheet("images/btns_playgame.png", btnsPlayGameSheetCoords:getSheet())

local btnsPlayGameGiga
local btnsPlayGameGigaSheetCoords = require("lua-sheets.btns_playgame_giga")
local btnsPlayGameGigaSheet = graphics.newImageSheet("images/btns_playgame_giga.png", btnsPlayGameGigaSheetCoords:getSheet())

local btnsOptions
local btnsOptionsSheetCoords = require("lua-sheets.btns_options")
local btnsOptionsSheet = graphics.newImageSheet("images/btns_options.png", btnsOptionsSheetCoords:getSheet())

local btnsOptionsGiga
local btnsOptionsGigaSheetCoords = require("lua-sheets.btns_options_giga")
local btnsOptionsGigaSheet = graphics.newImageSheet("images/btns_options_giga.png", btnsOptionsGigaSheetCoords:getSheet())

local btnsAbout
local btnsAboutSheetCoords = require("lua-sheets.btns_about")
local btnsAboutSheet = graphics.newImageSheet("images/btns_about.png", btnsAboutSheetCoords:getSheet())

local btnsAboutGiga
local btnsAboutGigaSheetCoords = require("lua-sheets.btns_about_giga")
local btnsAboutGigaSheet = graphics.newImageSheet("images/btns_about_giga.png", btnsAboutGigaSheetCoords:getSheet())

-- SAM: needs work
local function myTouchListener( event )
	currentObject = event.target
	display.getCurrentStage():setFocus(currentObject)
	if event.phase == "began" then
		print("touch ON. inside")
	elseif event.phase == "ended" or event.phase == "cancelled" then
		if currentObject.name == "playgame" then
			currentObject:setFrame(1)
		elseif currentObject.name == "options" then
			currentObject:setFrame(1)
		elseif currentObject.name == "about" then
			currentObject:setFrame(1)
		end

		-- redundant ??
		-- currentObject:setFrame(1)
		print(touchInsideBtn, isLoading)
		if touchInsideBtn == true and isLoading == false then

			print("touch OFF. inside")
			-- composer.removeScene("start")

			-- prevents scenes from firing twice!!
			isLoading = true
			print("going to..")
			local gotoo = currentObject.gotoScene
			composer.gotoScene ( gotoo, { effect = defaultTransition } )
			--[[
			if gotoo == "start" and event.target == btnsPlayGame then
				-- use for bringing up start overlay
				composer.showOverlay( gotoo, { isModal = true, params = { menuBtnsGroup = btnsGroup } })
			else
				composer.gotoScene ( gotoo, { effect = defaultTransition } )
			end
			]]--
		elseif touchInsideBtn == false then
			-- print("touch OFF outside")
		end

		currentObject = nil
		display.getCurrentStage():setFocus(nil)
		touchInsideBtn = false
	end
end

-- SAM: needs work
local function doFunction(e)
	if currentObject ~= nil then
		if e.x < currentObject.contentBounds.xMin or
		e.x > currentObject.contentBounds.xMax or
		e.y < currentObject.contentBounds.yMin or
		e.y > currentObject.contentBounds.yMax then
			if currentObject.name == "playgame" then
				currentObject:setFrame(1)
			elseif currentObject.name == "options" then
				currentObject:setFrame(1)
			elseif currentObject.name == "about" then
				currentObject:setFrame(1)
			end

			-- currentObject:setFrame(2)
			-- SAM: wtf. how is this working? do some testing.
			if(touchInsideBtn == true) then
				currentObject.xScale = 1
				currentObject.yScale = 1
				print("finger down, outside button: ", currentObject.name)
			end
			touchInsideBtn = false
		else
			if touchInsideBtn == false then
				print("finger down, inside button: ", currentObject.name)

				currentObject.xScale = 1
				currentObject.yScale = 1
				-- currentObject.xScale = 1.01
				-- currentObject.yScale = 1.01

				if currentObject.name == "playgame" then
					currentObject:setFrame(2)
				elseif currentObject.name == "options" then
					currentObject:setFrame(2)
				elseif currentObject.name == "about" then
					currentObject:setFrame(2)
				end
			end
			touchInsideBtn = true
		end
	end
end

-- DELETE?
local function prepareMenu()
	transition.to(btnsPlayGame, {time=0,alpha=.98})
	transition.to(btnsOptions, {time=0,alpha=.98})
	transition.to(btnsAbout, {time=0,alpha=.98})
end

-- DELETE?
function addFunction()
	btnsPlayGame.alpha=1
	btnsOptions.alpha=1
	btnsAbout.alpha=1
	-- btnsPlayGame:addEventListener("touch",doFunction)
	-- btnsOptions:addEventListener("touch",doFunction)
	-- btnsAbout:addEventListener("touch",doFunction)
end

-- DELETE?
function removeFunction()
	btnsPlayGame.alpha=0
	btnsOptions.alpha=0
	btnsAbout.alpha=0
	-- btnsPlayGame:removeEventListener("touch",doFunction)
	-- btnsOptions:removeEventListener("touch",doFunction)
	-- btnsAbout:removeEventListener("touch",doFunction)
end

local function spriteListener( event )
	local thisSprite = event.target  -- "event.target" references the sprite

	if ( event.phase == "ended" ) then
		if thisSprite.sequence == "cf_hold_1" or thisSprite.sequence == "cf_hold_25" then
			if animatedDirection == 0 then
				thisSprite:setSequence( "cf_forward" )
				thisSprite:play()
				animatedDirection = 1
			elseif animatedDirection == 1 then
				thisSprite:setSequence( "cf_backward" )
				thisSprite:play()
				animatedDirection = 0
			end
		else
			if animatedDirection == 0 then
				thisSprite:setSequence( "cf_hold_1" )
				thisSprite:play()
			elseif animatedDirection == 1 then
				thisSprite:setSequence( "cf_hold_25" )
				thisSprite:play()
			end
		end
	end
end


function scene:create( event )
	local sceneGroup=self.view
	print("a")

	local paint = {
	    type = "gradient",
	    color1 = { .6, .6, .6, 1 },
	    color2 = { .2, .2, .2, 1 },
	    direction = "down"
	}

	whiteBackground = display.newRect( _W/2, _H/2, _W, _H )
	whiteBackground.fill = paint
	-- whiteBackground:setFillColor(.5, .5, .5)

	titleLogo = display.newImageRect( "images/menu_background.png", _W, _H )
	titleLogo.anchorX=0.5
	titleLogo.anchorY=0.5
	titleLogo.x = _W/2
	titleLogo.y = _H/2

	local sequenceData =
	{
	    name="walking",
	    frames= { 1 }, -- frame indexes of animation, in image sheet
	    time = 240,
	    loopCount = 0        -- Optional ; default is 0
	}

	local sheetOptions =
	{
	    --array of tables representing each frame (required)
	    frames =
	    {
	        -- Frame 1
	        {
	            --all parameters below are required for each frame
	            x = 2,
	            y = 2,
	            width = 1107,
	            height = 194
	        }
	    },

	    -- Optional parameters; used for scaled content support
	    sheetContentWidth = 2048,
	    sheetContentHeight = 512
	}
	local sheet = graphics.newImageSheet( "data/colorflags-spine6.png", sheetOptions )

	colorFlagsAnimBack = display.newSprite( sheet, sequenceData )
	colorFlagsAnimBack:scale(0.5, 0.5)
	colorFlagsAnimBack.x = _W/2
	colorFlagsAnimBack.y = _H/2.8 - 50
	colorFlagsAnimBack:setFillColor(1, 1, 1, .2)

	-- rename
	local offsetStartBtns = _H/2
	-- local offsetStartBtns = _H/3 + ((_H/2)/2)

	local tempSeq = {
		{
			name = "playgame_anim",
			frames = {
				btnsPlayGameSheetCoords:getFrameIndex("PlayGame1"),
				btnsPlayGameSheetCoords:getFrameIndex("PlayGame2"),
				btnsPlayGameSheetCoords:getFrameIndex("PlayGame3"),
				btnsPlayGameSheetCoords:getFrameIndex("PlayGame4")
			},
			time = 500
		},
	}

	btnsGroup = display.newGroup()

	btnsPlayGame = display.newSprite( btnsPlayGameGigaSheet, {frames={1,2}} ) -- use btnsSeq
	btnsPlayGame.name = "playgame"
	btnsPlayGame:addEventListener( "touch", myTouchListener )
	btnsPlayGame.anchorY = .5
	btnsPlayGame.x = _W/2
--	btnsPlayGame.y = offsetStartBtns
	btnsPlayGame:setSequence( "playgame" )
	btnsPlayGame:setFrame(1)
	 btnsPlayGame.alpha=0.9
	btnsPlayGame.gotoScene="game"
	--  btnsPlayGame:scale(.8,.8)
    btnsGroup:insert(btnsPlayGame)

	local btnSpacing = btnsPlayGame.height + 4

	btnsOptions = display.newSprite( btnsOptionsGigaSheet, {frames={1,2}} ) -- use btnsSeq
	btnsOptions.name = "options"
	btnsOptions:addEventListener( "touch", myTouchListener )
	btnsOptions.anchorY = .5
	btnsOptions.x = _W/2
	btnsOptions.y = btnSpacing
	-- btnsOptions:setSequence("options")
	btnsOptions:setFrame(1)
	 btnsOptions.alpha=.9
	btnsOptions.gotoScene = "options"
	--  btnsOptions:scale(.8,.8)
    btnsGroup:insert(btnsOptions)

	btnsAbout = display.newSprite( btnsAboutGigaSheet, {frames={1,2}} ) -- use btnsSeq
	btnsAbout.name = "about"
	btnsAbout:addEventListener( "touch", myTouchListener )
	btnsAbout.anchorY = .5
	btnsAbout.x = _W/2
	btnsAbout.y = btnSpacing*2
	-- btnsAbout:setSequence("about")
	btnsAbout:setFrame(1)
	 btnsAbout.alpha=0.9
	btnsAbout.gotoScene = "about"
	--  btnsAbout:scale(.8,.8)
    btnsGroup:insert(btnsAbout)
    btnsGroup.y = _H - btnsGroup.height + 10

	sceneGroup:insert(whiteBackground)
	sceneGroup:insert(titleLogo) -- SAM: BACKGROUND NOT TITLE !!! CHANGE NAME
	sceneGroup:insert(colorFlagsAnimBack)
    sceneGroup:insert(btnsGroup)
	sceneGroup:insert(M.skeleton.group)

	if _G.license == true then
		local licenseGroup = display.newGroup()
		local licenseFont = "fonts/ptmono-bold.ttf"

		local colorFillArray = CFColor(0, 210, 240)
		local colorFillArray2 = CFColor(136, 208, 223)

		local licenseDesc = display.newText("licensed", 5, display.contentHeight + 3, licenseFont, 18)
		licenseDesc:setFillColor(colorFillArray.r, colorFillArray.g, colorFillArray.b)
		-- licenseDesc:setEmbossColor(licenseEmbossColor)
		licenseDesc.anchorX = 0
		licenseDesc.anchorY = 1
		licenseDesc.xScale = 1.01
		licenseDesc.yScale = 1.10
		local licenseDesc2 = display.newText("licensed", 6, display.contentHeight + 2, licenseFont, 18)
		licenseDesc2:setFillColor(colorFillArray2.r, colorFillArray2.g, colorFillArray2.b)
		-- licenseDesc:setEmbossColor(licenseEmbossColor)
		licenseDesc2.anchorX = 0
		licenseDesc2.anchorY = 1

		local licenseDot = display.newCircle( licenseDesc.x - 2, display.contentHeight - licenseDesc.height/2 + 3, 2 )
		licenseDot:setFillColor(colorFillArray.r, colorFillArray.g, colorFillArray.b)
		licenseDot.xScale = 1.01
		licenseDot.yScale = 1.10
		local licenseDot2 = display.newCircle( licenseDesc.x - 1, display.contentHeight - licenseDesc.height/2 + 3, 2 )
		licenseDot2:setFillColor(colorFillArray2.r, colorFillArray2.g, colorFillArray2.b)

		licenseGroup:insert(licenseDesc)
		licenseGroup:insert(licenseDesc2)
		licenseGroup:insert(licenseDot)
		licenseGroup:insert(licenseDot2)
		sceneGroup:insert(licenseGroup)
	end

	btnsPlayGame:addEventListener("touch",doFunction)
	btnsOptions:addEventListener("touch",doFunction)
	btnsAbout:addEventListener("touch",doFunction)
end

function scene:focusMenu()
	print("re-focus menu.lua")
	btnsPlayGame.xScale = 1
	btnsPlayGame.yScale = 1
	isLoading = false
	touchInsideBtn = false
end

function scene:show( event )
	local sceneGroup=self.view
	local phase = event.phase
	touchInsideBtn = false
	print("focus")
	if event.phase == "will" then
		print("b")
		--Runtime:addEventListener("enterFrame", checkMemory)
	elseif event.phase == "did" then
		print("c")

		--   prepareMenu()
		--timer.performWithDelay(300,eraseSplash,1)

		-- ALSO IN ERASESPLASH>>>>????
		-- COMPARE WITH gameover.lua


	end
end

function scene:hide( event )
	local sceneGroup=self.view
	local phase = event.phase

	print("a")
	if event.phase=="will" then

		print("d")
		composer.removeScene("menu",false)
	end
end

function scene:destroy( event )
	local group = self.view
	stopAnim()
	if tm then
		timer.cancel( tm )
	end
	print("e")

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-----------------------------------------------------------------------------------------
return scene
