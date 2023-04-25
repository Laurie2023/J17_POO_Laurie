require_relative 'player'

class Game
  attr_accessor :human_player, :enemies_names, :players_left, :enemies_in_sight

  def initialize(name_to_save, number_of_enemies) 
    @human_player = HumanPlayer.new(name_to_save)
    @players_left = number_of_enemies
    @enemies_in_sight = []
    @enemies_names = ["Chuckle_McSnort", "Giggles_McGee", "Smiley_McWink", "Slappy_Jack", "Fanny_Fartsalot", "Captain_Cackle", "Wacky_Willy", "Silly_Sally", "Loopy_Louie", "Happy_Harry", "Goofy_Gary", "Zany_Zack", "Grinny_Ginny", "Cheesy_Chuck", "Jolly_Josh", "Jazzy_Jeff", "Chipper_Charlie", "Tickles_Tony", "Crazy_Carl", "Daffy_Dave", "Bubbles_Bur", "Prankster_Pete", "Chuckles_Chuck", "Laughs_Larry", "Nutty_Ned", "Mischievous_Mike", "Wiggles_Wally", "Snickers_Steve", "Zippy_Zack", "Snorty_Sam", "Rambunctious_Rob", "Howler_Harry", "Clumsy_Clyde", "Wobbly_Will", "Jolly_Jake", "Peculiar_Paul", "Sappy_Sue", "Chuckles_Charlie", "Tittering_Tim", "Wacky_Wayne", "Spazzy_Steve", "Wiggly_Wendy", "Spunky_Sam", "Giggly_George", "Bouncy_Betty", "Chuckles_Chuck", "Chucklehead_Chris", "Hilarious_Henry", "Hopping_Harry", "Snickering_Steve", "Frolicsome_Fred", "Quirky_Quincy", "Zany_Zoe", "Boisterous_Bob", "Jolly_Joe", "Prankster_Phi", "Chuckles_Charlie", "Wacky_Walter", "Jocular_Jack", "Mischievous_Matt", "Chuckles_Chuck", "Bozo", "Cheesy", "Fudgicle", "Giggles", "Humdinger", "Jiggy", "Kooky", "Loopy", "Munchkin", "Nutty", "Quirk", "Silly", "Tiddlywinks", "Wacky", "Zany", "Bumblebee", "Clumsy", "Ditzy", "Flaky", "Goofball", "Happy", "Impish", "Jazzy", "Kooky", "Lazy", "Mischievou", "Numbskull", "Peculia", "Quirky", "Sappy", "Tickle", "Wimp", "Yoyo", "Boffo", "Cockeyed", "Daffy", "Flapper", "Goofy", "Harlequin", "Irksome", "Jittery", "Klutzy", "Loony", "Mopey", "Noodle”, “Oddball", "Peculiar", "Quirky", "Rascal", "Slaphapp", "Twerp", "Uppity", "Wacky", "Zany", "Blunder", "Clodhopper", "Doofus", "Flibbertigibbet", "Goon", "Hokey", "Impetuous", "Jaunty", "Klutz", "Lunatic", "Muddle", "Numbskull", "Oaf", "Prankster", "Quizzical", "Rattlebrain"]
  end 

  def kill_player(player, players_left) #supprimer les bots tués de l'array ennemies
    self.enemies_in_sight.delete(player)
    self.players_left -= 1
  end 

  def is_still_ongoing? #check si le jeu doit continuer ou pas
    return self.human_player.life_points > 0 && self.players_left > 0 ? true : false #modif
  end 

  def show_players #status du jeu
    self.human_player.show_state
    dialogue("Il reste encore #{self.players_left} bots en vie, dont #{self.enemies_in_sight.length} en vue.")
  end 

  def menu #affichage du menu
    #------------------------------------- ACCUEIL ---------------------------------------# 
  
    puts "____________________________________________________________________________"
    puts "|                Bienvenue sur 'ILS VEULENT TOUS MA POO' !                 |"
    puts "|              Le but du jeu est d'être le dernier survivant !             |"
    puts "|__________________________________________________________________________|"
    puts ""

    #--------------------------------------- MENU ----------------------------------------#
    self.show_players
    puts ""
    self..new_players_in_sight

    dialogue("\n______________Nouveau tour : Quelle action veux-tu effectuer ?______________\n")
    puts "q - Quitter la partie en cours"
    puts "a - Chercher une meilleure arme"
    puts "s - Chercher à se soigner"

    if enemies_in_sight.length > 0 
      puts "\nAttaquer un ennemi :"
      enemies_in_sight.each_with_index do |player, index|
        puts player.life_points > 0 ? "#{index} - #{player.show_state}" : nil
      end 
    else 
      puts "\nAucun ennemi en vue pour le moment..\n"
    end 
    print "\n> "
  end 

  def menu_choice(answer) #gestion choix dans le menu
    if answer == "q"
      dialogue("\nArrêt immédiat de la partie en cours.") #à reprogrammer à la fin
    else 
      dialogue("\n_________________________________Ton action_________________________________\n")
      if answer == "s"
        self.human_player.search_health_pack
      else 
        if answer == "a" 
          self.human_player.search_weapon
        else 
          if answer.length == 1 && enemies_in_sight.length > 0 && answer.to_i.between?(0,self.enemies_in_sight.length)
            self.human_player.attacks(self.enemies_in_sight[answer.to_i])
            self.enemies_in_sight[answer.to_i].life_points < 1 ? kill_player(self.enemies_in_sight[answer.to_i], self.players_left) : nil
          else 
            dialogue("Tu viens de louper une action car tu ne sais pas taper sur un clavier !")
            puts "Loser !"
          end
        end 
      end 
    end 
  end 
    
  def enemies_attack #gestion attaques des ennemies
    dialogue("\n__________________Attention !! Tes ennemies t'attaquent !!__________________\n")
    sleep(0.5)
    if enemies_in_sight.length > 0 
      self.enemies_in_sight.each do |player|
        player.attacks(self.human_player) 
        sleep(0.5)
      end 
    else 
      puts "Ah non, j'ai confondu avec mon ombre - Aucun ennemi en vue !\n" 
    end 
  end 

  def end(stop) #affichage fin du jeu
    if self.human_player.life_points > 0 && stop == 0 #à voir si on garde la condition de non-sortie
      dialogue("\nBRAVO ! TU AS GAGNE !")
    else 
      dialogue("\nLoser ! Tu as perdu !")
    end 
  end 

  def new_players_in_sight #passage des bots vivants non-visibles à visibles
    if self.enemies_in_sight.length == self.players_left
      puts "\nTous les bots sont en vue !\n"
    else 
      alea = rand(1..6)
      if alea.between?(2,4)
        alea_name = rand(0..enemies_names.length)
        enemies_in_sight << Player.new(enemies_names[alea_name])
        enemies_names.delete_at(alea_name)
        puts "\nNouvel bot en vue ! Il y a maintenant #{enemies_in_sight.length} visible(s) sur les #{players_left} vivant(s).\n"
      else 
        if alea.between?(5,6)
          if players_left > 1
            alea_name = rand(0..self.enemies_names.length)
            self.enemies_in_sight << Player.new(self.enemies_names[alea_name])
            self.enemies_names.delete_at(alea_name)
            alea_name = rand(0..enemies_names.length)
            self.enemies_in_sight << Player.new(self.enemies_names[alea_name])
            self.enemies_names.delete_at(alea_name)
            puts "\n2 nouveaux bots en vue ! Il y a maintenant #{self.enemies_in_sight.length} visible(s) sur les #{players_left} vivant(s).\n"
          else 
            alea_name = rand(0..self.enemies_names.length)
            self.enemies_in_sight << Player.new(self.enemies_names[alea_name])
            self.enemies_names.delete_at(alea_name)
            puts "\nNouvel bot en vue ! Il y a maintenant #{self.enemies_in_sight.length} visible(s) sur les #{self.players_left} vivant(s).\n"
          end 
        else 
          if alea == 1
            puts "\nPas de nouveau bot en vue ! Il y a toujours #{self.enemies_in_sight.length} visible(s) sur les #{self.players_left} vivant(s).\n"
          end 
        end 
      end
    end 
  end 
end 