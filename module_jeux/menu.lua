local menu = {}
local mon_service = require("system/service_locator")


--chargement des modules
function module_load()
    require("system/menu/quad_player")
    require("system/score_party/coordonnes_sprite")
    require("system/score_party/quad_score")
    require("system/quad_graphisme")
end

--coordonnées écran
local hauteur, largeur = 0, 0
local sx,sy = 0, 0

--si true : barre des scores réinitialisée
local lancement = false
function menu.get_lancement()
    return lancement
end
function menu.set_lancement()
    lancement = false
end

local keypressed = false


--image choix menu
local img_menu = love.graphics.newImage("assets/imgJB/RPG_GUI_v1.png")
--image proposition selection
local imgselect = {}
        imgselect.x = 0
        imgselect.y = 120
        imgselect.largeur = 300
        imgselect.hauteur = 60
local selection = love.graphics.newQuad(imgselect.x, imgselect.y, imgselect.largeur, imgselect.hauteur, img_menu:getDimensions())
--image selection left
local imgMarqueLeft = {}
        imgMarqueLeft.x = 330
        imgMarqueLeft.y = 120
        imgMarqueLeft.largeur = 30
        imgMarqueLeft.hauteur = 40
local imgMarqueLeft = love.graphics.newQuad(imgMarqueLeft.x, imgMarqueLeft.y, imgMarqueLeft.largeur, imgMarqueLeft.hauteur, img_menu:getDimensions())
--image selection right
local imgMarqueRight = {}
        imgMarqueRight.x = 365
        imgMarqueRight.y = 120
        imgMarqueRight.largeur = 30
        imgMarqueRight.hauteur = 40
local imgMarqueRight = love.graphics.newQuad(imgMarqueRight.x, imgMarqueRight.y, imgMarqueRight.largeur, imgMarqueRight.hauteur, img_menu:getDimensions())
--image selection up/down
local imgFleches = {}
        imgFleches.x = 424
        imgFleches.y = 120
        imgFleches.largeur = 66
        imgFleches.hauteur = 40
local imgFleches = love.graphics.newQuad(imgFleches.x, imgFleches.y, imgFleches.largeur, imgFleches.hauteur, img_menu:getDimensions())
--image TITRE
local TITRE = {}
        TITRE.x = 793
        TITRE.y = 550
        TITRE.largeur = 210
        TITRE.hauteur = 46
local TITRE = love.graphics.newQuad(TITRE.x, TITRE.y, TITRE.largeur, TITRE.hauteur, img_menu:getDimensions())
local img_boules = love.graphics.newImage("assets/img/boules.png")
local bouleBleue = {}
        bouleBleue.x = 36
        bouleBleue.y = 0
        bouleBleue.largeur = 32
        bouleBleue.hauteur = 32
local bouleBleue = love.graphics.newQuad(bouleBleue.x, bouleBleue.y, bouleBleue.largeur, bouleBleue.hauteur, img_boules:getDimensions())
local bouleRouge = {}
        bouleRouge.x = 108
        bouleRouge.y = 0
        bouleRouge.largeur = 32
        bouleRouge.hauteur = 32
local bouleRouge = love.graphics.newQuad(bouleRouge.x, bouleRouge.y, bouleRouge.largeur, bouleRouge.hauteur, img_boules:getDimensions())

local nb_joueurs = 1
    

local mon_menu = {}
        mon_menu.x = 0
        mon_menu.y = 0
        mon_menu.titre = "PETANQUE"
        mon_menu.choix = {}
        mon_menu.choix[1] = "NOMBRE DE JOUEURS"
        mon_menu.choix[2] = "HIGH SCORE"
        mon_menu.choix[3] = "CREDITS"
        mon_menu.choix[4] = "LANCER"
        mon_menu.selection = 1

function create_menu(pX, pY, pChaine)
    love.graphics.print(pChaine, pX, pY)
end

function menu.load() 
   print("menu charge")
   --chargement module
   module_load()

   mon_service.getService("quad_graphisme").load()
    --récupère les coordonnées de l'écran du module quad_graphisme
   largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
   sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()

   --rend le menu responsive
   mon_menu.x = 20 * (largeur/100)
   mon_menu.y = 20 * (hauteur/100)

   --recupère la hauteur et largeur du sprite joueur dans system/menu/create_player
   local sprite_largeur = mon_service.getService("quad_player").Get_imgMen1_largeur()
   local sprite_hauteur = mon_service.getService("quad_player").Get_imgMen1_hauteur()

   nb_joueurs = 1
   --angle gauche haut => toujours affiché => minimum un joueur
    mon_service.getService("quad_player").create(nb_joueurs)
    mon_service.getService("coordonnees_sprite").implement_coordonnes_sprite(0, 0, 1, 1)

    --pName, pX, pY, pSx, pSy, pLargeur
    mon_service.getService("quad_score").createBarre(nb_joueurs, sx, sy)
   --calcul des angles - dimensions images => pour les autres joueurs
    --angle droit haut => 2 joueurs
    angle_droit_haut_x = largeur - sprite_largeur
    angle_droit_haut_y = 0
    --angle gauche bas => 3 joueurs
    angle_gauche_bas_x = 0
    angle_gache_bas_y = hauteur - sprite_hauteur
    --angle droit bas  => 4 joueurs
    angle_droit_bas_x = largeur - sprite_largeur
    angle_droit_bas_y = hauteur - sprite_hauteur
end

function menu.update(dt)
    if mon_service.getService("gestion_ecran").getMODE() == "MENU" then
        if love.keyboard.isDown("down", "up", "right", "left") then
            if keypressed == false then 
                if love.keyboard.isDown("down") then
                    if mon_menu.selection < #mon_menu.choix then 
                        mon_menu.selection = mon_menu.selection + 1
                    end
                end
                if love.keyboard.isDown("up") then
                    if mon_menu.selection > 1 then 
                    mon_menu.selection = mon_menu.selection - 1
                    end
                end

                --nombre de joueurs
                if love.keyboard.isDown("right") and mon_menu.selection == 1 then 
                    if nb_joueurs < 4 then 
                        nb_joueurs = nb_joueurs + 1
                        
                        if nb_joueurs == 2 then 
                            mon_service.getService("quad_player").create(nb_joueurs)
                            mon_service.getService("coordonnees_sprite").implement_coordonnes_sprite(angle_droit_haut_x, angle_droit_haut_y, 1, 1)
                            mon_service.getService("quad_score").createBarre(nb_joueurs, sx, sy)
                        end
                        if nb_joueurs == 3 then 
                            mon_service.getService("quad_player").create(nb_joueurs)
                            mon_service.getService("coordonnees_sprite").implement_coordonnes_sprite(angle_gauche_bas_x, angle_gache_bas_y)
                            mon_service.getService("quad_score").createBarre(nb_joueurs, sx, sy)
                        end
                        if nb_joueurs == 4 then 
                            mon_service.getService("quad_player").create(nb_joueurs)
                            mon_service.getService("coordonnees_sprite").implement_coordonnes_sprite(angle_droit_bas_x, angle_droit_bas_y)
                            mon_service.getService("quad_score").createBarre(nb_joueurs, sx, sy)
                        end
                    end
                end
                if love.keyboard.isDown("left") and mon_menu.selection == 1 then 
                    if nb_joueurs > 1 then 
                        nb_joueurs = nb_joueurs - 1
                        mon_service.getService("coordonnees_sprite").delete_coordonnes_sprite()
                    end
                end
                --lancement du high_score
                if love.keyboard.isDown("right") and mon_menu.selection == 2 then 
                    require("module_jeux/high_score")
                    mon_service.getService("high_score").load()
                    mon_service.getService("gestion_ecran").setMODE("HIGH_SCORE")
                end
                --lancement du jeu
                if love.keyboard.isDown("right") and mon_menu.selection == 4 then 
                    lancement = true
                    require("module_jeux/score_joueurs")
                    --creation des joueurs => lst_joueurs
                    require("system/gestion_joueurs")
                    for n=1, nb_joueurs do
                        mon_service.getService("gestion_joueurs").create_joueurs(n)
                    end
                    mon_service.getService("score_joueurs").load()
                    mon_service.getService("gestion_ecran").setMODE("SCORE_JOUEURS")
                end
                keypressed = true
            end
        else
            keypressed = false
        end
    end
end


function menu.draw()
    if mon_service.getService("gestion_ecran").getMODE() == "MENU" then
        
        --love.graphics.draw(background, 0, 0, 0, sx, sy)
        mon_service.getService("quad_graphisme").draw_background()

        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end
        
        local posY = mon_menu.y
        local hauteurLigne = imgselect.hauteur * sy 
       
        --titre
        if love.getVersion() == 0 then
            love.graphics.setColor(6,6,6)
        else
            love.graphics.setColor(0.16,0.16,0.16)
        end

        love.graphics.draw(img_menu, TITRE, mon_menu.x+9*(largeur/100), 6*(hauteur/100), 0, sx, sy*1.5)
        create_menu(mon_menu.x+20*(largeur/100), 9*(hauteur/100), mon_menu.titre)
        
        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end

        love.graphics.draw(img_boules, bouleBleue, mon_menu.x+11.8*(largeur/100), 8*(hauteur/100), 0, 0.8*sx, 0.8*sy)
        love.graphics.draw(img_boules, bouleRouge ,mon_menu.x+40.8*(largeur/100), 8*(hauteur/100), 0, 0.8*sx, 0.8*sy)
        posY = posY + hauteurLigne

        --choix
        local n
        local marque = " "
        for n=1, #mon_menu.choix do 
            --graphismes JB
            love.graphics.draw(img_menu, selection, mon_menu.x, posY, 0, sx, sy)

            if mon_menu.selection == n and n == 1 and
            nb_joueurs > 1 then
                love.graphics.draw(img_menu, imgMarqueLeft, mon_menu.x+4*(largeur/100), posY+3*(hauteur/100), 0, sx, sy)
            end
            if mon_menu.selection == n then
               love.graphics.draw(img_menu, imgMarqueRight, mon_menu.x+(imgselect.largeur*sx)-7*(largeur/100), posY+3*(hauteur/100), 0, sx, sy)
            end

            create_menu(mon_menu.x+8*(largeur/100), posY+3*(hauteur/100), marque.." "..mon_menu.choix[n])
            posY = posY + hauteurLigne
        end

        --joueurs
        if nb_joueurs >= 1 then 
            mon_service.getService("quad_player").draw()
        end

        --aide
        posY = posY + hauteurLigne
        love.graphics.draw(img_menu, imgFleches, mon_menu.x, posY, 0, sx, sy)
       
        if love.getVersion() == 0 then
            love.graphics.setColor(6,6,6)
        else
            love.graphics.setColor(0.02,0.02,0.02)
        end

        create_menu(mon_menu.x+15*(largeur/100), posY, "Deplacer la selection")

        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end

        posY = posY + hauteurLigne
    end
end

mon_service.addService("menu", menu)
return menu