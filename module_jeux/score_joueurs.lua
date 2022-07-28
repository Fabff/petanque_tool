local score_joueurs = {}
local mon_service = require("system/service_locator")


local hauteur = 0
local largeur = 0

local sx,sy = 0, 0

local bouton_retour_etat = true
local bouton_suivant_etat = false

local nb_joueurs = 0
local lst_joueurs = nil
local numero_joueur = 1

local finParty = false
function score_joueurs.set_FinParty()
    finParty = false
end
local bouton_score = false

function score_joueurs.set_add_numero_joueur()
    numero_joueur = numero_joueur + 1
end
function score_joueurs.get_numero_joueur()
    return numero_joueur
end
function score_joueurs.reset_numero_joueur()
    numero_joueur = 1
end


--chargement des modules
function module_load()
    require("module_jeux/jeux")
    require("system/controle_botton")
    require("system/score_party/gestion_tour_joueur")
    require("system/quad_graphisme")
    require("system/score_party/coordonnees_sprite")
    require("system/gestion_joueurs")
end

function score_joueurs.load()
    print("score_joueurs charge")

    --chargement module
    module_load()

    mon_service.getService("quad_graphisme").load()

    --récupère les coordonnées de l'écran du module quad_graphisme
    largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
    sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()

    bouton_score = false

    --efface les précédentes coordonnées des sprites (coordonnées menu)
    mon_service.getService("coordonnees_sprite").remove_coordonnes()

    --récupération du nb_joueurs => lst_joueurs
    nb_joueurs = mon_service.getService("gestion_joueurs").get_nombre_joueurs()

    --init_nbBarre()
    local barre_posY = 13*(hauteur/100)
    for n = 1, nb_joueurs do 
        local barre_x = 22*(largeur/100)
        local barre_y = barre_posY 
        barre_posY = barre_posY + 20*(hauteur/100)
        mon_service.getService("coordonnees_sprite").implement_coordonnes_barre(barre_x, barre_y, sx/2.2, sy/2.2)
    end

    --init botton
    mon_service.getService("quad_graphisme").load()

    --init players
    local sprite_posY = 5*(hauteur/100)
    for n = 1, nb_joueurs do 
        local sprite_x = 5*(largeur/100)
        local sprite_y = sprite_posY 
        sprite_posY = sprite_posY + 20*(hauteur/100)
        mon_service.getService("coordonnees_sprite").implement_coordonnes_sprite(sprite_x, sprite_y, sx*0.5, sy*0.5)
    end    
end

function score_joueurs.update(dt)
    if numero_joueur > nb_joueurs then 
        numero_joueur = 1
    end
    lst_joueurs = mon_service.getService("gestion_joueurs").get_lst_joueurs() 
    
    --vider la barre score
    if mon_service.getService("gestion_ecran").getMODE() == "SCORE_JOUEURS" then  
        --si true => vide la barre des scores (démarrage)
        if mon_service.getService("menu").get_lancement() == true then
            mon_service.getService("quad_score").ScoreBarreDemarrage(nb_joueurs, dt)  
        end
        --remet set_lancement à false après vidage des barres de score
        if mon_service.getService("quad_score").GetImgBarre_largeur() < 20 then 
            mon_service.getService("menu").set_lancement()
        end
        --si set_lancement est à faux
        if mon_service.getService("menu").get_lancement() == false then 
            --deplacement des persos
            mon_service.getService("gestion_tour_joueur").calculForceDeplacement(numero_joueur)
            if lst_joueurs[numero_joueur].nb_manche > 0 then  
                mon_service.getService("gestion_tour_joueur").update(dt, sx, sy, numero_joueur)
            end
            --si nb de manche du dernier joueur est à 0 => fin de partie
            if lst_joueurs[#lst_joueurs].nb_manche == 0 then 
                finParty = true
            end
            --gestion des boutons
            bouton_retour_etat, bouton_suivant_etat = mon_service.getService("controle_botton").controle_score_joueurs(bouton_retour_etat, bouton_suivant_etat, finParty, bouton_score)
        end
    end
end

function score_joueurs.draw()
    if mon_service.getService("gestion_ecran").getMODE() == "SCORE_JOUEURS" then
        
        mon_service.getService("quad_graphisme").draw_background()
        --affichage bouton
        mon_service.getService("quad_graphisme").draw_botton(bouton_retour_etat, bouton_suivant_etat)
        --joueurs 
        mon_service.getService("quad_player").draw()
        --barre_score
        mon_service.getService("quad_score").draw()
        
    
        love.graphics.setColor(0.16,0.16,0.16)
    
        if finParty == false then 
            love.graphics.print("JOUER", 86*(largeur/100), 93*(hauteur/100))
            love.graphics.print("MENU", 3*(largeur/100), 93*(hauteur/100))
        else
            love.graphics.print("SUIVANT", 83*(largeur/100), 93*(hauteur/100))
        end

        love.graphics.setColor(1,1,1)
    
    end
end

mon_service.addService("score_joueurs", score_joueurs)
return score_joueurs