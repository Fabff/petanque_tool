local quad_player = {}
local mon_service = require("system/service_locator")

local imgMen = love.graphics.newImage("assets/img/male_runner_concepts.png")

--dimension imgage player
local imgMen1_largeur = 200
local imgMen1_hauteur = 200
local imgMen1 = {}
        imgMen1.x = 0
        imgMen1.y = 0


function quad_player.Get_imgMen1_largeur()
        return imgMen1_largeur
end
function quad_player.Get_imgMen1_hauteur()
        return imgMen1_hauteur
end

local lst_player = {}
function quad_player.create(pName, pSx, pSy)
     local my_player = {}
        my_player.name = pName
        my_player.sx = pSx
        my_player.sy = pSy

        if pName == 1 then
                my_player.img1 = love.graphics.newQuad(imgMen1.x, imgMen1.y, imgMen1_largeur, imgMen1_hauteur, imgMen:getDimensions())
        end
        if pName == 2 then
                my_player.img1 = love.graphics.newQuad(imgMen1.x+200, imgMen1.y, imgMen1_largeur, imgMen1_hauteur, imgMen:getDimensions())
        end
        if pName == 3 then
                my_player.img1 = love.graphics.newQuad(imgMen1.x+400, imgMen1.y, imgMen1_largeur, imgMen1_hauteur, imgMen:getDimensions())
        end
        if pName == 4 then
                my_player.img1 = love.graphics.newQuad(imgMen1.x+600, imgMen1.y, imgMen1_largeur, imgMen1_hauteur, imgMen:getDimensions())
        end
         table.insert(lst_player, my_player)
end

function quad_player.remove_Lst_player()
        for n=#lst_player, 1, -1 do
                table.remove(lst_player, n)
        end
end

function quad_player.draw()
        local my_sprite = mon_service.getService("coordonnees_sprite").Get_coordonnees_sprite()
        for n=1, #my_sprite do
                local sprite = my_sprite[n]
                love.graphics.draw(imgMen, lst_player[n].img1, sprite.x, sprite.y, 0, sprite.sx, sprite.sy)
        end    
end

--affichage sprite ecran jeux
function quad_player.draw_player(pNum_joueurs)
        local sprite = mon_service.getService("coordonnees_sprite").Get_coordonnees_sprite()
        love.graphics.draw(imgMen, lst_player[pNum_joueurs].img1, sprite[pNum_joueurs].x, sprite[pNum_joueurs].y, 0, sprite[pNum_joueurs].sx, sprite[pNum_joueurs].sy)
end

--affichage sprite recap score
function quad_player.draw_score()
        local my_sprite = mon_service.getService("coordonnees_sprite").Get_coordonnees_sprite()
        for n=1, #my_sprite do
                local sprite = my_sprite[n]
                love.graphics.draw(imgMen, lst_player[n].img1, sprite.x, sprite.y, 0, sprite.sx, sprite.sy)
        end    
end
mon_service.addService("quad_player", quad_player)
return quad_player