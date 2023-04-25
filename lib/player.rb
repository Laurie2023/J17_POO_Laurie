def dialogue(string) # impression du texte
  string.chars.each do |letter|
    print letter
    sleep (0.02)
  end 
  puts ""
end 

#--------------- Class qui modélise toutes les caracteristiques d'un joueur classic ---------------#
class Player
  attr_accessor :name , :life_points
  
  def initialize(name_to_save)
    @name = name_to_save
    @life_points = 10
  end 

  def show_state #Afficher l'état d'un joueur
    return "#{self.name} a #{self.life_points} points de vie."
  end 

  def gets_damage(damages) #Subir une attache
    self.life_points -= damages.to_i
    return self.life_points.to_i < 1 ? dialogue("Le joueur #{self.name} a été tué !") : nil
  end 

  def attacks(attacked_player) #Attaquer 
    dialogue("Le joueur #{self.name} attaque le joueur #{attacked_player.name}.")
    alea_damages = compute_damage
    dialogue("Il/elle lui inflige #{alea_damages} points de dommages.")
    puts attacked_player.gets_damage(alea_damages)
  end 

  def compute_damage #Calcul le dommage causé
    return rand(1..6) #nb aléatoire entre 1 et 6
  end 

end 

#------------------ Class qui modélise les caracteristiques d'un joueur spécial ------------------#
class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize (name_to_save)
    @weapon_level = 1 
    super(name_to_save) 
    @life_points = 100 
  end 

  def show_state
    return dialogue("#{self.name} a #{self.life_points} points de vie et une arme de niveau #{self.weapon_level}.")
  end 

  def compute_damage
    rand(1..6) * self.weapon_level
  end

  def search_weapon #new method - Rechercher une arme
    alea_number = rand(1..6)
    dialogue("Tu as trouvé une arme de niveau #{alea_number}.")

    if alea_number > self.weapon_level 
      dialogue("Youhou ! Elle est meilleure que ton arme actuelle : tu la prends.")
      self.weapon_level = alea_number
    else 
      dialogue("M@*#$... elle n'est pas mieux que ton arme actuelle...")
    end 
    return self.weapon_level
  end 

  def search_health_pack #new method - Rechercher des points de vie
    alea_number = rand(1..6)

    if alea_number == 1
      dialogue("Tu n'as rien trouvé... ")
    else 
      if alea_number == 6 
        dialogue("Bravo, tu as trouvé un pack de +80 points de vie !")
        puts "Attention : tu ne peux pas avoir plus de 100 points de vie)"
        if self.life_points < 21
          self.life_points += 80
        else 
          self.life_points = 100
        end 
      else 
        dialogue("Bravo, tu as trouvé un pack de +50 points de vie ! (dans la limite de 100 points)")
        if self.life_points < 51
          self.life_points += 50
        else 
          self.life_points = 100
        end 
      end 
    end 
  end 

end