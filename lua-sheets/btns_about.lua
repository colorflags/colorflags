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
            x=2,
            y=2,
            width=108,
            height=34,

        },
        {
            -- About2
            x=112,
            y=2,
            width=108,
            height=34,

        },
        {
            -- About3
            x=222,
            y=2,
            width=108,
            height=34,

        },
        {
            -- About4
            x=332,
            y=2,
            width=108,
            height=34,

        },
    },
    
    sheetContentWidth = 442,
    sheetContentHeight = 38
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
