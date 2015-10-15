--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:41e1ef8e6629a9d5dfcf4b15ea232a19:9e73607dbff378b04510e175763c9fa6:de682786e8ec15b0a9d917eeef86fd33$
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
            -- bar_dragon001
            x=2,
            y=2,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon002
            x=2,
            y=138,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon003
            x=2,
            y=274,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon004
            x=2,
            y=410,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon005
            x=2,
            y=546,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon006
            x=2,
            y=682,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon007
            x=580,
            y=2,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon008
            x=1158,
            y=2,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon009
            x=580,
            y=138,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon010
            x=1158,
            y=138,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon011
            x=580,
            y=274,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon012
            x=1158,
            y=274,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon013
            x=580,
            y=410,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon014
            x=1158,
            y=410,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon015
            x=580,
            y=546,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
        {
            -- bar_dragon016
            x=1158,
            y=546,
            width=576,
            height=134,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 576,
            sourceHeight = 150
        },
    },
    
    sheetContentWidth = 1736,
    sheetContentHeight = 818
}

SheetInfo.frameIndex =
{

    ["bar_dragon001"] = 1,
    ["bar_dragon002"] = 2,
    ["bar_dragon003"] = 3,
    ["bar_dragon004"] = 4,
    ["bar_dragon005"] = 5,
    ["bar_dragon006"] = 6,
    ["bar_dragon007"] = 7,
    ["bar_dragon008"] = 8,
    ["bar_dragon009"] = 9,
    ["bar_dragon010"] = 10,
    ["bar_dragon011"] = 11,
    ["bar_dragon012"] = 12,
    ["bar_dragon013"] = 13,
    ["bar_dragon014"] = 14,
    ["bar_dragon015"] = 15,
    ["bar_dragon016"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
