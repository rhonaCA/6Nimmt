# 6 Nimmt!

# About
6 Nimmt! /Take 6! is a card game for 2 - 10 players designed by Wolfgang Kramer in 1994. Suitable for 8 years or up, playing time can be vary, around 15 to 45 minutes depends on the numbers of player. This game is easy to play but can be quite challenging to win.

This game has 104 cards, each contains a number and 1 to 7 cattle heads icons that represent penalty points. Each round has 10 turns, each turn all players place one card of their choice out. The placed cards are placed on one of four rows according to the fixed rules. If the card needs to be placed onto a row that already has five cards which classified as a full row according to the rules. Then the player who place that card needs to collect those five cards, which count as penalty points that are totalled up at the end of each round. Game will continue until a player collects 66 cattle heads or more, the player with the least cattle heads wins the game.

# How to play

### **Goal of the game**
Try not to get any cards as it will add up the penalty points.


### **Gameplay**
Hi player, you are playing with 1 NPC in this game. Both of you will have 10 cards to start with each round. You will see 4 initial cards placed vertically on the screen and your own cards that have been arranged in ascending order. 

At each turn, you can select a card to play by using ↑ / ↓ keys. After you selected a card, depending on whose card is smaller (you or NPC), that player will put their card at the end of one of the 4 rows first based on below rules:

### **Rule No. 1: Ascending Order**

The number of the card that is added to a row must be higher than the number of the current last card in that row.

#### **Example:**
Player selects ```Card 12``` to play, as that card is only higher than ```Card 7``` so ```Card 12``` will be placed after ```Card 7```.

```diff
Card 102: 1 🐮
 
Card 103: 1 🐮
 
+ Card 7: 1 🐮
 
Card 91: 1 🐮
```

### **- Rule No. 2: Small Difference**

A card must always be added to the row with the smallest possible difference between the current last card and the new one.

#### **Example:**
Player selects ```Card 92``` to play. Although that card is higher than both ```Card 49``` and ```Card 88```, it will be placed after ```Card 88``` as it is the closest one.
```diff
Card 23: 1 🐮 | Card 49: 1 🐮
 
Card 103: 1 🐮
 
+ Card 7: 1 🐮 | Card 12: 1 🐮 | Card 88: 5 🐮
 
Card 91: 1 🐮
 
```

### **- Rule No. 3: Full Row**

A row with 5 cards in it means the row is full. If Rule No. 2 would put a sixth card in such a row, the player who played that card must take all five cards of the full row. Their card then becomes the first in the new row.

#### **Example:**
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
However this row already has 5 existing cards, that means the row is full. Player will collect all 5 cards `(Card 17, Card 23, Card 28, Card 32 and Card 89)` and keep them in the collected cards pile, separtely from the cards in hands. And the cattle heads will be added up and display on screen(which you can below in red). `Card 90` will become the first card of that row.
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


#### **Example:**
Player selects ```Card 2``` to play. As it is smaller than all last cards out there, player can select a row to place the card. In this example, player choose `row 2` as it has the least cattle heads on that row. 
```diff
 
Card 43: 1 🐮  | Card 55: 7 🐮
 
+ Card 13: 1 🐮 
 
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
Existing card on that row will be added to player collected cards pile and you will see the cattle heads has been updated on the screen.
```diff
 
--- After player place the selected card:

Card 43: 1 🐮  | Card 55: 7 🐮
 
+ Card 2: 1 🐮 
 
Card 45: 2 🐮 | Card 87: 1 🐮
 
Card 97: 1 🐮 | Card 99: 5 🐮
 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  
- Rhona has 1 🐮
 
NPC has 0 🐮

```

At the end of each turn, you will need to select a new card to play, this is repeated for 10 turns until all the cards in your hand are played.


### **When the game ends?**
After 10 turns, the game will count the cattle heads on the cards gathered during the round, keep score of each player and a new hand will start.

The game will end when you or NPC collect a total of 66 or more cattle heads. Whoever has collected the fewest cattle heads is the winner!

Winner’s name and score will be kept in the scoreboard.

### **Ready to play?**
<br>

# To install the application

1. Download the folder "TanNaLam_T1A3_6Nimmt-main.zip" and unzip.

# To play the game

2. Use command line to change directory into that unzip folder.
```
cd (path to src folder)
Example:
cd Downloads/TanNaLam_T1A3_6Nimmt-main/
```
3. Once you are in the folder, use command line to run the script file.
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
This game is developed in Ruby and requires Ruby installed to run. Please check out [here](https://www.ruby-lang.org/en/downloads/) to find instructions to download and install Ruby for your operating system.

Below are the dependencies required by running the game. All of them will be downloaded and installed for you when you run the game in script file.

**- Tty-prompt** ~> 0.23.1
<br>
<br>
**- Tty-box** ~> 0.7.0
<br>
<br>
**- Rainbow** ~> 3.0
<br>
<br>
**- Artii** ~> 2.1
<br>
<br>
**- TestUnit** - For unit tests.

# System/ hardware requirement
Please ensure your terminal's size is at minimum `110x45` to have a better user experience.

This game is using `tty-prompt` for player to select their choices. Although this gem does working on Windows, the `select` feature may not work on Window when run from Git Bash. If you have any issues when playing this game, please see [here](https://github.com/piotrmurach/tty-prompt#windows-support) for more details and fixes. 

This game is built on a M1 Apple Macbooks so any M1 users should be able to run it without any problem.

## Enjoy! ☺️