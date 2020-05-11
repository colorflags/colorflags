--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:2bf9e841e6f855e17e10414a0a4aa18a:63ae04f9278969fe180dee9d4a1dcfad:418b217e4d3568d0fcdb9b59e738e0a1$
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
            -- Share1-giga
            x=8,
            y=8,
            width=552,
            height=180,

        },
        {
            -- Share2-giga
            x=568,
            y=8,
            width=552,
            height=180,

        },
    },
    
    sheetContentWidth = 1128,
    sheetContentHeight = 196
}

SheetInfo.frameIndex =
{

    ["Share1-giga"] = 1,
    ["Share2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
