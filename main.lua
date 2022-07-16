-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

--appelle system
local mon_service = require("system/service_locator")
require("system/gestion_font")
require("system/gestion_ecran")

--appelle module
require("module_jeux/menu")
--test
local nb_frame = 0
local font = nil


function love.load()
  love.window.setTitle("PETANQUE")
  love.window.setMode(1024, 600)
  --love.window.setFullscreen(true, "desktop")

  local largeur = love.graphics.getWidth()
  font = mon_service.getService("gestion_font").small_font_load(largeur)
  mon_service.getService("menu").load()

  --require("module_jeux/high_score")
  --mon_service.getService("high_score").load()
  --mon_service.getService("gestion_ecran").setMODE("HIGH_SCORE")
end

function love.update(dt)
  nb_frame = love.timer.getFPS()
  if mon_service.getService("gestion_ecran").getMODE() == "MENU" then
    mon_service.getService("menu").update(dt)
  end
  if mon_service.getService("gestion_ecran").getMODE() == "SCORE_JOUEURS" then
    mon_service.getService("score_joueurs").update(dt)
  end
  if mon_service.getService("gestion_ecran").getMODE() == "JEUX" then
    mon_service.getService("jeux").update(dt)
  end
  if mon_service.getService("gestion_ecran").getMODE() == "HIGH_SCORE" then
    mon_service.getService("high_score").update(dt)
  end
end

function love.draw()
  love.graphics.setFont(font)
  if mon_service.getService("gestion_ecran").getMODE() == "MENU" then
    mon_service.getService("menu").draw()
  end
  if mon_service.getService("gestion_ecran").getMODE() == "SCORE_JOUEURS" then
    mon_service.getService("score_joueurs").draw()
  end
  if mon_service.getService("gestion_ecran").getMODE() == "JEUX" then
    mon_service.getService("jeux").draw()
  end
  if mon_service.getService("gestion_ecran").getMODE() == "HIGH_SCORE" then
    mon_service.getService("high_score").draw()
  end
  --test
  love.graphics.setColor(18,16,16)

  if love.getVersion() == 0 then
    love.graphics.setColor(18,16,16)
  else
    love.graphics.setColor(0.07,0.06,0.06)
  end

  love.graphics.print("nb_frame : "..tostring(nb_frame), 100, 10)

  if love.getVersion() == 0 then
    love.graphics.setColor(255,255,255)
  else
    love.graphics.setColor(1,1,1)
  end
end

function love.keypressed(key)
  if key == "escape" then 
    love.event.quit()
  end
end