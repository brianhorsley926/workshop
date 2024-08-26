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

    # Version 1 Gameplay - Hero always wins and only one monster accounted for. Might break with some of the version 2 changes
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

    # Version 2 gameplay
    def hero_vs_monsters
        # Hero initiates the fight everytime
        sleep 1
        puts "\n#{@monster.sound}"
        puts "#{@monster.number_of_monsters} #{@monster.name}(s) (#{@monster.health_points / @monster.number_of_monsters} HP each) showed up, defeat them quickly (1=basic attack & 2=special_atttack)"

        # Game continues until the monster is defeated
        while @monster.health_points > 0 && @hero.health_points > 0
            puts "Turn # #{@turn_number}"
            sleep 1
            if @turn_number % 2 > 0 # Odd - Hero's turn // Even - Monster's turn
                attack_input = gets.chomp 
                # Only accept 1 or 2 as the user input
                while attack_input != '1' && attack_input != '2'
                    attack_input = gets.chomp 
                end

                if attack_input == '1'
                    damage = @hero.basic_attack
                    puts "#{@hero.name} used a basic attack, it dealt #{damage} damage"
                    @monster.health_points -= damage
                    if @monster.health_points <= 0
                        puts "You have defeated them #{@hero.name}. You win!"
                        return
                    else
                        puts "The #{@monster.number_of_monsters} #{@monster.name}(s) with #{@monster.health_points} HP left are preparing to attack."
                        @turn_number += 1
                        sleep 1
                    end
                else
                    damage = @hero.special_attack
                    if damage > 0
                        puts "#{@hero.name} used his special attack, it dealt #{damage} damage"
                        @monster.health_points -= damage
                        if @monster.health_points <= 0
                            puts "You have defeated them #{@hero.name}. You win!"
                            return
                        else
                            puts "The #{@monster.number_of_monsters} #{@monster.name}(s) with #{@monster.health_points} HP left are preparing to attack."
                            @turn_number += 1
                            sleep 1
                        end
                    else
                        # Basically a warning, won't skip the Hero's turn if this happens
                        puts "You've run out of mana! Basic attacks will have to do..."
                        sleep 1
                    end
                end
            else
                # Monster's turn
                monster_damage = @monster.monster_attacks
                @hero.health_points -= monster_damage
                if @hero.health_points <= 0
                    puts "You have been defeated!"
                    return
                else
                    puts "You now have #{@hero.health_points} HP left."
                    @turn_number += 1
                    sleep 1
                end
            end
        end
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

# Bad decision to account for number of monsters in the Monster class. Should have generate_monster method in Game class 
# and use array/hash to hold the HP and name/sound etc.
# Hero special attack could apply damage to each monster (SpecATKdmg / # Monster) and basic attack hits lowest hp target always
class Monster
    attr_accessor :health_points, :name, :sound, :number_of_monsters
    # Initialize the Monster with HP between 10-50, the number of monsters will be handled here (?)
    def initialize(health_points, name='Goblin', sound='Raauughaughhhs', number_of_monsters)
        # Going to start with all monsters having the same HP for simplicity. I think to make them all random, I'll change healthpoints from being an argument
        # to being initialized within the Class
        @health_points = health_points * number_of_monsters
        @name = name
        @sound = sound
        @number_of_monsters = number_of_monsters
    end

    # Monsters can now attack, handles multiple monsters, 1 or many monsters can attack the hero during their turn
    def monster_attacks
        rng = Random.new 
        number_monster_attack = rng.rand(1..@number_of_monsters)
        damage = 0
        for monster in 1..number_monster_attack
            damage += rng.rand(5..10)
        end
        puts "#{number_monster_attack} #{@name} attacks! #{damage} damage was dealt to the Hero."
        return damage
    end
end

puts 'Hero, what is your name?'
hero_name = gets.chomp 
hero = Hero.new(hero_name)

rng = Random.new
num_monsters = rng.rand(1..10)
monster_health = rng.rand(50..100)
monster = Monster.new(monster_health, num_monsters)

game = Game.new(hero, monster)
game.hero_vs_monsters