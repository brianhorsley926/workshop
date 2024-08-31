class Hero 
  attr_accessor :name, :special_attack_limit, :health_points

  def initialize(name, special_attack_limit=3, health_points=500)
    @name = name
    @special_attack_limit = special_attack_limit
    @health_points = health_points
  end

  # Return the damage that the Hero's basic attack does 10-20
  def basic_attack
    rng = Random.new 
    rng.rand(10..20)
  end

  # Return the damage that the Hero's special attack does 100-200
  def special_attack 
    rng = Random.new
    if @special_attack_limit > 0
      @special_attack_limit -= 1
      return rng.rand(100..200)
    else
      return 0
    end
  end

  def show_attack(attack_num, damage)
    if attack_num == '1'
      puts "#{@name} used a basic attack, it dealt #{damage} damage to each monster"
    else
      puts "#{@name} used his special attack, it dealt #{damage} damage to each monster"
    end
  end
end