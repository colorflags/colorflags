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
            x=2,
            y=33,
            width=102,
            height=27,

        },
        {
            -- About2
            x=107,
            y=32,
            width=103,
            height=28,

        },
        {
            -- About3
            x=2,
            y=2,
            width=103,
            height=29,

        },
        {
            -- About4
            x=107,
            y=2,
            width=105,
            height=28,

        },
    },
    
    sheetContentWidth = 214,
    sheetContentHeight = 62
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
