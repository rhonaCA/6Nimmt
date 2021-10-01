require 'json'
require 'csv'
require 'tty-prompt'
require 'tty-box'
require 'rainbow'
require 'artii'

require_relative 'classes/game_setup.rb'
require_relative 'classes/errors.rb'
require_relative 'helpers/methods.rb'

# include Output::Users



begin
  if ARGV.length == 0
    raise NoMethodError
  end
  if ARGV.length == 2
    cli = ARGV[0].downcase
    name = ARGV[1]
    if name.index( /[^[:alnum:]]/ ) != nil
      raise WrongInputError
    end
  else
    raise TooManyArgError
  end
rescue WrongInputError
  puts ' '
  puts Rainbow('Sorry, name can only contains letters and numbers. Please try again!').tomato.bright 
  puts ' '
  exit
rescue NoMethodError
  puts ' '
  puts Rainbow('Sorry, seems like you are missing something. Please try again!').tomato.bright 
  puts ' '
  exit
rescue TooManyArgError
  puts ' '
  puts Rainbow('Sorry, seems like you are putting too many arguments in. Please try again!').tomato.bright 
  puts ' '
  exit
rescue 
  puts ' '
  puts Rainbow('Sorry, name can only contains letters and numbers. Please try again!').tomato.bright 
  puts ' '
  exit
end

case cli
when 'start'
  system 'clear'
  puts ' '
  a = Artii::Base.new :font => 'big'
  puts Rainbow(a.asciify('Welcome to Nimmt !')).lightskyblue.bright
  puts ' '
  ans = prompt_input({ 'Start the game': 1, 'Check out the rules first': 2, 'Checkout score board': 4, 'Exit game': 3 }, 'Shall we start?')
  game_round(ans, name)
when 'rules'
  show_rules_page
  ans = prompt_input({ 'Yes I am ready!': 1, 'Exit game': 3}, 'Ready to play the game?')
  game_round(ans, name)
  system 'clear'
when 'scoreboard'
  system 'clear'
  show_score_board()
  puts ' '
  ans = prompt_input({ 'Yes I am ready!': 1, 'Check out the rules first': 2, 'Exit game': 3 }, 'Ready to play the game?')
  game_round(ans, name)
else
  puts 'Wrong option, exit now and please try again!'
end