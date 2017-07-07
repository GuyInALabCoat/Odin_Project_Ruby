#!/usr/bin/env ruby

# File: tc_board.rb

require_relative "../logic/board"
require_relative "../logic/player"
require "test/unit"

class TestBoard < Test::Unit::TestCase

	def setup
		@board = Board.new
	end

	def test_place_mark
		@board.place_mark("X", 9)
		
		assert_equal(@board.get_row(2)[2], "X")

		assert_not_equal(@board.get_row(2)[2], "O")
		
		assert_nothing_raised RuntimeError do
			@board.place_mark("X", 15)
		end
	end

	def test_get_column
		(1..9).each {|index| @board.place_mark("#{index}", index)}

		assert_equal(["1", "4", "7"], @board.get_column(0))
		assert_equal(["2", "5", "8"], @board.get_column(1))
		assert_equal(["3", "6", "9"], @board.get_column(2))

		assert_nothing_raised Exception do
			@board.get_column(4)
		end
	end

	def test_get_row
		(1..9).each {|index| @board.place_mark("#{index}", index)}

		assert_equal(["1", "2", "3"], @board.get_row(0))
		assert_equal(["4", "5", "6"], @board.get_row(1))
		assert_equal(["7", "8", "9"], @board.get_row(2))

		assert_nothing_raised Exception do
			@board.get_row(5)
		end
	end

	def test_reset
		@board.place_mark("X", 5)
		@board.reset()
		
		assert_equal([" ", " ", " "], @board.get_column(1))
	end

	def test_is_valid?
		assert_equal(true, @board.is_valid?(0, 1))
	end

	def test_winning_condition?
		player = Player.new('tmp', 'X')
		@board.place_mark(player.mark, 2)
		@board.place_mark(player.mark, 5)
		
		assert_not_equal(true, @board.winning_condition?(player))

		@board.place_mark(player.mark, 8)

		assert_equal(true, @board.winning_condition?(player))
	end

	def test_equality
		board2 = Board.new
		assert_equal(true, @board == board2)
		
		@board.place_mark('X', 4)

		assert_not_equal(true, @board == board2)

		board2.place_mark('X', 4)

		assert_equal(true, @board == board2)
	end

	def test_hash
		board2 = Board.new
		assert_equal(true, @board.hash == board2.hash)
	end

	def test_clone
		copy = @board.clone()

		assert_equal(true, copy == @board)

		@board.place_mark('X', 3)

		assert_not_equal(true, copy == @board)
	end

	def test_get_available_positions
		assert_equal((1..9).to_a, @board.get_available_positions)
		@board.place_mark('X', 9)
		assert_equal((1..8).to_a, @board.get_available_positions)
	end
end	
