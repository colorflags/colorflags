--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:f01a67c54e8272145160784fe334f01a:e059b87a6012d1356ed365a0f6cc4f65:b9f17a05fc6f774e85b7d6f881acea63$
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
            x=4,
            y=4,
            width=272,
            height=68,

        },
        {
            -- Restart2
            x=280,
            y=4,
            width=272,
            height=68,

        },
        {
            -- Restart3
            x=4,
            y=76,
            width=272,
            height=68,

        },
        {
            -- Restart4
            x=280,
            y=76,
            width=272,
            height=68,

        },
    },
    
    sheetContentWidth = 556,
    sheetContentHeight = 150
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
