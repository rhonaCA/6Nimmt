require 'test/unit'
require_relative '../classes/game_setup'
require_relative '../classes/users'
require_relative '../classes/players'
require_relative '../classes/npc'

class NpcTest < Test::Unit::TestCase 
    def test_check_if_nil_method
        npc = NPC.new
        assert_equal(89, npc.check_if_nil([{:init_card=>79, :npc_card=>2, :diff=>-77}, {:init_card=>79, :npc_card=>91, :diff=>12}, {:init_card=>66, :npc_card=>89, :diff=>23}], 3))
        assert_equal(2, npc.check_if_nil([{:init_card=>79, :npc_card=>2, :diff=>-77}, nil, nil], 2))
    end

    def test_npc_choose_init_row_method 
        users = Users.new
        assert_equal(0, users.npc_choose_init_row([{"init1":[{"num":3,"head":1}]},{"init2":[{"num":22,"head":5}, {"num":33,"head":5}]},{"init3":[{"num":27,"head":1}]},{"init4":[{"num":81,"head":1}]}]))
        assert_equal(2, users.npc_choose_init_row([{"init1":[{"num":3,"head":1}, {"num":29,"head":1}]},{"init2":[{"num":22,"head":5}]},{"init3":[{"num":27,"head":1}]},{"init4":[{"num":99,"head":5}]}]))
    end
end

class ScoreboardTest < Test::Unit::TestCase 
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
end

class ResultTest < Test::Unit::TestCase 
    def test_check_66_method
        require 'rainbow'
        require 'csv'
        users = Users.new
        game_status = users.check_66([20, 15, 17], [5, 10, 3, 8], game_status, 'Player')
        assert_equal(true, game_status)
        game_status = users.check_66([20, 15, 17], [5, 10, 3, 8, 10, 15, 11], game_status, 'NPC')
        assert_equal(true, game_status)
    end
end

class UserTest < Test::Unit::TestCase 
    def test_print_player_cards
        players = Players.new
        expected_result = {"Card 3 - 1 🐮"=>"3", "Card 7 - 1 🐮"=>"7", "Card 34 - 1 🐮"=>"34", "Card 45 - 2 🐮"=>"45", "Card 49 - 1 🐮"=>"49", "Card 50 - 3 🐮"=>"50", "Card 61 - 1 🐮"=>"61", "Card 68 - 1 🐮"=>"68", "Card 86 - 1 🐮"=>"86", "Card 93 - 1 🐮"=>"93", "Check out the rules"=>0, "Exit game"=>-1}
        assert_equal(expected_result, players.print_player_cards([{"num":3,"head":1},{"num":7,"head":1},{"num":34,"head":1},{"num":45,"head":2},{"num":49,"head":1},{"num":50,"head":3},{"num":61,"head":1},{"num":68,"head":1},{"num":86,"head":1},{"num":93,"head":1}]))
        expected_result = {"Card 6 - 1 🐮"=>"6", "Card 38 - 1 🐮"=>"38", "Card 42 - 1 🐮"=>"42", "Card 51 - 1 🐮"=>"51", "Card 60 - 3 🐮"=>"60", "Card 64 - 1 🐮"=>"64", "Card 70 - 3 🐮"=>"70", "Card 72 - 1 🐮"=>"72", "Card 75 - 2 🐮"=>"75", "Card 82 - 1 🐮"=>"82", "Check out the rules"=>0, "Exit game"=>-1}
        assert_equal(expected_result, players.print_player_cards([{"num":6,"head":1},{"num":38,"head":1},{"num":42,"head":1},{"num":51,"head":1},{"num":60,"head":3},{"num":64,"head":1},{"num":70,"head":3},{"num":72,"head":1},{"num":75,"head":2},{"num":82,"head":1}]))
    end
end

