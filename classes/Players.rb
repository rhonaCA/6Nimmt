require 'json'
require_relative 'Users'

class Players < Users
    # Iterate player_cards_j to print out each player cards
    # def print_player_cards(arr)
    #     arr.each do |card|
    #         if card[:head] == 1
    #         puts "Card #{card[:num]}: #{card[:head]} kettle head."
    #         else
    #         puts "Card #{card[:num]}: #{card[:head]} kettle heads."
    #         end
    #     end
    # end
    
    def print_player_cards(arr)
        hash_for_prompt = {}
        arr.map do |c|
            hash_for_prompt.store("Card #{c[:num]} - #{c[:head]} 🐮", "#{c[:num]}") 
        end
        hash_for_prompt.store("View Rules", 0) 
        hash_for_prompt.store("Exit", -1) 
        return hash_for_prompt
    end
end