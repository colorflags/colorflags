--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:145de908b48067e6ec32377ed00a7561:cfd888d67af8dd6f2aee1ab6df3560b2:c5884ac85bc0e25745132c46775f4a7c$
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
            -- About1
            x=4,
            y=98,
            width=348,
            height=64,

            sourceX = 12,
            sourceY = 12,
            sourceWidth = 372,
            sourceHeight = 89
        },
        {
            -- About2
            x=378,
            y=86,
            width=372,
            height=76,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 372,
            sourceHeight = 89
        },
        {
            -- About3
            x=4,
            y=4,
            width=370,
            height=90,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 372,
            sourceHeight = 89
        },
        {
            -- About4
            x=378,
            y=4,
            width=372,
            height=78,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 372,
            sourceHeight = 89
        },
    },
    
    sheetContentWidth = 754,
    sheetContentHeight = 166
}

SheetInfo.frameIndex =
{

    ["About1"] = 1,
    ["About2"] = 2,
    ["About3"] = 3,
    ["About4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
