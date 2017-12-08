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
            y=68,
            width=11,
            height=22,

        },
        {
            -- new_lightning_2
            x=0,
            y=0,
            width=12,
            height=23,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 11,
            sourceHeight = 23
        },
        {
            -- new_lightning_3
            x=0,
            y=23,
            width=12,
            height=23,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 12,
            sourceHeight = 23
        },
        {
            -- new_lightning_4
            x=0,
            y=46,
            width=12,
            height=22,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 12,
            sourceHeight = 22
        },
        {
            -- new_lightning_5
            x=0,
            y=90,
            width=11,
            height=22,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 11,
            sourceHeight = 22
        },
    },
    
    sheetContentWidth = 12,
    sheetContentHeight = 112
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
