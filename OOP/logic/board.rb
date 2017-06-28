#!/usr/bin/env ruby

# File: board.rb

class Board
	
	def initialize()
		@board = Array.new(3) { Array.new(3, " ") }
	end
	
	def reset
		@board = Array.new(3) { Array.new(3, " ") }
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
		
	def get_column(column_index)

		if inside_board?(0, column_index)
			column = []
			(0..2).each {|row| column.push(@board[column_index][row])}
			return column
		end
	end

	def get_row(row_index)
		if inside_board?(row_index, 0)
			return @board[row_index]
		end
	end

	def get_diagonal_1_to_9
		diagonal = []
		(0..2).each {|index| diagonal.push(@board[index][index])}
		return diagonal
	end
	
	def get_diagonal_3_to_7
		diagonal = []
		(0..2).each {|index| diagonal.push(@board[index][(2 - index)])}
		return diagonal
	end
	
	private
		
		def inside_board?(x, y)
			return (0..2) === x && (0..2) === y
		end

		def is_empty?(x, y)
			return @board[x][y] == " "
		end

		def is_valid?(x, y)
			return inside_board?(x, y) && is_empty?(x, y)
		end

end
