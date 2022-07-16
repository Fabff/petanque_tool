local gestion_font = {}
local mon_service = require("system/service_locator")


function gestion_font.small_font_load(pLargeur)
    return love.graphics.newFont("assets/font/FIXED_BO.TTF", pLargeur/45)
end
function gestion_font.big_font_load(pLargeur)
    return love.graphics.newFont("assets/font/FIXED_BO.TTF", pLargeur/15)
end

mon_service.addService("gestion_font", gestion_font)
return gestion_font