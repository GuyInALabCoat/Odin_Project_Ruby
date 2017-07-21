#!/usr/bin/env ruby

# File: main.rb

require_relative 'mastermind'
require_relative 'ai'

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
			computer_guesses
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
				if valid_code(user_input)
					@mastermind.set_code(user_input)
					break
				else
					puts "Please enter a 4-digit code using the numbers 1-6"
				end
			end
		end

		def valid_code(input)
			return input =~ /[1-6]{4}/
		end

		def player_guesses
			win_flag = false

			while @turns > 0
				puts "Enter your 4 digit guess, from 1 to 6"

				guess = gets.chomp
	
				if !valid_code(guess)
					puts "Your guess must be four digits long and only contain"
					puts "numbers from 1 to 6. Try again." 
				
				else
					# Array: [0] = bool guess correct?, [1] # correct, [2] # misplaced
					response = @mastermind.guess(guess)

					if response[0]
						win_flag = true
						break

					else
						@turns -= 1
						puts "#{response[1]} digits are correct"
						puts "#{response[2]} digits are misplaced"
						puts "#{@turns} guesses remaining"
					end
				end
			end

			check_win(win_flag)
		end

		def computer_guesses
			ai = AI.new
			win_flag = false

			while @turns > 0
				response = @mastermind.guess(ai.guess)

				if response[0]
					win_flag = true
					break

				else
					@turns -= 1
					ai.update_response(response)
					puts "#{@turns} turns remaining"
				end
			end
			check_win(win_flag, true)
		end

		def check_win(flag, computer=false)
			if flag && !computer
				game_won
			elsif flag && computer
				game_won_computer
			elsif !flag && computer
				game_lost_computer
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

		def game_won_computer
			puts "The computer has guessed your code."
			play_again
		end

		def game_lost_computer
			puts "Wow, your code was so great that even a computer wasn't able to
			break it!"
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
