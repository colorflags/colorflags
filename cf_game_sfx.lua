require("class")

CFGameSFX = class(function(c)
    local component = {}
    component = {
        id = "sfx/shortR.wav"
    }
    c.component = component
end)

function CFGameSFX:getItemByID(id)
    return self.component[id]
end
