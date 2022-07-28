local jeux = {}

local mon_service = require("system/service_locator")

local largeur, hauteur = 0, 0
local sx, sy = 0, 0


local lst_ball = nil
local finParty = false
function jeux.set_FinParty()
    finParty = false
end

local small_font = nil
local big_font = nil
local bouton_retour_etat = false
local bouton_suivant_etat = false
local changement_joueurs = false
local numero_joueur = 1
local get_dt = 0
function  jeux.get_dt()
    return get_dt
end

function start_module()
    require("system/jeux/random")      
    --require("system/jeux/restart")      
    require("system/jeux/keyboard") 

    --affichage ecran jeu
    require("system/jeux/gestion_affichage_ecran_jeux/terrain_jeux") 
    require("system/jeux/gestion_affichage_ecran_jeux/boule")    
    require("system/jeux/gestion_affichage_ecran_jeux/particules")   
    require("system/jeux/gestion_affichage_ecran_jeux/inventaire")
    require("system/jeux/gestion_affichage_ecran_jeux/score")    

end

function create_object()
    --creation objet boule
    local bouleX = ((largeur*5.8)/100)
    mon_service.getService("boule").create_boule("e", (largeur*30)/100, (hauteur*50)/100, false, sx*0.07, sx*0.07, false, false)
    mon_service.getService("boule").create_boule("r", (largeur*50)/100, (hauteur*50)/100, false, sx*0.07, sx*0.07, false, false)
    mon_service.getService("boule").create_boule("t", (largeur*70)/100, (hauteur*50)/100, false, sx*0.07, sx*0.07, false, false)
    
    --creation objet inventaire
    mon_service.getService("inventaire").create_inventaire("1", (largeur*5/100), (hauteur*5)/100, sx, sy, false)
    mon_service.getService("inventaire").create_inventaire("2", (largeur*10/100), (hauteur*5)/100, sx, sy, false)
    mon_service.getService("inventaire").create_inventaire("3", (largeur*15/100), (hauteur*5)/100, sx, sy, false)
    
    --initialisation du RANDOM
    mon_service.getService("random").intit_random()
    
end

function jeux.load()
    --mode fenêtré
    print("jeux charge")
    mon_service.getService("quad_graphisme").load()
    --récupère les coordonnées de l'écran du module quad_graphisme
    largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
    sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()
    
    small_font = mon_service.getService("gestion_font").small_font_load(largeur)
    big_font = mon_service.getService("gestion_font").big_font_load(largeur)
    
    
    start_module()
    create_object()
    mon_service.getService("terrain_jeux").load_terrain_jeux()
    
    --chargement score
    mon_service.getService("score").load()

    --permet de gérer l'affichage des boules en bleu
    lst_ball = mon_service.getService("boule").get_lst_ball()

    --permet de gérer le numero_joueur
    changement_joueurs = true

    --récupération numero_joueur en cours
    numero_joueur = mon_service.getService("score_joueurs").get_numero_joueur()
end
    
function jeux.update(dt)  
    
    if mon_service.getService("gestion_ecran").getMODE() == "JEUX" then
        for n = 1, #lst_ball do
            if lst_ball[n].randomed == false then
                if mon_service.getService("random").get_last_lst_random() == lst_ball[n].num then
                    lst_ball[n].randomed = true 
                end
            end
            -- si seulement le bon bouton est pressé 
            mon_service.getService("keyboard").verif_touche_cible(dt)
        end
        mon_service.getService("particules").deleteParticule(dt)
        
        if (mon_service.getService("keyboard").getTir_essaie()) == 3 then
            finParty = true
            local score_party = mon_service.getService("score").get_score_manche_value()
            
            if changement_joueurs then 
                --récupération lst_joueurs
                local lst_joueurs = mon_service.getService("gestion_joueurs").get_lst_joueurs()
                
                --incrémente la barre de score
                mon_service.getService("gestion_joueurs").set_Score_Joueur(numero_joueur, score_party)

                --décrémente le nb de partie restante
                lst_joueurs[numero_joueur].nb_manche = lst_joueurs[numero_joueur].nb_manche - 1
                lst_joueurs[numero_joueur].nb_tour = lst_joueurs[numero_joueur].nb_tour + 1
                --incrémente le numéro joueurs = joueur suivant
                mon_service.getService("score_joueurs").set_add_numero_joueur()
                changement_joueurs = false
            end
            
        end
        bouton_retour_etat, bouton_suivant_etat = mon_service.getService("controle_botton").controle_jeux(bouton_retour_etat, bouton_suivant_etat, finParty)
    end
end

function jeux.draw()
    if mon_service.getService("gestion_ecran").getMODE() == "JEUX" then
        mon_service.getService("quad_graphisme").draw_background()
        mon_service.getService("quad_graphisme").draw_botton(bouton_retour_etat, bouton_suivant_etat, finParty)
        --affichage terrain_jeu
        mon_service.getService("terrain_jeux").draw_terrain(100, 100)
        --affichage particule
        mon_service.getService("particules").draw()
        --affichage boule
        mon_service.getService("boule").draw()
        --affichage inventaire
        mon_service.getService("inventaire").draw()
        --affichage du score
        love.graphics.setFont(big_font)
        mon_service.getService("score").draw()
        love.graphics.setFont(small_font)
        --affichage perso en cours
        mon_service.getService("quad_player").draw_player(numero_joueur)
        --affichage fleche down 
        mon_service.getService("quad_graphisme").draw_botton_down_game()
        if love.getVersion() == 0 then
            love.graphics.setColor(6,6,6)
        else
            love.graphics.setColor(0.16,0.16,0.16)
        end
        if mon_service.getService("keyboard").get_roll() == true or 
        mon_service.getService("keyboard").get_missed() == true then
            love.graphics.print("WAIT", 10*(largeur/100), 35*(hauteur/100))
        else
            love.graphics.print("READY", 10*(largeur/100), 35*(hauteur/100))
        end
        if finParty then 
            love.graphics.print("SUIVANT", 82*(largeur/100), 93*(hauteur/100))
        end
        love.graphics.print("MENU", 3*(largeur/100), 93*(hauteur/100))

        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end
    end
end

mon_service.addService("jeux", jeux)
return jeux