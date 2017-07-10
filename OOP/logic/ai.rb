#!/usr/bin/env ruby

# File: ai.rb

require_relative 'board'
require_relative 'game_tree'
require 'pry'

# implements an ai opponent for tic tac toe game

class AI
	attr_reader :mark 

	def initialize(mark, opponent, board)
		@root = Node.new(board)
		@board = board
		@mark = mark
		@player = opponent
	end

	# returns the best available move to maximize the outcome of a game
	def move(board)
		self.minimax(board, self, 0)
		return @choice
	end

	# returns a 2 item array where [0] is the best score for a given board
	#	and [1] is the best move to take
	def minimax(game, player, depth)
		if game.over?(self, @player)
			return self.score(game, depth)
		end
		
		depth += 1
		scores = []
		moves = []
		
		game.get_available_positions.each do |move|
			possible_game = game.clone()
			possible_game.place_mark(player.mark, move) # generate new game states
																									# based on available moves

			# alternate between the player and the ai as new board states are 
			# generated recursively

			next_player = (player == self) ? @player : self
			scores.push(self.minimax(possible_game, next_player, depth))
			moves.push(move)
		end

		if player == self 			# ai is the maximizing player
			
			max_score_index = scores.each_with_index.max[1]
			@choice = moves[max_score_index]
			return scores[max_score_index]

		else										# opponent is the minimizing player
			
			#binding.pry
			min_score_index = scores.each_with_index.min[1]
			@choice = moves[min_score_index]	
			return scores[min_score_index]
		end
	end

	def score(board, depth)
		if board.winning_condition?(self)
			return 10 - depth
		elsif board.winning_condition?(@player)
			return depth - 10
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
			self.construct_game_tree(child, !turn_order)
		end
		
	end
end
