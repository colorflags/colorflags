require("class")

CFGameScaleComponents = class(function(c)
    local component = {}
    component["map"] = {
        id = 1,
        name = "map",
        dimensions = {
            ['@1x'] = {width=2031, height=851},
            ['@2x'] = {width=4062, height=1702},
            ['@4x'] = {width=8124, height=3404}
        }
    }
    c.component = component
end)

function CFGameScaleComponents:getItemByID(id)
    for k, v in pairs(self.component) do
        if (v.id == id) then
            return v
        end
    end
end

function CFGameScaleComponents:getItemByName(name)
    return self.countries[name]
end

--[[
function CFGameSettings:getLength()
    local count = 0
    for k, v in pairs(self.countries) do
        count = count + 1
    end
    return count
end
]]--
