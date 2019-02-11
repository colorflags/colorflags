--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ee3cc81985821fc245d109a2e5937bff:00677475310af80dc6dde5ba80b68f9f:93a44c2201c51e3b0e5ba520d1d57608$
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
            x=4,
            y=4,
            width=212,
            height=70,

        },
        {
            -- Share2
            x=220,
            y=4,
            width=212,
            height=70,

        },
        {
            -- Share3
            x=436,
            y=4,
            width=212,
            height=70,

        },
        {
            -- Share4
            x=652,
            y=4,
            width=212,
            height=70,

        },
    },
    
    sheetContentWidth = 868,
    sheetContentHeight = 78
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
