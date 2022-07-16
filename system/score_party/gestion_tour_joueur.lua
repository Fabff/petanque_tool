local gestion_tour_joueur = {}
local mon_service = require("system/service_locator")

--initialisation de la liste des score
--local lst_score_joueurs = {}
-- function gestion_tour_joueur.initScore(pNb_joueurs)
--     lst_score_joueurs = {}
--     for n=1, pNb_joueurs do 
--         lst_score_joueurs[n] = 0
--     end
-- end
-- function gestion_tour_joueur.addScore(pNumJoueur, nbPoint)
--     lst_score_joueurs[pNumJoueur] = lst_score_joueurs[pNumJoueur] + nbPoint
-- endlst_score_joueurs

-- function gestion_tour_joueur.get_InitScore()
--     return lst_score_joueurs
-- end

--deplacement perso
local vx, vy = 0, 0
local Px, Py = 0, 0
local cibleX, cibleY = 0, 0

local largeur = love.graphics.getWidth()
local hauteur = love.graphics.getHeight()


function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function gestion_tour_joueur.calculForceDeplacement(pNumeroJoueur)

    vx, vy = 0, 0
    Px, Py = 0, 0
    cibleX, cibleY = 0, 0

    local lst_sprite = mon_service.getService("coordonnees_sprite").Get_coordonnees_sprite()
    local angle
    cibleX, cibleY = largeur/1.7, hauteur/1.7

    Px = lst_sprite[pNumeroJoueur].x
    Py = lst_sprite[pNumeroJoueur].y
    
    angle = math.angle(Px, Py, cibleX, cibleY)
    
    vx = 300 * math.cos(angle)
    vy = 300 * math.sin(angle)
end

function gestion_tour_joueur.update(dt, pSx, pSy, pNumeroJoueur)
        gestion_tour_joueur.calculForceDeplacement(pNumeroJoueur)

        if Px <= cibleX then
            mon_service.getService("coordonnees_sprite").changementCoordonnees(pNumeroJoueur, vx, 0, pSx, pSy, dt)
        end
        if Py <= cibleY then
            mon_service.getService("coordonnees_sprite").changementCoordonnees(pNumeroJoueur, 0, vy, pSx, pSy, dt)
        end
end


mon_service.addService("gestion_tour_joueur", gestion_tour_joueur)
return gestion_tour_joueur