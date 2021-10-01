#!/bin/bash

bundle install

echo "Hello! Welcom to the 6 nimmt!"
echo " "
echo "This is a fun, interesting card game and I hope you will enjoy 😊"
echo " "
echo "Ready to play?"
echo " "
echo -e "Tell me what you want to do? 'Start' to start the game, 'Rules' to checkout the rules, 'Scoreboard' to checkout the scoreboard. Easy! "
read option
echo -e "What is your name?"
read name

ruby main.rb $option $name