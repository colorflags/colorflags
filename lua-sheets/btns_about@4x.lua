--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:91f4dd597443a0f6154e8d0dec97fda5:99690a268d6701cc0b8453c827bd0e9a:a6b0c628d49414425d775f70fac857e0$
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
            -- About1
            x=8,
            y=8,
            width=432,
            height=136,

        },
        {
            -- About2
            x=448,
            y=8,
            width=432,
            height=136,

        },
        {
            -- About3
            x=888,
            y=8,
            width=432,
            height=136,

        },
        {
            -- About4
            x=1328,
            y=8,
            width=432,
            height=136,

        },
    },
    
    sheetContentWidth = 1768,
    sheetContentHeight = 152
}

SheetInfo.frameIndex =
{

    ["About1"] = 1,
    ["About2"] = 2,
    ["About3"] = 3,
    ["About4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
