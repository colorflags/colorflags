--about.lua
local composer=require("composer")
local scene = composer.newScene()

local bg
local font1
local font2
local font3
local font4
local font5
local font6
local font7
local font8
local font9
local font10
local font11
local font12
local font13
local font14
local font15
local font16
local font17
local font18
local font19


local function buttonHit(event)
	local goto = event.target.gotoScene
	composer.gotoScene ( goto, { effect = defaultTransition } )
	return true
end

function scene:create( event )
	 bg=display.newRect(0,0,_W+40,_H)
   --   bg:setFillColor(128/255,0,1)

    bg:setFillColor(64/255,64/255,224/225)
          bg:toFront() 
      bg.x=_W/2
      bg.y=_H/2
      bg:toFront()



    font1 = display.newText("FFF_Tusj", _W/2, _H/2, "FFF_Tusj", 25 )
    font1.x = 80
    font1.y = 20
    font1:setFillColor(224/225,96/225,224/225)      
    font2 = display.newText("AgentOrange", _W/2, _H/2, "AgentOrange", 25 )
    font2.x = 110
    font2.y = 60
    font3 = display.newText("", _W/2, _H/2, "", 25 )
    font3.x = 80
    font3.y = 40
    font4 = display.newText("", _W/2, _H/2, "", 25 )
    font4.x = 80
    font4.y = 80
    font5 = display.newText("", _W/2, _H/2, "", 25 )
    font5.x = 80
    font5.y = 100           
    font6 = display.newText("", _W/2, _H/2, "", 25 )
    font6.x = 80
    font6.y = 120    

    font7 = display.newText("JurassicPark", _W/2, _H/2, "JurassicPark", 35 )
    font7.x = 100
    font7.y = 140
    font8 = display.newText("", _W/2, _H/2, "", 25 )
    font8.x = 80
    font8.y = 160
    font9 = display.newText("", _W/2, _H/2, "", 25 )
    font9.x = 80
    font9.y = 180
    font10 = display.newText("", _W/2, _H/2, "", 25 )
    font10.x = 80
    font10.y = 200
    font11 = display.newText("", _W/2, _H/2, "", 25 )
    font11.x = 80
    font11.y = 220           
    font12 = display.newText("", _W/2, _H/2, "", 25 )
    font12.x = 80
    font12.y = 240    

    font13 = display.newText("Crayon", _W/2, _H/2, "Crayon", 25 )
    font13.x = 80
    font13.y = 260
    font14 = display.newText("3dimension", _W/2, _H/2, "federalescort3d", 25 )
    font14.x = 80
    font14.y = 280
    font15 = display.newText("3dital", _W/2, _H/2, "federalescort3dital", 25 )
    font15.x = 80
    font15.y = 300          
    font16 = display.newText("bullet", _W/2, _H/2, "federalescortbullet", 25 )
    font16.x = 350
    font16.y = 20 

    font17 = display.newText("bulletital", _W/2, _H/2, "federalescortbulletital", 25 )
    font17.x = 350
    font17.y = 40
    font18 = display.newText("chrome", _W/2, _H/2, "federalescortchrome", 25 )
    font18.x = 350
    font18.y = 60
    font19 = display.newText("chromeital", _W/2, _H/2, "federalescortchromeital", 25 )
    font19.x = 350
    font19.y = 80
   font20 = display.newText("", _W/2, _H/2, "", 25 )
    font20.x = 350
    font20.y = 100
    font21 = display.newText("", _W/2, _H/2, "", 25 )
    font21.x = 350
    font21.y = 120           
    font22 = display.newText("expand", _W/2, _H/2, "federalescortexpand", 25 )
    font22.x = 350
    font22.y = 140   

    font23 = display.newText("expandital", _W/2, _H/2, "federalescortexpandital", 25 )
    font23.x = 280
    font23.y = 160
    font24 = display.newText("half", _W/2, _H/2, "federalescorthalf", 25 )
    font24.x = 280
    font24.y = 180
    font25 = display.newText("halfital", _W/2, _H/2, "federalescorthalfital", 25 )
    font25.x = 280
    font25.y = 200          
    font26 = display.newText("ital", _W/2, _H/2, "federalescortital", 25 )
    font26.x = 280
    font26.y = 220

    font27 = display.newText("laser", _W/2, _H/2, "federalescortlaser", 25 )
    font27.x = 280
    font27.y = 240
    font28 = display.newText("laserital", _W/2, _H/2, "federalescortlaserital", 25 )
    font28.x = 280
    font28.y = 260
    font29 = display.newText("left", _W/2, _H/2, "federalescortleft", 25 )
    font29.x = 280
    font29.y = 280
    font30 = display.newText("out", _W/2, _H/2, "federalescortout", 30 )
    font30.x = 330
    font30.y = 300   

    font31 = display.newText("outital", _W/2, _H/2, "federalescortoutital", 25 )
    font31.x = 460
    font31.y = 160           
    font32 = display.newText("scan", _W/2, _H/2, "federalescortscan", 25 )
    font32.x = 460
    font32.y = 180   

    font33 = display.newText("scanital", _W/2, _H/2, "federalescortscanital", 25 )
    font33.x = 460
    font33.y = 200
    font34 = display.newText("semiital", _W/2, _H/2, "federalescortsemiital", 30 )
    font34.x = 460
    font34.y = 230
    font35 = display.newText("Insomnia", _W/2, _H/2, "Insomnia", 30 )
    font35.x = 460
    font35.y = 260          
    font36 = display.newText("NORMA", _W/2, _H/2, "NORMA", 30 )
    font36.x = 460
    font36.y = 290

    font37 = display.newText("SnComic", _W/2, _H/2, "SnackerComic", 30 )
    font37.x = 100
    font37.y = 200

    font1:setFillColor(224/225,96/225,224/225) 
    font2:setFillColor(224/225,96/225,224/225) 
    font3:setFillColor(224/225,96/225,224/225) 
    font4:setFillColor(224/225,96/225,224/225) 
    font5:setFillColor(224/225,96/225,224/225) 
    font6:setFillColor(224/225,96/225,224/225) 
    font7:setFillColor(224/225,96/225,224/225) 
    font8:setFillColor(224/225,96/225,224/225) 
    font9:setFillColor(224/225,96/225,224/225) 
    font10:setFillColor(224/225,96/225,224/225) 
    font11:setFillColor(224/225,96/225,224/225) 
    font12:setFillColor(224/225,96/225,224/225) 
    font13:setFillColor(224/225,96/225,224/225) 
    font14:setFillColor(224/225,96/225,224/225) 
    font15:setFillColor(224/225,96/225,224/225) 
    font16:setFillColor(224/225,96/225,224/225) 
    font17:setFillColor(224/225,96/225,224/225) 
    font18:setFillColor(224/225,96/225,224/225) 
    font19:setFillColor(224/225,96/225,224/225) 
    font20:setFillColor(224/225,96/225,224/225) 
    font21:setFillColor(224/225,96/225,224/225) 
    font22:setFillColor(224/225,96/225,224/225) 
    font23:setFillColor(224/225,96/225,224/225) 
    font24:setFillColor(224/225,96/225,224/225) 
    font25:setFillColor(224/225,96/225,224/225) 
    font26:setFillColor(224/225,96/225,224/225) 
    font27:setFillColor(224/225,96/225,224/225) 
    font28:setFillColor(224/225,96/225,224/225) 
    font29:setFillColor(224/225,96/225,224/225) 
    font30:setFillColor(224/225,96/225,224/225) 
    font31:setFillColor(224/225,96/225,224/225) 
    font32:setFillColor(224/225,96/225,224/225) 
    font33:setFillColor(224/225,96/225,224/225) 
    font34:setFillColor(224/225,96/225,224/225) 
    font35:setFillColor(224/225,96/225,224/225) 
    font36:setFillColor(224/225,96/225,224/225) 
    font37:setFillColor(224/225,96/225,224/225) 
	

	local backBtn = makeTextButton("Back", 40, _H-20, {listener=buttonHit, group=group})
	backBtn.gotoScene = "menu"

  self.view:insert(backBtn)
end

function scene:show( event )
	local group = self.view
end

function scene:hide( event )
	if scene.view=="will" then
		   composer.removeScene("options",false)  
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
