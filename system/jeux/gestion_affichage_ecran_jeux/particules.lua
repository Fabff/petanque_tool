local particules = {}

local mon_service = require("system/service_locator")

--gestion des particules
local lst_particule = {}

function particules.restart()
    for n=#lst_particule, 1, -1 do 
        table.remove(lst_particule, n)
    end
end

function ajouteParticule(Px, Py)
    local maparticule = {}
            maparticule.x = Px
            maparticule.y = Py
            maparticule.vx = math.random(-300,300)/100
            maparticule.vy = math.random(-600,0)/100
            if love.getVersion() == 0 then
                maparticule.colorR = math.random(84,179)
                maparticule.colorG = math.random(78,146)
                maparticule.colorB = math.random(64,141)
            else
                maparticule.colorR = math.random(0.33,0.70)
                maparticule.colorG = math.random(0.30,0.57)
                maparticule.colorB = math.random(0.25,0.55)
            end
            maparticule.duree_vie = math.random(0, 300)/100
    table.insert(lst_particule, maparticule)
end

function particules.ajouteExplosion(Px, Py)
    for n=1, 150 do
        ajouteParticule(Px, Py)
    end
end

function particules.deleteParticule(dt)
    for n=#lst_particule, 1, -1 do
        local part = lst_particule[n]
        part.x = part.x + part.vx
        part.y = part.y + part.vy
        part.duree_vie = part.duree_vie - dt
        if part.duree_vie <= 0 then
            table.remove(lst_particule, n)
        end
    end
end

function particules.get_lstParticules()
    return lst_particule
end

function particules.draw()
    --affichage particule
    for n=1, #lst_particule do
        local part = lst_particule[n]
        love.graphics.setColor(part.colorR, part.colorG, part.colorB)
        love.graphics.circle("fill", part.x, part.y, 2.5)
    end
    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end
end

mon_service.addService("particules", particules)
return particules