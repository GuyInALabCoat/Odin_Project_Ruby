#!/usr/bin/env ruby

# File: game_node.ruby

require_relative 'board'

# implementation of an N-ary tree where each node is a game board state
# and each node may have 0 to many children

# The tree is implemented such that it may only be built up and read 
# from but not modified or changed in any way

class Node
	attr_reader :value
	attr_accessor :children

	def initialize(board, children=[])
		@value = board
		@children = children
	end

	def add_child(board)
		@children.push(Node.new(board))
	end

	def get_number_of_children()
		return @children.length
	end

end
