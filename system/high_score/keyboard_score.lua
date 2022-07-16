local keyboard_score = {}
local mon_service = require("system/service_locator")

local choix_lettres = 
{
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z", " ", "@", "_", "-",
    "#"
}
local currentLetter = 1
local initials = {1,1,1}
local keypressed = false
local keypressedDown = false
local keypressedUP = false
local keypressedRight = false
local keypressedLeft = false
local largeur, hauteur, sx, sy = 0, 0, 0, 0
local name = nil
function keyboard_score.get_Name()
    return name
end

function keyboard_score.load()
    largeur, hauteur = mon_service.getService("quad_graphisme").get_largeur_hauteur()
    sx, sy = mon_service.getService("quad_graphisme").get_sx_sy()

    boutons = love.graphics.newImage("assets/img/bouton.png")
    top_bouton = love.graphics.newQuad(0,0,32,32, boutons:getDimensions())
    bottom_bouton = love.graphics.newQuad(32,0,32,32, boutons:getDimensions())
    right_bouton = love.graphics.newQuad(64,0,32,32, boutons:getDimensions())
    left_bouton = love.graphics.newQuad(96,0,32,32, boutons:getDimensions())
end

function keyboard_score.update(dt)
    if love.keyboard.isDown("up", "down", "right", "left") then
        if keypressed == false then
           
            if love.keyboard.isDown("up") then
                initials[currentLetter]  = initials[currentLetter] - 1
                keypressedUP = true
                if initials[currentLetter] < 1 then
                    initials[currentLetter] = #choix_lettres
                end
            end
            if love.keyboard.isDown("down") then
                initials[currentLetter]  = initials[currentLetter] + 1
                keypressedDown = true
                if initials[currentLetter] > #choix_lettres then
                    initials[currentLetter] = 1
                end
            end
            if love.keyboard.isDown("right") then
                keypressedRight = true
                if currentLetter < 3 then
                    currentLetter = currentLetter + 1
                else 
                    name = (choix_lettres[initials[1]]..choix_lettres[initials[2]]..choix_lettres[initials[3]])
                end
            end
            --ou faire un caractère de retour dans la liste
            if love.keyboard.isDown("left") then
                keypressedLeft = true
                if currentLetter > 1 then
                    currentLetter = currentLetter - 1
                end
            end
            keypressed = true
        end
    else
        keypressed = false
        keypressedUP = false
        keypressedDown = false
        keypressedRight = false
        keypressedLeft = false
    end
end

function keyboard_score.draw()
    love.graphics.setColor(255,255,255)
    local x = 40*(largeur/100)
    local y = 20*(hauteur/100)
    for n=1, #initials do
        --affichage des lettres
        love.graphics.print(choix_lettres[initials[n]], x+5*(largeur/100), y, 0, sx*0.5, sy*0.5)
        if n == currentLetter then
            --affichage des boutons

            --bouton up : blue
            love.graphics.setColor(11,139,250)
            if keypressedUP then
                love.graphics.setColor(255,0,0)
            end
            love.graphics.draw(boutons, top_bouton, x+5*(largeur/100), y-10*(hauteur/100), 0, sx*0.5, sy*0.5)

            --bouton down : yellow
            love.graphics.setColor(234,250,11)
            if keypressedDown then
                love.graphics.setColor(255,0,0)
            end
            love.graphics.draw(boutons, bottom_bouton, x+5*(largeur/100), y+12.5*(hauteur/100), 0, sx*0.5, sy*0.5)

            --bouton validation : green
            love.graphics.setColor(27,148,23)
            if keypressedRight then
                love.graphics.setColor(255,0,0)
            end
            love.graphics.draw(boutons, right_bouton, 75*(largeur/100), y-2*(hauteur/100), 0, sx*0.5, sy*0.5)

            --bouton retour : red
            love.graphics.setColor(148,23,23)
            if keypressedLeft then
                love.graphics.setColor(255,0,0)
            end
            love.graphics.draw(boutons, left_bouton, 35*(largeur/100), y-2*(hauteur/100), 0, sx*0.5, sy*0.5)

            --couleurs réinitialisées
            love.graphics.setColor(255,255,255)

        end
        x = x + 10*(largeur/100)
    end  
end

mon_service.addService("keyboard_score", keyboard_score)
return keyboard_score