local quad_graphisme = {}
local mon_service = require("system/service_locator")

local background = love.graphics.newImage("assets/imgJB/paper background.png")

local sx, sy = 0, 0
function quad_graphisme.get_sx_sy()
    return sx, sy
end

--image choix menu
local img_menu = love.graphics.newImage("assets/imgJB/RPG_GUI_v1.png")

--image selection left
local imgMarqueLeft_off = {}
    imgMarqueLeft_off.x = 380
    imgMarqueLeft_off.y = 260
    imgMarqueLeft_off.largeur = 30
    imgMarqueLeft_off.hauteur = 40
imgMarqueLeft_off = love.graphics.newQuad(imgMarqueLeft_off.x, imgMarqueLeft_off.y, 
                            imgMarqueLeft_off.largeur, imgMarqueLeft_off.hauteur, img_menu:getDimensions())
local imgMarqueLeft_on = {}
    imgMarqueLeft_on.x = 380
    imgMarqueLeft_on.y = 320
    imgMarqueLeft_on.largeur = 30
    imgMarqueLeft_on.hauteur = 40
imgMarqueLeft_on = love.graphics.newQuad(imgMarqueLeft_on.x, imgMarqueLeft_on.y, 
                            imgMarqueLeft_on.largeur, imgMarqueLeft_on.hauteur, img_menu:getDimensions())

    --image selection left
local imgMarqueRight_off = {}
    imgMarqueRight_off.x = 540
    imgMarqueRight_off.y = 255
    imgMarqueRight_off.largeur = 35
    imgMarqueRight_off.hauteur = 40
imgMarqueRight_off = love.graphics.newQuad(imgMarqueRight_off.x, imgMarqueRight_off.y, 
                            imgMarqueRight_off.largeur, imgMarqueRight_off.hauteur, img_menu:getDimensions())
local imgMarqueRight_on = {}
    imgMarqueRight_on.x = 545
    imgMarqueRight_on.y = 320
    imgMarqueRight_on.largeur = 30
    imgMarqueRight_on.hauteur = 40
imgMarqueRight_on = love.graphics.newQuad(imgMarqueRight_on.x, imgMarqueRight_on.y, 
                                imgMarqueRight_on.largeur, imgMarqueRight_on.hauteur, img_menu:getDimensions())
    --image selection down (perdu)
local imgMarqueDown_on = {}
imgMarqueDown_on.x = 617.5
imgMarqueDown_on.y = 257.5
imgMarqueDown_on.largeur = 35
imgMarqueDown_on.hauteur = 35
imgMarqueDown_on = love.graphics.newQuad(imgMarqueDown_on.x, imgMarqueDown_on.y, 
            imgMarqueDown_on.largeur, imgMarqueDown_on.hauteur, img_menu:getDimensions())

    --image terrain
local imgTerrain = {}
imgTerrain.x = 860
imgTerrain.y = 180 
imgTerrain.largeur = 140
imgTerrain.hauteur = 150
imgTerrain = love.graphics.newQuad(imgTerrain.x, imgTerrain.y, 
        imgTerrain.largeur, imgTerrain.hauteur, img_menu:getDimensions())

local hauteur, largeur = 0, 0
function quad_graphisme.get_largeur_hauteur()
    quad_graphisme.load()
    return largeur, hauteur
end

function quad_graphisme.Get_coordonnees_MarqueRight()
    return imgMarqueRightX, imgMarqueRightY
end

function quad_graphisme.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    --calcul du scale responsive
    sx = largeur/background:getWidth()
    sy = hauteur/background:getHeight()
end

function quad_graphisme.draw_terrain(pX, pY)
    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end
        love.graphics.draw(img_menu, imgTerrain, pX-(sx*25), pY-(sx*20), 0, sx*0.7, sx*0.7)
    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end
end

function quad_graphisme.draw_background()
    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end

    love.graphics.draw(background, 0, 0, 0, sx, sy)

    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end
end

function quad_graphisme.draw_back_botton(pBretour_etat)

    -- if love.getVersion() == 0 then
    --     love.graphics.setColor(255,255,255)
    -- else
    --     love.graphics.setColor(1,1,1)
    -- end

    --bouton retour
    if pBretour_etat  then 
        love.graphics.draw(img_menu, imgMarqueLeft_on, 4*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    else
        love.graphics.draw(img_menu, imgMarqueLeft_off, 4*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    end
end

function quad_graphisme.draw_next_botton(pBsuivant_etat)
    -- if love.getVersion() == 0 then
    --     love.graphics.setColor(255,255,255)
    -- else
    --     love.graphics.setColor(1,1,1)
    -- end

    --bouton suivant
    if pBsuivant_etat then 
        love.graphics.draw(img_menu, imgMarqueRight_on, 90*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    else
        love.graphics.draw(img_menu, imgMarqueRight_off, 90*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    end
    --end
end

function quad_graphisme.draw_botton(pBretour_etat, pBsuivant_etat)

    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end

    --bouton retour
    if pBretour_etat  then 
        love.graphics.draw(img_menu, imgMarqueLeft_on, 4*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    else
        love.graphics.draw(img_menu, imgMarqueLeft_off, 4*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    end

    --if mon_service.getService("gestion_ecran").getMODE() == "SCORE_JOUEURS"  or 
    --(mon_service.getService("gestion_ecran").getMODE() == "JEUX") then

    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end

    --bouton suivant
    if pBsuivant_etat then 
        love.graphics.draw(img_menu, imgMarqueRight_on, 90*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    else
        love.graphics.draw(img_menu, imgMarqueRight_off, 90*(largeur/100), 85*(hauteur/100), 0, sx, sy)
    end
    --end
end

function quad_graphisme.draw_botton_down_game()
    if mon_service.getService("gestion_ecran").getMODE() == "JEUX" then
        love.graphics.draw(img_menu, imgMarqueDown_on, 50*(largeur/100), 85*(hauteur/100), 0, sx, sy)
        if love.getVersion() == 0 then
            love.graphics.setColor(18,16,16)
          else
            love.graphics.setColor(0.07,0.06,0.06)
          end
        love.graphics.print("TIR MANQUE", 43*(largeur/100), 92*(hauteur/100) )
        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
           love.graphics.setColor(1,1,1)
        end
    end
end

mon_service.addService("quad_graphisme", quad_graphisme)
return quad_graphisme