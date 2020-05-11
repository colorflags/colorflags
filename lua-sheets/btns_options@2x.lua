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
            x=4,
            y=4,
            width=278,
            height=80,

        },
        {
            -- Options2
            x=286,
            y=4,
            width=278,
            height=80,

        },
    },
    
    sheetContentWidth = 568,
    sheetContentHeight = 88
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
