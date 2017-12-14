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
            x=1096,
            y=148,
            width=528,
            height=132,

        },
        {
            -- Options2
            x=1096,
            y=8,
            width=532,
            height=132,

        },
        {
            -- Options3
            x=556,
            y=8,
            width=532,
            height=136,

        },
        {
            -- Options4
            x=8,
            y=8,
            width=540,
            height=136,

        },
    },
    
    sheetContentWidth = 1636,
    sheetContentHeight = 288
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
