--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ff8b2498363a67245d08f8405c5705be:00677475310af80dc6dde5ba80b68f9f:93a44c2201c51e3b0e5ba520d1d57608$
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
            -- Share1
            x=106,
            y=2,
            width=98,
            height=27,

        },
        {
            -- Share2
            x=2,
            y=33,
            width=101,
            height=29,

        },
        {
            -- Share3
            x=105,
            y=33,
            width=100,
            height=29,

        },
        {
            -- Share4
            x=2,
            y=2,
            width=102,
            height=29,

        },
    },
    
    sheetContentWidth = 207,
    sheetContentHeight = 64
}

SheetInfo.frameIndex =
{

    ["Share1"] = 1,
    ["Share2"] = 2,
    ["Share3"] = 3,
    ["Share4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
