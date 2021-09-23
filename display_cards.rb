require 'json'
require_relative 'player_cards'

player_cards_j = JSON.load_file('player_cards.json', symbolize_names: true)
init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)

# Print out initial cards
init_cards_j.each_pair do |k, v|
    if v == 1
        puts " "
        puts "Card #{k}: #{v} kettle head."
        puts " " 
    else
        puts " "
        puts "Card #{k}: #{v} kettle heads."
        puts " "
    end
end

# Print out player_cards
puts "You have: "
player_cards_j.each_pair do |k, v|
    if v == 1
        puts "Card #{k}: {v} kettle heads."
    else
        puts "Card #{k}: {v} kettle heads."
    end
end
