--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:3b71ad5c9a7fbbb62fcade7b51ef4928:931bac425352850472de0ca881abe2a8:96dee931b2ce17d2b269564295099ee2$
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
            -- map_mask_2018
            x=4,
            y=4,
            width=1136,
            height=640,

        },
    },
    
    sheetContentWidth = 1144,
    sheetContentHeight = 650
}

SheetInfo.frameIndex =
{

    ["map_mask_2018"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
