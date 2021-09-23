require 'json'

class Deck
  def initialize
    @Deck = {}
  end

  def prepare_deck
    # Match each card to the corresponding number of cattle heads
    (1..104).each do |i|
      v = [1, 2, 3, 5, 7]
      if i == 55
        @Deck[i] = v[4]
      elsif (i % 11 == 0.0) && i != 55
        @Deck[i] = v[3]
     elsif (i % 10 == 0.0) && i != 55
        @Deck[i] = v[2]
      elsif (i % 5 == 0.0) && i != 55
        @Deck[i] = v[1]
      else
        @Deck[i] = v[0]
      end
    end
  end

  def generate_json
    # Transfer deck's data to JSON file
    File.open('deck.json', 'w') do |f|
      f.puts(@Deck.to_json)
    end
  end
end

deck = Deck.new
deck.prepare_deck
deck.generate_json

