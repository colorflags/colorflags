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
            x=544,
            y=8,
            width=516,
            height=108,

        },
        {
            -- Restart2
            x=8,
            y=132,
            width=524,
            height=112,

        },
        {
            -- Restart3
            x=540,
            y=132,
            width=524,
            height=112,

        },
        {
            -- Restart4
            x=8,
            y=8,
            width=528,
            height=116,

        },
    },
    
    sheetContentWidth = 1072,
    sheetContentHeight = 252
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
