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
            x=4,
            y=4,
            width=216,
            height=68,

        },
        {
            -- About2
            x=224,
            y=4,
            width=216,
            height=68,

        },
        {
            -- About3
            x=444,
            y=4,
            width=216,
            height=68,

        },
        {
            -- About4
            x=664,
            y=4,
            width=216,
            height=68,

        },
    },
    
    sheetContentWidth = 884,
    sheetContentHeight = 76
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
