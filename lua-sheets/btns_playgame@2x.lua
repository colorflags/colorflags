--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:efa6c677771d4d80e3a3f927e01e0927:fb55a3c6f277be2de60f3e8132c6d463:c5884ac85bc0e25745132c46775f4a7c$
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
            -- PlayGame1
            x=4,
            y=4,
            width=362,
            height=80,

        },
        {
            -- PlayGame2
            x=370,
            y=4,
            width=362,
            height=80,

        },
        {
            -- PlayGame3
            x=4,
            y=88,
            width=362,
            height=80,

        },
        {
            -- PlayGame4
            x=370,
            y=88,
            width=362,
            height=80,

        },
    },
    
    sheetContentWidth = 736,
    sheetContentHeight = 172
}

SheetInfo.frameIndex =
{

    ["PlayGame1"] = 1,
    ["PlayGame2"] = 2,
    ["PlayGame3"] = 3,
    ["PlayGame4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
