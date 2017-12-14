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
            x=568,
            y=128,
            width=536,
            height=104,

        },
        {
            -- Tutorial2
            x=8,
            y=132,
            width=552,
            height=112,

        },
        {
            -- Tutorial3
            x=8,
            y=8,
            width=544,
            height=116,

        },
        {
            -- Tutorial4
            x=560,
            y=8,
            width=548,
            height=112,

        },
    },
    
    sheetContentWidth = 1116,
    sheetContentHeight = 252
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
