--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a858ea046305488922415d0b6469b96a:64919f971a530045a2b0767a54f09044:554b6f30c2802724c779208ee0f94411$
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
            -- Tutorial1
            x=142,
            y=32,
            width=134,
            height=26,

        },
        {
            -- Tutorial2
            x=2,
            y=33,
            width=138,
            height=28,

        },
        {
            -- Tutorial3
            x=2,
            y=2,
            width=136,
            height=29,

        },
        {
            -- Tutorial4
            x=140,
            y=2,
            width=137,
            height=28,

        },
    },
    
    sheetContentWidth = 279,
    sheetContentHeight = 63
}

SheetInfo.frameIndex =
{

    ["Tutorial1"] = 1,
    ["Tutorial2"] = 2,
    ["Tutorial3"] = 3,
    ["Tutorial4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
