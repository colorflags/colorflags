--menu.lua
require("mobdebug").start()
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

local function animationPop2()
    transition.to( M.skeleton.group, { time=1250, alpha=1, onComplete=
        function()
            transition.to( M.skeleton.group, { time=1850, alpha=.9})
        end
    })
end

local tm
local function listenerA( event )
	animationPop2()
end
local function listener( event )
    animationPop2()
	tm = timer.performWithDelay( 9420, listenerA, 0 )
end
timer.performWithDelay(2600, listener)

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
    Runtime:addEventListener("enterFrame", playAnim);
	M.state:setAnimationByName(1, "cf_forward", false)
end;

local function stopAnim()
    Runtime:removeEventListener("enterFrame", playAnim);
end;

function M.load()
	-- local lastTime = 0
	result = loadSkeleton("colorflags-spine.atlas", "colorflags-spine.json", _W/2, _H/2 , 0.5, "animation")
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
	if lastUsedMusic ~= "musicMenu" then
		if lastReservedChannel == 1 then
			audio.stop(lastReservedChannel)
			lastReservedChannel = 2
			audioReservedChannels[lastReservedChannel] = audio.play( musicMenu, {channel=lastReservedChannel,loops=-1} )
		elseif lastReservedChannel == 2 then
			audio.stop(lastReservedChannel)
			lastReservedChannel = 1
			audioReservedChannels[lastReservedChannel] = audio.play( musicMenu, {channel=lastReservedChannel,loops=-1} )
		end
		lastUsedMusic = "musicMenu"
	end
else
	lastReservedChannel = 1
	audioReservedChannels[lastReservedChannel] = audio.play( musicMenu, {channel=lastReservedChannel,loops=-1} )
	lastUsedMusic = "musicMenu"
end

-- set by options.lua
soundOn=false

local whiteBackground
local titleLogo
local colorFlagsAnimBack

local currentObject
local isLoading = false
local touchInsideBtn = false
local isBtnAnim = false

-- local btnsPlayGame
-- local btnsPlayGameSheetCoords = require("lua-sheets.btns_playgame")
-- local btnsPlayGameSheet = graphics.newImageSheet("images/btns_playgame.png", btnsPlayGameSheetCoords:getSheet())
-- btnsPlayGame = display.newSprite( btnsPlayGameSheet, {frames={2}} )
-- btnsPlayGame.anchorY = .5
-- btnsPlayGame.x=_W/4
-- btnsPlayGame.y=_H - _H/4
-- btnsPlayGame:setFrame( 1 )

-- GLOBALIZE
local btnsSheetCoords = require("lua-sheets.buttons")
local btnsSheet = graphics.newImageSheet("images/buttons.png", btnsSheetCoords:getSheet())

local btnsSeq = {
	{
		name = "playgame",
		frames = {
			btnsSheetCoords:getFrameIndex("PlayGame3"),
			btnsSheetCoords:getFrameIndex("PlayGame5")
		},
		time = 500
	},
	{
		name = "playgame_anim",
		frames = {
			btnsSheetCoords:getFrameIndex("PlayGame1"),
			btnsSheetCoords:getFrameIndex("PlayGame2"),
			btnsSheetCoords:getFrameIndex("PlayGame3"),
			btnsSheetCoords:getFrameIndex("PlayGame4")
		},
		time = 500
	},
	{
		name = "options",
		frames = {
			btnsSheetCoords:getFrameIndex("Options3"),
			btnsSheetCoords:getFrameIndex("Options5")
		},
		time = 500
	},
	{
		name = "options_anim",
		frames = {
			btnsSheetCoords:getFrameIndex("Options2"),
			btnsSheetCoords:getFrameIndex("Options3"),
			btnsSheetCoords:getFrameIndex("Options4"),
			btnsSheetCoords:getFrameIndex("Options5")
		},
		time = 500
	},
	{
		name = "about",
		frames = {
			btnsSheetCoords:getFrameIndex("About3"),
			btnsSheetCoords:getFrameIndex("About5")
		},
		time = 500
	},
	{
		name = "about_anim",
		frames = {
			btnsSheetCoords:getFrameIndex("About2"),
			btnsSheetCoords:getFrameIndex("About3"),
			btnsSheetCoords:getFrameIndex("About4"),
			btnsSheetCoords:getFrameIndex("About5")
		},
		time = 500
	},
}

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

local btnsOptions
local btnsOptionsSheetCoords = require("lua-sheets.btns_options")
local btnsOptionsSheet = graphics.newImageSheet("images/btns_options.png", btnsOptionsSheetCoords:getSheet())

local btnsAbout
local btnsAboutSheetCoords = require("lua-sheets.btns_about")
local btnsAboutSheet = graphics.newImageSheet("images/btns_about.png", btnsAboutSheetCoords:getSheet())

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
			local goto = currentObject.gotoScene
			if goto == "start" and event.target == btnsPlayGame then
				composer.showOverlay( goto, { isModal= true})
			else
				-- composer.showOverlay( goto, { isModal= true})
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

-- SAM: needs work
local function doFunction(e)
	if currentObject ~= nil then
		if e.x < currentObject.contentBounds.xMin or
		e.x > currentObject.contentBounds.xMax or
		e.y < currentObject.contentBounds.yMin or
		e.y > currentObject.contentBounds.yMax then

			if(isBtnAnim) then
				if currentObject.name == "playgame" then
					currentObject:setSequence("playgame")
				elseif currentObject.name == "options" then
					currentObject:setSequence("options")
				elseif currentObject.name == "about" then
					currentObject:setSequence("about")
				end
			else
				if currentObject.name == "playgame" then
					currentObject:setFrame(1)
				elseif currentObject.name == "options" then
					currentObject:setFrame(1)
				elseif currentObject.name == "about" then
					currentObject:setFrame(1)
				end
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

				if(isBtnAnim) then
					if currentObject.name == "pg" then
						currentObject:setSequence("playgame_anim")
					elseif currentObject.name == "opt" then
						currentObject:setSequence("options_anim")
					elseif currentObject.name == "abt" then
						currentObject:setSequence("about_anim")
					end
					currentObject:play()
				else
					if currentObject.name == "playgame" then
						currentObject:setFrame(2)
					elseif currentObject.name == "options" then
						currentObject:setFrame(2)
					elseif currentObject.name == "about" then
						currentObject:setFrame(2)
					end
				end
			end
			touchInsideBtn = true
		end
	end
end

local function prepareMenu()
	titleLogo.alpha=1
	transition.to(btnsPlayGame, {time=0,alpha=.98})
	transition.to(btnsOptions, {time=0,alpha=.98})
	transition.to(btnsAbout, {time=0,alpha=.98})
end


function addFunction()
	btnsPlayGame.alpha=1
	btnsOptions.alpha=1
	btnsAbout.alpha=1
	-- btnsPlayGame:addEventListener("touch",doFunction)
	-- btnsOptions:addEventListener("touch",doFunction)
	-- btnsAbout:addEventListener("touch",doFunction)
end

-- MIKE: are we going to use this removeFunction() ??
function removeFunction()
	btnsPlayGame.alpha=0
	btnsOptions.alpha=0
	btnsAbout.alpha=0
	-- btnsPlayGame:removeEventListener("touch",doFunction)
	-- btnsOptions:removeEventListener("touch",doFunction)
	-- btnsAbout:removeEventListener("touch",doFunction)
end

--local function checkMemory(e)
-- collectgarbage();
-- print("Memory usage " .. collectgarbage("count"));
--  print("Texture memory usage " .. system.getInfo("textureMemoryUsed")/1024/1024 .. "MB")
--end

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

	whiteBackground = display.newRect( _W/2, _H/2, _W, _H )
	whiteBackground:setFillColor(1, 1, 1)

	titleLogo = display.newImageRect( "images/menu_background.png", _W, _H )
	-- titleLogo = display.newImageRect( "images/start-menuWTF.png", _W, _H )
	titleLogo.anchorX=0.5
	titleLogo.anchorY=0.5
	titleLogo.x = _W/2
	titleLogo.y = _H/2
	titleLogo.alpha=0.98


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
	colorFlagsAnimBack.y = _H/2 - 50
	colorFlagsAnimBack.blendMode = "multiply"
	colorFlagsAnimBack:setFillColor(1, 1, 1, .5)

	-- rename
	local offsetStartBtns = _H/1.5
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

	btnsPlayGame = display.newSprite( btnsPlayGameSheet, {frames={1,2,3,4}} ) -- use btnsSeq
	btnsPlayGame.name = "playgame"
	btnsPlayGame:addEventListener( "touch", myTouchListener )
	btnsPlayGame.anchorY = .5
	btnsPlayGame.x = _W/2
	btnsPlayGame.y = offsetStartBtns
	btnsPlayGame:setSequence( "playgame" )
	btnsPlayGame:setFrame(1)
	--  btnsPlayGame.alpha=0.98
	btnsPlayGame.gotoScene="start"
	--  btnsPlayGame:scale(.8,.8)

	local btnSpacing = btnsPlayGame.height + 4

	btnsOptions = display.newSprite( btnsOptionsSheet, {frames={1,2,3,4}} ) -- use btnsSeq
	btnsOptions.name = "options"
	btnsOptions:addEventListener( "touch", myTouchListener )
	btnsOptions.anchorY = .5
	btnsOptions.x = _W/2
	btnsOptions.y = offsetStartBtns+btnSpacing
	-- btnsOptions:setSequence("options")
	btnsOptions:setFrame(1)
	--  btnsOptions.alpha=.98
	btnsOptions.gotoScene = "options"
	--  btnsOptions:scale(.8,.8)

	btnsAbout = display.newSprite( btnsAboutSheet, {frames={1,2,3,4}} ) -- use btnsSeq
	btnsAbout.name = "about"
	btnsAbout:addEventListener( "touch", myTouchListener )
	btnsAbout.anchorY = .5
	btnsAbout.x = _W/2
	btnsAbout.y = offsetStartBtns+(btnSpacing*2)
	-- btnsAbout:setSequence("about")
	btnsAbout:setFrame(1)
	--  btnsAbout.alpha=0.98
	btnsAbout.gotoScene = "about"
	--  btnsAbout:scale(.8,.8)

	sceneGroup:insert(whiteBackground)
	sceneGroup:insert(titleLogo) -- SAM: BACKGROUND NOT TITLE !!! CHANGE NAME
	sceneGroup:insert(colorFlagsAnimBack)
	sceneGroup:insert(btnsPlayGame)
	sceneGroup:insert(btnsOptions)
	sceneGroup:insert(btnsAbout)
	sceneGroup:insert(M.skeleton.group)

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
	isBtnAnim = false
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
