--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:994ad83f734e2607314989d6657e15c6:5e5ead75fb31a9c040ff46cc9111820d:4ed63d0f64a54708c3b227d1a1ea119b$
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
            -- about-off
            x=2,
            y=67,
            width=168, -- 338
            height=55,

            -- sourceX = 4,
            -- sourceY = 0,
            -- sourceWidth = 342,
            -- sourceHeight = 55
        },
        {
            -- about-on
            x=2,
            y=235,
            width=338,
            height=55,

            -- sourceX = 4,
            -- sourceY = 0,
            -- sourceWidth = 342,
            -- sourceHeight = 55
        },        
        {
            -- options-off
            x=570,
            y=2,
            width=216, -- 432
            height=63,

            -- sourceX = 4,
            -- sourceY = 0,
            -- sourceWidth = 436,
            -- sourceHeight = 63
        },
        {
            -- options-on
            x=786,
            y=2,
            width=216, -- 432
            height=63,

            -- sourceX = 4,
            -- sourceY = 0,
            -- sourceWidth = 436,
            -- sourceHeight = 63
        },
        {
            -- playgame-off
            x=2,
            y=2,
            width=283, --566
            height=63,

            -- sourceX = 4,
            -- sourceY = 0,
            -- sourceWidth = 570,
            -- sourceHeight = 63
        },
        {
            -- playgame-on
            x=2,
            y=285,
            width=283,
            height=63,

            -- sourceX = 4,
            -- sourceY = 0,
            -- sourceWidth = 570,
            -- sourceHeight = 63
        },        
    },
    
    sheetContentWidth = 1004,
    sheetContentHeight = 124
}

SheetInfo.frameIndex =
{

    ["about-off"] = 1,
    ["about-on"] = 2,    
    ["options-off"] = 3,
    ["options-on"] = 4,
    ["playgame-off"] = 5,
    ["playgame-on"] = 6,    
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
