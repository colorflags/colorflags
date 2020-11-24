--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e80dab8c2cb8a162fb74e1ea0b9984af:a5ef2ec5235f2429d2c5f346d328787a:11b0e1a505262fc4574ad993adbecee1$
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
            -- icons-arrow
            x=2,
            y=2,
            width=57,
            height=26,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 57,
            sourceHeight = 26
        },
    },
    
    sheetContentWidth = 61,
    sheetContentHeight = 30
}

SheetInfo.frameIndex =
{

    ["icons-arrow"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
