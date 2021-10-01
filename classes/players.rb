require 'json'
require_relative 'users'

class Players < Users    
    def print_player_cards(arr)
        hash_for_prompt = {}
        arr.map do |c|
            hash_for_prompt.store("Card #{c[:num]} - #{c[:head]} 🐮", "#{c[:num]}") 
        end
        hash_for_prompt.store("Check out the rules", 0) 
        hash_for_prompt.store("Exit game", -1) 
        return hash_for_prompt
    end
end
