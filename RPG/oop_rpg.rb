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
- Add turn based attacks 
- Add logic to handle multiple monsters
    - Randomize the subset of monsters that attack during their turn. I.e. 3 monsters - 1, 2, or all 3 might attack on the Monster turn?
- Add a way to generate different types of monsters? File I/O with list of monster names/sounds/hp ranges
- Give the hero HP and add logic to handle the upset (hero dies)
    - File I/O, give the user the ability to choose their Hero Type/Special Attack combo
        - Mage/Fireball - Warrior/Execute - Paladin/Holy Strike - Assassin/Backstab etc...

===================


=end

require 'pry'

class Game
    attr_accessor :turn_number

    # The game will take a Hero, Monster 
    def initialize(hero, monster)
        @hero = hero
        @monster = monster
        @turn_number = 1
        puts "#{@hero.name} the Hero, defeat the monster(s) to protect the castle.\nEnter 1 to perform a basic attack or 2 to perform your special attack. But remember, you can only use it 3 times."
    end

    def hero_defeats_monsters
        sleep 1
        puts "\n#{@monster.sound}"
        puts "The #{@monster.name} (#{@monster.health_points} HP) is here, defeat them quick (1=basic attack & 2=special_atttack)"

        # Game continues until the monster is defeated
        while @monster.health_points > 0
            attack_input = gets.chomp 
            # Only accept 1 or 2 as the user input
            while attack_input != '1' && attack_input != '2'
                attack_input = gets.chomp 
            end

            sleep 1

            if attack_input == '1'
                damage = @hero.basic_attack
                puts "#{@hero.name} used a basic attack, it dealt #{damage} damage"
                @monster.health_points -= damage
                puts "The #{@monster.name} now has #{@monster.health_points} HP left."
                sleep 1
            else
                damage = @hero.special_attack
                if damage > 0
                    puts "#{@hero.name} used his special attack, it dealt #{damage} damage"
                    @monster.health_points -= damage
                    puts "The #{@monster.name} now has #{@monster.health_points} HP left."
                    sleep 1
                else
                    puts "You've run out of mana! Basic attacks will have to do..."
                    sleep 1
                end
            end
        end

        puts "You've deafeated the #{@monster.name}, #{@hero.name}. END...?"
    end
end

class Hero 
    attr_accessor :name, :special_attack_limit

    def initialize(name, special_attack_limit=3)
        @name = name
        @special_attack_limit = special_attack_limit
    end

    # Return the damage that the Hero's basic attack does 10-20
    def basic_attack
        rng = Random.new 
        return rng.rand(10..20)
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
end

class Monster
    attr_accessor :health_points, :name, :sound, :number_of_monsters

    # Initialize the Monster with HP between 10-50, the number of monsters will be handled here (?)
    def initialize(health_points=Random.new.rand(10..50), name='Goblin', sound='Raauughaughhhs', number_of_monsters=1)
        @health_points = health_points
        @name = name
        @sound = sound
    end
end

puts 'Hero, what is your name?'
hero_name = gets.chomp 
hero = Hero.new(hero_name)
monster = Monster.new
game = Game.new(hero, monster)
game.hero_defeats_monsters