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
            x=1188,
            y=8,
            width=384,
            height=128,

        },
        {
            -- Again2
            x=404,
            y=8,
            width=384,
            height=132,

        },
        {
            -- Again3
            x=796,
            y=8,
            width=384,
            height=132,

        },
        {
            -- Again4
            x=8,
            y=8,
            width=388,
            height=132,

        },
    },
    
    sheetContentWidth = 1580,
    sheetContentHeight = 148
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
