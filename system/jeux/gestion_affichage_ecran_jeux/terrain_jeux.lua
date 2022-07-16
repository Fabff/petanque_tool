local terrain_jeux = {}
local mon_service = require("system/service_locator")

local lst_ball = {}

local lst_terrain = {}
function create_terrain(pX, pY)
        local my_terrain = {}
        my_terrain.x = pX 
        my_terrain.y = pY 
        table.insert(lst_terrain, my_terrain)
end
   
local largeur, hauteur = 0,0
function terrain_jeux.load_terrain_jeux()
    largeur, hauteur = 0,0
    lst_ball = mon_service.getService("boule").get_lst_ball()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()
    for n=1, #lst_ball do 
        create_terrain(lst_ball[n].x, lst_ball[n].y)
    end
end

function terrain_jeux.draw_terrain()
    for n=1, #lst_ball do 
        mon_service.getService("quad_graphisme").draw_terrain(lst_terrain[n].x, lst_terrain[n].y)
    end
end

mon_service.addService("terrain_jeux", terrain_jeux)

return terrain_jeux