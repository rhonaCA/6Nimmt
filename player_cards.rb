require 'json'
require_relative 'prepare_deck'

class Card
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
end

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

