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
	puts "Would you like to create the code or guess it? [ create | guess ]"

		while user_input = gets.chomp.downcase
			if user_input == "create" || user_input == "guess"
				break
			else
				puts "Please enter either 'create' or 'guess'"
			end
		end

		if user_input == "create"
			player_sets_code
			computer_guess
		else
			@mastermind.generate_code
			player_guesses
		end
	end

	private

		def player_sets_code
			puts "Please enter a 4-digit code using any combinations of numbers"
			puts "between 1 and 6"

			while user_input = gets.chomp
				if user_input =~ /[1-6]{4}/
					@mastermind.set_code(user_input)
					break
				else
					puts "Please enter a 4-digit code using the numbers 1-6"
				end
			end
		end

		def player_guesses
			win_flag = false

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

			check_win(win_flag)
		end

		def computer_guesses
			win_flag = false

			while @turns > 0

				if @mastermind.guess(guess)
					win_flag = true
					break

				else
					@turns -= 1
				end
			end
			check_win(win_flag)
		end

		def check_win(flag)
			if flag
				game_won
			else
				game_lost
			end
		end

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
