--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:32b8a88c5e56658180134627ff03a943:ef5ca051bf97f1895ae2dc5fd74e8389:e0585486e937d6818a97282be2b23641$
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
            -- 01
            x=2,
            y=2,
            width=1107,
            height=194,

        },
        {
            -- 02
            x=1111,
            y=2,
            width=1107,
            height=194,

        },
        {
            -- 03
            x=2220,
            y=2,
            width=1107,
            height=194,

        },
        {
            -- 04
            x=2,
            y=198,
            width=1107,
            height=194,

        },
        {
            -- 05
            x=1111,
            y=198,
            width=1107,
            height=194,

        },
        {
            -- 06
            x=2220,
            y=198,
            width=1107,
            height=194,

        },
        {
            -- 07
            x=2,
            y=394,
            width=1107,
            height=194,

        },
        {
            -- 08
            x=1111,
            y=394,
            width=1107,
            height=194,

        },
        {
            -- 09
            x=2220,
            y=394,
            width=1107,
            height=194,

        },
        {
            -- 10
            x=2,
            y=590,
            width=1107,
            height=194,

        },
        {
            -- 11
            x=1111,
            y=590,
            width=1107,
            height=194,

        },
        {
            -- 12
            x=2220,
            y=590,
            width=1107,
            height=194,

        },
        {
            -- 13
            x=2,
            y=786,
            width=1107,
            height=194,

        },
        {
            -- 14
            x=1111,
            y=786,
            width=1107,
            height=194,

        },
        {
            -- 15
            x=2220,
            y=786,
            width=1107,
            height=194,

        },
        {
            -- 16
            x=2,
            y=982,
            width=1107,
            height=194,

        },
        {
            -- 17
            x=1111,
            y=982,
            width=1107,
            height=194,

        },
        {
            -- 18
            x=2220,
            y=982,
            width=1107,
            height=194,

        },
        {
            -- 19
            x=2,
            y=1178,
            width=1107,
            height=194,

        },
        {
            -- 20
            x=1111,
            y=1178,
            width=1107,
            height=194,

        },
        {
            -- 21
            x=2220,
            y=1178,
            width=1107,
            height=194,

        },
        {
            -- 22
            x=2,
            y=1374,
            width=1107,
            height=194,

        },
        {
            -- 23
            x=1111,
            y=1374,
            width=1107,
            height=194,

        },
        {
            -- 24
            x=2220,
            y=1374,
            width=1107,
            height=194,

        },
        {
            -- 25
            x=2,
            y=1570,
            width=1107,
            height=194,

        },
    },
    
    sheetContentWidth = 3329,
    sheetContentHeight = 1766
}

SheetInfo.frameIndex =
{

    ["01"] = 1,
    ["02"] = 2,
    ["03"] = 3,
    ["04"] = 4,
    ["05"] = 5,
    ["06"] = 6,
    ["07"] = 7,
    ["08"] = 8,
    ["09"] = 9,
    ["10"] = 10,
    ["11"] = 11,
    ["12"] = 12,
    ["13"] = 13,
    ["14"] = 14,
    ["15"] = 15,
    ["16"] = 16,
    ["17"] = 17,
    ["18"] = 18,
    ["19"] = 19,
    ["20"] = 20,
    ["21"] = 21,
    ["22"] = 22,
    ["23"] = 23,
    ["24"] = 24,
    ["25"] = 25,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
