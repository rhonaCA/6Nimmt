# Tan Na Lam - T1A3 - Terminal Application: 6 Nimmt!

# Links

## GitHub repository

https://github.com/rhonaCA/T1A3 

# Software development Plan

## Application description and function
This terminal application is a clone of a card game called 6 Nimmt! 6 Nimmt! / Take 6! Is a card game for 2 - 10 players designed by Wolfgang Kramer in 1994. Suitable for 8 years or up and playing time can be vary, around 15 to 45 minutes depends on the numbers of player. This game is easy to play and can be quite challenging to win.

This game has 104 cards, each contains a number and 1 to 7 cattle heads icons that represent penalty points. Each round has 10 turns, each turn all players place one card of their choice out. The placed cards are placed on one of four rows according to the fixed rules. If the card needs to be placed onto a row that already has five cards which classified as a full row according to the rules. Then the player who place that card needs to collect those five cards, which count as penalty points that are totalled up at the end of each round. Game will continue until a player collects 66 cattle heads or more, the player with the least cattle heads wins the game.

## Reason for development

I want to create something that is fun and interesting to use or play. As I will spend quite a bit of times on this application, I want the process is enjoyable. And I would be more likely to have motivation to make it better. Also, this game is one of my families' favourite card game, I want to make an application for them so they can play at their leisure. 

## Problem solved
As I said before, one of the reason I choose this card game as my idea of the application is because I want my families can play it and enjoy it. I do not know when the international travel will be re-opened due to the current pandemic, so I hope this application can bring some joy to them and hopefully they can think of me during the game.

## Target audience
Apart my families and friends. I want anyone who loves board games or card games to enjoy it. For first time players, it may be a bit confused at first, but I guarantee you will get a hang of it after a few rounds.  

## How to play

### **Goal of the game**
---
Try not to get any cards as it will add up the penalty points.


### **Gameplay**
---
Hi player, you are playing with 1 NPC in this game. Both of you will have 10 cards to start with each round. You will see 4 initial set up cards placed vertically on the screen and your own cards that have be arranged in ascending order. 

At each turn, you can select a card to play by using ↑ / ↓ keys. After you select a card, depend whose card is smaller (you or NPC), that player will first put their card at the end of one of the 4 rows base on below rules:

### **- Rule No. 1: Ascending Order**

The number of the card that is added to a row must be higher than the number of the current last card in that row.

##### **Example:**
Player selects ```Card 12``` to play, as that card is only higher than ```Card 7``` so ```Card 12``` will be placed after ```Card 7```.

```diff
Card 102: 1 🐮
 
Card 103: 1 🐮
 
+ Card 7: 1 🐮
 
Card 91: 1 🐮
```

### **- Rule No. 2: Small Difference**

A card must always be added to the row with the smallest possible difference between the current last card and the new one.

##### **Example:**
Player selects ```Card 92``` to play. Although that card is higher than both ```Card 49``` and ```Card 88```, it will be placed after ```Card 88``` as it is the closest one.
```diff
Card 23: 1 🐮 | Card 49: 1 🐮
 
Card 103: 1 🐮
 
+ Card 7: 1 🐮 | Card 12: 1 🐮 | Card 88: 5 🐮
 
Card 91: 1 🐮
 
```

### **- Rule No. 3: Full Row**

A row with 5 cards in it means the row is full. If Rule No. 2 would put a sixth card in such a row, the player who played that card must take all five cards of the full row. Their card then becomes the first in the new row.

##### **Example:**
Player selects ```Card 90``` to play. As the card is closest with ```Card 89``` so it will be placed after ```Card 89```. 

```diff
Card 52: 1 🐮 | Card 87: 1 🐮
 
Card 12: 1 🐮
 
+ Card 17: 1 🐮 | Card 23: 1 🐮 | Card 28: 1 🐮 | Card 32: 1 🐮 | Card 89: 1 🐮
 
Card 2: 1 🐮
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
Rhona has 1 🐮
 
NPC has 0 🐮
```
However this row already has 5 existing cards, that means this row is full. Player will collect all 5 cards (Card 17, Card 23, Card 28, Card 32 and Card 89) and keep them in the collected cards pile. Adn the cattle heads will be added up and display on screen. `Card 90` will become the first card of that row.
```diff

--- After player place the selected card:

Card 52: 1 🐮 | Card 87: 1 🐮
 
Card 12: 1 🐮
 
+ Card 90: 3 🐮
 
Card 2: 1 🐮
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
- Rhona has 6 🐮
 
NPC has 0 🐮

```

### **- Rule No. 4: Lowest Card**

If a player plays a card whose number is so low that it does not fit into any row, they must pick up all cards of a row of their choice. Their card then becomes the first card of the new row. *** **Usually player will choose the row that will score them the fewest cattle heads.** ***


##### **Example:**
Player selects ```Card 2``` to play. As it is smaller than all last cards out there, player can select a row to place the card. In this example, player choose `row 2` as it has the least cattle heads on that row. Cattle heads will be updated on the screen.
```diff
 
Card 43: 1 🐮  | Card 55: 7 🐮
 
+ Card 13: 1 🐮 
 
Card 45: 2 🐮 | Card 87: 1 🐮
 
Card 97: 1 🐮 | Card 99: 5 🐮

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
- Rhona has 1 🐮
 
NPC has 0 🐮
 
```
Existing card on that row will be added to player collected cards pile and you 
```diff
 
--- After player place the selected card:

Card 43: 1 🐮  | Card 55: 7 🐮
 
+ Card 2: 1 🐮 
 
Card 45: 2 🐮 | Card 87: 1 🐮
 
Card 97: 1 🐮 | Card 99: 5 🐮
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
Which row you want to place the card? (Press ↑/↓ arrow to move and Enter to select)
  Row 1
+ Row 2
  Row 3
  Row 4
  Check out the rules!
  Exit game
```

At the end of each turn, you will need to select a new card to play, this is repeated for 10 turns until all the cards in your hand are played.


### **When the game ends?**
---
After 10 turns, the game will count the cattle heads on the cards gathered during the round, keep score of each player and a new hand will start.

The game will end when you or NPC collect a total of 66 or more cattle heads. Whoever has collected the fewest cattle heads is the winner!

Winner’s name and score will be kept in the scoreboard so you can check out later.

### **Ready to play?**
<br>

# Features

## Display player's cards
At the beginning of each round, system will deal 10 random cards from the 104-card deck to player and NPC, data will be stored in a JSON file. Each card contains a number and 1-7 cattle heads symbols that represent the penalty points, both are visible to player. Their cards have been arranged in ascending order vertically for readability. After they select a card to play, that card will be removed from the list. 
```
Which card do you want to play? (Press ↑/↓ arrow to move and Enter to select)
‣ Card 28 - 1 🐮
  Card 32 - 1 🐮
  Card 33 - 5 🐮
  Card 37 - 1 🐮
  Card 43 - 1 🐮
  Card 46 - 1 🐮
  Card 60 - 3 🐮
  Card 91 - 1 🐮
  Card 92 - 1 🐮
  Card 94 - 1 🐮
  Check out the
```

## Display total cattle heads after each turn/ round
When player collect cards from outside, those cards will be stored in the collected cards pile. Each turn, player can see how many cattle heads they and NPC have been collected so far. After each round, those scores will be kept separately to calculate when the game will end, player will also able to see the total cattle heads that have been accumulated during the game. 

Green ones are the scores of each round.
Red ones are the total scores during the game.

```diff
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
+Rhona has 16 🐮
 
+NPC has 8 🐮
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
This round is finished - 
NPC wins this round!
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 
-Rhona has 16 🐮 in total
 
-NPC has 8 🐮 in total
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
```

## Player can select a row of their choice when their card is smaller than any last cards
When player select a card that is smaller than any last cards out there, they can select a row of their choice.
```bash
Which row you want to place the card? (Press ↑/↓ arrow to move and Enter to select)
‣ Row 1
  Row 2
  Row 3
  Row 4
  Check out the rules!
  Exit game
```

## NPC
Player will play with 1 NPC in this game. NPC will have 10 cards at the beginning of each round like player. NPC will choose a card each turn base on probability and other logics. If the chosen card is smaller than any last cards out there, NPC will place the card to the row that has least cattle heads.

## Scoreboard
When the game is finished, application will store the winner's name and score in scoreboard.csv file. Player can check out the scoreboard at the beginning and end of the game.

## Max 5 cards of each row
Base on the rules, each row can only contains 5 cards. If the sixth card needs to place on that specific row according to the rules. Whoever play the sixth card will collect all 5 cards and keep them at their collected cards pile. That row will be cleared and the placed card will 
become the first card of that row.

# Users interaction and experience

## Controls
As I am using tty-prompt to get player's input the whole game, only exception is when player runs the game with script file at the very beginning. All questions will have a default message to tell the player how to select their desire choice which is by ↑/↓ arrow keys.
```diff
+Shall we start? (Press ↑/↓ arrow to move and Enter to select)
‣ Start the game
  Check out the rules first
  Checkout score board
  Exit game
```

## How each feature is used

This game mostly rely on player's input, except for the NPC part. Player uses ↑/↓ arrow keys to select their choice. Including start game, check the rules, check out the scoreboard, exit game, select which card to play, select which row to place and so on.

## Errors handling

When player runs the game with script file, it will prompt the player to type in what they want to do ('start' to start game, 'rules' to check out the rules, 'scoreboard' to check out the scoreboard) and also get their name. 

If player type in a wrong option, means it's not one of those three, application will tell the player that option is wrong and ask if they want to try it again:
```
Wrong option, do you want to try it again? (Y/N)
```
If they type in 'Y', application will prompt them for option and name again. Otherwise it will print out a goodbye message:
```
Byebye, hope I will see you again!
```

For name, it can only contains letters and numbers so if they type in any special character it will throw an error message: 
```
Sorry, name can only contains letters and numbers. Please try again!
```

Because I am using tty-prompt for the rest of the player's input so there is not much error handlings on that.

# Control flow diagram

![Preview](docs/control_flow_diagram.png)

# Implementation plan

## High Priority

### **Initial Setup**

#### **Prep the deck for the game (30mins)**
The card game has 104 cards and each card contains a number and variable number of cattle heads symbol to represent the penalty points, here's the setup:
<li>7 cattle heads: number 55</li>
<li>5 cattle heads: multiples of 11 (except 55): 11, 22, 33, 44, 66, 77, 88, 99</li>
<li>3 cattle heads: multiples of ten: 10, 20, 30, 40, 50, 60, 70, 80, 90, 100</li>
<li>2 cattle heads: multiples of five that are not multiples of ten (except 55): 5, 15, 25, 35, 45, 65, 75, 85, 95</li>
<li>1 cattle head: the rest of the cards from 1 through 104</li>
<br>

#### **Prepare cards for player, npc and the initial setup (30mins)**
Each round, player and npc will each have 10 cards randomly generate from the deck. Also needs 4 random cards for the initial rows. All cards can not be duplicated.

#### **Display initial cards (1hr)**
These 4 initial cards will be placed in 4 different rows vertically.

### **Display players cards (30mins)**
Player can see their cards at all time.

### **Player can choose which card they want to play (1hr)**
Player can choose which card they want to play each turn.

#### **Methods that are needed:**
<li>Iterate through number 1 to 104 to match the corresponding number of cattle heads, and store the hash in a JSON file.</li>
<li>Randomly generate 4 cards for initial rows, each card will store in a hash(row 1-4) inside an array (init_rows). Cards are also store in an array called used_cards to keep track which cards have been used.</li>
<li>Randomly generate 10 cards for player and NPC, store them in players_cards array and npc_cards array respectively. If the number has been found in used_cards array, system will generate a new card until both player and npc have 10 cards each. During the process, all generated cards will store in users_cards array.</li>
<li>Iterate init_rows array to print out each cards</li>
<li>Iterate player_cards to print out all cards, add check out rules and exit game options for usability</li>

### **Set up NPC**
The card game needs minimum 2 players. As this application is not a multiplayer game we need at least one NPC so player can play against with.

#### **How NPC decide which card they select to play each turn(3hrs)**
The NPC should select a card not just by purely randomness but with some logics to make it act more like a real player. 

#### **How NPC decide which row to put if the selected card is smaller than all last cards(2hr)**
When NPC play a card that is smaller than all last cards, NPC will select a row that with least cattle heads.

#### **Methods that are needed:**
<li>Iterate through npc_cards array and compare with each last cards out there, get the difference and store them in an temp_npc array</li>
<li>Divide temp_npc into 3 arrays:</li>
<ul>
<li>Negative differences (means NPC cards are smaller than last cards outside)</li>
<li>Difference between 1 - 20</li>
<li>Difference over 20</li>
</ul>
<li>Randomly choose a card from each arrays and store them in a npc_choose_card array</li>
<li>A card will be picked from this array base on probability:</li>
<ul>
<li>5% - Negative differences</li>
<li>60% - Differences between 1- 20</li>
<li>35% - Differences over 20</li>
</ul>
<li>If the picked card's value is nil, the previous card will be picked instead</li>
<li>Calculate total cattle heads each row has, the row has the least cattle heads will be the one NPC choose</li>


### **Users (include player and NPC)**

#### **Add played card to the row base on the rules(2hrs)**
Every played cards should go to the corresponding row base on the rules automatically. Only exception is when the played card is smaller than all last cards out there, player can choose a row at their choice. NPC will place the card to the row that has the least cattle heads.

#### **Player can choose which row to place the card when needed(2hrs)**
Prompt player to choose a row to place the played card. Add checkout the rules and exit game option for usability. 

#### **Remove played card from player's cards / NPC's cards(1hr)**
Played card should be remove from player's and NPC's hands as they can't be reused.

#### **Check if the row is full(1hr)**
If the row has 5 cards already means that row is full. Whoever play the 6th card will need to collect all 5 cards and the 6th card will become the first card of that row.

#### **Display played card(1hr)**
System will display cards that player and NPC just played.

#### **Keeping score and Display scores(2hrs)**
System will display how many cattle heads each user has collected during each round. Also a total cattle heads each user has accumulated after each round. This accumulated score will use to determine when the game will finish.

#### **Determine when game will finish(1hr)**
When one user reach 66 or more cattle heads, game will finish. User with least cattle heads wins.

#### **Display winner(30mins)**
Display who wins after each round and final winner at the end of the game.

#### **Checkout rules and exit game options on all option lists(30mins)**
Player should able to check rules and exit game at any stage of the game

#### **Methods that are needed:**
<li>If played card is only larger than one of the last card, played card will be added after that card.</li> 
<li>If played card is larger than more than one last card, played card will be added to the closest card.</li>
<li>If played card is smaller than all last cards, whoever played the card can choose a row to place. All existing cards will move and store to player_collected_cards array / npc_collected_cards array respectively. And the selected card will become the first card of that row.</li>
<li>Pop the played card from player_cards and npc_cards array after each turn.</li>
<li>Get the answer from player can push card to the end of that row</li>
<li>When a new card about to add to a row, system will check the length of that row, if it's less than 5, card will add to the end of that row. If not, those 5 cards will remove from the row and add to player's/npc's collected_cards pile depend who place the 6th card. Then the 6th will add to that row.</li>
<>Print out played card of both player after each round<li>
<li>Get the sum of collected_cards pile of each user, update and display it on each turn.</li>
</li>After each round, system will store the total score each user has in player_score and NPC_score respectively, clear the collected_cards pile and start a new round.
<li>After each round, system will get the sum of player_score and NPC_score. When one user reaches 66 or more cattle heads, game will finish.</li>
<li>Compare player_score and NPC_score, user will least cattle heads win.</li>
<li>Print out final result and annonce who is winner.</li>

## Medium Priority

### **Scoreboard**

#### **Add winner data to scoreboard(30mins)**
Store winner's name and score to a csv file. 

#### **Display names and scores of each winner(30mins)**
When player checkout the scoreboard, they can see each winner's name and score.

#### **Methods that are needed:**
<li>Open a csv when the game is finished, push winner's name and score to a csv file.</li>
<li>Iterate a csv file to print out each row of data</li>

## Trello board

https://trello.com/b/9B8uQP3L/rhona-lam-t1a3

![Preview](docs/trello_board_1.png)
![Preview](docs/trello_board_2.png)

# Help documentation

## To install the application

1. Download the folder "TanNaLam_T1A3_6Nimmt-main.zip" and unzip.

## To play the game

2. Use command line to change directory into src folder.
```
cd (path to src folder)
Example:
cd Downloads/TanNaLam_T1A3_6Nimmt-main/src
```
3. Once you are in the src folder, use command line to run the script file.
```
./run_game.sh
```
4. This script file will download and install all dependencies that are needed for this game. 
5. After all dependencies are installed, this script file will prompt you to choose a option and input your name. 
```
Hello! Welcome to the 6 Nimmt!
 
This is a fun, interesting card game and I hope you will enjoy it 😊
 
Ready to play? Type in 'Start' to start the game, 'Rules' to checkout the rules, 'Scoreboard' to checkout the scoreboard. Easy! 
```
Name can only contains letters and numbers.
```
Awesome! What is your name?
```

# Dependencies

### **<li>Tty-prompt</li>**
GitHub link: https://github.com/piotrmurach/tty-prompt#ttyprompt- 
<br>
Version needed: ~> 0.23.1

### **<li>Tty-box</li>**
GitHub link: https://github.com/piotrmurach/tty-box 
<br>
Version needed ~> 0.7.0

### **<li>Rainbow</li>**
GitHub link: https://github.com/sickill/rainbow
<br>
Version needed ~> 3.0

### **<li>Artii</li>**
GitHub link: https://github.com/miketierney/artii
<br>
Version needed ~> 2.1

# Tests
I am using TestUnit for this application.

To run all the tests, please ensure you are in the src directory and run the following in the terminal:
```
$ ruby test/unit_test.rb
```

## NPC function tests
- **test_check_if_nil_method**
<br>
Tests that when NPC select a card base on probability, if the selected card's value is nil, system will select the previous card instead.

- **test_npc_choose_init_row_method**
<br>
Tests that when NPC selects a card that is smaller than all last cards out there, the card will place on a row that has the least cattle heads

## Player function test
-- **test_print_player_cards**
<br>
Tests that all player cards are printed out in the right order and format.

## Result test
-- **test_check_66_method**
<br>
Tests that game will finish when one user(player or npc) reaches 66 or more cattle heads.

## Scoreboard test
- **test_check_add_to_csv_method**
Tests that if winner's data has been added to csv file successfully.

# References
UltraBoardGames (n.d.) 6 nimmt! Game Rules. Retrieved from https://www.ultraboardgames.com/6-nimmt/game-rules.php

Wikipedia (n.d.) 6 Nimmt!. Retrieved from https://en.wikipedia.org/wiki/6_Nimmt! 
