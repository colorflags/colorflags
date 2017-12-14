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
            x=376,
            y=132,
            width=356,
            height=108,

        },
        {
            -- Start2
            x=8,
            y=132,
            width=360,
            height=108,

        },
        {
            -- Start3
            x=8,
            y=8,
            width=364,
            height=116,

        },
        {
            -- Start4
            x=380,
            y=8,
            width=368,
            height=112,

        },
    },
    
    sheetContentWidth = 756,
    sheetContentHeight = 248
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
