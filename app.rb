require 'bundler'
Bundler.require 

require_relative 'lib/game.rb'
require_relative 'lib/player.rb'

#---------------------------------- JEU VERSION 1.0 ----------------------------------#
#---------------------------- INITIALISATION D'UNE PARTIE ----------------------------#

#Création des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")

#-------------------------------------- COMBAT ---------------------------------------#

while player1.life_points > 0 && player2.life_points > 0
  #Présentation des joueurs
  puts "\nVoici l'état de chaque joueur :"
  puts player1.show_state
  puts player2.show_state

  #Combat
  puts "\nPassons à la phase d'attaque :"
  player1.attacks(player2)
  if player2.life_points < 1 
    break
  end 
  player2.attacks(player1)
end 

#binding.pry