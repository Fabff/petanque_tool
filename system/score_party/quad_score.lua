local quad_score = {}
local mon_service = require("system/service_locator")

local img_score = love.graphics.newImage("assets/imgJB/gradients.png")


--dimension imgage player
local imgBarre_hauteur = 50

local imgBarre = {}
imgBarre.x = 11
imgBarre.y = 11
imgBarre.largeur = 570
imgBarre.scoreNum = nil
local lst_barre = {}

--Quad
function quad_score.createBarre(pName, pSx, pSy)
    local my_barre = {}
    my_barre.name = pName
    my_barre.sx = pSx
    my_barre.sy = pSy
    my_barre.imgBarre_largeur = imgBarre.largeur

        if pName == 1 then
            my_barre.img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y, my_barre.imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
        end
        if pName == 2 then
            my_barre.img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+66, my_barre.imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
        end
        if pName == 3 then
            my_barre.img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+134, my_barre.imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
        end
        if pName == 4 then
            my_barre.img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+208, my_barre.imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
        end
        my_barre.scoreNum = 0

        table.insert(lst_barre, my_barre)
end

function quad_score.remove_Lst_Barre()
    lst_barre = {}
end

 function quad_score.ScoreBarreDemarrage(pName, dt)
    for n=1, #lst_barre do
        if lst_barre[n].imgBarre_largeur > 15 then 
            lst_barre[n].imgBarre_largeur = lst_barre[n].imgBarre_largeur - 63*(8*dt)
            if pName == 1 then
                lst_barre[1].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y, lst_barre[1].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            end
            if pName == 2 then
                lst_barre[1].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y, lst_barre[1].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
                lst_barre[2].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+66, lst_barre[2].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            end
            if pName == 3 then
                lst_barre[1].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y, lst_barre[1].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
                lst_barre[2].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+66, lst_barre[2].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
                lst_barre[3].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+134, lst_barre[3].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            end
            if pName == 4 then
                lst_barre[1].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y, lst_barre[1].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
                lst_barre[2].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+66, lst_barre[2].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
                lst_barre[3].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+134, lst_barre[3].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
                lst_barre[4].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+208, lst_barre[4].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            end
        end
    end
end

function quad_score.ScoreBarreAdd(pMarque, pNumJoueur)
    if pMarque then 
        lst_barre[pNumJoueur].imgBarre_largeur  = lst_barre[pNumJoueur].imgBarre_largeur + (imgBarre.largeur/9)
        if pNumJoueur == 1 then 
            lst_barre[pNumJoueur].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y, lst_barre[pNumJoueur].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            lst_barre[pNumJoueur].scoreNum = lst_barre[pNumJoueur].scoreNum + 10
        end    
        if pNumJoueur == 2 then 
            lst_barre[pNumJoueur].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+66, lst_barre[pNumJoueur].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            lst_barre[pNumJoueur].scoreNum = lst_barre[pNumJoueur].scoreNum + 10
        end
        if pNumJoueur == 3 then 
            lst_barre[pNumJoueur].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+134, lst_barre[pNumJoueur].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            lst_barre[pNumJoueur].scoreNum = lst_barre[pNumJoueur].scoreNum + 10
        end      
        if pNumJoueur == 4 then 
            lst_barre[pNumJoueur].img1 = love.graphics.newQuad(imgBarre.x, imgBarre.y+208, lst_barre[pNumJoueur].imgBarre_largeur, imgBarre_hauteur, img_score:getDimensions())
            lst_barre[pNumJoueur].scoreNum = lst_barre[pNumJoueur].scoreNum + 10
        end   
    end
end

function quad_score.GetImgBarre_largeur()
     return lst_barre[1].imgBarre_largeur
end

function quad_score.GetLst_barre()
    return lst_barre
end

function quad_score.draw()
     if mon_service.getService("gestion_ecran").getMODE() == "SCORE_JOUEURS" then
         local my_coordonnes = mon_service.getService("coordonnees_sprite").Get_coordonnees_barre()
         for n=1, #my_coordonnes do
             local coordonnes = my_coordonnes[n]
             love.graphics.draw(img_score, lst_barre[n].img1, coordonnes.x, coordonnes.y, 0, coordonnes.sx, coordonnes.sy)
             love.graphics.print(lst_barre[n].scoreNum, coordonnes.x+20, coordonnes.y, 0, coordonnes.sx, coordonnes.sy)
         end    
     end
end

mon_service.addService("quad_score", quad_score)
return quad_score