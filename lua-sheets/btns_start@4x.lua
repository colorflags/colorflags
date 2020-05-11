--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:3bd1df757ed116f8cf52a08265ff72d6:9c173fbdeced61accaabb059c1c9cc67:528589a0cf6b7962e3ba926d9e9d7755$
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
            -- Start1
            x=8,
            y=8,
            width=384,
            height=136,

        },
        {
            -- Start2
            x=400,
            y=8,
            width=384,
            height=136,

        },
    },
    
    sheetContentWidth = 804,
    sheetContentHeight = 152
}

SheetInfo.frameIndex =
{

    ["Start1"] = 1,
    ["Start2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
