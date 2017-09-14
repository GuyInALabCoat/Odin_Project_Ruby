#!/usr/bin/ruby

require 'set'

class Hangman
	attr_reader :secret_word

	def initialize
		# select random word from dictionary
		@secret_word = select_word(read_file).split('')

		# initialize array of equal length to secret word.
		# This will be shown to the user
		@guessed_word = Array.new(@secret_word.length, '_')

		# create empty set of used letters
		@used_letters = Set.new()

		self.play
	end

	def read_file
		filepath = File.expand_path('../../dic/5desk.txt', __FILE__)
		File.readlines(filepath).map(&:chomp).map(&:downcase)
	end

	def select_word(array)
		array.select{ |word| word.length >= 5 && word.length <= 12 }.sample
	end

	def play
		number_incorrect_guesses = 0

		while number_incorrect_guesses < 6 && @guessed_word.include?('_') do
			puts "Secret word: #{@guessed_word.join(' ')}"
			puts "Number of chances remaining #{6 - number_incorrect_guesses}"
			puts "Letters already used #{@used_letters.to_a.join(', ')}"

			guess = get_user_input

			if !@used_letters.include?(guess) && @secret_word.include?(guess)
				update_public_code(guess)
			else
				@used_letters.add(guess)
				number_incorrect_guesses += 1
			end
		end
	end

	def update_public_code(letter)
		@used_letters.add(letter)

		@secret_word.each_with_index do |secret_letter, index|
			
			if secret_letter == letter
				@guessed_word[index] = letter 	
			end

		end
	end

	def get_user_input
		puts "Please guess a lowercase letter"
		
		while user_input = gets.chomp
			if user_input =~ /[^a-z]/
				puts "Please enter a single lowercase letter only"
			
			elsif @used_letters.include?(user_input)
				puts "This letter has already been guessed before"

			else
				break
			end

		end

		return user_input
	end
end

game = Hangman.new
