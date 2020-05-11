--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1bc3a3650596318068bfee00ac6caad6:4c00b38461a8d7d87e0e426e96a6f8b3:99d973b437b84bb94edb4fe3c8cc0a91$
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
    },
    
    sheetContentWidth = 1136,
    sheetContentHeight = 176
}

SheetInfo.frameIndex =
{

    ["Options1"] = 1,
    ["Options2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
