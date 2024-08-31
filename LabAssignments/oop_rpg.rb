=begin 
Lab Assignment: Using classes and OOP programming
- Create a Game class, a Hero class, and Monster class
- Instantiate an instance of the game. In console, ask the player to do basic_attack via inputting 1, special attack inputting 2
- Special attack does 100-200 randomized damage, a basic attack does 10 -20 randomized damage
- You can only use special attack 3 times in a game
- Monsters can generate with random HP ranging from 10-50 hp


=====VERSION 1=====
Define what 'the game' is
How do I use the Hero and Monster classes? Initial thought is to see how scope between separate classes works
    Maybe Inheritance? - Can pass classes as arguments! Any issue with this?    

Game - starting with just one monster
Hero will always win against monster as they have no HP and monsters don't attack yet
- Has a hero defeating 1 monster
    - w/ some amount of HP? - No hero HP at first
- Hero attacks by user_input and the Hero can only use their special_attack 3 times
- The Game is over when either the monsters are all defeated or the Hero is killed
- Something like, while Hero.health_points != 0 && MonsterS.summed_health_points != 0 ...
- Inheritance is likely

Hero
- Some HP
- Basic and special attacks
- 3 limit on special attack
- Hero type?? Paladin/Warrior/Mage/etc.

Monster
- Some HP
- Basic attack
===================


=====VERSION 2=====
Updates to make
- Add turn based attacks - DONE
- Add logic to handle multiple monsters - Kinda? Need to rework Monster logic
    - Randomize the subset of monsters that attack during their turn. I.e. 3 monsters - 1, 2, or all 3 might attack on the Monster turn?
- Add a way to generate different types of monsters? File I/O with list of monster names/sounds/hp ranges
- Give the hero HP and add logic to handle the upset (hero dies)
    - File I/O, give the user the ability to choose their Hero Type/Special Attack combo
        - Mage/Fireball - Warrior/Execute - Paladin/Holy Strike - Assassin/Backstab etc...

===================

method to accept user input and show all health

Should separate the classes into their own files and `require` them in this file

Scope this out more - 

=end

require 'pry'

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

# Bad decision to account for number of monsters in the Monster class. Should have generate_monster method in Game class 
# and use array/hash to hold the HP and name/sound etc.
# Hero special attack could apply damage to each monster (SpecATKdmg / # Monster) and basic attack hits lowest hp target always
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

game = Game.new
game.hero_vs_monsters
