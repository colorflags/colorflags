--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:fe112d36173f3e801fa3b7647cfe2249:b62a7d3ccd1e02991e2768d4e1496c2c:256ce84bfc1e5716108b569f2ff20992$
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
            -- 1_output_0000
            x=2,
            y=2,
            width=32,
            height=32,

        },
        {
            -- 1_output_0001
            x=2,
            y=36,
            width=32,
            height=32,

        },
        {
            -- 1_output_0002
            x=2,
            y=70,
            width=32,
            height=32,

        },
        {
            -- 1_output_0003
            x=36,
            y=2,
            width=32,
            height=32,

        },
        {
            -- 1_output_0004
            x=70,
            y=2,
            width=32,
            height=32,

        },
        {
            -- 1_output_0005
            x=36,
            y=36,
            width=32,
            height=32,

        },
        {
            -- 1_output_0006
            x=36,
            y=70,
            width=32,
            height=32,

        },
        {
            -- 1_output_0007
            x=70,
            y=36,
            width=32,
            height=32,

        },
    },
    
    sheetContentWidth = 104,
    sheetContentHeight = 104
}

SheetInfo.frameIndex =
{

    ["1_output_0000"] = 1,
    ["1_output_0001"] = 2,
    ["1_output_0002"] = 3,
    ["1_output_0003"] = 4,
    ["1_output_0004"] = 5,
    ["1_output_0005"] = 6,
    ["1_output_0006"] = 7,
    ["1_output_0007"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
