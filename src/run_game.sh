#!/bin/bash

bundle install

echo "Hello!"
echo -e "What would you like to do? 'Start' to start the game, 'Rules' to checkout the rules, 'Scoreboard' to checkout the scoreboard. Easy! "
read option
echo -e "What is your name?"
read name

ruby main.rb $option $name