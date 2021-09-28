require 'json'
require_relative 'Deck'


class Users
    # attr_accessor :player_collected_cards

    def initialize
        @parsed = JSON.load_file('deck.json')
        @used_cards = []
        @init_cards = [
            {
              init1: []
            }, 
            {
              init2: []
            }, 
            {
              init3: []
            }, 
            {
              init4: []
            }
          ]        
        @player_cards = []
        @npc_cards = []
    end

    def create_json(json_file_name, data_name)
        File.open(json_file_name, 'w') do |f|
            f.puts(data_name.to_json)
        end
    end

    def generate_init_cards
        count = 0
        while count < 4
            num = rand(1..104)        
            # Access each key-value pair in deck.json
            @parsed.each_pair do |k, v|
                if num.to_s == k 
                    if !@used_cards.include?(k.to_i)
                        @used_cards << (k.to_i)
                        # Add the first card to init1
                        if count == 0
                            @init_cards[0][:init1] << {num: k.to_i, head: v}
                            count += 1
                            break
                        # Add the second card to init2
                        elsif count == 1
                            @init_cards[1][:init2] << {num: k.to_i, head: v}
                            count += 1
                            break
                        # Add the third card to init3
                        elsif count == 2
                            @init_cards[2][:init3] << {num: k.to_i, head: v}
                            count += 1
                            break
                        # Add the forth card to init4
                        elsif count == 3
                            @init_cards[3][:init4] << {num: k.to_i, head: v}
                            count += 1
                            break
                        end
                    end
                end
            end
        end
        @init_cards
    end

    def generate_player_cards
        count = 0
        while count < 10
            num = rand(1..104)        
            # Access each key-value pair in deck.json
            @parsed.each_pair do |k, v|
                if num.to_s == k 
                    if !@used_cards.include?(k.to_i)
                        @used_cards << (k.to_i)
                        @player_cards << {num: k.to_i, head: v}
                        count += 1
                    end
                end
            end
        end
        @player_cards
    end

    def generate_npc_cards
        count = 0
        while count < 10
            num = rand(1..104)        
            # Access each key-value pair in deck.json
            @parsed.each_pair do |k, v|
                if num.to_s == k 
                    if !@used_cards.include?(k.to_i)
                        @used_cards << (k.to_i)
                        @npc_cards << {num: k.to_i, head: v}
                        count += 1
                    end
                end
            end
        end
        @npc_cards
    end

    # Sort player card in ascdneing order
    def sorted_cards(arr)
        arr.sort_by { |k| k[:num]}
    end    

    # Print out the init cards in separate rows
    def print_init_cards(arr) #init_cards_j
        arr.each do |hash|
            # Iterate each init row and join by |
            hash.each_value do |values|
                puts values.map { |c| "Card #{c[:num]}: #{c[:head]} head" }.join(' | ')
                puts " "
            end
        end
    end

    # Check if player's dispose card larger or NPC's dispose card larger
    # player_cards_j, init_cards_j, player_collected cards, card_dispose
    def check_which_card_bigger(arr, arr_npc, arr2, arr3, arr3_npc, num, num_npc)
        if num < num_npc
            add_card_to_init(arr, arr2, arr3, num, 'Player')  
            add_card_to_init(arr_npc, arr2, arr3_npc, num_npc, 'NPC')  
        else
            add_card_to_init(arr_npc, arr2, arr3_npc, num_npc, 'NPC') 
            add_card_to_init(arr, arr2, arr3, num, 'Player')  
        end
    end

    # Find out which init row npc will put their card when their disposed card is smaller than the cards outside
    def npc_choose_init_row(arr2) # init_row
        total_heads_on_each_row = []
        # iterate init_row 
        arr2.each_with_index do |row, index|
            # Get the total heads of each init row and add it total_heads_on_each_init_row with total num of heads and index of that init_row
            total_heads_on_each_row << {total: row.values[0].sum { |h| h[:head] }, index: index}
        end
        # Find the min total and get the index of that
        return total_heads_on_each_row.min_by{ |k| k[:total]}[:index]
    end

    # Player will input a num (1-4) to indicate which row they want to put the card
    def choose_init_row(arr2, arr3, init_row, card) # player_cards / init_cards / player cards collected / card
        arr2[init_row-1].values[0] << {num: card[:num], head: card[:head]}
        *first, last = arr2[init_row-1].values[0]
        arr3 << first
        arr2[init_row-1].values[0].shift(arr2[init_row-1].values[0].length - 1)
    end

    # Add disposed card to one of the init rows
    # player_cards or npc_cards / init_cards / player_cards_collected or npc_cards_collected/ num of card_dispose
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
                # When num is not larger than any init row's last card
                when 0
                    # If it's player, prompt player to choose which row they want to put the card
                    if name != 'NPC'
                        puts " * * * * * "
                        puts "#{name} Which row you want to put instead? "
                        init_row = gets.chomp.to_i
                        choose_init_row(arr2, arr3, init_row, card)
                    # If it's npc, use method to calcute which row they will put the card
                    else
                        init_row = npc_choose_init_row(arr2) + 1
                        choose_init_row(arr2, arr3, init_row, card)
                    end
                # When num is larger than any init row's last card
                when 1..5
                    arr2.each_with_index do |row, index|
                        # Add the num and difference into an array 
                        if num > row.values[0].last[:num]
                            temp_arr.push(num: row.values[0].last[:num], head: row.values[0].last[:head], diff: num - row.values[0].last[:num], index: index)
                        end
                    end
                    min = find_min(temp_arr)
                    max_5_on_each_init(arr2[min[:index]].values[0], arr3, card)
                end
                # player_cards or npc_cards / num of dispose card
                delete_card(arr, num)
            end
        end
    end

    # Check if the selected init row has 5 cards already
    def max_5_on_each_init(arr2, arr3, item) # init_cards / player_cards_collected OR npc_cards_collected / card
        # If less than 5 cards, add the disposed card to that row
        if arr2.length < 5
            arr2 << {num: item[:num], head: item[:head]}
        else
            # If more than 5 cards, add the disposed card to that row and move the first 5 cards to cards_collected pile
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

    # Remove disposed card from player_cards or npc_cards pile
    def delete_card(arr, num) # player_cards or npc_cards /  num of disposed card
        arr.delete_if { |h| h[:num] == num }
    end

    # Display how many heads player and npc currently have
    def display_total_heads(arr, name) # player_collected_cards or npc_collected_cards / player or npc
        num = arr.flatten.inject(0) { |sum, h| sum + h[:head]}
        if num > 1
        puts "#{name} has #{num} heads in total."
        else
        puts "#{name} has #{num} head in total."
        end
    end

    # Display which card player and npc have disposed
    def display_disposed_card(name, num)
        puts "#{name} has put card #{num}"
    end

    def who_wins_each_round(arr, arr2, arr4, arr5) # player_collected_cards / npc_collected_cards / player_total / npc_total
        player_score = arr.flatten.inject(0) { |sum, h| sum + h[:head]}
        npc_score = arr2.flatten.inject(0) { |sum, h| sum + h[:head]}
    
        if player_score > npc_score
            puts 'NPC wins this round!'
        elsif player_score < npc_score
            puts 'Player wins this round!'
        else 
            puts 'It"s a tie!'
        end
        arr4 << player_score
        arr5 << npc_score
    end

    # Display total cattle heads each player have after each round
    def display_total_score(arr, arr2) #player_total / #npc_total
        puts "Player has #{arr.sum} heads in total."
        puts "NPC has #{arr2.sum} heads in total."
    end

    # Find out who wins after one player reach 66 cattle heads
    def who_is_final_winner(arr4, arr5) # player_total / npc_total
        if arr4.sum < arr5.sum
            puts "Winner is Player, congratulations!"
        else 
            puts "Winner is NPC, congratulations!"
        end
        # puts "Winner is #{arr.tally.max_by{|k,v| v}[0].capitalize}! Congratulations!"      
    end

    # Check if users have reach 66 cattle heads
    def check_66(arr4, arr5, game_status)
        if arr4.sum >= 66 || arr5.sum >= 66
            who_is_final_winner(arr4, arr5)
            return false
        end
        return true
    end


end
