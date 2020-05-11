--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:5ed82b47c6b7bef97fdd276e60e5104d:a42a11e34a8777667b040d62ecbbb2c9:15378b04c06aa806b735d5be1c39f0dd$
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
            -- About1-giga
            x=8,
            y=8,
            width=540,
            height=172,

        },
        {
            -- About2-giga
            x=556,
            y=8,
            width=540,
            height=172,

        },
    },
    
    sheetContentWidth = 1104,
    sheetContentHeight = 188
}

SheetInfo.frameIndex =
{

    ["About1-giga"] = 1,
    ["About2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
