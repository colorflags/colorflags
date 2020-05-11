--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:82c1c44cbcc9506fa0ccb73b83c7758a:e5a8a4060fa72f4ee9e3ff4402544ade:a638f7ec1bdec1fbb914b2b2e0b78637$
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
            -- Quit1
            x=4,
            y=4,
            width=164,
            height=72,

        },
        {
            -- Quit2
            x=172,
            y=4,
            width=164,
            height=72,

        },
    },
    
    sheetContentWidth = 340,
    sheetContentHeight = 80
}

SheetInfo.frameIndex =
{

    ["Quit1"] = 1,
    ["Quit2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
