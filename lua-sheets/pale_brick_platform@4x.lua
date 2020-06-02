--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7dddc7842f1d7fd0e73f81b8ce4a9727:68952d1f9948e5c037e084072f9762db:dd605d968ba8baa27264327756227b5d$
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
            -- pale_brick_platform_btm
            x=0,
            y=0,
            width=712,
            height=40,

        },
        {
            -- pale_brick_platform_top
            x=712,
            y=0,
            width=652,
            height=40,

        },
    },
    
    sheetContentWidth = 1364,
    sheetContentHeight = 40
}

SheetInfo.frameIndex =
{

    ["pale_brick_platform_btm"] = 1,
    ["pale_brick_platform_top"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
