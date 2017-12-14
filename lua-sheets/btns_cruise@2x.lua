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
            x=686,
            y=4,
            width=220,
            height=52,

        },
        {
            -- Cruise2
            x=4,
            y=4,
            width=224,
            height=56,

        },
        {
            -- Cruise3
            x=460,
            y=4,
            width=222,
            height=56,

        },
        {
            -- Cruise4
            x=232,
            y=4,
            width=224,
            height=56,

        },
    },
    
    sheetContentWidth = 910,
    sheetContentHeight = 64
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
