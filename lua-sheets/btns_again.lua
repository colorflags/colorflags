--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:6c1087735724b18414702f66639ddcfb:40b6f9c66f9faaf9374f692781c995f8:56be0cc7c017c3b328dcf4c6a825c3de$
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
    },
    
    sheetContentWidth = 206,
    sheetContentHeight = 41
}

SheetInfo.frameIndex =
{

    ["Again1"] = 1,
    ["Again2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
