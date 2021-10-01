require 'json'

require_relative 'deck'
require_relative '../helpers/rules'
require_relative '../helpers/methods'

class Users
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
        next unless num.to_s == k

        next if @used_cards.include?(k.to_i)

        @used_cards << (k.to_i)
        # Add the first card to init1
        if count == 0
          @init_cards[0][:init1] << { num: k.to_i, head: v }
          count += 1
          break
        # Add the second card to init2
        elsif count == 1
          @init_cards[1][:init2] << { num: k.to_i, head: v }
          count += 1
          break
        # Add the third card to init3
        elsif count == 2
          @init_cards[2][:init3] << { num: k.to_i, head: v }
          count += 1
          break
        # Add the forth card to init4
        elsif count == 3
          @init_cards[3][:init4] << { num: k.to_i, head: v }
          count += 1
          break
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
        next unless num.to_s == k

        next if @used_cards.include?(k.to_i)

        @used_cards << (k.to_i)
        @player_cards << { num: k.to_i, head: v }
        count += 1
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
        next unless num.to_s == k

        next if @used_cards.include?(k.to_i)

        @used_cards << (k.to_i)
        @npc_cards << { num: k.to_i, head: v }
        count += 1
      end
    end
    @npc_cards
  end

  # Sort player card in ascdneing order
  def sorted_cards(arr)
    arr.sort_by { |k| k[:num] }
  end

  # Check if player's dispose card larger or NPC's dispose card larger
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
  def npc_choose_init_row(arr2) 
    total_heads_on_each_row = []
    # iterate init_row
    arr2.each_with_index do |row, index|
      # Get the total heads of each init row and add it total_heads_on_each_init_row with total num of heads and index of that init_row
      total_heads_on_each_row << { total: row.values[0].sum { |h| h[:head] }, index: index }
    end
    # Find the min total and get the index of that
    return total_heads_on_each_row.min_by { |k| k[:total] }[:index]
  end

  # Player will input a num (1-4) to indicate which row they want to put the card
  def choose_init_row(arr2, arr3, init_row, card)
    arr2[init_row - 1].values[0] << { num: card[:num], head: card[:head] }
    *first, last = arr2[init_row - 1].values[0]
    arr3 << first
    arr2[init_row - 1].values[0].shift(arr2[init_row - 1].values[0].length - 1)
  end

  # Prompt user to choose a row to place
  def prompt_question
    prompt = TTY::Prompt.new
    puts ' '
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts ' '
    rows = { 'Row 1': 1, 'Row 2': 2, 'Row 3': 3, 'Row 4': 4, 'Check out the rules!': 5, 'Exit game': 6 }
    init_row = prompt.select("Which row you want to place the card?", rows, cycle: true)
    return init_row
  end

  # Add disposed card to one of the init rows
  def add_card_to_init(arr, arr2, arr3, num, name)
    prompt = TTY::Prompt.new

    arr.each do |card|
      temp_arr = []
      # Iterate player cards to compare num to [:num]
      next unless num == card[:num]

      count = 0
      # Iterate init cards to check if num > any init cards'num, index = index of each init row in init_cards
      arr2.each_with_index do |row, _index|
        count += 1 if num >= row.values[0].last[:num]
      end
      case count
      # When num is not larger than any init row's last card
      when 0
        # If it's player, prompt player to choose which row they want to put the card
        if name == 'NPC'
          init_row = npc_choose_init_row(arr2) + 1
          choose_init_row(arr2, arr3, init_row, card)
        else
          init_row = prompt_question()
          # If player choose to check the rules page
          while init_row == 5
            show_rules_page
            ans = prompt_input({ 'Yes I am ready!': 1, 'Exit Game': 3 }, 'Ready to resume the game?')
            # If player choose to exit game
            if ans == 3
              game_over(name)
            end
            system 'clear'

            print_init_cards(arr2)
            puts ' '
            display_disposed_card(name, num)
            # print init cards again
            init_row = prompt_question()
          end
          if init_row == 6
            game_over(name)
          end
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
      delete_card(arr, num)
    end
  end

  # Check if the selected init row has 5 cards already
  def max_5_on_each_init(arr2, arr3, item)
    # If less than 5 cards, add the disposed card to that row
    if arr2.length < 5
      arr2 << { num: item[:num], head: item[:head] }
    else
      # If more than 5 cards, add the disposed card to that row and move the first 5 cards to cards_collected pile
      arr2 << { num: item[:num], head: item[:head] }
      *remaining, last = arr2
      arr3 << remaining
      arr2.shift(5)
    end
  end

  # Find the min in the arr
  def find_min(arr)
    arr.min_by { |x| x[:diff] }
  end

  # Remove disposed card from player_cards or npc_cards pile
  def delete_card(arr, num) 
    arr.delete_if { |h| h[:num] == num }
  end

  # Display how many heads player and npc currently have
  def display_total_heads(arr, name) 
    num = arr.flatten.inject(0) { |sum, h| sum + h[:head] }
    puts Rainbow("#{name} ").cyan.bright + "has " + Rainbow("#{num} ").cyan.bright + "🐮"
  end
  
  # Display which card player and npc have disposed
  def display_disposed_card(name, num)
    puts Rainbow("#{name} ").magenta.bright + 'had put ' + Rainbow("card #{num}").magenta.bright
  end

  def who_wins_each_round(arr, arr2, arr4, arr5, name)
    player_score = arr.flatten.inject(0) { |sum, h| sum + h[:head] }
    npc_score = arr2.flatten.inject(0) { |sum, h| sum + h[:head] }

    if player_score > npc_score
      puts Rainbow('NPC wins this round!').orangered.bright
      puts ' '
    elsif player_score < npc_score
      puts Rainbow("#{name} wins this round!").orangered.bright
      puts ' '
    else
      puts Rainbow('It\'s a tie!').orangered.bright
      puts ' '
    end
    arr4 << player_score
    arr5 << npc_score
  end

  # Display total cattle heads each player have after each round
  def display_total_score(arr, arr2, name)
    puts Rainbow("#{name} ").hotpink.bright + 'has ' + Rainbow("#{arr.sum} ").hotpink.bright + '🐮 in total'
    puts ' '
    puts Rainbow('NPC ').hotpink.bright + 'has ' + Rainbow("#{arr2.sum} ").hotpink.bright + '🐮 in total'
    puts ' '
  end

  def display_winner(name)
    puts '👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏 '
    puts ' '
    puts Rainbow("                    Winner is #{name}, congratulations!").gold.bright
    puts ' '
    puts '👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏  👏'
  end

  def add_to_csv(path, name, score)
    begin
      CSV.open(path, 'a') do |csv| 
        csv << [name, score]
      end
      rescue
        puts "Something went wrong!"
        puts "Exiting now please try again :)"
        exit 
    end
  end

  # Find out who wins after one player reach 66 cattle heads
  def who_is_final_winner(score1, score2, name)
    if score1 < score2
      display_winner(name)
      add_to_csv('score_board.csv',name, score1)
    else
      display_winner("NPC")
      add_to_csv('score_board.csv','NPC', score2)
    end
  end

  # Check if users have reach 66 cattle heads
  def check_66(arr4, arr5, game_status, name)
    player_score = arr4.sum
    npc_score = arr5.sum
    if player_score >= 66 || npc_score >= 66
      who_is_final_winner(player_score, npc_score, name)
      return false
    end
    return true
  end
end


