require 'json'
require_relative 'player_cards'

player_collected_cards = []

# Iterate init_cards to print out each init card
def print_init_cards(arr)
  arr.each do |hash|
    hash.each_value do |values|
      puts values.map { |c| "Card #{c[:num]}: #{c[:head]} head" }.join(' | ')
    end
  end
end

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

# Find the min in the arr
def find_min(arr)
  arr.min_by {|x| x[:diff]} 
end

# If the init row has 5 cards already, the 6th card will become the first card of that row and those 5 cards will be added into player_collected cards
def max_5_on_each_init(arr, arr2, item)
  if arr.length < 5
    arr << {num: item[:num], head: item[:head]}
  else
    arr << {num: item[:num], head: item[:head]}
    *remaining, last = arr
    arr2 << remaining
    arr.shift(5)
  end
end

# Delete card that has been choosen to place outside
def delete_card(arr, num)
  arr.delete_if { |h| h[:num] == num }
end

# Tell player how many heads they currently have
def display_total_heads(arr)
  num = arr.flatten.inject(0) { |sum, h| sum + h[:head]}
  if num > 1
    puts "You currently have #{num} heads in total."
    else
    puts "You currently have #{num} head in total."
  end
end

round = 10
until round == 0
  # Display init cards
  init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)

  # Display player's cards
  player_cards_j = JSON.load_file('player_cards.json', symbolize_names: true)

  print_init_cards(init_cards_j)

  puts "You have - "

  print_player_cards(player_cards_j)
  display_total_heads(player_collected_cards)

  # Prompt player select a card to place outside
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
          max_5_on_each_init(init_cards_j[temp[:index]].values[0], player_collected_cards, card)
        end
        delete_card(player_cards_j, card_dispose)
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
