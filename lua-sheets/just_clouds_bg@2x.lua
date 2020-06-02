--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:140f2f0133f8864cfb39c5251ed330ee:746d1c03b4cf9ca35f03fa895e566c28:c54fd2c053cde38089ccb1ea5235f8b7$
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
            -- just_clouds_bg
            x=0,
            y=0,
            width=1140,
            height=720,

        },
    },
    
    sheetContentWidth = 1140,
    sheetContentHeight = 720
}

SheetInfo.frameIndex =
{

    ["just_clouds_bg"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
