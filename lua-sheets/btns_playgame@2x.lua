--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0f67c2694cdb9c56e4e5cd227f0700e0:fb55a3c6f277be2de60f3e8132c6d463:c5884ac85bc0e25745132c46775f4a7c$
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
            y=78,
            width=348,
            height=66,

        },
        {
            -- PlayGame2
            x=360,
            y=4,
            width=352,
            height=68,

        },
        {
            -- PlayGame3
            x=360,
            y=76,
            width=352,
            height=68,

        },
        {
            -- PlayGame4
            x=4,
            y=4,
            width=352,
            height=70,

        },
    },
    
    sheetContentWidth = 722,
    sheetContentHeight = 148
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
