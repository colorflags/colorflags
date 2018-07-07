--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:51f3347be2d44f4728da12b99f0d8a64:13c617281d877a1c1e6ea2e6ff90273d:3d5ae1dd42da0b9151a61576cf2691c5$
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
            -- 1scatter1
            x=2,
            y=462,
            width=200,
            height=359,

            sourceX = 6,
            sourceY = 41,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter10
            x=433,
            y=2,
            width=209,
            height=425,

            sourceX = 3,
            sourceY = 16,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter11
            x=221,
            y=2,
            width=210,
            height=445,

            sourceX = 3,
            sourceY = 8,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter12
            x=2,
            y=2,
            width=217,
            height=458,

        },
        {
            -- 1scatter2
            x=204,
            y=462,
            width=199,
            height=358,

            sourceX = 5,
            sourceY = 42,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter4
            x=405,
            y=449,
            width=199,
            height=365,

            sourceX = 5,
            sourceY = 37,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter5
            x=1012,
            y=399,
            width=198,
            height=379,

            sourceX = 8,
            sourceY = 37,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter6
            x=606,
            y=429,
            width=201,
            height=391,

            sourceX = 7,
            sourceY = 29,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter7
            x=847,
            y=2,
            width=201,
            height=395,

            sourceX = 7,
            sourceY = 29,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter8
            x=809,
            y=411,
            width=201,
            height=399,

            sourceX = 7,
            sourceY = 29,
            sourceWidth = 217,
            sourceHeight = 458
        },
        {
            -- 1scatter9
            x=644,
            y=2,
            width=201,
            height=407,

            sourceX = 7,
            sourceY = 21,
            sourceWidth = 217,
            sourceHeight = 458
        },
    },
    
    sheetContentWidth = 1212,
    sheetContentHeight = 823
}

SheetInfo.frameIndex =
{

    ["1scatter1"] = 1,
    ["1scatter10"] = 2,
    ["1scatter11"] = 3,
    ["1scatter12"] = 4,
    ["1scatter2"] = 5,
    ["1scatter4"] = 6,
    ["1scatter5"] = 7,
    ["1scatter6"] = 8,
    ["1scatter7"] = 9,
    ["1scatter8"] = 10,
    ["1scatter9"] = 11,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
