--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e491ded75f243ac32861205be071d1df:591a318526b9d11dac7a3228d8ec509e:5d39da0cf2b43448ba289bb3c8cf5cc8$
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
            x=1186,
            y=2,
            width=198,
            height=58,

        },
        {
            -- about-on
            x=1386,
            y=2,
            width=198,
            height=58,

        },
        {
            -- playgame-off
            x=2,
            y=2,
            width=330,
            height=66,

        },
        {
            -- playgame-on
            x=334,
            y=2,
            width=330,
            height=66,

        },
        {
            -- tutorial-off
            x=666,
            y=2,
            width=258,
            height=58,

        },
        {
            -- tutorial-on
            x=926,
            y=2,
            width=258,
            height=58,

        },
    },
    
    sheetContentWidth = 1586,
    sheetContentHeight = 70
}

SheetInfo.frameIndex =
{

    ["about-off"] = 1,
    ["about-on"] = 2,
    ["playgame-off"] = 3,
    ["playgame-on"] = 4,
    ["tutorial-off"] = 5,
    ["tutorial-on"] = 6,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
