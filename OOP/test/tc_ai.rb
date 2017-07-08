#!/usr/bin/env ruby

# File: tc_ai.rb

require_relative '../logic/board'
require_relative '../logic/player'
require_relative '../logic/ai'
require 'test/unit'

class TestAI < Test::Unit::TestCase
	
	def setup
		@board = Board.new
		@player = Player.new('tmp', 'O')
		@ai = AI.new('X', @player, @board)
	end

	def test_move
		assert_equal(5, @ai.move(@board)[1])
	end

	def test_evaluate_line
		assert_equal(0, @ai.evaluate_line([' ', ' ', ' ']))
		assert_equal(1, @ai.evaluate_line(['X', ' ', ' ']))
		assert_equal(1, @ai.evaluate_line([' ', ' ', 'X']))
		assert_equal(10, @ai.evaluate_line([' ', 'X', 'X']))
		assert_equal(100, @ai.evaluate_line(['X', 'X', 'X']))
		assert_equal(-1, @ai.evaluate_line([' ', 'O', ' ']))
		assert_equal(-10, @ai.evaluate_line(['O', 'O', ' ']))
		assert_equal(-100, @ai.evaluate_line(['O', 'O', 'O']))
		assert_equal(0, @ai.evaluate_line(['X', ' ', 'O']))
		assert_equal(0, @ai.evaluate_line(['X', 'O', 'X']))
		assert_equal(0, @ai.evaluate_line([' ', 'O', 'X']))
	end

	def test_score
		@board.place_mark(@ai.mark, 5)
		@board.place_mark(@player.mark, 7)
		@board.place_mark(@ai.mark, 8)

		assert_equal(11, @ai.score(@board))
	end
end
