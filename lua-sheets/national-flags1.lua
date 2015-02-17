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
            -- andorra
            x=0,
            y=0,
            width=500,
            height=332,

        },
        {
            -- argentina
            x=500,
            y=0,
            width=500,
            height=332,

        },
        {
            -- australia
            x=1000,
            y=0,
            width=500,
            height=332,

        },
        {
            -- austria
            x=1500,
            y=0,
            width=500,
            height=332,

        },
        {
            -- belgium
            x=0,
            y=332,
            width=500,
            height=332,

        },
        {
            -- brazil
            x=500,
            y=332,
            width=500,
            height=332,

        },
        {
            -- canada
            x=1000,
            y=332,
            width=500,
            height=332,

        },
        {
            -- chile
            x=1500,
            y=332,
            width=500,
            height=332,

        },
        {
            -- china
            x=0,
            y=664,
            width=500,
            height=332,

        },
        {
            -- croatia
            x=0,
            y=996,
            width=500,
            height=332,

        },
        {
            -- cyprus
            x=0,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- czech_republic
            x=0,
            y=1660,
            width=500,
            height=332,

        },
        {
            -- denmark
            x=500,
            y=664,
            width=500,
            height=332,

        },
        {
            -- egypt
            x=1000,
            y=664,
            width=500,
            height=332,

        },
        {
            -- estonia
            x=1500,
            y=664,
            width=500,
            height=332,

        },
        {
            -- finland
            x=500,
            y=996,
            width=500,
            height=332,

        },
        {
            -- france
            x=500,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- germany
            x=500,
            y=1660,
            width=500,
            height=332,

        },
        {
            -- greece
            x=1000,
            y=996,
            width=500,
            height=332,

        },
        {
            -- hungary
            x=1500,
            y=996,
            width=500,
            height=332,

        },
        {
            -- iceland
            x=1000,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- india
            x=1500,
            y=1328,
            width=500,
            height=332,

        },
        {
            -- indonesia
            x=1000,
            y=1660,
            width=500,
            height=332,

        },
        {
            -- ireland
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

    ["andorra"] = 1,
    ["argentina"] = 2,
    ["australia"] = 3,
    ["austria"] = 4,
    ["belgium"] = 5,
    ["brazil"] = 6,
    ["canada"] = 7,
    ["chile"] = 8,
    ["china"] = 9,
    ["croatia"] = 10,
    ["cyprus"] = 11,
    ["czech_republic"] = 12,
    ["denmark"] = 13,
    ["egypt"] = 14,
    ["estonia"] = 15,
    ["finland"] = 16,
    ["france"] = 17,
    ["germany"] = 18,
    ["greece"] = 19,
    ["hungary"] = 20,
    ["iceland"] = 21,
    ["india"] = 22,
    ["indonesia"] = 23,
    ["ireland"] = 24,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
