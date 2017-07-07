#!/usr/bin/env ruby

# File: tc_game_tree.rb

require_relative '../logic/game_tree'
require_relative '../logic/board'
require 'test/unit'

class TestGameTree < Test::Unit::TestCase

	def setup
		board = Board.new
		@root = Node.new(board)
	end

	def test_add_child
		assert_equal(0, @root.get_number_of_children)
		
		board2 = Board.new

		@root.add_child(board2)

		assert_equal(1, @root.get_number_of_children)
	end
end
