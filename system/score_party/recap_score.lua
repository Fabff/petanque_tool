local recap_score = {}
local mon_service = require("system/service_locator")

local hauteur = 0
local largeur = 0

local sx,sy = 0, 0

local bouton_retour_etat = true
local bouton_suivant_etat = false



function recap_score.load()
    mon_service.getService("quad_graphisme").load()
    --récupère les coordonnées de l'écran du module quad_graphisme
    largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
    sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()
   
    mon_service.getService("coordonnees_sprite").remove_coordonnes()
    
    require("system/gestion_joueurs")
    require("system/score_party/coordonnes_sprite")
    require("system/jeux/restart")

    --mon_service.getService("restart").trie_score()
    mon_service.getService("gestion_joueurs").trie_score()

    local lst_joueurs =  mon_service.getService("gestion_joueurs").get_lst_joueurs()
    
    --init players
    local sprite_posY = 5*(hauteur/100)
    for n = 1, #lst_joueurs do 
        print("n : "..n)
        print("name ".. lst_joueurs[n].name)
        local sprite_x = 5*(largeur/100)
        local sprite_y = sprite_posY 
        sprite_posY = sprite_posY + 20*(hauteur/100)
        mon_service.getService("coordonnees_sprite").changementCoordonneesJeu(lst_joueurs[n].name, sprite_x, sprite_y, sx*0.5, sy*0.5)
    end    

     --init_nbBarre()
     local barre_posY = 13*(hauteur/100)
     for n = 1, #lst_joueurs do 
         local barre_x = 20*(largeur/100)
         local barre_y = barre_posY 
         barre_posY = barre_posY + 20*(hauteur/100)
         mon_service.getService("coordonnees_sprite").changementCoordonnees_barre_Jeu(lst_joueurs[n].name, barre_x, barre_y, sx/2.2, sy/2.2)
     end

     mon_service.getService("score_joueurs").load()
     mon_service.getService("gestion_ecran").setMODE("SCORE_JOUEURS")
end

-- function recap_score.update()
--     bouton_retour_etat, bouton_suivant_etat = mon_service.getService("controle_botton").controle_score_joueurs(bouton_retour_etat, bouton_suivant_etat, finParty)
-- end

-- function recap_score.draw()
--     mon_service.getService("quad_graphisme").draw_background()
--     --affichage bouton
--     mon_service.getService("quad_graphisme").draw_botton(bouton_retour_etat, bouton_suivant_etat)
--     mon_service.getService("quad_player").draw()
-- end

mon_service.addService("recap_score", recap_score)
return recap_score

