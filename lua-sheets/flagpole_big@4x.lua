--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ebd65932ef58bfcff06a627c54d09176:a4e6ea7200e29063f70c1d328272fd3f:d07d3cd58454e6083b919315200c979d$
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
            x=0,
            y=0,
            width=52,
            height=568,

        },
    },
    
    sheetContentWidth = 52,
    sheetContentHeight = 568
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
