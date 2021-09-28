require 'json'
require_relative 'Users'

class Players < Users
    # Iterate player_cards_j to print out each player cards
    def print_player_cards(arr)
        arr.each do |card|
            if card[:head] == 1
            puts "Card #{card[:num]}: #{card[:head]} kettle head."
            else
            puts "Card #{card[:num]}: #{card[:head]} kettle heads."
            end
        end
    end

end