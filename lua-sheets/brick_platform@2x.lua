--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:f0ab82c8117d777c83fb910dbcaa92ff:93b38a5d007d58fcda4b0c62a4bac8da:a2d03116fe9746ffd2eb68da0afd660e$
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
            -- brick_platform4
            x=0,
            y=0,
            width=356,
            height=34,

        },
    },
    
    sheetContentWidth = 356,
    sheetContentHeight = 34
}

SheetInfo.frameIndex =
{

    ["brick_platform4"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
