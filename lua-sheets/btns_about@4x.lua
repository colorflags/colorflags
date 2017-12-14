--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:5c448248848c47c1c01957dcf2d448c6:99690a268d6701cc0b8453c827bd0e9a:a6b0c628d49414425d775f70fac857e0$
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
            y=132,
            width=408,
            height=108,

        },
        {
            -- About2
            x=428,
            y=128,
            width=412,
            height=112,

        },
        {
            -- About3
            x=8,
            y=8,
            width=412,
            height=116,

        },
        {
            -- About4
            x=428,
            y=8,
            width=420,
            height=112,

        },
    },
    
    sheetContentWidth = 856,
    sheetContentHeight = 248
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
