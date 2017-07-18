#!/usr/bin/env ruby

# File: main.rb

require_relative 'mastermind'

class Main
	
	def initialize
		@mastermind = Mastermind.new
		@turns = 12
		self.run
	end

	def run
		@mastermind.generate_code

		while @turns > 0
			puts "Enter your 4 digit guess, from 1 to 6"

			guess = gets.chomp
	
			if guess.length != 4 || guess !~ /[1-6]{4}/
				puts "Your guess must be four digits long and only contain"
				puts "numbers from 1 to 6. Try again." 
			
			elsif @mastermind.guess(guess)
				break

			else
				@turns -= 1
				puts "#{@turns} guesses remaining"
			end
		end

		puts "Congradulations, you won!"
	end

	private
end
Main.new
