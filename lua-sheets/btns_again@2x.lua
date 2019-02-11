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
            x=4,
            y=4,
            width=200,
            height=74,

        },
        {
            -- Again2
            x=208,
            y=4,
            width=200,
            height=74,

        },
        {
            -- Again3
            x=412,
            y=4,
            width=200,
            height=74,

        },
        {
            -- Again4
            x=616,
            y=4,
            width=200,
            height=74,

        },
    },
    
    sheetContentWidth = 820,
    sheetContentHeight = 82
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
