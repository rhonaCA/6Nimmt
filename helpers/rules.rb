def show_rules_page
        puts ' '
        a = Artii::Base.new :font => 'small'
        puts Rainbow(a.asciify('6 Nimmt! Rules')).bright.aqua
        puts ' '
        puts ' '
        puts Rainbow('SUMMARY').bright.lemonchiffon.underline
        puts ' '
        puts 'This game has 104 cards, each bearing a number and 1 to 7 cattle heads icons that represent penalty points. 
A round of 10 turns is played where all players place one card of their choice out. The placed cards are 
placed on one of four rows according to the fixed rules. If the card needs to be placed onto a row that 
already has five cards than the player who place that card collects those five cards, which count as 
penalty points that are totalled up at the end of each round. Game will continue until a player collects 
66 cattle heads or more, whereupon the player with the least cattle heads wins.'
        puts ' '
        puts ' '
        puts Rainbow('GOAL OF THE GAME').bright.lemonchiffon.underline
        puts ' '
        puts 'Try not to get any cards as it will add up the penalty points.'
        puts ' '
        puts ' '
        puts Rainbow('GAMEPLAY').bright.lemonchiffon.underline
        puts ' '
        puts 'Hi player, you are playing with 1 NPC in this game. Both of you will have 10 cards to start with each round. 
You will see 4 initial set up cards placed vertically on the screen and your own cards that have be arranged 
in ascending order.'
        puts ' '
        puts 'At each turn, you can select a card to play by using ↑ / ↓ keys. After you select a card, depend whose card 
is smaller (you or NPC), that player will first put their card at the end of one of the 4 rows base on 
below rules: '
        puts ' '
        puts ' '
        box = TTY::Box.frame(width: 80, height: 6, title: {top_left: " RULE NO. 1: Ascending Order "}) do 
    "
    The number of the card that is added to a row must be higher than the 
    number of the current last card in that row.
    "
        end
        print box
        puts ' '
        box = TTY::Box.frame(width: 80, height: 6, title: {top_left: " RULE NO. 2: Small Difference "}) do 
    "
    A card must always be added to the row with the smallest possible 
    difference between the current last card and the new one.
    "
        end
        print box
        puts ' '
        box = TTY::Box.frame(width: 80, height: 8, title: {top_left: " RULE NO. 3: Full Row "}) do 
    "
    A row with 5 cards in it means the row is full. If RULE NO. 2 would put 
    a sixth card in such a row, the player who played that card must take 
    all five cards of the full row. Their card then becomes the first in the 
    new row.
    "
        end
        print box
        puts ' '
        box = TTY::Box.frame(width: 80, height: 9, title: {top_left: " RULE NO. 4: Lowest Card "}) do 
    "
    If a player plays a card whose number is so low that it does not fit 
    into any row, they must pick up all cards of a row of their choice. 
    Their card then becomes the first card of the new row. # Usually 
    player will choose the row that will score them the fewest cattle 
    heads.
    "
        end
        print box
        puts ' '
        puts ' '
        puts 'At the end of each turn, you will need to select a new card to play, this is repeated for 10 turns until all 
the cards in your hand are played.'
        puts ' '
        puts ' '
        puts Rainbow('WHEN THE GAME ENDS?').bright.lemonchiffon.underline
        puts ' '
        puts 'After 10 turns, the game will count the cattle heads on the cards gathered during the round, keep score of 
each player and a new hand will start.'
        puts ' '
        puts 'The game will end when you or NPC collect a total of 66 or more cattle heads. Whoever has collected the 
fewest cattle heads is the winner!'
        puts ' '
        puts 'Winner’s name and score will be kept in the scoreboard so you can check out later.'
        puts ' '
        puts ' '
end

