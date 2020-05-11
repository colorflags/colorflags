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
            x=8,
            y=8,
            width=520,
            height=192,

        },
        {
            -- Again2-giga
            x=536,
            y=8,
            width=520,
            height=192,

        },
    },
    
    sheetContentWidth = 1064,
    sheetContentHeight = 208
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
