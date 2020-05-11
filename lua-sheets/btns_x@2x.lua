--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a6624c7fe6b8ffee3423d4d09d0950ff:15a739db1518a4715ed8ee261ace183b:179560bb2aa7df634d5e9cf94275cd57$
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
            -- x1
            x=4,
            y=4,
            width=124,
            height=88,

        },
        {
            -- x2
            x=132,
            y=4,
            width=124,
            height=88,

        },
    },
    
    sheetContentWidth = 260,
    sheetContentHeight = 96
}

SheetInfo.frameIndex =
{

    ["x1"] = 1,
    ["x2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
