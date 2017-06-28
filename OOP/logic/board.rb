#!/usr/bin/env ruby

# File: board.rb

class Board
	
	def initialize
		@board = Array.new(3) { Array.new(3, " ") }
	end

	def reset
		@board = Array.new(3) { Array.new(3, " ") }
	end

	def inside_board?(x, y)
		return (0..2) === x and (0..2) === y
	end

	def is_empty?(x, y)
		return @board[x][y] == " "
	end

	def is_valid?(x, y)
		return valid_move? and is_empty?(x, y)
	end

	def place_mark(mark, x, y)
		if is_valid?(x, y)
			@board[x][y] = mark
		end
	end
		
	def print_board
		(0..2).each do |row|
			(0..2).each do |column|
				print @board[row][column]
				print " | " unless column == 2
			end
			
			print "\n---------\n" unless row == 2
		end
		print "\n"
	end
		
end
