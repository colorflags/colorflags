--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:567144fc012b4c617334cb1f50c48879:6b4dfd8aa75e6293648ef41b750be127:21e075b8a3be9044a66b6b2cca83e156$
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
            -- arrowleft1
            x=4,
            y=4,
            width=132,
            height=76,

        },
        {
            -- arrowleft2
            x=140,
            y=4,
            width=132,
            height=76,

        },
    },
    
    sheetContentWidth = 276,
    sheetContentHeight = 84
}

SheetInfo.frameIndex =
{

    ["arrowleft1"] = 1,
    ["arrowleft2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
