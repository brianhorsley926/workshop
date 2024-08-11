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
$player_turn = true
$dealer_name = 'Dealer'

# Intialize the deck of cards
$list_of_cards = []

# Gets player's name
$player_name = gets.chomp

################################################################################

puts "Thanks #{$player_name}.\n"

# Uses the Array#shuffle method to jumble up the cards
def shuffle()
    $list_of_cards.shuffle!
end

# Deals the dealer and player a hand each and removes the cards from the Deck using the deal_a_card() method
def deal_a_hand()
    puts "\nTurn #{$turn_number}:\n"
    deal_number_of_cards = 2
    dealer = []
    player = []
    for card in 1..deal_number_of_cards
        # Deals the initial hands for the player and Dealer
        player << deal_a_card()
        # binding.pry # DEBUGGING
        puts "#{$player_name} has the #{player[card - 1][0]} of #{player[card - 1][1]}"

        dealer << deal_a_card()
        puts "#{$dealer_name} has the #{dealer[card-1][0]} of #{dealer[card - 1][1]}"
    end

    puts "\nIt's your turn #{$player_name}.\n"

    $turn_number += 1
    return dealer, player # Why didn't this work without return?
end

# Uses the Array#pop method to deal a card and remove it from the Deck
def deal_a_card()
    $list_of_cards.pop()
end

# Prints the remaining contents of the Deck
def remaining_cards()
    puts $list_of_cards
end 

# Returns back the int value of a card
# I am missing the logic for handling the ace having two values (1, 11)
def check_score(hand)
    score = 0
    number_of_aces = 0

    hand.each do |card|
        card_value = card[0]

        case card_value
        when 'jack'
            score += 10
        when 'queen'
            score += 10
        when 'king'
            score += 10
        when 'ace'
            score += 11
            number_of_aces += 1
        else
            score += card_value.to_i # This was original making numbered cards string types
        end
    end

    while score > 21 && number_of_aces > 0
        score -= 10 # Adjust one ace from 11 to 1
        number_of_aces -= 1
    end

    return score # Without the return this didn't work??
end

# Check if the player/dealer score is a bust
def bust?(score)
    score > 21
end

# Populates the Deck of cards
def reset_deck(cards)
    cards.each do |suit, value|
        value.each do |v|
            $list_of_cards << [v,suit]
        end
    end
end

# # Assigns 1 or 11 to an ace depending on the current score
# def check_aces(score, hand)
#     # This count method counts the number of elements in the cards array that are an 'ace'
#     aces_in_hand = hand.count{|card| card[0] == 'ace'}
#     while aces_in_hand > 0 && score > 21
#         # Make the ace value 1 
#         score -= 10
#         # Now that the value is adjusted take away that ace from consideration
#         aces_in_hand -= 1
#     end
#     score 
# end

# Game logic
def game_of_blackjack()
    # Shuffle the deck
    puts "The deck has been shuffled.\n"
    shuffle()   

    # Initialize the player's scores
    player_score = 0
    dealer_score = 0

    # While both players have valid hands
    while !bust?(player_score) && !bust?(dealer_score)
        # If the deck runs out of cards quit the game
        if $list_of_cards.length == 0 
            break
        end

        # Dealer hand is Array[0] and Player hand is Array[1]
        initial_hands = deal_a_hand()

        # binding.pry # DEBUGGING
        # Initial hand returns multi-dimensional array - check for any aces that cause a bust for dealer/player
        player_score = check_score(initial_hands[1])
        # player_score = check_aces(player_score, initial_hands[1])

        dealer_score = check_score(initial_hands[0])
        # dealer_score = check_aces(dealer_score, initial_hands[0])
        
        # Check if anyone hit blackjack from the initial hand, prioritizing the player
        if player_score == 21
            puts "#{$player_name} hits blackjack! You win!"
            return
        elsif dealer_score == 21
            puts "#{$dealer_name} hits blackjack! House wins."
            return
        elsif player_score == 21 && dealer_score == 21
            puts "It's a tie!"
            return
        end

        # Player's turn
        puts "It's #{$player_name}'s turn."
        while true
            puts 'Will you hit or stand?'
            player_choice = gets.chomp
            
            # Check if the user ends their turn
            if player_choice == 'stand'
                puts "Dealer needs to beat #{player_score}"
                $player_turn = false
                break
            # If player hits, continue until they bust or stand
            elsif player_choice == 'hit'
                next_card = deal_a_card()
                puts "#{next_card[0]} of #{next_card[1]}\n"

                initial_hands[1] << next_card
                player_score = check_score(initial_hands[1])
                # player_score = check_aces(player_score, initial_hands[1])
                if bust?(player_score)
                    puts "You bust with a score of #{player_score}. House wins!"
                    return
                end
                puts "#{$player_name} now has #{player_score}"
            else
                puts "Please type 'hit' or 'stand'."
            end
        end

        # Dealer's turn
        puts "It's the #{$dealer_name}'s turn."

        # Dealer hits unless score is 17>
        while dealer_score < 17
            next_card = deal_a_card()
            puts "#{next_card[0]} of #{next_card[1]}\n"

            initial_hands[0] << next_card
            dealer_score = check_score(initial_hands[0])

            if bust?(dealer_score)
                puts "#{$dealer_name} busts with a score of #{dealer_score}. #{$player_name} wins!"
                return
            end
            puts "#{$dealer_name} now has #{dealer_score}"
        end

        # Determine the winner
        if dealer_score > player_score
            puts 'House wins.'
        elsif player_score > dealer_score
            puts "#{$player_name} wins!"
        else
            puts "It's a tie!"
        end
        return
    end
end


# Creates a hash for suits and card values
cards = {
    'hearts' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'],
    'spades' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'],
    'clubs' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'],
    'diamonds' => [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
}

reset_deck(cards)

# Start the game
game_of_blackjack()

# Let the player play until they type 'N'
puts "Play again? (Y/N)"
play_again = gets.chomp 

while play_again == 'Y'
    reset_deck(cards)
    game_of_blackjack()
    puts "Play again? (Y/N)"
    play_again = gets.chomp 
end
