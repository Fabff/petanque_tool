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
local score_minimum = 0
local score_maximum = 0
local cam = {}
    cam.x = 0
    cam.y = 0

local bouton_retour_etat = false
local bouton_suivant_etat = false
local call_menu = false
local last_line = false
local stop_scroll = false
local affichage_scrolling = false
local timer = 0
local implement_score = false
local valid = false
    
function load_module()
    require("system/controle_botton")
    require("system/quad_graphisme")
    require("system/menu/quad_player")

    if call_menu == false and valid == false then 
        require("system/high_score/keyboard_score")
        mon_service.getService("keyboard_score").load()
    end
    call_menu = mon_service.getService("menu").Get_call_menu()
    high_score_fic = {}
    cam = {}
    cam.x = 0
    cam.y = 0
    score_minimum = 0
    score_maximum = 0
    last_line = false
    stop_scroll = false
    affichage_scrolling = false
    timer = 0
    implement_score = false
    bouton_retour_etat = false
    bouton_suivant_etat = false
    valid = false
end

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

function high_score.load()
    print("HIGH_SCORE")

    load_module()
    
    largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
    sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()
    
    if love.filesystem.exists("high_score_fic.json") == false then
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
       
        --print(mon_json)
    end
    if call_menu == false then 
        require("system/gestion_joueurs")
        score = mon_service.getService("gestion_joueurs").get_Score_Joueur(1)
        name = mon_service.getService("gestion_joueurs").get_Name_Joueur(1)
        require("system/score_party/coordonnes_sprite")
        mon_service.getService("coordonnees_sprite").changementCoordonneesJeu(name, 20, 10, sx*0.8, sy*0.8)
    end

    if love.filesystem.exists("high_score_fic.json") == true then
        lecture_json()
        if call_menu == false then 
            score_minimum = cherche_score()
        else 
            score_minimum = high_score_fic[#high_score_fic].score 
            score_maximum = high_score_fic[1].score 
        end
    end
end

function cherche_score(dt)
    for n=1, #high_score_fic do  
        if high_score_fic[n].score < score and n >= 2 then
            return high_score_fic[n-1].score
        elseif score > high_score_fic[1].score then 
            return high_score_fic[1].score
        elseif score < high_score_fic[#high_score_fic].score then
            return high_score_fic[#high_score_fic].score
        end
    end
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
            cam.x = 0
            cam.y = 0
            affichage_scrolling = false
            implement_score = true
        end
        -- if  love.keyboard.isDown("right") and implement_score then
        --     require("system/jeux/restart") 
        --     mon_service.getService("restart").jeu_restart()
        -- end
    end

    if call_menu then
        bouton_retour_etat = mon_service.getService("controle_botton").controle_high_score_joueurs_menu(bouton_retour_etat)
    elseif call_menu == false and valid == true then 
        print("passage")
        bouton_suivant_etat = mon_service.getService("controle_botton").controle_high_score_joueurs_jeux(bouton_suivant_etat)
        print(bouton_suivant_etat)
    end
end



function high_score.draw()
    mon_service.getService("quad_graphisme").draw_background()
        --affichage bouton
    if call_menu then
        mon_service.getService("quad_graphisme").draw_back_botton(bouton_retour_etat)
    else
        mon_service.getService("quad_graphisme").draw_next_botton(bouton_suivant_etat)
    end
    local posX, posY

    if call_menu == false then 
        posY = 40*(hauteur/100)
        posX = 25*(largeur/100)
    elseif call_menu == true then 
        posY = 10*(hauteur/100)
        posX = 25*(largeur/100)
    end
    
    if love.getVersion() == 0 then
        love.graphics.setColor(6,6,6)
    else
        love.graphics.setColor(0.16,0.16,0.16)
    end

    love.graphics.print("RANK", posX, posY)
    posX = 45*(largeur/100)
    love.graphics.print("SCORE", posX, posY)
    posX = 70*(largeur/100)
    love.graphics.print("NAME", posX, posY)

    for n=1, #high_score_fic do
        posY = posY + 10*(hauteur/100)
        posX = 25*(largeur/100)
        
        local pos_score_y = 0
        if call_menu then 
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

            
            if implement_score and high_score_fic[n].score > score_minimum  and affichage_scrolling then 
                cam.y = cam.y + 2
            end
            if call_menu then 
                if high_score_fic[n].score > score_minimum and last_line == false and stop_scroll == false then 
                    cam.y = cam.y + 0.1 
                    if cam.y > 200*(hauteur/100) then
                        last_line = true
                    end 
                end
    
                if last_line then
                    if high_score_fic[n].score < score_maximum then 
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
    if call_menu == false then  
        mon_service.getService("keyboard_score").draw()
        mon_service.getService("quad_player").draw_player(name)

        if love.getVersion() == 0 then
            love.graphics.setColor(6,6,6)
        else
            love.graphics.setColor(0.16,0.16,0.16)
        end

        love.graphics.print(score, 45*(largeur/100), 20*(hauteur/100))
        love.graphics.print("MENU", 89*(largeur/100), 93*(hauteur/100))
    end

    if love.getVersion() == 0 then
       love.graphics.setColor(255,255,255)
    else
       love.graphics.setColor(1,1,1)
    end
end


mon_service.addService("high_score", high_score)
return high_score