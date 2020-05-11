--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:73479980938b5d0a37a396257cb39c57:4e3681c029a2041b8e3466ce805f6a58:554b6f30c2802724c779208ee0f94411$
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
            -- Tutorial1
            x=2,
            y=2,
            width=141,
            height=34,

        },
        {
            -- Tutorial2
            x=145,
            y=2,
            width=141,
            height=34,

        },
    },
    
    sheetContentWidth = 288,
    sheetContentHeight = 38
}

SheetInfo.frameIndex =
{

    ["Tutorial1"] = 1,
    ["Tutorial2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
