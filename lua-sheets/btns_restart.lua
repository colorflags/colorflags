--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1379ab86967826ce04d3ab1517ef832c:e059b87a6012d1356ed365a0f6cc4f65:b9f17a05fc6f774e85b7d6f881acea63$
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
            -- Restart1
            x=136,
            y=2,
            width=129,
            height=27,

        },
        {
            -- Restart2
            x=2,
            y=33,
            width=131,
            height=28,

        },
        {
            -- Restart3
            x=135,
            y=33,
            width=131,
            height=28,

        },
        {
            -- Restart4
            x=2,
            y=2,
            width=132,
            height=29,

        },
    },
    
    sheetContentWidth = 268,
    sheetContentHeight = 63
}

SheetInfo.frameIndex =
{

    ["Restart1"] = 1,
    ["Restart2"] = 2,
    ["Restart3"] = 3,
    ["Restart4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
