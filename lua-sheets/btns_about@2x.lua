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
            x=4,
            y=66,
            width=204,
            height=54,

        },
        {
            -- About2
            x=214,
            y=64,
            width=206,
            height=56,

        },
        {
            -- About3
            x=4,
            y=4,
            width=206,
            height=58,

        },
        {
            -- About4
            x=214,
            y=4,
            width=210,
            height=56,

        },
    },
    
    sheetContentWidth = 428,
    sheetContentHeight = 124
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
