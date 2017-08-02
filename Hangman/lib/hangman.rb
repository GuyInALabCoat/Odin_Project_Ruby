#!/usr/bin/ruby

class Hangman
	attr_reader :secret_word

	def initialize
		@secret_word = select_word(read_file)
	end

	def read_file
		filepath = File.expand_path('../../dic/5desk.txt', __FILE__)
		File.readlines(filepath).map(&:chomp).map(&:downcase)
	end

	def select_word(array)
		array.select{ |word| word.length >= 5 && word.length <= 12 }.sample
	end
end

game = Hangman.new
puts game.secret_word

