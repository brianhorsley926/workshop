=begin 
Lab Assignment: Using classes and OOP programming
- Create a Game class, a Hero class, and Monster class
- Instantiate an instance of the game. In console, ask the player to do basic_attack via inputting 1, special attack inputting 2
- Special attack does 100-200 randomized damage, a basic attack does 10 -20 randomized damage
- You can only use special attack 3 times in a game
- Monsters can generate with random HP ranging from 10-50 hp



Define what 'the game' is
How do I use the Hero and Monster classes? Initial thought is to see how scope between separate classes works
    Maybe Inheritance?


Game - starting with just one monster
has attacking mechanism while hero and monster has 
- Has a hero defending a castle against monsters 
    - w/ some amount of HP?
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
=end

require 'pry'

class Game
    attr_accessor :turn_number, :number_of_monsters

    def initialize(hero, monster, turn_number=1, number_of_monsters=1)
        @hero = hero
        @monster = monster
        @turn_number = turn_number
        @number_of_monsters = number_of_monsters
        puts "#{@hero.name} the Hero, defeat the monster(s) to protect the castle.\nEnter 1 to perform a basic attack or 2 to perform your special attack. But remember, you can only use it 3 times."
    end
end

class Hero 
    attr_accessor :name, :special_attack_limit
    
    def initialize(name, special_attack_limit=3)
        @name = name
        @special_attack_limit = special_attack_limit
        puts "I'm the Hero, #{@name}"
    end

    def basic_attack
        rng = Random.new 
        return rng.rand(10..20)
    end

    def special_attack 
        rng = Random.new
        if @special_attack_limit > 0
            @special_attack_limit -= 1
            return rng.rand(100..200)
        else
            return 0
        end
    end
end

class Monster
    attr_accessor :health_points, :name

    def initialize(health_points=Random.new.rand(10..50), name='Goblin')
        @health_points = health_points
        @name = name
        puts "Raauughaughhhs"
    end
end

puts 'Hero, what is your name?'
hero_name = gets.chomp 

hero = Hero.new(hero_name)
monster = Monster.new

game = Game.new(hero, monster)
binding.pry