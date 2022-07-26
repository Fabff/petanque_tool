local high_score = {}
local mon_service = require("system/service_locator")

json = require("system/json")

local largeur = 0
local hauteur = 0
local sx, sy = 0, 0
local high_score_fic = {}

--simule un score
local score = 0
local name = 1
local score_minimum_affichable = 0
local score_maximum_affichable = 0
local cam = {}
    cam.x = 0
    cam.y = 0

local bouton_retour_etat = false
local bouton_suivant_etat = false
local call_menu = false
local score_insufisant = false

local last_line = false
local stop_scroll = false
local affichage_scrolling = false
local timer = 0
local implement_score = false
local valid = false
    

function high_score.AjouteScore(pNom, pScore)
    local mon_score = {}
        mon_score.nom = pNom
        mon_score.score = pScore
    table.insert(high_score_fic, mon_score)
    mon_json = json.encode(high_score_fic)
    local fichier = love.filesystem.newFile("high_score_fic.json")
    fichier:open("w")
    fichier:write(mon_json)
    fichier:close()
end

function lecture_json()
    local fichier = love.filesystem.newFile("high_score_fic.json")
    fichier:open("r")
    local contenuFichier = fichier:read()
    --print(contenuFichier)
    high_score_fic = json.decode(contenuFichier)
    --print(hight_score[1].nom)
    
    --high_score.AjouteScore("new", score)

    --affichage
    function trie_score(a, b)
        return a.score > b.score
    end
    table.sort(high_score_fic, trie_score)
end

function load_module()
    require("system/controle_botton")
    require("system/quad_graphisme")
    require("system/menu/quad_player")

    valid = false
    call_menu = mon_service.getService("menu").Get_call_menu()

    if call_menu == false and valid == false then 
        require("system/high_score/keyboard_score")
        mon_service.getService("keyboard_score").load()
    end
    high_score_fic = {}
    cam = {}
    cam.x = 0
    cam.y = 0
    score_minimum_affichable = 0
    score_maximum_affichable = 0
    score = 0
    name = 1
    last_line = false
    stop_scroll = false
    affichage_scrolling = false
    timer = 0
    implement_score = false
    bouton_retour_etat = false
    bouton_suivant_etat = false
    score_insufisant = false
end
function high_score.load()
    print("HIGH_SCORE")

    load_module()
    
    largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
    sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()
    
    if love.filesystem.getInfo("high_score_fic.json") == nil then
        high_score.AjouteScore("pau", 40)
        high_score.AjouteScore("fab", 90)
        high_score.AjouteScore("dav", 30)
        high_score.AjouteScore("ser", 10)
        high_score.AjouteScore("pau", 40)
        high_score.AjouteScore("tot", 85)
        high_score.AjouteScore("tat", 105)
        high_score.AjouteScore("tut", 15)
        high_score.AjouteScore("tit", 105)
        high_score.AjouteScore("fut", 85)
        high_score.AjouteScore("dan", 27)
        high_score.AjouteScore("sur", 9)
        high_score.AjouteScore("pau", 40)
        high_score.AjouteScore("fab", 90)
        high_score.AjouteScore("dav", 30)
        high_score.AjouteScore("ser", 10)
        high_score.AjouteScore("pau", 40)
        high_score.AjouteScore("tot", 95)
        high_score.AjouteScore("tat", 35)
        high_score.AjouteScore("tut", 15)
        high_score.AjouteScore("tit", 45)
        high_score.AjouteScore("fut", 85)
        high_score.AjouteScore("dan", 27)
        high_score.AjouteScore("sur", 9)
        high_score.AjouteScore("pau", 40)
        high_score.AjouteScore("fab", 90)
        high_score.AjouteScore("dav", 30)
        high_score.AjouteScore("ser", 10)
        high_score.AjouteScore("pau", 40)
        high_score.AjouteScore("tot", 105)
        --print(mon_json)
    end

    if call_menu == false and score_insufisant == false then 
        require("system/gestion_joueurs")
        score = mon_service.getService("gestion_joueurs").get_Score_Joueur(1)
        name = mon_service.getService("gestion_joueurs").get_Name_Joueur(1)
        require("system/score_party/coordonnees_sprite")
        mon_service.getService("coordonnees_sprite").changementCoordonneesJeu(name, 20, 10, sx*0.8, sy*0.8)
    end
    
    if love.filesystem.getInfo("high_score_fic.json") then
        lecture_json()
        if call_menu == false and score_insufisant == false then 
            score_minimum_affichable = cherche_score()
        else 
            score_minimum_affichable = high_score_fic[#high_score_fic].score 
            score_maximum_affichable = high_score_fic[1].score 
        end
    end
   
    --si score du joueur < score du dernier fic et que le fichier contient 30 enregistrement :
    if (score < high_score_fic[#high_score_fic].score and #high_score_fic >= 30) and call_menu == false then
        score_insufisant = true
    end
end

function cherche_score()
    for n=1, #high_score_fic do  
        if high_score_fic[n].score < score and n >= 2 then
            return high_score_fic[n-1].score
        elseif score > high_score_fic[1].score then 
            return high_score_fic[1].score
        elseif score <= high_score_fic[#high_score_fic].score then
            return high_score_fic[#high_score_fic].score
        end
    end
end

function delete_last_score()
    table.remove(high_score_fic, #high_score_fic)
    mon_json = json.encode(high_score_fic)
    local fichier = love.filesystem.newFile("high_score_fic.json")
    fichier:open("w")
    fichier:write(mon_json)
    fichier:close()
end

function high_score.update(dt)

    if affichage_scrolling == false then
        timer = timer+1*(dt)
        if timer > 3 then 
            affichage_scrolling = true
        end
    end

    --lancement du clavier score
    if call_menu == false then
        if valid == false then 
            mon_service.getService("keyboard_score").update()
            valid = mon_service.getService("keyboard_score").get_Valid()
        end
        --récupération du nom du joueur
        if mon_service.getService("keyboard_score").get_Name() ~= nil and implement_score == false then
            high_score.AjouteScore(mon_service.getService("keyboard_score").get_Name(), score)
            lecture_json()
            if (#high_score_fic >= 30) then
                delete_last_score()
            end 
            cam.x = 0
            cam.y = 0
            affichage_scrolling = false
            implement_score = true
        end
    end

    if call_menu or score_insufisant then
        bouton_retour_etat = mon_service.getService("controle_botton").controle_high_score_joueurs_menu(bouton_retour_etat, score_insufisant)
    elseif call_menu == false and valid == true then 
        bouton_suivant_etat = mon_service.getService("controle_botton").controle_high_score_joueurs_jeux(bouton_suivant_etat)
    end
end



function high_score.draw()
    mon_service.getService("quad_graphisme").draw_background()
        --affichage bouton
    if call_menu or score_insufisant then
        mon_service.getService("quad_graphisme").draw_back_botton(bouton_retour_etat)
    else
        mon_service.getService("quad_graphisme").draw_next_botton(bouton_suivant_etat)
    end
    local posX, posY = 0, 0

    if call_menu == false and score_insufisant == false then 
        posY = 40*(hauteur/100)
        posX = 25*(largeur/100)
    elseif call_menu == true or score_insufisant == true then 
        posY = 10*(hauteur/100)
        posX = 25*(largeur/100)
    end
    
    
    
    love.graphics.setColor(0.16,0.16,0.16)
    

    love.graphics.print("RANK", posX, posY)
    posX = 45*(largeur/100)
    love.graphics.print("SCORE", posX, posY)
    posX = 70*(largeur/100)
    love.graphics.print("NAME", posX, posY)

    for n=1, #high_score_fic do
        posY = posY + 10*(hauteur/100)
        posX = 25*(largeur/100)
        
        local pos_score_y = 0
        if call_menu or score_insufisant then 
            pos_score_y = 15
        else
            pos_score_y = 40
        end

        if posY-cam.y > pos_score_y*(hauteur/100) then 
            love.graphics.print(n, posX, posY-cam.y)
            posX = 45*(largeur/100)
            love.graphics.print(high_score_fic[n].score, posX, posY-cam.y)
            posX = 70*(largeur/100)
            love.graphics.print(high_score_fic[n].nom, posX, posY-cam.y)

            if implement_score and high_score_fic[n].score > score_minimum_affichable and affichage_scrolling then 
                cam.y = cam.y + 2
            end

            if call_menu or score_insufisant then 
                if high_score_fic[n].score > score_minimum_affichable and last_line == false and stop_scroll == false then 
                    cam.y = cam.y + 0.1
                    if cam.y > (#high_score_fic-7)*10*(hauteur/100) then
                        last_line = true
                    end 
                end
    
                if last_line then
                    if (cam.y > 0 ) then 
                        cam.y = cam.y - 0.1
                    else
                        last_line = false
                        stop_scroll = true
                    end
                end
                love.graphics.print("MENU", 3*(largeur/100), 93*(hauteur/100))
            end
        end
    end 

    if call_menu == false and score_insufisant == false then  
        mon_service.getService("keyboard_score").draw()
        mon_service.getService("quad_player").draw_player(name)
    
        love.graphics.setColor(0.16,0.16,0.16)
    
        love.graphics.print(score, 45*(largeur/100), 20*(hauteur/100))
        love.graphics.print("MENU", 89*(largeur/100), 93*(hauteur/100))
    end

    love.graphics.setColor(1,1,1)
end


mon_service.addService("high_score", high_score)
return high_score