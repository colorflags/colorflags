--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1dad506cf6ff707eb27aadaf708b415e:57e7da085b60cf67fae0c19e33572a63:42aa1d6f16e7b81d6892f5c1ad0c2257$
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
            -- arrowright1
            x=8,
            y=8,
            width=264,
            height=152,

        },
        {
            -- arrowright2
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

    ["arrowright1"] = 1,
    ["arrowright2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
