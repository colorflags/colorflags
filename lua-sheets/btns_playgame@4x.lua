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
            x=8,
            y=196,
            width=696,
            height=128,

            sourceX = 24,
            sourceY = 24,
            sourceWidth = 743,
            sourceHeight = 177
        },
        {
            -- About2
            x=756,
            y=172,
            width=744,
            height=152,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 743,
            sourceHeight = 177
        },
        {
            -- About3
            x=8,
            y=8,
            width=740,
            height=180,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 743,
            sourceHeight = 177
        },
        {
            -- About4
            x=756,
            y=8,
            width=744,
            height=156,

            sourceX = 0,
            sourceY = 24,
            sourceWidth = 743,
            sourceHeight = 177
        },
    },
    
    sheetContentWidth = 1508,
    sheetContentHeight = 332
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
