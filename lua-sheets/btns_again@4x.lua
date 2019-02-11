--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b0028f54c336847565427d16ac72f7a1:fadfbc870d42decd454b16010cc29010:56be0cc7c017c3b328dcf4c6a825c3de$
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
            x=8,
            y=8,
            width=400,
            height=148,

        },
        {
            -- Again2
            x=416,
            y=8,
            width=400,
            height=148,

        },
        {
            -- Again3
            x=824,
            y=8,
            width=400,
            height=148,

        },
        {
            -- Again4
            x=1232,
            y=8,
            width=400,
            height=148,

        },
    },
    
    sheetContentWidth = 1640,
    sheetContentHeight = 164
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
