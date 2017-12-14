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
            x=1372,
            y=8,
            width=440,
            height=104,

        },
        {
            -- Cruise2
            x=8,
            y=8,
            width=448,
            height=112,

        },
        {
            -- Cruise3
            x=920,
            y=8,
            width=444,
            height=112,

        },
        {
            -- Cruise4
            x=464,
            y=8,
            width=448,
            height=112,

        },
    },
    
    sheetContentWidth = 1820,
    sheetContentHeight = 128
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
