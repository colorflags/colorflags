--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0b39b29a67e6db7823df026ff80817d2:5180ae3cd267435fff11c25b1f564104:a638f7ec1bdec1fbb914b2b2e0b78637$
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
            x=237,
            y=2,
            width=74,
            height=29,

        },
        {
            -- Quit2
            x=81,
            y=2,
            width=76,
            height=30,

        },
        {
            -- Quit3
            x=159,
            y=2,
            width=76,
            height=30,

        },
        {
            -- Quit4
            x=2,
            y=2,
            width=77,
            height=30,

        },
    },
    
    sheetContentWidth = 313,
    sheetContentHeight = 34
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
