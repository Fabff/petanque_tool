local inventaire = {}

local mon_service = require("system/service_locator")

local lst_inventary = {}

function inventaire.restart()
    for n=#lst_inventary, 1, -1 do 
        table.remove(lst_inventary, n)
    end
end

function inventaire.create_inventaire(pNum, pX, pY, pSx, pSy, pUsed)
    local   myInventary = {}
            myInventary.img = love.graphics.newImage("assets/img/boule.png")
            myInventary.num = pNum
            myInventary.x = pX
            myInventary.y = pY
            myInventary.scaleX = pSx*0.03
            myInventary.scaleY = pSy*0.03
            myInventary.used = pUsed
            table.insert(lst_inventary, myInventary)
end

function inventaire.getLst_inventary()
    return lst_inventary
end

function inventaire.print_inventary()
    return #lst_inventary
end
--affichage inventaire
function inventaire.draw()
    for n=1, #lst_inventary do 
            --utilisé
        if lst_inventary[n].used == true then
            if love.getVersion() == 0 then
                love.graphics.setColor(17.85,318.75,10.2)
            else
                love.graphics.setColor(0.07,0.8,0.04)
            end
        else
            if love.getVersion() == 0 then
                love.graphics.setColor(255,255,255)
            else
                love.graphics.setColor(1,1,1)
            end
        end
        love.graphics.draw(lst_inventary[n].img, lst_inventary[n].x, lst_inventary[n].y, 0, lst_inventary[n].scaleX, lst_inventary[n].scaleY)
        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end
    end
end

mon_service.addService("inventaire", inventaire)
return inventaire