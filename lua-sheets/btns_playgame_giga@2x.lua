--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:d008b974716a2d9d038af510eb1fe6fa:c02b896bd417abbce4c655c796698943:4ad21c99ba2516e16290b69fdcaac994$
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
            -- PlayGame1-giga
            x=4,
            y=4,
            width=470,
            height=102,

        },
        {
            -- PlayGame2-giga
            x=478,
            y=4,
            width=470,
            height=102,

        },
    },
    
    sheetContentWidth = 952,
    sheetContentHeight = 110
}

SheetInfo.frameIndex =
{

    ["PlayGame1-giga"] = 1,
    ["PlayGame2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
