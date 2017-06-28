#!/usr/bin/env ruby

# File: player.rb

class Player

	def initialize(name)
		@name = name
		@streak = 0
	end

	def name
		return(@name)
	end

	def streak
		return(@streak)
	end

	def update_streak()
		@streak += 1
	end

end
