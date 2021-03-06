--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:4ffb85fd8dee9178e2bf61035b50f7fe:b0f2dca3f418bad52d6b7dc94035cffa:314077c1e12a481ee5b3bd4cf24addf3$
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
            -- Quit1-giga
            x=2,
            y=2,
            width=106,
            height=47,

        },
        {
            -- Quit2-giga
            x=110,
            y=2,
            width=106,
            height=47,

        },
    },
    
    sheetContentWidth = 218,
    sheetContentHeight = 51
}

SheetInfo.frameIndex =
{

    ["Quit1-giga"] = 1,
    ["Quit2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
