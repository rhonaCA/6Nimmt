require 'json'

require_relative 'Players'
require_relative 'NPC'
require_relative '../helpers/Rules'
require_relative '../helpers/Methods'

deck = Deck.new
deck.prepare_deck
deck.generate_json('deck.json', deck.deck)


def start_game(name)
  prompt = TTY::Prompt.new

  players = Players.new
  npc = NPC.new  

  player_total = []
  npc_total = []

  game_status = true
  while game_status == true
    users = Users.new
    # Dealt cards to each player and 4 initial cards out the front
    init_cards = users.generate_init_cards
    player_cards = users.sorted_cards(users.generate_player_cards)
    npc_cards = users.sorted_cards(users.generate_npc_cards)

    # Create JSON files to store above data
    users.create_json('init_cards.json', init_cards)
    users.create_json('player_cards.json', player_cards)
    users.create_json('npc_cards.json', npc_cards)

    # Load JSON files to prepare the game
    begin
      init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)
      player_cards_j = JSON.load_file('player_cards.json', symbolize_names: true)
      npc_cards_j = JSON.load_file('npc_cards.json', symbolize_names: true)
    rescue
      puts "Something went wrong!"
      puts "Exiting now please try again :)"
      exit
    end

    player_collected_cards = []
    npc_collected_cards = []

    turn = 10
    card_dispose = nil
    card_dispose_npc = nil
    until turn == 0
      system "clear"
      puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
      puts ' '
      print_init_cards(init_cards_j)
      puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
      puts ' '
    
      # puts "Here's your card: "
      # players.print_player_cards(player_cards_j)
      users.display_total_heads(player_collected_cards, name)
      puts ' '
      users.display_total_heads(npc_collected_cards, 'NPC')
      puts ' '
      puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'

      # Map player_cards_j to a new array for tty-prompt
      hash_for_prompt = players.print_player_cards(player_cards_j)
      if card_dispose and card_dispose_npc
        puts ' '    
        users.display_disposed_card(name, card_dispose)
        puts ' '
        users.display_disposed_card('NPC', card_dispose_npc)
        puts ' '  
        puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'

      end
      puts ' '
      card_dispose = prompt.select('Which card do you want to play?', hash_for_prompt, cycle: true, per_page: 12).to_i
      
      if card_dispose == -1
        game_over(name)
      end
      while card_dispose == 0
        show_rules_page
        ans = prompt_input({ 'Yes I am ready!': 1, 'Exit Game': 3 }, 'Ready to resume the game?')
        if ans == 3
          game_over(name)
        end
        system "clear"
        puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
        puts ' '
        print_init_cards(init_cards_j)
        puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
        puts ' '
        card_dispose = prompt.select('Which card do you want to play?', hash_for_prompt, cycle: true,
          per_page: 12).to_i
      end

      card_dispose_npc = npc.npc_card_dispose(npc_cards_j, init_cards_j)
      
      # player_cards_j, init_cards_j, player_collected cards, card_dispose
      users.check_which_card_bigger(player_cards_j, npc_cards_j, init_cards_j, player_collected_cards,
        npc_collected_cards, card_dispose, card_dispose_npc)
      turn -= 1

    end
    system 'clear'
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts ' '
    print_init_cards(init_cards_j)
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts ' '
    # player.display_total_heads
    # npc.dispay_total_heads
    users.display_total_heads(player_collected_cards, name)
    puts ' '
    users.display_total_heads(npc_collected_cards, 'NPC')
    puts ' '
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts ' '
    puts "This round is finished - "
    # puts "Press enter to continue..."
    # gets.chomp
    users.who_wins_each_round(player_collected_cards, npc_collected_cards, player_total, npc_total, name)
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts ' '
    users.display_total_score(player_total, npc_total, name)
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts ' '
    game_status = users.check_66(player_total, npc_total, game_status, name)
    puts ' '
    puts "Press enter to move onto the next round..."
    gets.chomp
  end
end
