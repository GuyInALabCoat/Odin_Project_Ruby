#!/usr/bin/env ruby

# File: board.rb

class Board
	
	def initialize()
		@board = Array.new(3) { Array.new(3, " ") }
	end
	
	def reset
		@board = Array.new(3) { Array.new(3, " ") }
	end

	def place_mark(mark, position)
		x = ((position - 0.1) / 3).truncate
		y = (position - 1) % 3

		if is_valid?(x, y)
			@board[x][y] = mark
			return true
		else
			return false
		end
	end
		
	def print_board
		print "\n"
		(0..2).each do |row|
			(0..2).each do |column|
				print @board[row][column]
				print " | " unless column == 2
			end
			
			print "\n---------\n" unless row == 2
		end
		print "\n\n"
	end
		
	def get_column(column_index)

		if inside_board?(0, column_index)
			column = []
			(0..2).each {|row| column.push(@board[row][column_index])}
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
	
	def is_valid?(x, y)
		return inside_board?(x, y) && is_empty?(x, y)
	end

	def winning_condition?(player)
		
		# get board rows, columns and diagonals and check whether any of them
		# satisfy the winning conditions of the game for the given player

		board_axis = []
		board_axis.push(self.get_diagonal_1_to_9)
		board_axis.push(self.get_diagonal_3_to_7)

		for i in (0..2) do
			board_axis.push(self.get_column(i))
			board_axis.push(self.get_row(i))
		end

		return board_axis.any? do |axis| 
			axis == [player.mark, player.mark, player.mark]
		end
	end

	def ==(other_board)
		return @board[0] == other_board.get_row(0) && \
					 @board[1] == other_board.get_row(1) && \
					 @board[2] == other_board.get_row(2)
	end

	def eql?(other)
		self == other
	end

	def hash
		hash_value = 0
		@board.each {|array| hash_value += array.hash}
		return hash_value
	end

	def clone
		copy = Board.new()
		
		for i in (0..9) do
			x = ((i - 0.1) / 3).truncate
			y = (i - 1) % 3

			copy.place_mark(@board[x][y], i)
		end

		return copy
	end

	def get_available_positions
		positions = []
		for i in (1..9) do
			x = ((i - 0.1) / 3).truncate
			y = (i - 1) % 3
			if is_valid?(x, y)
				positions.push(i)
			end
		end
		
		return positions
	end

	private
		
		def inside_board?(x, y)
			return (0..2) === x && (0..2) === y
		end

		def is_empty?(x, y)
			return @board[x][y] == " "
		end

end
