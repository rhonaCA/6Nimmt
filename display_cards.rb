require 'json'
require_relative 'player_cards'

round = 5
until round == 0
  # Display init cards
  init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)

  # Iterate init_cards_j to print out each init card
  init_cards_j.each do |card|
    if card[:head] == 1
      print "Card #{card[:num]}: #{card[:head]} kettle head. "
    else
      print "Card #{card[:num]}: #{card[:head]} kettle heads. "
    end
  end

  # Display player's cards
  player_cards_j = JSON.load_file('player_cards.json', symbolize_names: true)

  puts "You have - "
  # Iterate player_cards_j to print out each player cards
  player_cards_j.each do |card|
    if card[:head] == 1
      puts "Card #{card[:num]}: #{card[:head]} kettle head."
    else
      puts "Card #{card[:num]}: #{card[:head]} kettle heads."
    end
  end
  # Player select a card to place outside
  puts "Card you want to place outside? "
  card_dispose = gets.chomp.to_i

  # Find the key-value pair that match player_input
  # Then add that into init pile
  player_cards_j.each_with_index do |card, index|
    init_cards_j << player_cards_j[index] if card[:num] == card_dispose
  end

  # And delete from player_cards_j pile
  player_cards_j.delete_if do |card|
    card[:num] == card_dispose
  end

  # Update json file will the updated player_cards_j
  File.open('player_cards.json', 'w') do |f|
    f.puts(player_cards_j.to_json)
  end
  # Update json file will the updated init_cards_j
  File.open('init_cards.json', 'w') do |f|
    f.puts(init_cards_j.to_json)
  end
end
