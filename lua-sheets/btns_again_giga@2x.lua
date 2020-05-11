--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:51b772a00e7ee38b0502f9169a934132:de2b69154a00df189e3176f4d43ec82b:2971947c8e4fe43ce5663021385936f9$
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
            -- Again1-giga
            x=4,
            y=4,
            width=260,
            height=96,

        },
        {
            -- Again2-giga
            x=268,
            y=4,
            width=260,
            height=96,

        },
    },
    
    sheetContentWidth = 532,
    sheetContentHeight = 104
}

SheetInfo.frameIndex =
{

    ["Again1-giga"] = 1,
    ["Again2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
