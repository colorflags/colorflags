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
            x=2,
            y=2,
            width=136,
            height=34,

        },
        {
            -- Restart2
            x=140,
            y=2,
            width=136,
            height=34,

        },
        {
            -- Restart3
            x=2,
            y=38,
            width=136,
            height=34,

        },
        {
            -- Restart4
            x=140,
            y=38,
            width=136,
            height=34,

        },
    },
    
    sheetContentWidth = 278,
    sheetContentHeight = 75
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
