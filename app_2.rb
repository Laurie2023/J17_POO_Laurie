require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


def dialogue(string) # impression du texte
  string.chars.each do |letter|
    print letter
    sleep (0.04)
  end 
  puts ""
end 

#---------------------------------- JEU VERSION 2.0 ----------------------------------#
#---------------------------- INITIALISATION D'UNE PARTIE ----------------------------#

#Création des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]
stop = 0

human_player1 = HumanPlayer.new("Ted")

system ("clear")

while (player1.life_points > 0 || player2.life_points > 0) && human_player1.life_points > 0

  #------------------------------------- ACCUEIL ---------------------------------------#
  
  puts "____________________________________________________________________________"
  puts "|                Bienvenue sur 'ILS VEULENT TOUS MA POO' !                 |"
  puts "|              Le but du jeu est d'être le dernier survivant !             |"
  puts "|__________________________________________________________________________|"
  puts ""

  #-------------------------------------- COMBAT ---------------------------------------#
  
  dialogue("\n#{human_player1.show_state}")

  #menu 
  dialogue("\n______________Nouveau tour : Quelle action veux-tu effectuer ?______________\n")
  puts "q - Quitter la partie en cours"
  puts "a - Chercher une meilleure arme"
  puts "s - Chercher à se soigner"

  puts "\nAttaquer un ennemi :"
  puts player1.life_points > 0 ? "0 - #{player1.show_state}" : "0 - #{player1.name} a été tué.e"
  puts player2.life_points > 0 ? "1 - #{player2.show_state}" : "1 - #{player2.name} a été tué.e"
  print "> "
  answer = gets.chomp.to_s.downcase.gsub(" ","")
  sleep(0.1)

  #actions 
  if answer == "q"
    dialogue("Arrêt immédiat de la partie en cours.")
    stop = 1
    break
  else 
    dialogue("\n_________________________________Ton action_________________________________\n")
    if answer == "s"
      human_player1.search_health_pack
    else 
      if answer == "0" && player1.life_points > 0
        human_player1.attacks(player1)
      else 
        if answer == "1" && player2.life_points > 0
          human_player1.attacks(player2)
        else 
          if answer == "a"
            human_player1.search_weapon
          else 
            dialogue("Tu viens de louper une action car tu ne sais pas taper sur un clavier !")
            puts "Loser !"
          end
        end 
      end
    end
  end

  (player1.life_points > 0 || player2.life_points > 0) ? nil : break

  sleep(0.1)
  dialogue("\n__________________Attention !! Tes ennemies t'attaquent !!__________________\n")
  enemies.each do |player|
    player.life_points > 0 ? player.attacks(human_player1) : nil
  end 

  sleep(0.1)
  dialogue("Appuis sur entrer pour effectuer une nouvelle action")
  gets
  system ("clear")
end 

#------------------------------------ FIN DU JEU -------------------------------------#

sleep(0.1)
if human_player1.life_points > 0 && stop == 0
  dialogue("BRAVO ! TU AS GAGNE !")
else 
  dialogue("Loser ! Tu as perdu !")
end 