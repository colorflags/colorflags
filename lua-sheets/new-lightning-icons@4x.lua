--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:5f2e5d38cbdc862b999257a959773a24:a9a537af0171a989d6b908ffac6618fd:8fb420ea98d1bd437d05f6d4f5f54e4b$
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
            -- new_lightning_1
            x=0,
            y=272,
            width=44,
            height=88,

        },
        {
            -- new_lightning_2
            x=0,
            y=0,
            width=48,
            height=92,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 45,
            sourceHeight = 90
        },
        {
            -- new_lightning_3
            x=0,
            y=92,
            width=48,
            height=92,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 47,
            sourceHeight = 90
        },
        {
            -- new_lightning_4
            x=0,
            y=184,
            width=48,
            height=88,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 47,
            sourceHeight = 88
        },
        {
            -- new_lightning_5
            x=0,
            y=360,
            width=44,
            height=88,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 44,
            sourceHeight = 86
        },
    },
    
    sheetContentWidth = 48,
    sheetContentHeight = 448
}

SheetInfo.frameIndex =
{

    ["new_lightning_1"] = 1,
    ["new_lightning_2"] = 2,
    ["new_lightning_3"] = 3,
    ["new_lightning_4"] = 4,
    ["new_lightning_5"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
