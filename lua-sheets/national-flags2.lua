--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1a211143b6f736c1fd732604b2a09479:819aa4e070daf5639fea63cb107ba31e:ca6966bf24cf9b3f6e6c0fbad0387565$
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
            -- isreal
            x=0,
            y=0,
            width=500,
            height=332,

        },
        {
            -- italy
            x=500,
            y=0,
            width=500,
            height=332,

        },
        {
            -- japan
            x=1000,
            y=0,
            width=500,
            height=332,

        },
        {
            -- lituania
            x=1500,
            y=0,
            width=500,
            height=332,

        },
        {
            -- luxembourg
            x=0,
            y=332,
            width=500,
            height=332,

        },
        {
            -- malaysia
            x=500,
            y=332,
            width=500,
            height=332,

        },
        {
            -- malta
            x=1000,
            y=332,
            width=500,
            height=332,

        },
        {
            -- mexico
            x=1500,
            y=332,
            width=500,
            height=332,

        },
        {
            -- netherlands
            x=0,
            y=664,
            width=500,
            height=332,

        },
        {
            -- new_zealand
            x=0,
            y=996,
            width=500,
            height=332,

        },
        {
            -- norway
            x=0,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- philippines
            x=0,
            y=1660,
            width=500,
            height=332,

        },
        {
            -- poland
            x=500,
            y=664,
            width=500,
            height=332,

        },
        {
            -- portugal
            x=1000,
            y=664,
            width=500,
            height=332,

        },
        {
            -- republic_of_china
            x=1500,
            y=664,
            width=500,
            height=332,

        },
        {
            -- russia
            x=500,
            y=996,
            width=500,
            height=332,

        },
        {
            -- san_marino
            x=500,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- singapore
            x=500,
            y=1660,
            width=500,
            height=332,

        },
        {
            -- slovakia
            x=1000,
            y=996,
            width=500,
            height=332,

        },
        {
            -- slovenia
            x=1500,
            y=996,
            width=500,
            height=332,

        },
        {
            -- south_africa
            x=1000,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- south_korea
            x=1500,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- spain
            x=1000,
            y=1660,
            width=500,
            height=332,

        },
        {
            -- sri_lanka
            x=1500,
            y=1660,
            width=500,
            height=332,

        },
    },
    
    sheetContentWidth = 2000,
    sheetContentHeight = 2000
}

SheetInfo.frameIndex =
{

    ["isreal"] = 1,
    ["italy"] = 2,
    ["japan"] = 3,
    ["lituania"] = 4,
    ["luxembourg"] = 5,
    ["malaysia"] = 6,
    ["malta"] = 7,
    ["mexico"] = 8,
    ["netherlands"] = 9,
    ["new_zealand"] = 10,
    ["norway"] = 11,
    ["philippines"] = 12,
    ["poland"] = 13,
    ["portugal"] = 14,
    ["republic_of_china"] = 15,
    ["russia"] = 16,
    ["san_marino"] = 17,
    ["singapore"] = 18,
    ["slovakia"] = 19,
    ["slovenia"] = 20,
    ["south_africa"] = 21,
    ["south_korea"] = 22,
    ["spain"] = 23,
    ["sri_lanka"] = 24,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
