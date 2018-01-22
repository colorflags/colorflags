--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0b5f4d9c4897dcdaf981f8f190ced07f:64e2d2d0eb79638453a157a19533f691:48f4421d6af096191c3d57e6cf21956b$
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
            -- map_mask_1
            x=0,
            y=0,
            width=1136,
            height=640,

        },
    },
    
    sheetContentWidth = 1136,
    sheetContentHeight = 640
}

SheetInfo.frameIndex =
{

    ["map_mask_1"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
