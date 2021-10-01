# module Output
#     module Cards
#         def print_init_cards(arr) # init_cards_j
#             arr.each do |hash|
#               # Iterate each init row and join by |
#               hash.each_value do |values|
#                 puts values.map { |c| "Card #{c[:num]}: #{c[:head]} 🐮" }.join(' | ')
#                 puts " "
#               end
#             end
#           end
        
#     end
#     module Users
#         def prompt_input(choices, label)
#             prompt = TTY::Prompt.new
#             return prompt.select(label, choices, cycle: true)
#         end
#     end 
# end

def print_init_cards(arr) # init_cards_j
    arr.each do |hash|
      # Iterate each init row and join by |
      hash.each_value do |values|
        puts values.map { |c| Rainbow("Card #{c[:num]}: ").indianred.bright + Rainbow("#{c[:head]} 🐮").papayawhip }.join(' | ')
        puts " "
      end
    end
  end

def prompt_input(choices, label)
    prompt = TTY::Prompt.new
    return prompt.select(label, choices, cycle: true)
end

def game_over(name="player")
  system 'clear'
  puts ' '
  puts Rainbow("Goodbye #{name}, thanks for playing!").lemonchiffon
  puts ' '
  exit
end

def show_score_board
  a = Artii::Base.new :font => 'big'
  puts Rainbow(a.asciify('Score Board').center(20)).bright.aqua
  puts ' '
  arr = []
  CSV.foreach('score_board.csv') do |row|
    arr << {name: row[0], score: row[1]}
  end
  sorted = arr.sort_by! do |k| 
      k[:score]
  end
  score_board_arr = sorted.map { |element| [element[:name], element[:score]]}
  score_board_arr.each do |item|
    puts Rainbow(item[0].center(item[0].length + 22)).lightblue + Rainbow(item[1].center(35 - item[0].length)).lightblue
    puts ' '
  end
end