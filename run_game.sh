#!/bin/bash

bundle install

clear
echo " "
echo "Hello! Welcome to the 6 Nimmt!"
echo " "
echo "This is a fun, interesting card game and I hope you will enjoy it 😊"
echo " "
echo "Please set your terminal size to a minimum 110x45 to have a better user experience."
echo " "
echo "Press enter to continue... "
read key
echo -e "Ready to play? Type in 'Start' to start the game, 'Rules' to checkout the rules, 'Scoreboard' to checkout the scoreboard. Easy! "
read option
echo -e "Awesome! What is your name?"
read name

ruby main.rb $option $name