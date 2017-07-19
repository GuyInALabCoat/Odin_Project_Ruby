#!/usr/bin/env ruby 

# File: mastermind.rb

class Mastermind
	
	def initialize
	end

	def generate_code
		@code = []
		4.times do
			@code.push(rand(1..6))
		end
	end

	def guess(guess)
		guess = guess.split('')
		guess.map! {|num| num.to_i}

		return compare_codes?(guess)
	end

	def set_code(code)
		@code = code.split('')
		@code.map! {|num| num.to_i}
	end

	private 
		
		# returns an array containing a boolean whether the full guess is correct
		# and and the number of correct and misplaced digits
		def compare_codes?(guess)
			unmatched_code = []
			unmatched_guess = []
			correct = 0
			misplaced = 0
			
			# check correct in number and location
			@code.zip(guess).each do |code, guess|

				if code == guess
					correct += 1
				else
					unmatched_code.push(code)
					unmatched_guess.push(guess)
				end
			end

			# check misplaced numbers in guess
			unmatched_guess.each do |guess|
				if unmatched_code.include?(guess)
					misplaced += 1
					unmatched_code.delete_at(unmatched_code.index(guess))
				end
			end

			return [correct == @code.length, correct, misplaced]
		end
end
