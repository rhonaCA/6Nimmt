require 'json'

deck = {}

# Match each card to the corresponding number of cattle heads
for i in 1..104
    v = [1, 2, 3, 5, 7]
    if i == 55
        deck[i] = v[4]
    elsif (i % 11 == 0.0) && i != 55
        deck[i] = v[3]
    elsif (i % 10 == 0.0)
        deck[i] = v[2]
    elsif (i % 5 == 0.0) && i != 55
        deck[i] = v[1]
    else 
        deck[i] = v[0]
    end
end

# Transfer deck's data to JSON file 
File.open('deck.json', 'w') do |f|
    f.puts(deck.to_json)
end




