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
            x=212,
            y=4,
            width=196,
            height=54,

        },
        {
            -- Share2
            x=4,
            y=66,
            width=202,
            height=58,

        },
        {
            -- Share3
            x=210,
            y=66,
            width=200,
            height=58,

        },
        {
            -- Share4
            x=4,
            y=4,
            width=204,
            height=58,

        },
    },
    
    sheetContentWidth = 414,
    sheetContentHeight = 128
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
