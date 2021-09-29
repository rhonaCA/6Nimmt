require 'json'
require 'tty-prompt'
require 'rainbow'

require_relative 'classes/Game_setup.rb'
require_relative './helpers/methods.rb'

# include Output::Users

system 'clear'
puts ' '
puts Rainbow('Welcome to 6 Nimmt!').cyan.bright.underline
puts ' '
ans = prompt_input({ 'Start the game': 1, 'Check out the rules first': 2, 'Exit': 3 }, 'Shall we start?')
until ans == 3
  case ans
  when 1
    start_game
    ans = prompt_input({ 'Play Again?': 1, 'Check out the rules first': 2, 'Exit': 3 }, 'What next?')
    system 'clear'
  when 2
    show_rules_page
    ans = prompt_input({ 'Yes I am ready!': 1, 'Exit': 3}, 'Ready to play the game?')
    system 'clear'
  end
end
puts ' '
puts Rainbow('Goodbye, thanks for playing!').lemonchiffon
puts ' '