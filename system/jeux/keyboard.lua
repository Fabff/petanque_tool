local keyboard = {}

local mon_service = require("system/service_locator")

local tir_essaie = 0
local tir_essaie_max = 3
local keypressed = false
local score_manche = 10
local numero_joueur = 0
local time_passed = 0
local time_finished = 0
local time_started = 0
local roll = false
local missed = false

function keyboard.get_roll()
    return roll
end
function keyboard.get_missed()
    return missed
end

local num_boule = 0
local vitesse_deplacement_boule = 1.5

--permet de savoir si le joueurs à marqué
local marque = false
function keyboard.get_marque()
    return marque
end

function keyboard.restart()
    tir_essaie = 0
    tir_essaie_max = 3
    keypressed = false
    score_manche = 10
    marque = false
end

function cible_marque()
    numero_joueur = mon_service.getService("score_joueurs").get_numero_joueur()
    tir_essaie = tir_essaie + 1
    mon_service.getService("score").addScore(score_manche, tir_essaie, true)
    mon_service.getService("quad_score").ScoreBarreAdd(marque, numero_joueur)
    mon_service.getService("random").intit_random()
end

function cible_manque()
    tir_essaie = tir_essaie + 1
    mon_service.getService("score").addScore(0, tir_essaie, false)
    mon_service.getService("random").intit_random()
end

local timer = 0
local affichage_scrolling = false
 --vérifier l'ensemble des retours cibles
function keyboard.verif_touche_cible(dt)
    --time_started = love.timer.getTime()
    if love.keyboard.isDown("e", "r", "t", "down") and tir_essaie < tir_essaie_max+1 then
            if keypressed == false then
                --récupération de la dernière valeur désignée par random
                local random_designe = mon_service.getService("random").get_last_lst_random()
                --récupération de la liste de balle
                local lst_ball =  mon_service.getService("boule").get_lst_ball()
                --sert à l'explosion
                local balle_milieuX = 298
                local balle_milieuY = 500

                if  random_designe == "e"  then
                    if love.keyboard.isDown("e") then  
                        lst_ball[1].scored = true 
                        marque = true
                        mon_service.getService("particules").ajouteExplosion(lst_ball[1].x+(balle_milieuX* lst_ball[3].scaleX), lst_ball[1].y+(balle_milieuY* lst_ball[1].scaleY))
                        cible_marque()
                        roll = true
                        num_boule = 1
                    else
                        lst_ball[1].missed = true
                        missed = true
                        cible_manque()
                    end
                end

                if random_designe == "r" then
                    if love.keyboard.isDown("r") then  
                        lst_ball[2].scored = true 
                        marque = true
                        mon_service.getService("particules").ajouteExplosion(lst_ball[2].x+(balle_milieuX* lst_ball[3].scaleX), lst_ball[2].y+(balle_milieuY*lst_ball[2].scaleY))
                        cible_marque()
                        roll = true
                        num_boule = 2
                    else
                        lst_ball[2].missed = true
                        missed = true
                        cible_manque()
                    end 
                end

                if random_designe == "t" then
                    if love.keyboard.isDown("t") then  
                        lst_ball[3].scored = true 
                        marque = true
                        mon_service.getService("particules").ajouteExplosion(lst_ball[3].x+(balle_milieuX* lst_ball[3].scaleX), lst_ball[3].y+(balle_milieuY*lst_ball[3].scaleY))
                        cible_marque()
                        roll = true
                        num_boule = 3
                    else
                        lst_ball[3].missed = true
                        missed = true
                        cible_manque()
                    end
                end
                keypressed = true
            end
        else
           -- if affichage_scrolling == false then
                timer = timer+1*(dt)
                if timer > 5 then 
                    keypressed = false
                    time_passed = 0
                    roll = false
                    missed = false
                    num_boule = 0
                    affichage_scrolling = true
                    timer = 0
                end
    end
         --faire rouler
        if roll == true then 
            mon_service.getService("boule").roll_boule(num_boule, vitesse_deplacement_boule, dt)  
        end  
end

function keyboard.getTir_essaie_max()
    return tir_essaie_max
end
function keyboard.getTir_essaie()
    return tir_essaie
end


mon_service.addService("keyboard", keyboard)
return keyboard