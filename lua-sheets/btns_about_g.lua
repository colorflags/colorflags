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
            x=2,
            y=2,
            width=135,
            height=43,

        },
        {
            -- About2-giga
            x=139,
            y=2,
            width=135,
            height=43,

        },
    },
    
    sheetContentWidth = 276,
    sheetContentHeight = 47
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
