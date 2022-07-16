local high_score = {}
local mon_service = require("system/service_locator")

json = require("system/json")

local largeur = 0
local hauteur = 0
local sx, sy = 0, 0
local high_score_fic = {}

--simule un score
local score = 60
local score_minimum = 0
local cam = {}
cam.x = 0
cam.y = 0


function load_module()
    require("system/quad_graphisme")
    require("system/high_score/keyboard_score")
    mon_service.getService("keyboard_score").load()
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

    if love.filesystem.exists("high_score_fic.json") == true then
        lecture_json()
        score_minimum = cherche_score()
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

local affichage_scrolling = false
local timer = 0
local implement_score = false
function high_score.update(dt)
    if affichage_scrolling == false then
        timer = timer+1*(dt)
        if timer > 3 then 
            affichage_scrolling = true
        end
    end

    --lancement du clavier score
    mon_service.getService("keyboard_score").update()
    --récupération du nom du joueur
    if mon_service.getService("keyboard_score").get_Name() ~= nil and implement_score == false then
        high_score.AjouteScore(mon_service.getService("keyboard_score").get_Name(), score)
        lecture_json()
        cam.x = 0
        cam.y = 0
        affichage_scrolling = false
        implement_score = true
    end
end

function high_score.draw()
    mon_service.getService("quad_graphisme").draw_background()
        --affichage bouton
    mon_service.getService("quad_graphisme").draw_botton(bouton_retour_etat, bouton_suivant_etat)

    
    local posY = 40*(hauteur/100)
    local posX = 25*(largeur/100)

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
        
        
        if posY-cam.y > 40*(hauteur/100) then 
            love.graphics.print(n, posX, posY-cam.y)
            posX = 45*(largeur/100)
            love.graphics.print(high_score_fic[n].score, posX, posY-cam.y)
            posX = 70*(largeur/100)
            love.graphics.print(high_score_fic[n].nom, posX, posY-cam.y)
            

            if high_score_fic[n].score > score_minimum and affichage_scrolling and implement_score == false then
                cam.y = cam.y + 2
            end
            if implement_score and high_score_fic[n].score > score_minimum  and affichage_scrolling then 
                cam.y = cam.y + 2
            end
        end
    end 
    mon_service.getService("keyboard_score").draw()

    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end

end

mon_service.addService("high_score", high_score)
return high_score