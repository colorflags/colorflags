local cameraEvent = {}

function cameraEvent.focus(transitionToCountryDuration, country, countryFill, previousCountry, previousCountryFill, mapGroup)
    print(country.name)
    local transitionToCountryDuration = transitionToCountryDuration
    local country = country
    local countryFill = countryFill
    local previousCountry = previousCountry
    local previousCountryFill = previousCountryFill
    local mapGroup = mapGroup

    local zoomMultiplier = nil

    local xCoord=(0)-(country.coords.x + (countryFill.width/2))
    local yCoord=(0)-(country.coords.y + (countryFill.height/2))

    local previousXCoord=(0)-(previousCountry.coords.x + (previousCountryFill.width/2))
    local previousYCoord=(0)-(previousCountry.coords.y + (previousCountryFill.height/2))

    local distanceX = xCoord - (xCoord - previousXCoord)/2
    local distanceY = yCoord - (yCoord - previousYCoord)/2

    local mapTimer = transition.to( mapGroup[1], { transition=easing.inCirc,
        time=transitionToCountryDuration/2,
        x=distanceX,
        y=distanceY,
        onComplete=function(event)
            mapTimer = transition.to(mapGroup[1], { transition=easing.inCirc,
                time=transitionToCountryDuration/2,
                x=xCoord,
                y=yCoord
            })
        end
    })

    zoomMultiplier = .20
    local zoomTimer = transition.to( mapGroup, { transition=easing.inCirc,
        time=transitionToCountryDuration/2,
        xScale=1*zoomMultiplier,
        yScale=1*zoomMultiplier,
        onComplete=function(event)
            zoomMultiplier = .3
            mapTimer = transition.to(mapGroup, { transition=easing.inCirc,
                time=transitionToCountryDuration/2,
                xScale=1*zoomMultiplier,
                yScale=1*zoomMultiplier
            })
        end
    })

end

return cameraEvent
