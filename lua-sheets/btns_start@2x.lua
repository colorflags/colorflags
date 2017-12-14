--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1d86b0d8cbecc587d76941a34a6386f6:8c9f126178736bf255f2f8101e49f315:a5aad66bec85923819f29deceb2a3c7d$
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
            x=188,
            y=66,
            width=178,
            height=54,

        },
        {
            -- Start2
            x=4,
            y=66,
            width=180,
            height=54,

        },
        {
            -- Start3
            x=4,
            y=4,
            width=182,
            height=58,

        },
        {
            -- Start4
            x=190,
            y=4,
            width=184,
            height=56,

        },
    },
    
    sheetContentWidth = 378,
    sheetContentHeight = 124
}

SheetInfo.frameIndex =
{

    ["Start1"] = 1,
    ["Start2"] = 2,
    ["Start3"] = 3,
    ["Start4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
