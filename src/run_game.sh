#!/bin/bash

bundle install

echo " "
echo "Hello! Welcome to the 6 Nimmt!"
echo " "
echo "This is a fun, interesting card game and I hope you will enjoy it 😊"
echo " "
echo -e "Ready to play? Type in 'Start' to start the game, 'Rules' to checkout the rules, 'Scoreboard' to checkout the scoreboard. Easy! "
read option
echo -e "Awesome! What is your name?"
read name

ruby main.rb $option $name