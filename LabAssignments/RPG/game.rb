require_relative 'hero'
require_relative 'monster'

class Game
  attr_accessor :turn_number

  # The game will take a Hero, Monster 
  def initialize()
    @hero = Hero.new('Arthur') # Instantiate class in the Game. class are blueprints we are 'creating' this and teaching the code what it is - can call like other data types
    @number_of_monsters = []
    @turn_number = 1
    puts "#{@hero.name} the Hero, defeat the monster(s) to protect the castle.\nEnter 1 to perform a basic attack or 2 to perform your special attack. But remember, you can only use it 3 times."
  end

  # Version 2 gameplay
  def hero_vs_monsters
    generate_monsters(horde_size)
    monster_health = monster_health_pool
    # Hero initiates the fight everytime
    sleep 1
    monsters_appear(monster_health)
    # Game continues until the monster is defeated
    while monster_health > 0 && @hero.health_points > 0
      puts "Turn # #{@turn_number}"
      sleep 1
      if @turn_number % 2 > 0 # Odd - Hero's turn // Even - Monster's turn
        attack_input = gets.chomp 
        # Only accept 1 or 2 as the user input
        while attack_input != '1' && attack_input != '2'
          attack_input = gets.chomp 
        end
        monster_health = heros_turn(attack_input)
      else
        monsters_turn
      end
    end
  end

  def update_turn
    @turn_number += 1
    sleep 1
  end

  def heros_turn(attack_input)
    if attack_input == '1'
      damage = @hero.basic_attack / @number_of_monsters.length
      @hero.show_attack(attack_input, damage)
      monster_health = monster_health_pool(damage)
      if monster_health <= 0
        puts "You have defeated them #{@hero.name}. You win!"
        return monster_health
      else
        show_monster_stats(monster_health)
        update_turn
      end
    else
      damage = @hero.special_attack / @number_of_monsters.length
      if damage > 0
        @hero.show_attack(attack_input, damage)
        monster_health = monster_health_pool(damage)
        if monster_health <= 0
          puts "You have defeated them #{@hero.name}. You win!"
          return monster_health
        else
          show_monster_stats(monster_health)
          update_turn
        end
      else
        puts "You've run out of mana! Basic attacks will have to do..."
        sleep 1
      end
    end
    monster_health
  end

  def monsters_turn
    # Monster's turn
    monster_damage = 0
    for m in (0...@number_of_monsters.length)
      monster_damage += @number_of_monsters[m].monster_attack
    end
    puts "You were dealt #{monster_damage} damage!"
    @hero.health_points -= monster_damage
    if @hero.health_points <= 0
      puts "You have been defeated!"
      return
    else
      puts "You now have #{@hero.health_points} HP left."
      update_turn
    end
  end

  def horde_size
    rng = Random.new 
    rng.rand(3..10)
  end

  def generate_monsters(num_monster)
    rng = Random.new
    for m in 1..num_monster do 
      @number_of_monsters << Monster.new(rng.rand(25..50))
    end
  end

  def monster_health_pool(damage=0)
    @number_of_monsters.each do |monster|
      monster.health_points -= damage
    end
  
    @number_of_monsters.reject! { |monster| monster.health_points <= 0 }
    total_health = @number_of_monsters.sum(&:health_points)
    total_health.nil? ? 0 : total_health
  end

  def show_monster_stats(monster_health)
    puts "The #{@number_of_monsters.length} #{@number_of_monsters[0].name}(s) with #{monster_health} HP left are preparing to attack."
  end

  def monsters_appear(monster_health)
    puts "#{@number_of_monsters.length} #{@number_of_monsters[0].name}(s) (#{monster_health / @number_of_monsters.length} HP each) showed up, defeat them quickly (1=basic attack & 2=special_atttack)"
  end
end