require("class")
require("cf_color")

CFGameSettings = class(function(c)
    local countries = {}
    countries["Andorra"] = {
        id = 1,
        name = "andorra",
        code = "ryb",
        colors = {
            r = CFColor(208,16,58),
            y = CFColor(254,223,0),
            b = CFColor(0,24,168)
        },
        coords = { x = 3901, y = 910 }
    }
    countries["Argentina"] = {
        id = 2,
        name = "argentina",
        code = "bwy",
        colors = {
            b = CFColor(116,172,223),
            w = CFColor(255,255,255),
            y = CFColor(246,180,14)
        },
        coords = { x = 2195, y = 2567 }
    }
    countries["Australia"] = {
        id = 3,
        name = "australia",
        code = "rwb",
        colors = {
            r = CFColor(255,0,0),
            w = CFColor(255,255,255),
            b = CFColor(0,4,139)
        },
        coords = { x = 6443, y = 2266 }
    }
    countries["Austria"] = {
        id = 4,
        name = "austria",
        code = "rw",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255),
        },
        coords = { x = 4085, y = 750 }
    }
    countries["Belgium"] = {
        id = 5,
        name = "belgium",
        code = "ryk",
        colors = {
            r = CFColor(237,41,57),
            y = CFColor(250,224,66),
            k = CFColor(0,0,0)
        },
        coords = { x = 3926, y = 688 }
    }
    countries["Brazil"] = {
        id = 6,
        name = "brazil",
        code = "ygbw",
        colors = {
            y = CFColor(254,233,0),
            g = CFColor(0,155,58),
            b = CFColor(0,39,118),
            w = CFColor(255,255,255)
        },
        coords = { x = 2186, y = 1872 }
    }
    countries["Canada"] = {
        id = 7,
        name = "canada",
        code = "rw",
        colors = {
            r = CFColor(255,0,0),
            w = CFColor(255,255,255)
        },
        coords = { x = 659, y = 8 }
    }
    countries["Chile"] = {
        id = 8,
        name = "chile",
        code = "rwb",
        colors = {
            r = CFColor(213,43,30),
            w = CFColor(255,255,255),
            b = CFColor(0,57,166)
        },
        coords = { x = 2147, y = 2457 }
    }
    countries["China"] = {
        id = 9,
        name = "china",
        code = "ry",
        colors = {
            r = CFColor(213,43,30),
            y = CFColor(255,222,0)
        },
        coords = { x = 5542, y = 638 }
    }
    countries["Croatia"] = {
        id = 10,
        name = "croatia",
        code = "rwb",
        colors = {
            r = CFColor(255,0,0),
            w = CFColor(255,255,255),
            b = CFColor(23,23,150)
        },
        coords = { x = 4175, y = 813 }
    }
    countries["Cyprus"] = {
        id = 11,
        name = "cyprus",
        code = "ogw",
        colors = {
            o = CFColor(216,217,3),
            g = CFColor(47,71,18),
            w = CFColor(255,255,255)
        },
        coords = { x = 4602, y = 1089 }
    }
    countries["CzechRepublic"] = {
        id = 12,
        name = "czechrepublic",
        code = "rwb",
        colors = {
            r = CFColor(215,20,26),
            w = CFColor(255,255,255),
            b = CFColor(17,69,126)
        },
        coords = { x = 4143, y = 699 }
    }
    countries["Denmark"] = {
        id = 13,
        name = "denmark",
        code = "rw",
        colors = {
            r = CFColor(198,12,48),
            w = CFColor(255,255,255)
        },
        coords = { x = 4052, y = 536 }
    }
    countries["Egypt"] = {
        id = 14,
        name = "egypt",
        code = "rw",
        colors = {
            r = CFColor(206,17,38),
            w = CFColor(255,255,255)
        },
        coords = { x = 4431, y = 1192 }
    }
    countries["Estonia"] = {
        id = 15,
        name = "estonia",
        code = "bkw",
        colors = {
            b = CFColor(72,145,217),
            k = CFColor(0,0,0),
            w = CFColor(255,255,255)
        },
        coords = { x = 4366, y = 491 }
    }
    countries["Finland"] = {
        id = 16,
        name = "finland",
        code = "bw",
        colors = {
            b = CFColor(0,53,128),
            w = CFColor(255,255,255)
        },
        coords = { x = 4313, y = 255 }
    }
    countries["France"] = {
        id = 17,
        name = "france",
        code = "rwb",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255),
            b = CFColor(0,35,149)
        },
        coords = { x = 3759, y = 698 }
    }
    countries["Germany"] = {
        id = 18,
        name = "germany",
        code = "ryk",
        colors = {
            r = CFColor(221,0,0),
            y = CFColor(255,206,0),
            k = CFColor(0,0,0)
        },
        coords = { x = 4003, y = 602 }
    }
    countries["Greece"] = {
        id = 19,
        name = "greece",
        code = "bw",
        colors = {
            b = CFColor(13,94,175),
            w = CFColor(255,255,255)
        },
        coords = { x = 4315, y = 934 }
    }
    countries["Hungary"] = {
        id = 20,
        name = "hungary",
        code = "rgw",
        colors = {
            r = CFColor(205,42,62),
            g = CFColor(67,111,77),
            w = CFColor(255,255,255)
        },
        coords = { x = 4234, y = 761 }
    }
    countries["Iceland"] = {
        id = 21,
        name = "iceland",
        code = "rwb",
        colors = {
            r = CFColor(215,40,40),
            w = CFColor(255,255,255),
            b = CFColor(0,56,151)
        },
        coords = { x = 3312, y = 333 }
    }
    countries["India"] = {
        id = 22,
        name = "india",
        code = "ogw",
        colors = {
            o = CFColor(255,153,51),
            g = CFColor(18,136,7),
            w = CFColor(255,255,255)
        },
        coords = { x = 5418, y = 1094 }
    }
    countries["Indonesia"] = {
        id = 23,
        name = "indonesia",
        code = "rw",
        colors = {
            r = CFColor(206,17,38),
            w = CFColor(255,255,255)
        },
        coords = { x = 6032, y = 1855 }
    }
    countries["Ireland"] = {
        id = 24,
        name = "ireland",
        code = "ogw",
        colors = {
            o = CFColor(255,121,0),
            g = CFColor(0,155,72),
            w = CFColor(255,255,255)
        },
        coords = { x = 3630, y = 595 }
    }
    countries["Israel"] = {
        id = 25,
        name = "israel",
        code = "bw",
        colors = {
            b = CFColor(0,56,184),
            w = CFColor(255,255,255)
        },
        coords = { x = 4647, y = 1150 }
    }
    countries["Italy"] = {
        id = 26,
        name = "italy",
        code = "rgw",
        colors = {
            r = CFColor(206,43,55),
            g = CFColor(0,146,70),
            w = CFColor(255,255,255)
        },
        coords = { x = 4019, y = 798 }
    }
    countries["Japan"] = {
        id = 27,
        name = "japan",
        code = "rw",
        colors = {
            r = CFColor(188,0,45),
            w = CFColor(255,255,255)
        },
        coords = { x = 6681, y = 838 }
    }
    countries["Lithuania"] = {
        id = 28,
        name = "lithuania",
        code = "ryg",
        colors = {
            r = CFColor(139,39,45),
            y = CFColor(253,185,19),
            g = CFColor(0,106,68)
        },
        coords = { x = 4347, y = 568 }
    }
    countries["Luxembourg"] = {
        id = 29,
        name = "luxembourg",
        code = "rwb",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255),
            b = CFColor(0,161,222)
        },
        coords = { x = 3998, y = 721 }
    }
    countries["Malaysia"] = {
        id = 30,
        name = "malaysia",
        code = "rybw",
        colors = {
            r = CFColor(204,0,1),
            y = CFColor(255,204,0),
            b = CFColor(1,0,102),
            w = CFColor(255,255,255)
        },
        coords = { x = 6135, y = 1818 }
    }
    countries["Malta"] = {
        id = 31,
        name = "malta",
        code = "rw",
        colors = {
            r = CFColor(207,20,43),
            w = CFColor(255,255,255),
        },
        coords = { x = 4194, y = 1081 }
    }
    countries["Mexico"] = {
        id = 32,
        name = "mexico",
        code = "rgw",
        colors = {
            r = CFColor(206,17,38),
            g = CFColor(0,104,71),
            w = CFColor(255,255,255)
        },
        coords = { x = 1177, y = 1165 }
    }
    countries["Netherlands"] = {
        id = 33,
        name = "netherlands",
        code = "rwb",
        colors = {
            r = CFColor(174,28,40),
            w = CFColor(255,255,255),
            b = CFColor(33,70,139)
        },
        coords = { x = 3945, y = 639 }
    }
    countries["NewZealand"] = {
        id = 34,
        name = "newzealand",
        code = "rwb",
        colors = {
            r = CFColor(204,20,43),
            w = CFColor(255,255,255),
            b = CFColor(0,36,125),
        },
        coords = { x = 7639, y = 2892 }
    }
    countries["Norway"] = {
        id = 35,
        name = "norway",
        code = "rwb",
        colors = {
            r = CFColor(239,43,45),
            w = CFColor(255,255,255),
            b = CFColor(0,40,104)
        },
        coords = { x = 3662, y = 45 }
    }
    countries["Philippines"] = {
        id = 36,
        name = "philippines",
        code = "rybw",
        colors = {
            r = CFColor(206,17,38),
            y = CFColor(252,209,22),
            b = CFColor(0,56,168),
            w = CFColor(255,255,255)
        },
        coords = { x = 6528, y = 1480 }
    }
    countries["Poland"] = {
        id = 37,
        name = "poland",
        code = "rw",
        colors = {
            r = CFColor(220,20,60),
            w = CFColor(255,255,255)
        },
        coords = { x = 4190, y = 606 }
    }
    countries["Portugal"] = {
        id = 38,
        name = "portugal",
        code = "rg",
        colors = {
            r = CFColor(255,0,0),
            g = CFColor(0,102,0)
        },
        coords = { x = 3213, y = 923 }
    }
    countries["Russia"] = {
        id = 39,
        name = "russia",
        code = "rwb",
        colors = {
            r = CFColor(213,43,30),
            w = CFColor(255,255,255),
            b = CFColor(0,57,166)
        },
        coords = { x = 4318, y = 27 }
    }
    countries["SanMarino"] = {
        id = 40,
        name = "sanmarino",
        code = "bw",
        colors = {
            b = CFColor(94,182,228),
            w = CFColor(255,255,255)
        },
        coords = { x = 4149, y = 880 }
    }
    countries["Singapore"] = {
        id = 41,
        name = "singapore",
        code = "rw",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255)
        },
        coords = { x = 6226, y = 1970 }
    }
    countries["Slovakia"] = {
        id = 42,
        name = "slovakia",
        code = "rwb",
        colors = {
            r = CFColor(238,28,37),
            w = CFColor(255,255,255),
            b = CFColor(11,78,162)
        },
        coords = { x = 4254, y = 736 }
    }
    countries["Slovenia"] = {
        id = 43,
        name = "slovenia",
        code = "rwb",
        colors = {
            r = CFColor(237,28,36),
            w = CFColor(255,255,255),
            b = CFColor(0,93,164)

        },
        coords = { x = 4173, y = 803 }
    }
    countries["SouthAfrica"] = {
        id = 44,
        name = "southafrica",
        code = "rygbwk",
        colors = {
            r = CFColor(222,56,49),
            y = CFColor(255,182,18),
            g = CFColor(0,122,77),
            b = CFColor(0,35,149),
            w = CFColor(255,255,255),
            k = CFColor(0,0,0)
        },
        coords = { x = 4243, y = 2577 }
    }
    countries["SouthKorea"] = {
        id = 45,
        name = "southkorea",
        code = "rbwk",
        colors = {
            r = CFColor(198,12,48),
            b = CFColor(0,52,120),
            w = CFColor(255,255,255),
            k = CFColor(0,0,0)
        },
        coords = { x = 6736, y = 1013 }
    }
    countries["Spain"] = {
        id = 46,
        name = "spain",
        code = "ry",
        colors = {
            r = CFColor(198,11,30),
            y = CFColor(225,196,0)
        },
        coords = { x = 3457, y = 882 }
    }
    countries["SriLanka"] = {
        id = 47,
        name = "srilanka",
        code = "royg",
        colors = {
            r = CFColor(141,32,41),
            o = CFColor(255,91,0),
            y = CFColor(255,183,0),
            g = CFColor(0,86,65)
        },
        coords = { x = 5680, y = 1754 }
    }
    countries["Sweden"] = {
        id = 48,
        name = "sweden",
        code = "yb",
        colors = {
            y = CFColor(255,183,0),
            b = CFColor(0,106,167)
        },
        coords = { x = 4122, y = 277 }
    }
    countries["Switzerland"] = {
        id = 49,
        name = "switzerland",
        code = "rw",
        colors = {
            r = CFColor(213,43,30),
            w = CFColor(255,255,255)
        },
        coords = { x = 4004, y = 781 }
    }
    countries["Taiwan"] = {
        id = 50,
        name = "taiwan",
        code = "rwb",
        colors = {
            r = CFColor(254,0,0),
            w = CFColor(255,255,255),
            b = CFColor(0,0,149)
        },
        coords = { x = 6558, y = 1357 }
    }
    countries["Thailand"] = {
        id = 51,
        name = "thailand",
        code = "rwb",
        colors = {
            r = CFColor(237,28,36),
            w = CFColor(255,255,255),
            b = CFColor(36,29,79)

        },
        coords = { x = 6081, y = 1481 }
    }
    countries["Turkey"] = {
        id = 52,
        name = "turkey",
        code = "rw",
        colors = {
            r = CFColor(227,10,23),
            w = CFColor(255,255,255)
        },
        coords = { x = 4460, y = 924 }
    }
    countries["UnitedArabEmirates"] = {
        id = 53,
        name = "unitedarabemirates",
        code = "rgwk",
        colors = {
            r = CFColor(255,0,0),
            g = CFColor(0,115,47),
            w = CFColor(255,255,255),
            k = CFColor(0,0,0)
        },
        coords = { x = 5041, y = 1336 }
    }
    countries["UnitedKingdom"] = {
        id = 54,
        name = "unitedkingdom",
        code = "rwb",
        colors = {
            r = CFColor(207,20,43),
            w = CFColor(255,255,255),
            b = CFColor(0,36,125)

        },
        coords = { x = 3683, y = 464 }
    }
    countries["UnitedStates"] = {
        id = 55,
        name = "unitedstates",
        code = "rwb",
        colors = {
            r = CFColor(178,34,52),
            w = CFColor(255,255,255),
            b = CFColor(60,59,110)
        },
        coords = { x = 0, y = 226 }
    }

    c.countries = countries
end)

function CFGameSettings:getItemByID(id)
    for k, v in pairs(self.countries) do
        if (v.id == id) then
            return v
        end
    end
end

function CFGameSettings:getLength()
    local count = 0
    for k, v in pairs(self.countries) do
        count = count + 1
    end
    return count
end

--[[
function BulbGameSettings:getItemByName(name)
    return self.countries[name]
end
]]--
