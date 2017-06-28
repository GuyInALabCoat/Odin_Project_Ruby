#!/usr/bin/env ruby

# File: tc_board.rb

require_relative "../logic/board"
require "test/unit"

class TestBoard < Test::Unit::TestCase

	def setup
		@board = Board.new
	end

	def test_place_mark
		@board.place_mark("X", 2, 2)
		
		assert_equal(@board.get_row(2)[2], "X")

		assert_not_equal(@board.get_row(2)[1], "O")
		
		assert_nothing_raised RuntimeError do
			@board.place_mark("X", 5, 5)
		end
	end

	def test_get_column
		@board.place_mark("X", 1, 1)

		assert_equal([" ", "X", " "], @board.get_column(1))

		assert_nothing_raised Exception do
			@board.get_column(4)
		end
	end

	def test_get_row
		@board.place_mark("O", 0, 2)

		assert_equal([" ", " ", "O"], @board.get_row(0))

		assert_nothing_raised Exception do
			@board.get_row(5)
		end
	end

end	
