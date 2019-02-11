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
            x=8,
            y=8,
            width=464,
            height=136,

        },
        {
            -- Cruise2
            x=480,
            y=8,
            width=464,
            height=136,

        },
        {
            -- Cruise3
            x=952,
            y=8,
            width=464,
            height=136,

        },
        {
            -- Cruise4
            x=1424,
            y=8,
            width=464,
            height=136,

        },
    },
    
    sheetContentWidth = 1896,
    sheetContentHeight = 152
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
