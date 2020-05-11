--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b18efd3f2bda5bf624bdd2f3a4ef2cb6:902a7c539a540ec96325474596e27b09:6dd253db3deead87dda076505c774be7$
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
            -- Options1-giga
            x=8,
            y=8,
            width=724,
            height=204,

        },
        {
            -- Options2-giga
            x=740,
            y=8,
            width=724,
            height=204,

        },
    },
    
    sheetContentWidth = 1472,
    sheetContentHeight = 220
}

SheetInfo.frameIndex =
{

    ["Options1-giga"] = 1,
    ["Options2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
