--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:79e01694f7ad704dd6562d013c950752:5e9f49927ccadee96f1290c4c386c456:a1db3c08425829f8d2ae39e343992c72$
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
            x=4,
            y=4,
            width=232,
            height=68,

        },
        {
            -- Cruise2
            x=240,
            y=4,
            width=232,
            height=68,

        },
        {
            -- Cruise3
            x=476,
            y=4,
            width=232,
            height=68,

        },
        {
            -- Cruise4
            x=712,
            y=4,
            width=232,
            height=68,

        },
    },
    
    sheetContentWidth = 948,
    sheetContentHeight = 76
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
