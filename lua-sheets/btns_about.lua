--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c2ee3493a9b7b7cbdbf52972b9ec6e8b:4ae25aeab4ba9dcad17e68d3368620ea:a6b0c628d49414425d775f70fac857e0$
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
    },
    
    sheetContentWidth = 222,
    sheetContentHeight = 38
}

SheetInfo.frameIndex =
{

    ["About1"] = 1,
    ["About2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
