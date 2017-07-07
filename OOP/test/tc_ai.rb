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
		assert_equal(0, @ai.move(@board)[1])
	end
end
