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
            x=2,
            y=2,
            width=96,
            height=34,

        },
        {
            -- Start2
            x=100,
            y=2,
            width=96,
            height=34,

        },
        {
            -- Start3
            x=198,
            y=2,
            width=96,
            height=34,

        },
        {
            -- Start4
            x=296,
            y=2,
            width=96,
            height=34,

        },
    },
    
    sheetContentWidth = 394,
    sheetContentHeight = 38
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
