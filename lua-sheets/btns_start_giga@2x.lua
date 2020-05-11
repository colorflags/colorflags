--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:34045c07d077066096eba2119f17d1d6:0043932b89c4030cb1b9bf61889ad3fe:5132887d6bc61a212885cc9a3de88122$
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
            -- Start1-giga
            x=4,
            y=4,
            width=250,
            height=90,

        },
        {
            -- Start2-giga
            x=258,
            y=4,
            width=250,
            height=90,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 98
}

SheetInfo.frameIndex =
{

    ["Start1-giga"] = 1,
    ["Start2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
