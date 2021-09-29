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
        puts values.map { |c| "Card #{c[:num]}: #{c[:head]} 🐮" }.join(' | ')
        puts " "
      end
    end
  end

def prompt_input(choices, label)
    prompt = TTY::Prompt.new
    return prompt.select(label, choices, cycle: true)
end