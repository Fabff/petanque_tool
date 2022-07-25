local coordonnees_sprite = {}
local mon_service = require("system/service_locator")

local coordonnees_affichage_barre = {}
function coordonnees_sprite.implement_coordonnes_barre(pX, pY, pSx, pSy)
    local my_coordonnes = {}
        my_coordonnes.x = pX
        my_coordonnes.y = pY 
        my_coordonnes.sx = pSx 
        my_coordonnes.sy = pSy 
    table.insert(coordonnees_affichage_barre, my_coordonnes)
end

function coordonnees_sprite.changementCoordonnees_barre_Jeu(pName, pX, pY, pSx, pSy)
    coordonnees_affichage_barre[pName].x = pX
    coordonnees_affichage_barre[pName].y = pY
    coordonnees_affichage_barre[pName].sx = pSx
    coordonnees_affichage_barre[pName].sy = pSy
end

function coordonnees_sprite.Get_coordonnees_barre()
    return coordonnees_affichage_barre
end

local coordonnees_affichage_sprite = {}
function coordonnees_sprite.implement_coordonnes_sprite(pX, pY, pSx, pSy)
    local my_coordonnes = {}
        my_coordonnes.x = pX
        my_coordonnes.y = pY 
        my_coordonnes.sx = pSx 
        my_coordonnes.sy = pSy 
    table.insert(coordonnees_affichage_sprite, my_coordonnes)
end

function coordonnees_sprite.Get_coordonnees_sprite()
    return coordonnees_affichage_sprite
end

function coordonnees_sprite.delete_coordonnes_sprite()
    table.remove(coordonnees_affichage_sprite, #coordonnees_affichage_sprite)
end

function coordonnees_sprite.delete_lst_coordonnees_affichage_sprite()
    for n=#coordonnees_affichage_sprite, 1, -1 do
        table.remove(coordonnees_affichage_sprite, n)
    end
end

function coordonnees_sprite.changementCoordonnees(pName, pVx, pVy, pSx, pSy, dt)
    coordonnees_affichage_sprite[pName].x = coordonnees_affichage_sprite[pName].x + (pVx*dt)
    coordonnees_affichage_sprite[pName].y = coordonnees_affichage_sprite[pName].y + (pVy*dt)
    coordonnees_affichage_sprite[pName].sx = pSx
    coordonnees_affichage_sprite[pName].sy = pSy
end

function coordonnees_sprite.changementCoordonneesJeu(pName, pX, pY, pSx, pSy)
    coordonnees_affichage_sprite[pName].x = pX
    coordonnees_affichage_sprite[pName].y = pY
    coordonnees_affichage_sprite[pName].sx = pSx
    coordonnees_affichage_sprite[pName].sy = pSy
end

function coordonnees_sprite.remove_coordonnes()
    coordonnees_affichage_sprite = {}
    coordonnees_affichage_barre = {}
end

mon_service.addService("coordonnees_sprite", coordonnees_sprite)
return coordonnees_sprite