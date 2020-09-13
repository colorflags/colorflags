--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:80265eb9c12636816c78f0cd6d4336c1:99d27d2c8f7f960f8d0e76cc28daf0ce:d07d3cd58454e6083b919315200c979d$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- flagpole_big
            x=8,
            y=8,
            width=52,
            height=568,

        },
    },
    
    sheetContentWidth = 68,
    sheetContentHeight = 584
}

SheetInfo.frameIndex =
{

    ["flagpole_big"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
