require 'json'
require_relative 'prepare_deck'

# Get deck.json's data
parsed = JSON.load_file('deck.json', symbolize_names: true)

used_cards = []
init_cards = {}
player_cards = {}
npc_cards = {}

# Generate 10 random cards for player
count = 0
while count < 24

  num = rand(1..104)
  # Access each key-value pair in deck.json
  parsed.each_pair do |k, v|
    # Check if the random number match the key & used_cards doesn't include the random number
    next unless num.to_s == k.to_s && !used_cards.include?(k)
    # If not, add the card into used_cards
    used_cards.push(k)
    # Initial set up: 4 cards on the table
    if count < 4
      init_cards[k] = v
      count += 1
    # 10 cards to each player
    elsif count < 14
      player_cards[k] = v
      count += 1
    else
      npc_cards[k] = v
      count += 1
    end
  end
end

# Sort hashes by key in ascending order
player_cards = (player_cards.sort_by { |k, v| k}).to_h
init_cards = (init_cards.sort_by { |k, v| k}).to_h


# Transfer init_cards to JSON file 
File.open('init_cards.json', 'w') do |f|
    f.puts(init_cards.to_json)
end
 
# Transfer players_cards to JSON file 
File.open('player_cards.json', 'w') do |f|
    f.puts(player_cards.to_json)
end

# Transfer npc_cards to JSON file 
File.open('npc_cards.json', 'w') do |f|
    f.puts(npc_cards.to_json)
end