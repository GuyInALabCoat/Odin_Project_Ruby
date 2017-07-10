#!/usr/bin/env ruby

# File: tc_ai.rb

require_relative '../logic/board'
require_relative '../logic/player'
require_relative '../logic/ai'
require 'test/unit'
require 'pry'

class TestAI < Test::Unit::TestCase
	
	def setup
		@board = Board.new
		@player = Player.new('tmp', 'O')
		@ai = AI.new('X', @player, @board)
	end

	def test_move
		#binding.pry
		assert_equal(9, @ai.move(@board))
	end


	def test_score
		@board.place_mark(@ai.mark, 5)
		@board.place_mark(@player.mark, 7)
		@board.place_mark(@ai.mark, 8)
		@board.place_mark(@ai.mark, 2)

		assert_equal(10, @ai.score(@board, 0))
		assert_not_equal(-10, @ai.score(@board, 0))
	end

	def test_score_special_case
		@board.place_mark(@ai.mark, 1)
		@board.place_mark(@player.mark, 2)
		@board.place_mark(@ai.mark, 3)
		@board.place_mark(@player.mark, 4)
		@board.place_mark(@ai.mark, 5)
		@board.place_mark(@ai.mark, 6)
		@board.place_mark(@player.mark, 7)
		@board.place_mark(@ai.mark, 8)
		@board.place_mark(@player.mark, 9)

		assert_equal(0, @ai.score(@board, 0))
	end
end
