--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a7ff4061079ff45f11196b1fb49c6571:7f8b32d3056d4d4bc75b8de7fe5cd14d:1d5efca211c629884f7ad90fba00083f$
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
            -- newmap2017_3
            x=8,
            y=8,
            width=8124,
            height=3404,

        },
    },
    
    sheetContentWidth = 8140,
    sheetContentHeight = 3420
}

SheetInfo.frameIndex =
{

    ["newmap2017_3"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
