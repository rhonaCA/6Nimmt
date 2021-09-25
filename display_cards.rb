require 'json'
require_relative 'player_cards'

round = 5
until round == 0
  # Display init cards
  init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)

  ### NEEDS TO AMEND vvvvv

  ## Iterate init_cards_j to print out each init card
  # Iterate to get each init row
  init_cards_j.each do |hash|
    hash.each_value do |values|
      puts values.map { |c| "Card #{c[:num]}: #{c[:head]} head" }.join(' / ')
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

  ### NEEDS TO ADD LOGIC ON WHIC ROW SHOULD THE CARD GOES  vvvvvvv

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
          if card[:num]== card_dispose
              init_cards_j[temp[:index]].values[0] << {num: card[:num], head: card[:head]}
          end
          player_cards_j.delete_if { |h| h[:num] == card_dispose }
          round -= 1
      end
  end

   ### NEEDS TO ADD LOGIC ON WHIC ROW SHOULD THE CARD GOES  ^^^^^^


  # Update json file will the updated player_cards_j
  File.open('player_cards.json', 'w') do |f|
    f.puts(player_cards_j.to_json)
  end
  # Update json file will the updated init_cards_j
  File.open('init_cards.json', 'w') do |f|
    f.puts(init_cards_j.to_json)
  end
end
