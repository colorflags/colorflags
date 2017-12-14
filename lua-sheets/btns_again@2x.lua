--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0b05be8cc35db8c50f4e884713076c93:fadfbc870d42decd454b16010cc29010:56be0cc7c017c3b328dcf4c6a825c3de$
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
            -- Again1
            x=594,
            y=4,
            width=192,
            height=64,

        },
        {
            -- Again2
            x=202,
            y=4,
            width=192,
            height=66,

        },
        {
            -- Again3
            x=398,
            y=4,
            width=192,
            height=66,

        },
        {
            -- Again4
            x=4,
            y=4,
            width=194,
            height=66,

        },
    },
    
    sheetContentWidth = 790,
    sheetContentHeight = 74
}

SheetInfo.frameIndex =
{

    ["Again1"] = 1,
    ["Again2"] = 2,
    ["Again3"] = 3,
    ["Again4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
