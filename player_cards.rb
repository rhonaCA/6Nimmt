require 'json'
require_relative 'prepare_deck'

# Get deck.json's data
parsed = JSON.load_file('deck.json', symbolize_names: true)
player_cards = {}

# Generate 10 random cards for player
count = 0
while count < 10
    num = rand(1..104)
    # Access each key-value pair in deck.json
    parsed.each_pair do |k, v|
        # Check if the random number match the key
        if num.to_s == k.to_s
            # If yes, add the card to player_cards
            player_cards[k] = v
        end
    end
    count += 1
end

# Print out player_cards
player_cards.each_pair do |k, v|
    if v== 1
        puts "Card #{k} has #{v} kettle head."
    else
        puts "Card #{k} has #{v} kettle heads."
    end
end
