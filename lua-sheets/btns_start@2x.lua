--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:bc3e8bec312fc4f162ff5fed1b430250:8c9f126178736bf255f2f8101e49f315:a5aad66bec85923819f29deceb2a3c7d$
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
            x=4,
            y=4,
            width=192,
            height=68,

        },
        {
            -- Start2
            x=200,
            y=4,
            width=192,
            height=68,

        },
        {
            -- Start3
            x=396,
            y=4,
            width=192,
            height=68,

        },
        {
            -- Start4
            x=592,
            y=4,
            width=192,
            height=68,

        },
    },
    
    sheetContentWidth = 788,
    sheetContentHeight = 76
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
