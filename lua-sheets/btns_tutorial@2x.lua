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
            x=284,
            y=64,
            width=268,
            height=52,

        },
        {
            -- Tutorial2
            x=4,
            y=66,
            width=276,
            height=56,

        },
        {
            -- Tutorial3
            x=4,
            y=4,
            width=272,
            height=58,

        },
        {
            -- Tutorial4
            x=280,
            y=4,
            width=274,
            height=56,

        },
    },
    
    sheetContentWidth = 558,
    sheetContentHeight = 126
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
