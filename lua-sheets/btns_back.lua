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
            x=2,
            y=34,
            width=83,
            height=28,

        },
        {
            -- Back2
            x=90,
            y=2,
            width=86,
            height=29,

        },
        {
            -- Back3
            x=90,
            y=33,
            width=85,
            height=29,

        },
        {
            -- Back4
            x=2,
            y=2,
            width=86,
            height=30,

        },
    },
    
    sheetContentWidth = 178,
    sheetContentHeight = 64
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
