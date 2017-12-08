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
            y=136,
            width=22,
            height=44,

        },
        {
            -- new_lightning_2
            x=0,
            y=0,
            width=24,
            height=46,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 23,
            sourceHeight = 45
        },
        {
            -- new_lightning_3
            x=0,
            y=46,
            width=24,
            height=46,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 24,
            sourceHeight = 45
        },
        {
            -- new_lightning_4
            x=0,
            y=92,
            width=24,
            height=44,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 24,
            sourceHeight = 44
        },
        {
            -- new_lightning_5
            x=0,
            y=180,
            width=22,
            height=44,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 22,
            sourceHeight = 43
        },
    },
    
    sheetContentWidth = 24,
    sheetContentHeight = 224
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
