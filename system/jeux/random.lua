local random = {}

local mon_service = require("system/service_locator")

--[[
██████╗  ██████╗ ██╗   ██╗██╗     ███████╗
██╔══██╗██╔═══██╗██║   ██║██║     ██╔════╝
██████╔╝██║   ██║██║   ██║██║     █████╗  
██╔══██╗██║   ██║██║   ██║██║     ██╔══╝  
██████╔╝╚██████╔╝╚██████╔╝███████╗███████╗
╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
]]
local lst_random_possible = {"e","r","t"}
local lst_random_designe = {}
local nombre_random = 3

function random.start()
    lst_random_possible = {"e","r","t"}
    lst_random_designe = {}
    nombre_random = 3
end

function random.intit_random()
    --love.timer.sleep(0.5)
    if (#lst_random_possible > 0 ) then 
        math.randomseed(os.time())
        
        number = love.math.random(1, #lst_random_possible)
        table.insert(lst_random_designe, lst_random_possible[number])
        delete_random(number)    
    end
end
function delete_random(number)
    if nombre_random > 0 then
        table.remove(lst_random_possible, number)
        nombre_random = nombre_random - 1
    end
end

function random.get_last_lst_random()
    return lst_random_designe[#lst_random_designe]
end
function random.get_nombre_random()
    return nombre_random
end


mon_service.addService("random", random)

return random