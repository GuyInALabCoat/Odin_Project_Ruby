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
		win_flag = false
		@mastermind.generate_code

		while @turns > 0
			puts "Enter your 4 digit guess, from 1 to 6"

			guess = gets.chomp
	
			if guess.length != 4 || guess !~ /[1-6]{4}/
				puts "Your guess must be four digits long and only contain"
				puts "numbers from 1 to 6. Try again." 
			
			elsif @mastermind.guess(guess)
				win_flag = true
				break

			else
				@turns -= 1
				puts "#{@turns} guesses remaining"
			end
		end

		if win_flag
			game_won
		else
			game_lost
		end
	end

	private
		
		def game_won
			puts "Congratulations, you won!"
			play_again
		end

		def game_lost
			puts "Sorry, you were unable to break the code."
			play_again
		end

		def play_again
			puts "Care to play again? [yes | no]"

			answer = gets.chomp.downcase

			if answer == "yes"
				@turns = 12
				self.run
			else
				exit
			end
		end
end
Main.new
