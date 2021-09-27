require 'json'
require_relative 'player_cards'



# ---- Methods for players ---- #
def print_init_cards(arr)
    arr.each do |hash|
        hash.each_value do |values|
            puts values.map { |c| "Card #{c[:num]}: #{c[:head]} head" }.join(' | ')
            puts " "
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

# init_cards / player_cards / card
def max_5_on_each_init(arr2, arr3, item)
    if arr2.length < 5
        arr2 << {num: item[:num], head: item[:head]}
    else
        arr2 << {num: item[:num], head: item[:head]}
        *remaining, last = arr2
        arr3 << remaining
        arr2.shift(5)
    end
end

# Find the min in the arr
def find_min(arr)
    arr.min_by {|x| x[:diff]} 
end

# player_cards /  num of card_dispose
def delete_card(arr, num)
    arr.delete_if { |h| h[:num] == num }
end

# Tell player how many heads they currently have
# player_collected_cards
def display_total_heads(arr, name)
    num = arr.flatten.inject(0) { |sum, h| sum + h[:head]}
    if num > 1
      puts "#{name} has #{num} heads in total."
      else
      puts "#{name} has #{num} head in total."
    end
end

# player_collected_cards / npc_collected_cards
def who_wins_each_round(arr, arr2, winning)
    player_total = arr.flatten.inject(0) { |sum, h| sum + h[:head]}
    npc_total = arr2.flatten.inject(0) { |sum, h| sum + h[:head]}

    if player_total > npc_total
        puts 'NPC wins!'
        winning << "npc"
    elsif player_total < npc_total
        puts 'Player wins!'
        winning << "player"
    else 
        puts 'It"s a tie!'
    end
end

# Who wins?!
# winning
def who_is_final_winner(arr)
    puts "Winner is #{arr.tally.max_by{|k,v| v}[0].capitalize}! Congratulations!"      
end


# player_cards or npc_cards / init_cards / player or npc cards collected / card
def choose_init_row(arr2, arr3, init_row, card)
    arr2[init_row-1].values[0] << {num: card[:num], head: card[:head]}
    *first, last = arr2[init_row-1].values[0]
    arr3 << first
    arr2[init_row-1].values[0].shift(arr2[init_row-1].values[0].length - 1)
end

# Iterate init_row to get the total heads of each row
def npc_choose_init_row(arr3)
    total_heads_on_each_row = []
    # iterate init_row 
    arr3.each_with_index do |row, index|
        # Get the total heads of each init row and add it total_heads_on_each_init_row with total num of heads and index of that init_row
        total_heads_on_each_row << {total: row.values[0].sum { |h| h[:head] }, index: index}
    end
    # Find the min total and get the index of that
    return total_heads_on_each_row.min_by{ |k| k[:total]}[:index]
end

# player_cards / init_cards / player_cards_collected / num of card_dispose
def add_card_to_init(arr, arr2, arr3, num, name)  
    arr.each do |card|
        temp_arr = []
        # Iterate player cards to compare num to [:num]
        if num == card[:num]
            count = 0
            # Iterate init cards to check if num > any init cards'num, index = index of each init row in init_cards
            arr2.each_with_index do |row, index|
                if num >= row.values[0].last[:num]
                    count += 1
                end      
            end
            case count
            when 0
                if name != 'NPC'
                    puts "#{name} Which row you want to put instead? "
                    init_row = gets.chomp.to_i
                    choose_init_row(arr2, arr3, init_row, card)
                else
                    init_row = npc_choose_init_row(arr2) + 1
                    choose_init_row(arr2, arr3, init_row, card)
                end
            when 1..5
                arr2.each_with_index do |row, index|
                    # Add the num and difference into an array 
                    if num > row.values[0].last[:num]
                        temp_arr.push(num: row.values[0].last[:num], head: row.values[0].last[:head], diff: num - row.values[0].last[:num], index: index)
                    end
                end
                min = find_min(temp_arr)
                # init_row that we want to add the new card / player_collected_cards / card
                max_5_on_each_init(arr2[min[:index]].values[0], arr3, card)
            end
            # player_cards / num of dispose card
            delete_card(arr, num)
        end
    end
end

# Update json file will the updated player_cards_j
def save(jsonname, var)
    File.open(jsonname, 'w') do |f|
        f.puts(var.to_json)
    end
end

def display_disposed_card(name, num)
    puts "#{name} has put card #{num}"
end

# ---- Methods just for NPC ----#
# Check if there is any nil value on npc_will_choose arr
# npc_will_choose / index
def check_if_nil(arr, num)
    if arr[num] == nil
        if arr[num-1] == nil
            arr[num-2][:npc_card]
        else
            arr[num-1][:npc_card]
        end
    else
        arr[num][:npc_card]
    end
end

# Get a card base on possibility
# 5% - netagive_arr
# 60% - 1-2- arr
# 35% - over-20-arr
def get_num(arr)
    case rand(100) + 1
    when 1..5
        arr[0][:npc_card]
    when 6..65
        check_if_nil(arr,1)
    when 66..100
        check_if_nil(arr,2)
    end
end


    
# Push a random from each row to npc_will_choose_card arr
def add_random_card(arr, arr2)
    arr << arr2.sample
end

def npc_card_dispose(npc_cards, init_cards)
    temp_npc = []

    npc_cards.each do |card|
        init_cards.each_with_index do |row, index|
            # Calculate difference between each npc_card to each init_card
            temp_npc.push(init_card: row.values[0].last[:num], npc_card: card[:num], diff: card[:num] - row.values[0].last[:num])
        end
    end

    negative_arr = []
    arr_1_20 = []
    arr_over_20 = []
    npc_will_choose_card = []

    temp_npc.each do |card|
        if card[:diff] < 0
            negative_arr << card
        elsif card[:diff] > 0 && card[:diff] <= 20
            arr_1_20 << card
        else
            arr_over_20 << card
        end
    end

    add_random_card(npc_will_choose_card, negative_arr)
    add_random_card(npc_will_choose_card, arr_1_20)
    add_random_card(npc_will_choose_card, arr_over_20)

    return get_num(npc_will_choose_card)
end


total_round = 0
winning = []
until total_round == 3
    card = Card.new
    init_cards = card.generate_init_cards
    player_cards = card.sorted_cards(card.generate_player_cards)
    npc_cards = card.sorted_cards(card.generate_npc_cards)

    File.open('init_cards.json', 'w') do |f|
    f.puts(init_cards.to_json)
    end

    File.open('player_cards.json', 'w') do |f|
    f.puts(player_cards.to_json)
    end

    File.open('npc_cards.json', 'w') do |f|
    f.puts(npc_cards.to_json)
    end

    # Load init cards file
    init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)
    # Load player's cards file
    player_cards_j = JSON.load_file('player_cards.json', symbolize_names: true)
    # Load npc's cards file
    npc_cards_j = JSON.load_file('npc_cards.json', symbolize_names: true)

    player_collected_cards = []
    npc_collected_cards = []
    
    round = 10
    until round == 0        

    print_init_cards(init_cards_j)
    puts "--------------------------------------------------------------------------"
    puts "You have - "
    puts " "
    print_player_cards(player_cards_j)
    puts " "
    puts "--------------------------------------------------------------------------"
    display_total_heads(player_collected_cards, 'Player')
    puts " "
    display_total_heads(npc_collected_cards, 'NPC')
    puts "--------------------------------------------------------------------------"

    # Prompt player select a card to place outside
    puts "Player: Card you want to place outside? "
    card_dispose = gets.chomp.to_i

        # Npc select a card to place outside
        card_dispose_npc = npc_card_dispose(npc_cards_j, init_cards_j)

        puts " "
        puts " *  *  *  *  * "
        puts " "
        display_disposed_card('Player', card_dispose)
        puts " "
        display_disposed_card('NPC', card_dispose_npc)
        puts " "
        puts " *  *  *  *  * "
        puts " "
        
        if card_dispose < card_dispose_npc
            add_card_to_init(player_cards_j, init_cards_j, player_collected_cards, card_dispose, 'Player')  
            add_card_to_init(npc_cards_j, init_cards_j, npc_collected_cards, card_dispose_npc, 'NPC')  
        else
            add_card_to_init(npc_cards_j, init_cards_j, npc_collected_cards, card_dispose_npc, 'NPC') 
            add_card_to_init(player_cards_j, init_cards_j, player_collected_cards, card_dispose, 'Player')  
        end

        # # Update json file will the updated player_cards_j
        # save('player_cards.json', player_cards_j)
        # # Update json file will the updated init_cards_j
        # save('init_cards.json', init_cards_j)
        # # Update json file will the updated init_cards_j
        # save('npc_cards.json', npc_cards_j)
        
        round -= 1
    end

    print_init_cards(init_cards_j)
    display_total_heads(player_collected_cards, 'Player')
    display_total_heads(npc_collected_cards, 'NPC')

    total_round += 1
    puts " "
    puts "This round is finished!!!!"
    puts " "
    who_wins_each_round(player_collected_cards, npc_collected_cards, winning)
    puts "____________________________________________ "
    puts "____________________________________________ "
    puts " "
    puts " "
    
end
puts "Game is finished"
who_is_final_winner(winning)





