require 'json'
require_relative 'prepare_deck'

parsed = JSON.load_file('deck.json')

used_cards = []
init_cards = [
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

    count = 0
    while count < 4
        num = rand(1..104)        
        # Access each key-value pair in deck.json
        parsed.each_pair do |k, v|
            if num.to_s == k 
                if !used_cards.include?(k.to_i)
                    used_cards << (k.to_i)
                    if count == 0
                        init_cards[0][:init1] << {num: k.to_i, head: v}
                        count += 1
                        break
                    elsif count == 1
                        init_cards[1][:init2] << {num: k.to_i, head: v}
                        count += 1
                        break
                    elsif count == 2
                        init_cards[2][:init3] << {num: k.to_i, head: v}
                        count += 1
                        break
                    elsif count == 3
                        init_cards[3][:init4] << {num: k.to_i, head: v}
                        count += 1
                        break
                    end
                end
            end
        end
    end


p init_cards[0][:init1]
p init_cards[1][:init2]
p init_cards[2][:init3]
p init_cards[3][:init4]

