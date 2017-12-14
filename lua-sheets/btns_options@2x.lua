--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0ba78a24c344feaa0e8ce03416d0b197:f4f24a5abf0b2692a7a5aafbd15db83f:99d973b437b84bb94edb4fe3c8cc0a91$
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
            x=548,
            y=74,
            width=264,
            height=66,

        },
        {
            -- Options2
            x=548,
            y=4,
            width=266,
            height=66,

        },
        {
            -- Options3
            x=278,
            y=4,
            width=266,
            height=68,

        },
        {
            -- Options4
            x=4,
            y=4,
            width=270,
            height=68,

        },
    },
    
    sheetContentWidth = 818,
    sheetContentHeight = 144
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
