require("mobdebug").start()

local composer=require("composer")

-- utf8 = require( "plugin.utf8" )
ponyfont = require("ponyfont")

require("ssk2.loadSSK")
require("cf_game_settings")
require("cf_game_scale_components")
require("cf_game_sfx")
CFGameSettings = CFGameSettings()
CFGameScaleComponents = CFGameScaleComponents()
CFGameSFX = CFGameSFX()

-- SAM: Uncomment and test!
_G.ssk.init({})
ssk.persist.setDefault( "score.json", "highScore", 0 )
ssk.persist.setDefault( "scone.json", "bought_extra_content", false )

-- SAM: delete?
--_W = display.pixelWidth
--_H = display.pixelHeight
_G._W = display.contentWidth -- Get the width of the screen
_G._H = display.contentHeight -- Get the height of the screen
_G.fps = display.fps
_G.scaleSuffix = display.imageSuffix
_G.license = false
-- print(scaleSuffix)
-- print(display.safeActualContentWidth)
print("width: " .. _W, "height: " .. _H)
print("actualContentWidth: " .. display.actualContentWidth, "actualContentHeight: " .. display.actualContentHeight)

display.setStatusBar( display.HiddenStatusBar )

----- PERMISSIONS ------
local function appPermissionsListener( event )
    for k,v in pairs( event.grantedAppPermissions ) do
        if ( v == "Storage" ) then
            print( "Storage permission granted!" )
        end
    end
end

local options =
{
    appPermission = "Storage",
    urgency = "Critical",
    listener = appPermissionsListener,
    rationaleTitle = "Storage access required",
    rationaleDescription = "Storage access is required play Color Flags",
    settingsRedirectTitle = "Alert",
    settingsRedirectDescription = "Without the ability to write to storage, this app will not properly function. Please grant storage access within Settings."
}
native.showPopup( "requestAppPermission", options )
----- END PERMISSIONS ------

_G.platform = system.getInfo( "platform" )
if platform == "android" then
	local function onResize( event )
		native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
	end
	Runtime:addEventListener( "resize", onResize )
end

function runMain()
	print("pixelHeight: " .. display.pixelHeight, "pixelWidth: " .. display.pixelWidth)

	_G.pixelRatio = display.pixelHeight / display.pixelWidth
	print("pixel ratio: " .. pixelRatio)

	-- Override Corona's core widget libraries with the files contained in this project's subdirectory.
	-- Argument "name" will be set to the name of the library being loaded by the require() function.
	local function onRequireWidgetLibrary(name)
		return require("_widget_library." .. name)
	end
	package.preload.widget = onRequireWidgetLibrary
	package.preload.widget_tableview = onRequireWidgetLibrary

	-- For xcode console output
	io.output():setvbuf( "no" )

	defaultTransition="crossFade"

	overrideScore=true  --set true to test gameover.lua

	local fontFace
	local backgrounImage=nil
	local backgroundColor={255,255,255}

	-- SAM: when building with sizeoverloadkey, audio.loadStream() failed to create stream
	_G.musicMenu = audio.loadStream( "magee_music/magee_main.mp3" ) -- rename magee_main.mp3 to magee_menu.mp3
	_G.musicGameOver = audio.loadStream( "magee_music/magee_gameover.mp3" )

	audio.reserveChannels( 2 )
	audio.setVolume( .5, { channel = 1 } )
	audio.setVolume( .5, { channel = 2 } )

	_G.audioReservedChannels = {nil, nil}
	_G.lastReservedChannel = nil
	_G.lastUsedMusic = nil

	-- SAM: what is this?
	audioCanPlay=true

	-- SAM: what's this?
	--composer.recycleOnSceneChange = true

	-- SAM: cool, test this out. Do we still need it?
	function checkMemory(e)
	  collectgarbage();
	  print("Memory usage " .. collectgarbage("count"));
	  print("Texture memory usage " .. system.getInfo("textureMemoryUsed")/1024/1024 .. "MB")
	end

	composer.gotoScene( "game", {effect = defaultTransition})
end
runMain()
