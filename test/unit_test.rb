require 'test/unit'
require_relative '../classes/game_setup'
require_relative '../classes/users'
require_relative '../classes/npc'

class Game_setupTest < Test::Unit::TestCase 
    def test_deck_exist
        assert_path_exist('deck.json')
    end

    def test_init_exist
        assert_path_exist('init_cards.json')
    end

    def test_npc_exist
        assert_path_exist('npc_cards.json')
    end

    def test_player_exist
        assert_path_exist('player_cards.json')
    end
end

class NpcTest < Test::Unit::TestCase 
    def test_check_if_nil_method
        npc = NPC.new
        assert_equal(89, npc.check_if_nil([{:init_card=>79, :npc_card=>2, :diff=>-77}, {:init_card=>79, :npc_card=>91, :diff=>12}, {:init_card=>66, :npc_card=>89, :diff=>23}], 3))
        assert_equal(2, npc.check_if_nil([{:init_card=>79, :npc_card=>2, :diff=>-77}, nil, nil], 2))
    end
end

class UsersTest < Test::Unit::TestCase 
    def test_check_add_to_csv_method
        require 'csv'
        expected_result = ["player", "10"]
        users = Users.new
        users.add_to_csv('test/test_scores.csv', 'player', 10)
        assert_equal(expected_result, CSV.parse(csv_file).last)
    end

    def csv_file
        File.read('test/test_scores.csv') 
    end
    
    def test_check_66_method
        require 'rainbow'
        require 'csv'
        users = Users.new
        game_status = users.check_66([20, 15, 17], [5, 10, 3, 8], game_status, 'Player')
        assert_equal(true, game_status)
        game_status = users.check_66([20, 15, 17], [5, 10, 3, 8, 10, 15, 11], game_status, 'NPC')
        assert_equal(true, game_status)
    end

    def test_npc_choose_init_row_method 
        users = Users.new
        assert_equal(0, users.npc_choose_init_row([{"init1":[{"num":3,"head":1}]},{"init2":[{"num":22,"head":5}, {"num":33,"head":5}]},{"init3":[{"num":27,"head":1}]},{"init4":[{"num":81,"head":1}]}]))
        assert_equal(2, users.npc_choose_init_row([{"init1":[{"num":3,"head":1}, {"num":29,"head":1}]},{"init2":[{"num":22,"head":5}]},{"init3":[{"num":27,"head":1}]},{"init4":[{"num":99,"head":5}]}]))
    end
end

