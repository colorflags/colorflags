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
            x=2,
            y=2,
            width=139,
            height=40,

        },
        {
            -- Options2
            x=143,
            y=2,
            width=139,
            height=40,

        },
        {
            -- Options3
            x=2,
            y=44,
            width=139,
            height=40,

        },
        {
            -- Options4
            x=143,
            y=44,
            width=139,
            height=40,

        },
    },
    
    sheetContentWidth = 284,
    sheetContentHeight = 86
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
