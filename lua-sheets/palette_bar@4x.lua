--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7f45bad33f19a2fff151db409196d3d8:ae6f64f2679c3e8bfa5367e01cb98aa1:44c778d1d633e5ff1a2555ad5ef2ad03$
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
            -- palette_bar_btm
            x=4,
            y=4,
            width=1136,
            height=140,

        },
        {
            -- palette_bar_top
            x=4,
            y=148,
            width=1136,
            height=140,

        },
    },
    
    sheetContentWidth = 1144,
    sheetContentHeight = 292
}

SheetInfo.frameIndex =
{

    ["palette_bar_btm"] = 1,
    ["palette_bar_top"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
