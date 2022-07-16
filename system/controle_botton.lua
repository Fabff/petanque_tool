local controle_botton = {}
local mon_service = require("system/service_locator")


local bouton_score = false
function controle_botton.controle_score_joueurs(pBretour_etat, pBsuivant_etat, pFinParty)
    local bouton_retour_etat = pBretour_etat
    local bouton_suivant_etat = pBsuivant_etat

    if pFinParty and bouton_score == false then 
        require("module_jeux/high_score")
        require("system/score_party/recap_score")
        mon_service.getService("recap_score").load()
        bouton_score = true
    end
    
    if love.keyboard.isDown("left", "right") then
        if keypressed == false then 

            --selectionner :  
            if love.keyboard.isDown("left") and bouton_retour_etat == false and bouton_suivant_etat == false then
                bouton_retour_etat = true
                bouton_suivant_etat = false
            end 
            if love.keyboard.isDown("right") and bouton_retour_etat == false and bouton_suivant_etat == false then
                bouton_retour_etat = false
                bouton_suivant_etat = true
            end      
            -- confirmer 
            if love.keyboard.isDown("left") and bouton_retour_etat == true and bouton_suivant_etat == false then
                --retour au menu
                require("system/jeux/restart")
                mon_service.getService("restart").jeu_restart()
            end
            if love.keyboard.isDown("right") and bouton_retour_etat == false and bouton_suivant_etat == true and keypressed == false then 
                if pFinParty == false then
                    --lancement jeux
                    --change les coordonnées du sprite
                    require("system/score_party/coordonnes_sprite")
                    local largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
                    local sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()
                    local numero_joueur = mon_service.getService("score_joueurs").get_numero_joueur()
                    mon_service.getService("coordonnees_sprite").changementCoordonneesJeu(numero_joueur, (largeur*0.5)/100, (hauteur*8.5)/100, sx*0.7, sy*0.7)
                    mon_service.getService("jeux").load()
                    mon_service.getService("gestion_ecran").setMODE("JEUX")
                end
                if bouton_score == true then
                    mon_service.getService("high_score").load()
                    mon_service.getService("gestion_ecran").setMODE("HIGH_SCORE")
                end
            end
            
            -- changer
            if love.keyboard.isDown("left") then
                bouton_retour_etat = true
                bouton_suivant_etat = false
            end
            if love.keyboard.isDown("right") then
                bouton_retour_etat = false
                bouton_suivant_etat = true
            end  
            keypressed = true
        end
    else
        keypressed = false
    end
    return bouton_retour_etat, bouton_suivant_etat
end

function controle_botton.controle_jeux(pBretour_etat, pBsuivant_etat, pFinParty)
    local bouton_retour_etat = pBretour_etat
    local bouton_suivant_etat = pBsuivant_etat

    if love.keyboard.isDown("left", "right") then
        if keypressed == false then 

            --selectionner :  
            if love.keyboard.isDown("left") and bouton_retour_etat == false and bouton_suivant_etat == false then
                bouton_retour_etat = false
                bouton_suivant_etat = false
            end 
            if love.keyboard.isDown("right") and bouton_retour_etat == false and bouton_suivant_etat == false then
                bouton_retour_etat = false
                bouton_suivant_etat = true
            end      
            -- confirmer 
            if love.keyboard.isDown("left") and bouton_retour_etat == true and bouton_suivant_etat == false then
                --retour au menu
                require("system/jeux/restart")
                mon_service.getService("restart").jeu_restart()
            end
            if love.keyboard.isDown("right") and bouton_retour_etat == false and bouton_suivant_etat == true and keypressed == false 
            and pFinParty then
                --lancement jeux
                mon_service.getService("restart").restart()
            end   
            -- changer
            if love.keyboard.isDown("left") then
                bouton_retour_etat = true
                bouton_suivant_etat = false
            end
            if love.keyboard.isDown("right") then
                bouton_retour_etat = false
                bouton_suivant_etat = true
            end  
            keypressed = true
        end
    else
        keypressed = false
    end
    return bouton_retour_etat, bouton_suivant_etat
end
mon_service.addService("controle_botton", controle_botton)
return controle_botton