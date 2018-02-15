--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:04c5a02d8e4d04e52a3e254ece69223c:6a114d65b3674c5f9b69c787c0d207ca:52b9ae356f3c66d49a2c7810924286e9$
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
            -- map_mask_2018_3px
            x=0,
            y=0,
            width=574,
            height=326,

        },
    },
    
    sheetContentWidth = 574,
    sheetContentHeight = 326
}

SheetInfo.frameIndex =
{

    ["map_mask_2018_3px"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
