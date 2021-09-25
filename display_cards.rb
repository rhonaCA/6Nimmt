require 'json'
require_relative 'player_cards'

player_collected_cards = []

round = 10
until round == 0
  # Display init cards
  init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)

  ## Iterate init_cards_j to print out each init card
  init_cards_j.each do |hash|
    hash.each_value do |values|
      puts values.map { |c| "Card #{c[:num]}: #{c[:head]} head" }.join(' | ')
    end
  end

  # Find the min in the arr
  def find_min(arr)
    arr.min_by {|x| x[:diff]} 
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
      arr = []
      if card[:num] == card_dispose
          init_cards_j.each_index do |index|
              # x represent each init row without :init
              x = init_cards_j[index].values[0]
              # p x[x.length-1][:num] # value of the last key-value of each init
              # Compare num to the last key-value of each init
              if card_dispose > x[x.length-1][:num]
                  # Add the num and difference into an array 
                  arr.push(num: x[x.length-1][:num], head: x[x.length-1][:head], diff: card_dispose - x[x.length-1][:num], index: index)
              end
          end
          temp = find_min(arr)
          if card[:num] == card_dispose
            # Keep each init row can only have max 5 cards
            if init_cards_j[temp[:index]].values[0].length < 5
              init_cards_j[temp[:index]].values[0] << {num: card[:num], head: card[:head]}
            else
              # If the init row has 5 cards already, the 6th card will become the first card of that row and those 5 cards will be added into player_collected cards
              init_cards_j[temp[:index]].values[0] << {num: card[:num], head: card[:head]}
              *remaining, last = init_cards_j[temp[:index]].values[0]
              player_collected_cards << remaining
              init_cards_j[temp[:index]].values[0].shift(5)
            end
            p player_collected_cards
        end
          player_cards_j.delete_if { |h| h[:num] == card_dispose }
          round -= 1
      end
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
