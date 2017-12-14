--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:592d32f8e345460eb1b77495f067d9e9:5e9f49927ccadee96f1290c4c386c456:a1db3c08425829f8d2ae39e343992c72$
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
            -- Cruise1
            x=343,
            y=2,
            width=110,
            height=26,

        },
        {
            -- Cruise2
            x=2,
            y=2,
            width=112,
            height=28,

        },
        {
            -- Cruise3
            x=230,
            y=2,
            width=111,
            height=28,

        },
        {
            -- Cruise4
            x=116,
            y=2,
            width=112,
            height=28,

        },
    },
    
    sheetContentWidth = 455,
    sheetContentHeight = 32
}

SheetInfo.frameIndex =
{

    ["Cruise1"] = 1,
    ["Cruise2"] = 2,
    ["Cruise3"] = 3,
    ["Cruise4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
