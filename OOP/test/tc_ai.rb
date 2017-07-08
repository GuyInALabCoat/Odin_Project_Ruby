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
		assert_equal(5, @ai.move(@board)[1])
	end


	def test_score
		@board.place_mark(@ai.mark, 5)
		@board.place_mark(@player.mark, 7)
		@board.place_mark(@ai.mark, 8)
		@board.place_mark(@ai.mark, 2)

		assert_equal(10, @ai.score(@board))
		assert_not_equal(-10, @ai.score(@board))
	end
end
