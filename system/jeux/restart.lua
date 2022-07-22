local restart = {}
local mon_service = require("system/service_locator")
function restart.trie_score()
    --arret du roll
    mon_service.getService("keyboard").set_roll_false()
    --remet à 0 les tables et variables du module random
    mon_service.getService("random").start()
    --remet à 0 le nombre de tir
    mon_service.getService("keyboard").restart()
    --remet à 0 les boules
    mon_service.getService("boule").restart()    
    --remet à 0 le score
    mon_service.getService("score").restart()
    --remet à 0 les particules
    mon_service.getService("particules").restart()
     --remet à 0 l'inventaire
    mon_service.getService("inventaire").restart()
    --remet à false fin de party
    mon_service.getService("jeux").set_FinParty()
end

function restart.restart()
    --arret du roll
    mon_service.getService("keyboard").set_roll_false()
    --remet à 0 les tables et variables du module random
    mon_service.getService("random").start()
    --remet à 0 le nombre de tir
    mon_service.getService("keyboard").restart()
    --remet à 0 les boules
    mon_service.getService("boule").restart()    
    --remet à 0 le score
    mon_service.getService("score").restart()
    --remet à 0 les particules
    mon_service.getService("particules").restart()
     --remet à 0 l'inventaire
    mon_service.getService("inventaire").restart()
    --remet à false fin de party
    mon_service.getService("jeux").set_FinParty()
    
    mon_service.getService("score_joueurs").load()
    mon_service.getService("gestion_ecran").setMODE("SCORE_JOUEURS")
end

function restart.jeu_restart()
    require("system/jeux/random")
    require("system/jeux/keyboard")
    require("system/jeux/gestion_affichage_ecran_jeux/boule")
    require("system/jeux/gestion_affichage_ecran_jeux/particules")
    require("system/jeux/gestion_affichage_ecran_jeux/inventaire")
    require("system/jeux/gestion_affichage_ecran_jeux/score")
    --arret du roll
    mon_service.getService("keyboard").set_roll_false()
    --remet à 0 les tables et variables du module random
    mon_service.getService("random").start()
    --remet à 0 le nombre de tir
    mon_service.getService("keyboard").restart()
    --remet à 0 les boules
    mon_service.getService("boule").restart()    
    --remet à 0 le score
    mon_service.getService("score").restart()
    --remet à 0 les particules
    mon_service.getService("particules").restart()
    --remet à 0 l'inventaire
    mon_service.getService("inventaire").restart()
    --remet à false fin de party
    mon_service.getService("jeux").set_FinParty()
    mon_service.getService("score_joueurs").set_FinParty()
    --remet a 0 les coordonnees des sprite
    mon_service.getService("coordonnees_sprite").remove_coordonnes()
    -- efface la liste des joueurs (sprite) creer dans le menu
    mon_service.getService("quad_player").remove_Lst_player()
    --efface la liste des barres de scores pour chaque sprite
    mon_service.getService("quad_score").remove_Lst_Barre()
    --efface la liste des joueurs + score + nb_partie
    mon_service.getService("gestion_joueurs").delete_lst_joueurs()
    --remet a 1 le numero du joueur courant
    mon_service.getService("score_joueurs").reset_numero_joueur()
   

    mon_service.getService("menu").load()
    mon_service.getService("gestion_ecran").setMODE("MENU")
end

function restart.high_score_menu_restart()
    
    mon_service.getService("coordonnees_sprite").remove_coordonnes()
    mon_service.getService("quad_player").remove_Lst_player()
    mon_service.getService("menu").Set_call_menu(false)

    mon_service.getService("menu").load()
    mon_service.getService("gestion_ecran").setMODE("MENU")
end
mon_service.addService("restart", restart)
return restart