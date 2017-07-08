#!/usr/bin/env ruby

# File: ai.rb

require_relative 'board'
require_relative 'game_tree'

class AI
	attr_reader :mark 

	def initialize(mark, opponent, board)
		@root = Node.new(board)
		@board = board
		@mark = mark
		@player = opponent
	end


	def move(board)
		return minimax(@board, self)[1]
	end

	def minimax(game=@board, player)
		possible_moves = game.get_available_positions
		
		best_move = -1;
		best_score = (player == self) ? -10000 : 10000

		if possible_moves == []
			return [score(game), best_move]
		
		else
			possible_moves.each do |move|
				
				possible_board = game.clone()
				possible_board.place_mark(player.mark, move)

				if player == self 		# ai is the maximizing player
					score = minimax(possible_board, @player)[0]
					
					best_score = [score, best_score].max
					best_move = move

				else									# opponent is the minimizing player
					score = minimax(possible_board, self)[0]
					
					best_score = [score, best_score].min
					best_move = move

				end
			end
		end

		return [best_score, best_move]
	end
	
	def score(board)
		score = 0

		for i in (0..2) do
			score += evaluate_line(board.get_row(i))
			score += evaluate_line(board.get_column(i))
		end

		score += evaluate_line(board.get_diagonal_1_to_9)
		score += evaluate_line(board.get_diagonal_3_to_7)

		return score
	end

	def evaluate_line(line)
		score = 0
		
		# first cell in a line
		if line[0] == self.mark
			score = 1
		elsif line[0] == @player.mark
			score = -1
		end

		# second cell in a line
		if line[1] == self.mark
			if score == 1
				score = 10
			elsif score == -1
				return 0
			else
				score = 1
			end
		
		elsif line[1] == @player.mark
			if score == -1
				score = -10
			elsif score == 1
				return 0
			else
				score = -1
			end
		end

		# third cell in a line
		if line[2] == self.mark
			if score > 0
				score *= 10
			elsif score < 0
				return 0
			else
				score = 1
			end

		elsif line[2] == @player.mark
			if score < 0
				score *= 10
			elsif score > 0
				return 0
			else
				score = -1
			end
		end

		return score
	end
	
	# Method to construct whole game tree given a stating node
	# deprecated due to requiring ~15mins to build whole tree
	def construct_game_tree(node=@root, turn_order)

		if turn_order
			mark = @player.mark
		else
			mark = @mark
		end

		board = node.value

		available_moves = board.get_available_positions

		available_moves.each do |position|
			copy = board.clone()
			copy.place_mark(mark, position)
			node.add_child(copy)
		end

		node.children.each do |child|
			construct_game_tree(child, !turn_order)
		end
		
	end
end
