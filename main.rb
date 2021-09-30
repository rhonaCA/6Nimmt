require 'json'
require 'csv'
require 'tty-prompt'
require 'rainbow'
require 'artii'

require_relative 'classes/Game_setup.rb'
require_relative 'classes/Errors.rb'
require_relative 'helpers/Methods.rb'

# include Output::Users

a = Artii::Base.new :font => 'big'

system 'clear'
puts ' '
puts Rainbow(a.asciify('Welcome to Nimmt !')).lightskyblue.bright
puts ' '


ans = prompt_input({ 'Start the game': 1, 'Check out the rules first': 2, 'Checkout score board': 4, 'Exit game': 3 }, 'Shall we start?')
until ans == 3
  case ans
  when 1

    begin
      puts ' '
      puts 'What\'s your name?'
      name = gets.chomp
      if name.empty? or name.nil?
        raise EmptyInputError
      end
      if name.gsub(/\s+/, "").index( /[^[:alnum:]]/ ) != nil
        raise WrongInputError
      end
    rescue EmptyInputError
        puts Rainbow('You haven\'t put your name in yet. Try again!').tomato.bright
        puts ' '
        retry
    rescue WrongInputError
      puts ' '
      puts Rainbow('Sorry, name can only contains letters and numbers. Try again!').tomato.bright
      retry    
    end

    start_game(name)
    ans = prompt_input({ 'Play Again?': 1, 'Check out the rules first': 2, 'Exit game': 3 }, 'What next?')
    system 'clear'
  when 2
    show_rules_page
    ans = prompt_input({ 'Yes I am ready!': 1, 'Exit game': 3}, 'Ready to play the game?')
    system 'clear'
  when 4
    system 'clear'
    show_score_board()
    puts ' '
    ans = prompt_input({ 'Yes I am ready!': 1, 'Check out the rules first': 2, 'Exit game': 3 }, 'Ready to play the game?')
  end
end
game_over()