local boule = {}

local mon_service = require("system/service_locator")

local hauteur, largeur = 0, 0 


function boule.getWidth()
    largeur = love.graphics.getWidth()
end
function boule.getHeight()
    hauteur = love.graphics.getHeight()
end
local lst_ball = {}


function boule.restart()
    for n=#lst_ball, 1, -1 do 
        table.remove(lst_ball, n)
    end
end

function boule.create_boule(pNum, pX, pY, pRandomed, pSx, pSy, pScored, pMissed)
    local   myBall = {}
            myBall.num = pNum
            myBall.img = love.graphics.newImage("assets/img/boule_shadow1.png")
            myBall.x = pX
            myBall.y = pY
            myBall.scaleX = pSx
            myBall.scaleY = pSy
            myBall.scored = pScored
            myBall.randomed = pRandomed
            myBall.missed = pMissed
            table.insert(lst_ball, myBall)
end

function boule.get_lst_ball()
    return lst_ball
end

function boule.get_number_lst_ball()
    return #lst_ball
end

function boule.roll_boule(pNumero_boule, pVy, dt)
    lst_ball[pNumero_boule].y = lst_ball[pNumero_boule].y - pVy+(1*dt)
end


function boule.draw()
    for n=1, #lst_ball do
        
        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end
        --selectionnée
        if lst_ball[n].randomed == true and lst_ball[n].scored == false and  lst_ball[n].missed == false then
            if love.getVersion() == 0 then
                love.graphics.setColor(0,255,255)
            else
                love.graphics.setColor(0,1,1)
            end
            --tirée
        elseif lst_ball[n].randomed == true and lst_ball[n].scored == true and  lst_ball[n].missed == false then
            if love.getVersion() == 0 then
                love.graphics.setColor(127.5,127.5,127.5)
            else
                love.graphics.setColor(0.5,0.5,0.5)
            end
            --ratée
        elseif lst_ball[n].randomed == true and lst_ball[n].scored == false and  lst_ball[n].missed == true then
            if love.getVersion() == 0 then
                love.graphics.setColor(255,0,0)
            else
                love.graphics.setColor(1,0,0)
            end
        end
        
        love.graphics.draw(lst_ball[n].img, lst_ball[n].x, lst_ball[n].y, 0, lst_ball[n].scaleX, lst_ball[n].scaleY)
        if love.getVersion() == 0 then
            love.graphics.setColor(255,255,255)
        else
            love.graphics.setColor(1,1,1)
        end
    end
end
mon_service.addService("boule", boule)

return boule