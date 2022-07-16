local gestion_ecran = {}
local mon_service = require("system/service_locator")

local MODE = "MENU"

function gestion_ecran.getMODE()
    return MODE
end
function gestion_ecran.setMODE(pMode)
    MODE = pMode
end

mon_service.addService("gestion_ecran", gestion_ecran)
return gestion_ecran