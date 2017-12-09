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
            x=2,
            y=49,
            width=174,
            height=32,

            sourceX = 6,
            sourceY = 6,
            sourceWidth = 186,
            sourceHeight = 44
        },
        {
            -- About2
            x=189,
            y=43,
            width=186,
            height=38,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 186,
            sourceHeight = 44
        },
        {
            -- About3
            x=2,
            y=2,
            width=185,
            height=45,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 186,
            sourceHeight = 44
        },
        {
            -- About4
            x=189,
            y=2,
            width=186,
            height=39,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 186,
            sourceHeight = 44
        },
    },
    
    sheetContentWidth = 377,
    sheetContentHeight = 83
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
