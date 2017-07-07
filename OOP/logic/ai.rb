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
		return minimax(@board, self, -1000000, 1000000)[1]
	end

	def minimax(game=@board, player, alpha, beta)
		possible_moves = game.get_available_positions
		
		best_move = -1;

		if possible_moves == []
			return [score(game), best_move]
		
		else
			possible_moves.each do |move|
				
				possible_board = game.clone()
				possible_board.place_mark(player.mark, move)

				if player == self 		# ai is the maximizing player
					score = minimax(possible_board, @player, alpha, beta)[0]
					
					if score > alpha 
						alpha = score
						best_move = move
					end

				else									# opponent is the minimizing player
					score = minimax(possible_board, self, alpha, beta)[0]
					
					if score < beta
						beta = score
						best_move = move
					end
				end

				if alpha >= beta then break end
			end

			if player == self
				return [alpha, best_move]
			else
				return [beta, best_move]
			end
		end
	end
	
	private

	def score(board)
		
		if board.winning_condition?(self)
			return 10
		elsif board.winning_condition?(@player)
			return -10
		else
			return 0
		end

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
