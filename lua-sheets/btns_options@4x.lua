--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:edf6e7de2cfa64851fd0c457f8f1bc72:f4f24a5abf0b2692a7a5aafbd15db83f:99d973b437b84bb94edb4fe3c8cc0a91$
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
            -- Options1
            x=8,
            y=8,
            width=556,
            height=160,

        },
        {
            -- Options2
            x=572,
            y=8,
            width=556,
            height=160,

        },
        {
            -- Options3
            x=8,
            y=176,
            width=556,
            height=160,

        },
        {
            -- Options4
            x=572,
            y=176,
            width=556,
            height=160,

        },
    },
    
    sheetContentWidth = 1136,
    sheetContentHeight = 344
}

SheetInfo.frameIndex =
{

    ["Options1"] = 1,
    ["Options2"] = 2,
    ["Options3"] = 3,
    ["Options4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
