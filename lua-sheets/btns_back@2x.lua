--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:122c60d9c9155ef86ca72b10c74e009f:b28db9051ba7c3209a8577c4c973aaab:0453c91b0912199791926a1773374b4f$
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
            y=68,
            width=166,
            height=56,

        },
        {
            -- Back2
            x=180,
            y=4,
            width=172,
            height=58,

        },
        {
            -- Back3
            x=180,
            y=66,
            width=170,
            height=58,

        },
        {
            -- Back4
            x=4,
            y=4,
            width=172,
            height=60,

        },
    },
    
    sheetContentWidth = 356,
    sheetContentHeight = 128
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
