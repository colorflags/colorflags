require("class")
--require("bulb_color")

BulbGameSettings = class(function(c)
    
    local countries = {}
    countries["andorra"] = { 
        id = 1,
        name = "andorra",
        code = "ryb",
        colors = {
            r = ColorFlagsColor(),
            y = ColorFlagsColor(),
            b = ColorFlagsColor()
        }
    }
    c.countries = countries
    print("working here:", #countries)
end)

function BulbGameSettings:getItemByID(id)
    for k, v in pairs(self.countries) do
        if (v.id == id) then
            return v
        end
    end
end

function BulbGameSettings:getItemByName(name)
    return self.countries[name]
end
