--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c4b2bd1367fc13bb683e21909e1d4fe5:b28db9051ba7c3209a8577c4c973aaab:0453c91b0912199791926a1773374b4f$
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
            x=4,
            y=4,
            width=182,
            height=68,

        },
        {
            -- Back2
            x=190,
            y=4,
            width=182,
            height=68,

        },
        {
            -- Back3
            x=376,
            y=4,
            width=182,
            height=68,

        },
        {
            -- Back4
            x=562,
            y=4,
            width=182,
            height=68,

        },
    },
    
    sheetContentWidth = 748,
    sheetContentHeight = 76
}

SheetInfo.frameIndex =
{

    ["Back1"] = 1,
    ["Back2"] = 2,
    ["Back3"] = 3,
    ["Back4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
