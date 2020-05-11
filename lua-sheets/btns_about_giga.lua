--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:563eb9e4beae6495145b0a614747ef1d:6e08dd14d8118f3e86b0aca41d6dc38c:ef6928b6f3670eaa12d6b7de199e5d00$
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
            -- About1-giga
            x=2,
            y=2,
            width=141,
            height=45,

        },
        {
            -- About2-giga
            x=145,
            y=2,
            width=141,
            height=45,

        },
    },
    
    sheetContentWidth = 288,
    sheetContentHeight = 49
}

SheetInfo.frameIndex =
{

    ["About1-giga"] = 1,
    ["About2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
