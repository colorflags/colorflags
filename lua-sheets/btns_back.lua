--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a155bcbe1f74928ca4b348fef24c5dac:2618342723ee85b3eea8f2cb81a1c919:0453c91b0912199791926a1773374b4f$
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
            -- Back1
            x=2,
            y=2,
            width=91,
            height=34,

        },
        {
            -- Back2
            x=95,
            y=2,
            width=91,
            height=34,

        },
    },
    
    sheetContentWidth = 191,
    sheetContentHeight = 38
}

SheetInfo.frameIndex =
{

    ["Back1"] = 1,
    ["Back2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
