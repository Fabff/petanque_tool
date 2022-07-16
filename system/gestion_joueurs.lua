local gestion_joueurs = {}
local mon_service = require("system/service_locator")

local lst_joueurs = {}
--local lst_final_score = {}


function gestion_joueurs.create_joueurs(pNumeroJoueur)
    local my_player = {}
        my_player.name = pNumeroJoueur
        my_player.score = 0
        my_player.nb_manche = 3
    table.insert(lst_joueurs, my_player)
end

function gestion_joueurs.trie_score()
    function trie_score(a, b)
        return a.score > b.score
    end
    table.sort(lst_joueurs, trie_score)
end

--vider la liste des joueurs
function gestion_joueurs.delete_lst_joueurs()
    for n=#lst_joueurs, 1, -1 do
        table.remove(lst_joueurs, n)
    end
end

--récupération lst_joueurs
function gestion_joueurs.get_lst_joueurs()
    return lst_joueurs
end

--récupère le nombre de joueur
function gestion_joueurs.get_nombre_joueurs()
    return #lst_joueurs
end

--incrémente le score total du joueur
function gestion_joueurs.set_Score_Joueur(pNumeroJoueur, pNbPoints)
    lst_joueurs[pNumeroJoueur].score = lst_joueurs[pNumeroJoueur].score + pNbPoints
end

--récupere les scores des joueurs (en fonction du paramètre)
function gestion_joueurs.get_Score_Joueur(pNumeroJoueur)
    --return 56
    return lst_joueurs[pNumeroJoueur].score 
end
function gestion_joueurs.get_Name_Joueur(pNumeroJoueur)
    --return 1
    return lst_joueurs[pNumeroJoueur].name 
end
--debug
function gestion_joueurs.print_lst_joueurs()
    for n=1, #lst_joueurs do 
        print("name : "..lst_joueurs[n].name)
        print("score : "..lst_joueurs[n].score)
        print("nb manche: "..#lst_joueurs)
    end
end

mon_service.addService("gestion_joueurs", gestion_joueurs)
return gestion_joueurs