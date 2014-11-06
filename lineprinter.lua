--[[ =========================================
	Part of the Outlaw Game Tools Lib 
	http://OutlawGameTools.com
	Copyright 2013 J. A. Whye
--==========================================]]

--[[ =========================================
	Sample Usage

	require("lineprinter")

	local fields = { 
		{"Your Great Game", size=18, color={255, 255, 255}, align="center" },
		{" ", size=14},
		{"by You Alone", color={255, 255, 0} },
		{"Copyright 2013" },
		{" "},
		{"Published by" },
		{"Giant Games Software" },
		{" "},
		{"Production & Design" },
		{"Friend #1" },
		{"Friend #2" },
	}
		
linePrinter(fields, centerX, centerY-90)

--==========================================]]

local defaultLinePrinterSize = 14
local defaultLinePrinterFont = "Helvetica"
local defaultLinePrinterColor = {0,0,0}
local defaultLinePrinterAlign = "center"

function linePrinter(t, xStart, yStart, grp)
	local lineSpacing = 18
	local xLoc = xStart
	local yLoc = yStart
	local idx = 1
	local fontSize
	local fontFace = "Helvetica"
	local lineColor
	
	for i = 1, #t do
		if t[i][1] ~= nil and t[i][1] ~= "" then
			
			fontSize = t[i]["size"] or defaultLinePrinterSize
			defaultLinePrinterSize = fontSize
			fontFace = t[i]["font"] or defaultLinePrinterFont
			defaultLinePrinterFont = fontFace
			lineColor = t[i]["color"] or defaultLinePrinterColor
			defaultLinePrinterColor = lineColor
			alignment = t[i]["align"] or defaultLinePrinterAlign
			defaultLinePrinterAlign = alignment
			
			local txt = display.newText( t[i][1], 0, 0, fontFace, fontSize )
			txt.x = xLoc
			txt.y = yLoc + (idx * lineSpacing)
			txt:setFillColor ( lineColor[1], lineColor[2], lineColor[3] )
			lineSpacing = fontSize + 4
			
			if alignment ~= nil then
				if alignment == "center" then
					txt.anchorX=0.5
					txt.anchorY=0.5
					txt.x = centerX
				elseif alignment == "right" then
					txt.anchorX=0.5
					txt.anchorY=0.5
					txt.x = _W - xLoc	
				end
			end
			
			if grp then
				grp:insert(txt)
			end
			idx = idx + 1
		end
	end
end

