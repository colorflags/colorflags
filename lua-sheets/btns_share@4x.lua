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
            x=424,
            y=8,
            width=392,
            height=108,

        },
        {
            -- Share2
            x=8,
            y=132,
            width=404,
            height=116,

        },
        {
            -- Share3
            x=420,
            y=132,
            width=400,
            height=116,

        },
        {
            -- Share4
            x=8,
            y=8,
            width=408,
            height=116,

        },
    },
    
    sheetContentWidth = 828,
    sheetContentHeight = 256
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
