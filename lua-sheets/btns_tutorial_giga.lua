--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:3652b460000a6f1ea77249a2d65f560d:3fcf5465a0655cc157b37727d49b76d8:54a299eebd2fd2bcfe5a8bf4104a4caf$
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
            -- Tutorial1-giga
            x=2,
            y=2,
            width=183,
            height=44,

        },
        {
            -- Tutorial2-giga
            x=187,
            y=2,
            width=183,
            height=44,

        },
    },
    
    sheetContentWidth = 372,
    sheetContentHeight = 48
}

SheetInfo.frameIndex =
{

    ["Tutorial1-giga"] = 1,
    ["Tutorial2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
