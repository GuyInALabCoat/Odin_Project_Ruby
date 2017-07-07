#!/usr/bin/env ruby

# File: game_node.ruby

require_relative 'board'

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
