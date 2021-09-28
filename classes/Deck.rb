require 'json'

class Deck
  attr_reader :deck

  def initialize
    @deck = {}
  end

  # Match each card to the corresponding number of cattle heads
  def prepare_deck
    (1..104).each do |i|
      v = [1, 2, 3, 5, 7]
      if i == 55
        @deck[i] = v[4]
      elsif (i % 11 == 0.0) && i != 55
        @deck[i] = v[3]
     elsif (i % 10 == 0.0) && i != 55
        @deck[i] = v[2]
      elsif (i % 5 == 0.0) && i != 55
        @deck[i] = v[1]
      else
        @deck[i] = v[0]
      end
    end
  end

  # Transfer data to JSON file
  def generate_json(json_file_name, data)
    File.open(json_file_name, 'w') do |f|
      f.puts(data.to_json)
    end
  end
end




