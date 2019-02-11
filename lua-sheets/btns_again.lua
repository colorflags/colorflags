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
            x=2,
            y=2,
            width=100,
            height=37,

        },
        {
            -- Again2
            x=104,
            y=2,
            width=100,
            height=37,

        },
        {
            -- Again3
            x=206,
            y=2,
            width=100,
            height=37,

        },
        {
            -- Again4
            x=308,
            y=2,
            width=100,
            height=37,

        },
    },
    
    sheetContentWidth = 410,
    sheetContentHeight = 41
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
