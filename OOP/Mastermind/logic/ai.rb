#!/usr/bin/env ruby 

# File: ai.rb

require_relative 'code'

class AI
		
		def initialize()
			@guess = nil
			@guesses_made = false
			@mastermind_response = nil
		end
		
		# implementation of Knuth's mastermind algorithm
		def guess
			
			if !@guesses_made
				@guesses_made = true
				@guess = '1122'

			else

			end
				
			return @guess
		end

		def generate_code_set
			@code_set = []
			i = 0
			n = 1296
			code = Code.new(1111)

			while i < n do
				@code_set.push(code.number)
				code.increment
				i += 1
			end

			return @code_set.length
		end

		def update_code_set
			number_correct = @mastermind_response[1]
			number_misplaced = @mastermind_response[2]

			@code_set.delete_if do |code|
				
				response = evaluate_guess(@guess, code)

				if (response[0] != number_correct) || (response[1] != number_misplaced)
					true
				end
			end

			return @code_set.length
		end

		def update_response(response_array)
			@mastermind_response = response_array
		end

		def evaluate_guess(guess, code)
			guess = guess.split('')
			guess.map! {|num| num.to_i}
			code = code.split('')
			code.map! {|num| num.to_i}

			unmatched_code = []
			unmatched_guess = []
			correct = 0
			misplaced = 0

			code.zip(guess).each do |code, guess|

				if code == guess
					correct += 1
				else
					unmatched_code.push(code)
					unmatched_guess.push(guess)
				end
			end

			unmatched_guess.each do |guess|
				if unmatched_code.include?(guess)
					misplaced += 1
					unmatched_code.delete_at(unmatched_code.index(guess))
				end
			end

			return [correct, misplaced]
		end
end
