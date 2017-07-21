#!/usr/bin/env ruby 

# File: ai.rb

require_relative 'code'
require 'pry'

class AI
		
		def initialize()
			@guess = nil
			@guesses_made = false
			@mastermind_response = nil
			self.generate_code_set
		end
		
		# implementation of Knuth's mastermind algorithm
		def guess
			
			if !@guesses_made
				@guesses_made = true
				@guess = '1122'
				@set_S.delete('1122')
				puts "The second guess may take some time. Please be patient."

			elsif @set_S.length() == 1
				@guess = @set_S[0]
			
			else
				self.reduce_code_set
				@guess = self.code_set_minimax
				@set_S.delete(@guess)

			end
				
			puts "Computer guesses #{@guess}"
			return @guess
		end

		def code_set_minimax
			possible_responses = [[0,0], [0,1], [0,2], [0,3], [0,4], [1,0], \
														[1,1], [1,2], [1,3], [2,0], [2,1], [2,2], \
														[3,0], [4,0]]
			minimum = 10**100
			best_combination = nil

			@all_possible_combinations.each do |guess|
				maximum = 0

				possible_responses.each do |response|
					count = 0

					@set_S.each do |code|
						
						if response == self.evaluate_guess(guess, code)
							count += 1
						end
					end

					if count > maximum
						maximum = count
					end

				end

				if maximum < minimum
					minimum = maximum
					best_combination = guess
				end
			end

			return best_combination
		end

		def generate_code_set
			@set_S = []
			@all_possible_combinations = []
			i = 0
			n = 1296
			code = Code.new(1111)

			while i < n do
				@set_S.push(code.number)
				@all_possible_combinations.push(code.number)
				code.increment
				i += 1
			end

			return @set_S.length
		end

		def reduce_code_set
			number_correct = @mastermind_response[1]
			number_misplaced = @mastermind_response[2]

			@set_S.delete_if do |code|
				
				response = evaluate_guess(@guess, code)

				if (response[0] != number_correct) || (response[1] != number_misplaced)
					true
				end
			end

			return @set_S.length
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
