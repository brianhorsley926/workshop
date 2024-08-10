=begin
1. Create a ruby file to create the basics of blackjack
2. On start, it asks for your name. It should store this and output it at the end of the game.
3. The game should inform you each turn in next what is happening
- Shuffle the deck
- deal the player 1 card
- deal the dealer 1 card
- deal the player a 2nd card
- deal the dealer a 2nd card

For simplicity sake, it's ok that all cards are facing up so we can see the value and the suit

4. Create a method where anytime I type the method in console, it will show the deck's remaining contents and order
5. Create a turn mechanism to know who's turn it is. After dealing hands, it is always the players turn
=end

require 'pry'

# Get the player's name
puts "What's your name?"

############################### GLOBAL VARIABLES ###############################

# Set the initial turn and names of each player
$turn_number = 1
$dealer_name = 'Dealer'

# Creates an array of all 52 cards w/ the format ['value of suit', ...]
$list_of_cards = []

# Gets player's name
$player_name = gets.chomp

################################################################################

puts "Thanks #{$player_name}."

# Creates a hash to map suits to card values
cards = {
    'hearts' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'],
    'spades' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'],
    'clubs' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'],
     'diamonds' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
}
# Creates the Deck of cards as an Array
cards.each do |suit, value|
    value.each do |v|
        $list_of_cards << "#{v} of #{suit}" 
    end
end

# Uses the Array#shuffle method to jumble up the cards
def shuffle()
    $list_of_cards.shuffle!
end

# Deals the dealer and player a hand each and removes the cards from the Deck using the deal_a_card() method
def deal_a_hand()
    puts "Turn #{$turn_number}:\n"
    deal_number_of_cards = 2
    dealer = []
    player = []
    for card in 1..deal_number_of_cards
        player << deal_a_card()
        puts "#{$player_name} has the #{player[card - 1]}"

        dealer << deal_a_card()
        puts "#{$dealer_name} has the #{dealer[card-1]}"
    end

    puts "It's your turn #{$player_name}."

    $turn_number += 1
    # Returning might be unnecessary, find out next time
    return dealer, player
end

# Uses the Array#pop method to deal a card and remove it from the Deck
def deal_a_card()
    $list_of_cards.pop()
end

# Prints the remaining contents of the Deck
def remaining_cards()
    puts $list_of_cards
end 

binding.pry