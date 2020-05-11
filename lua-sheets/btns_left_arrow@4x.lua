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
            x=8,
            y=8,
            width=264,
            height=152,

        },
        {
            -- arrowleft2
            x=280,
            y=8,
            width=264,
            height=152,

        },
    },
    
    sheetContentWidth = 552,
    sheetContentHeight = 168
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
