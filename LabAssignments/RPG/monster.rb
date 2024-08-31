class Monster
  attr_accessor :health_points, :name, :sound

  # Initialize the Monster with HP between 10-50, the number of monsters will be handled here (?)
  def initialize(health_points, name='Goblin', sound='Raauughaughhhs')
    # Going to start with all monsters having the same HP for simplicity. I think to make them all random, I'll change healthpoints from being an argument
    # to being initialized within the Class
    @health_points = health_points
    @name = name
    @sound = sound
  end

  # Monsters can now attack, handles multiple monsters, 1 or many monsters can attack the hero during their turn
  def monster_attack
    rng = Random.new 
    rng.rand(5..10)
  end
end