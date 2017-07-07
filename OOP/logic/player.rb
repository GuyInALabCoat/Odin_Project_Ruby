#!/usr/bin/env ruby

# File: player.rb

class Player

	def initialize(name, mark)
		@name = name
		@streak = 0
		@mark = mark
	end

	def name
		return(@name)
	end

	def streak
		return(@streak)
	end

	def mark
		return(@mark)
	end

	def update_streak()
		@streak += 1
	end

end
