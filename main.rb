require 'json'
require 'tty-prompt'

require_relative 'classes/Players'
require_relative 'classes/NPC'
require_relative 'helpers/Rules'

deck = Deck.new
deck.prepare_deck
deck.generate_json('deck.json', deck.deck)

def start_game
    prompt = TTY::Prompt.new

    players = Players.new
    npc = NPC.new

    player_total = []
    npc_total = []

    game_status = true
    while game_status == true
        # Dealt cards to each player and 4 initial cards out the front
        users = Users.new
        init_cards = users.generate_init_cards
        player_cards = users.sorted_cards(users.generate_player_cards)
        npc_cards = users.sorted_cards(users.generate_npc_cards)

        # Create JSON files to store above data
        users.create_json('init_cards.json', init_cards)
        users.create_json('player_cards.json', player_cards)
        users.create_json('npc_cards.json', npc_cards)

        # Load JSON files to prepare the game
        init_cards_j = JSON.load_file('init_cards.json', symbolize_names: true)
        player_cards_j = JSON.load_file('player_cards.json', symbolize_names: true)
        npc_cards_j = JSON.load_file('npc_cards.json', symbolize_names: true)

        player_collected_cards = []
        npc_collected_cards = []

        turn = 10
        until turn == 0        
            users.print_init_cards(init_cards_j)
            # puts "Here's your card: "
            # players.print_player_cards(player_cards_j)

            users.display_total_heads(player_collected_cards, 'Player')
            users.display_total_heads(npc_collected_cards, 'NPC')

            # Map player_cards_j to a new array for tty-prompt
            hash_for_prompt = {}
            player_cards_j.map do |c|
                hash_for_prompt.store("Card #{c[:num]} - #{c[:head]} heads", "#{c[:num]}") 
            end

            card_dispose = prompt.select('Which card do you want to play?', hash_for_prompt).to_i
            

            # # Prompt player select a card to place outside
            # puts "Player: Card you want to place outside? "
            # card_dispose = gets.chomp.to_i

            # NPC select a card to place outside
            card_dispose_npc = npc.npc_card_dispose(npc_cards_j, init_cards_j)

            users.display_disposed_card('Player', card_dispose)
            users.display_disposed_card('NPC', card_dispose_npc)

            # player_cards_j, init_cards_j, player_collected cards, card_dispose
            users.check_which_card_bigger(player_cards_j, npc_cards_j, init_cards_j, player_collected_cards, npc_collected_cards, card_dispose, card_dispose_npc)
            turn -= 1
        end
        users.print_init_cards(init_cards_j)
        users.display_total_heads(player_collected_cards, 'Player')
        users.display_total_heads(npc_collected_cards, 'NPC')

        puts "This round is finished!!!!"
        users.who_wins_each_round(player_collected_cards, npc_collected_cards, player_total, npc_total)
        users.display_total_score(player_total, npc_total)

        game_status = users.check_66(player_total, npc_total, game_status)
    end
end

prompt = TTY::Prompt.new

puts 'Welcome to 6 Nimmt!'
choices = {'Start the game': 1, 'Check out the rules first': 2}
ans = prompt.select('Shall we start?', choices)
if ans == 1
    start_game()
else
    if show_rules_page() == 'y'
        start_game()
    end
end