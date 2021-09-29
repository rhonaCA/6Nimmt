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

def print_game_over
  puts ' '
  puts Rainbow('Goodbye, thanks for playing!').lemonchiffon
  puts ' '
  exit
end