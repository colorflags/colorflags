--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:fe91eaed63e5e629236c351f2e55d14c:3074d674ee8c16010c5f75dbb82ec210:c5884ac85bc0e25745132c46775f4a7c$
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
            -- PlayGame1
            x=8,
            y=8,
            width=724,
            height=160,

        },
        {
            -- PlayGame2
            x=740,
            y=8,
            width=724,
            height=160,

        },
    },
    
    sheetContentWidth = 1472,
    sheetContentHeight = 176
}

SheetInfo.frameIndex =
{

    ["PlayGame1"] = 1,
    ["PlayGame2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
