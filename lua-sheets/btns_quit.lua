--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c19a1e7524cec19f51813fc373707cae:5180ae3cd267435fff11c25b1f564104:a638f7ec1bdec1fbb914b2b2e0b78637$
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
            x=2,
            y=2,
            width=82,
            height=36,

        },
        {
            -- Quit2
            x=86,
            y=2,
            width=82,
            height=36,

        },
        {
            -- Quit3
            x=170,
            y=2,
            width=82,
            height=36,

        },
        {
            -- Quit4
            x=254,
            y=2,
            width=82,
            height=36,

        },
    },
    
    sheetContentWidth = 338,
    sheetContentHeight = 40
}

SheetInfo.frameIndex =
{

    ["Quit1"] = 1,
    ["Quit2"] = 2,
    ["Quit3"] = 3,
    ["Quit4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
