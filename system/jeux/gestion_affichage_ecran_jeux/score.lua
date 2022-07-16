local score = {}

mon_service = require("system/service_locator")

local tir_essaie_max = mon_service.getService("keyboard").getTir_essaie_max()
local hauteur = love.graphics.getHeight()
local largeur = love.graphics.getWidth()

--[[
██████╗  █████╗ ██████╗ ██████╗ ███████╗    ███████╗ ██████╗ ██████╗ ██████╗ ███████╗
██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝    ██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
██████╔╝███████║██████╔╝██████╔╝█████╗      ███████╗██║     ██║   ██║██████╔╝█████╗  
██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝      ╚════██║██║     ██║   ██║██╔══██╗██╔══╝  
██████╔╝██║  ██║██║  ██║██║  ██║███████╗    ███████║╚██████╗╚██████╔╝██║  ██║███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
]]
-- rectangle_score = {}
-- rectangle_score.x = 0
-- rectangle_score.y = 0
-- rectangle_score.largeur = 0
-- rectangle_score.hauteur = 0
-- function score.get_barre_score()
--     return rectangle_score
-- end

--[[
██████╗  █████╗ ██████╗ ██████╗ ███████╗    ███████╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝    ██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗
██████╔╝███████║██████╔╝██████╔╝█████╗      ███████╗██║     ██║   ██║██████╔╝█████╗  ██║  ██║
██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝      ╚════██║██║     ██║   ██║██╔══██╗██╔══╝  ██║  ██║
██████╔╝██║  ██║██║  ██║██║  ██║███████╗    ███████║╚██████╗╚██████╔╝██║  ██║███████╗██████╔╝
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ 
]]
-- rectangle_scored = {}
-- rectangle_scored.x = 0
-- rectangle_scored.y = 0
-- rectangle_scored.largeur = 0
-- rectangle_scored.hauteur = 0
-- function score.get_barre_scored()
--     return rectangle_scored
-- end

--[[
███████╗ ██████╗ ██████╗ ██████╗ ███████╗    ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗██╗  ██╗███████╗
██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝    ████╗ ████║██╔══██╗████╗  ██║██╔════╝██║  ██║██╔════╝
███████╗██║     ██║   ██║██████╔╝█████╗      ██╔████╔██║███████║██╔██╗ ██║██║     ███████║█████╗  
╚════██║██║     ██║   ██║██╔══██╗██╔══╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║██║     ██╔══██║██╔══╝  
███████║╚██████╗╚██████╔╝██║  ██║███████╗    ██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╗██║  ██║███████╗
╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝
]]
score_manche = {}
score_manche.x = 0
score_manche.y = 0
score_manche.value = 0
function score.get_score_manche()
    return score_manche
end
function score.get_score_manche_value()
    return score_manche.value
end

local sx, sy = 0, 0

function score.restart()
    score_manche.value = 0
end
--ajout point manche
function score.addScore(pPoint, pTir_essaie, pReussi)
    local lst_inventary = mon_service.getService("inventaire").getLst_inventary()
    if pTir_essaie <= tir_essaie_max then
        if pReussi then
            score_manche.value = score_manche.value + pPoint
            -- if pPoint == 10 then
            --     rectangle_scored.hauteur =  rectangle_scored.hauteur - (hauteur/3)
            -- end
        end
        if pTir_essaie > 0 then
                lst_inventary[pTir_essaie].used = true
        end
    end
end

--[[
██╗      ██████╗  █████╗ ██████╗ 
██║     ██╔═══██╗██╔══██╗██╔══██╗
██║     ██║   ██║███████║██║  ██║
██║     ██║   ██║██╔══██║██║  ██║
███████╗╚██████╔╝██║  ██║██████╔╝
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ 
]]
function score.load(pSx, pSy)
    --récupération sx et sy => scalable
    sx, sy = pSx, pSy
    

    --  --definition rectangle score
    -- rectangle_score.largeur = 30
    -- rectangle_score.x = largeur - rectangle_score.largeur
    -- rectangle_score.hauteur = hauteur
    -- print("passe")
    --  --definition rectangle scored
    -- rectangle_scored.x = rectangle_score.x
    -- rectangle_scored.y = hauteur
    -- rectangle_scored.hauteur = 0
    -- rectangle_scored.largeur = rectangle_score.largeur
     --recuperation listes :
        score_manche = score.get_score_manche()
        score_manche.x = 80* (largeur/100)
end

--[[
██████╗ ██████╗  █████╗ ██╗    ██╗
██╔══██╗██╔══██╗██╔══██╗██║    ██║
██║  ██║██████╔╝███████║██║ █╗ ██║
██║  ██║██╔══██╗██╔══██║██║███╗██║
██████╔╝██║  ██║██║  ██║╚███╔███╔╝
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ 
]]
function score.draw()
     --affichage du score
    if love.getVersion() == 0 then
        love.graphics.setColor(37,28,28)
    else
        love.graphics.setColor(0.14,0.11,0.11)
    end   

    love.graphics.print(score_manche.value, score_manche.x, score_manche.y, 0, sx, sy)
    -- love.graphics.rectangle("line", rectangle_score.x, rectangle_score.y, rectangle_score.largeur, rectangle_score.hauteur)
    -- love.graphics.rectangle("fill", rectangle_scored.x, rectangle_scored.y, rectangle_scored.largeur, rectangle_scored.hauteur)
    if love.getVersion() == 0 then
        love.graphics.setColor(255,255,255)
    else
        love.graphics.setColor(1,1,1)
    end
end

mon_service.addService("score", score)

return score