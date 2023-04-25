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

system("clear")
#---------------------------------- JEU VERSION 2.0 ----------------------------------#
#---------------------------- INITIALISATION D'UNE PARTIE ----------------------------#
puts "____________________________________________________________________________"
puts "|                Bienvenue sur 'ILS VEULENT TOUS MA POO' !                 |"
puts "|              Le but du jeu est d'être le dernier survivant !             |"
puts "|__________________________________________________________________________|"
puts ""

dialogue("Quel est ton prénom combattant.e ?")
print "> "
user_name = gets.chomp.to_s

dialogue("\nA combien d'ennemies veux-tu te confronter ? (max 130)")
print "> "
user_number = gets.chomp.to_i

stop = 0
my_game = Game.new(user_name,user_number)

system("clear")

#-------------------------------------- COMBAT ---------------------------------------#
while my_game.is_still_ongoing? == true
  my_game.menu 

  user_answer = gets.chomp.to_s.downcase.gsub(" ","")
  user_answer == "q" ? stop = 1 : my_game.menu_choice(user_answer)

  (my_game.is_still_ongoing? == true && stop == 0) ? nil : break #on vérifie qu'au moins 1 bot est vivant
  sleep(1)
  my_game.enemies_attack

  (my_game.is_still_ongoing? == true && stop == 0) ? nil : break #on vérifie que l'humain est toujours vivant

  #Pause avant le prochain tour afin que l'utilisateur ait le temps de lire
  sleep(1)
  dialogue("Appuis sur entrer pour effectuer une nouvelle action")
  gets
  system ("clear")
end 

#------------------------------------ FIN DU JEU -------------------------------------#
stop == 1 ? dialogue("Arrêt immédiat de la partie en cours.") : nil
my_game.end(stop)

#binding.pry

