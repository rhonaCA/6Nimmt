require 'json'
require_relative 'users'

class NPC < Users


    # Helper method of - NPC picks a card
    # Push a random from each row to npc_will_choose_card arr
    def add_random_card(arr, arr2)
        arr << arr2.sample
    end

    # Helper method of - NPC picks a card to dispose
    # Card will be picked base on probability
    # 5% - Difference is netagive, 60% - Difference is between 1-20, 35% - Difference is over 20
    def get_num(arr)
        case rand(100) + 1
        when 1..5
            arr[0][:npc_card]
        when 6..65
            check_if_nil(arr,1)
        when 66..100
            check_if_nil(arr,2)
        end
    end

    # NPC picks a card to dispose
    def npc_card_dispose(npc_cards, init_cards)
        temp_npc = []

        npc_cards.each do |card|
            init_cards.each_with_index do |row, index|
                # Calculate difference between each npc_card to each init_card
                temp_npc.push(init_card: row.values[0].last[:num], npc_card: card[:num], diff: card[:num] - row.values[0].last[:num])
            end
        end

        negative_arr = []
        arr_1_20 = []
        arr_over_20 = []
        npc_will_choose_card = []

        # Iterate through array and categorize the cards
        temp_npc.each do |card|
            if card[:diff] < 0
                negative_arr << card
            elsif card[:diff] > 0 && card[:diff] <= 20
                arr_1_20 << card
            else
                arr_over_20 << card
            end
        end

        add_random_card(npc_will_choose_card, negative_arr)
        add_random_card(npc_will_choose_card, arr_1_20)
        add_random_card(npc_will_choose_card, arr_over_20)

        return get_num(npc_will_choose_card)
    end

    # Check if there is any nil value on npc_will_choose arr
    # npc_will_choose / index
    def check_if_nil(arr, num)
        if arr[num] == nil
            if arr[num-1] == nil
                arr[num-2][:npc_card]
            else
                arr[num-1][:npc_card]
            end
        else
            arr[num][:npc_card]
        end
    end
    
end