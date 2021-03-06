#!/usr/bin/env ruby

# File: ui.rb

# class handles some of the console ui features of tic tac toe and 
# gets user input necessary to setup the game

class UI

	def initialize()
		intro()
	end

	def get_name()
			puts "Please enter your name: "
			name = gets.chomp
	end

	def get_mark(name)
		print "\n"
		puts "#{name}, you can choose to use either an X or an O during"
		puts "this game. Whichever mark you do not choose, will be" 
		puts "assigned to your opponent. Input your chosen mark: "

		while true
			input = gets.chomp.upcase

			if input == 'X' || input == 'O'
				break
			else
				puts "Please enter either an X or an O. "
			end
		end

		return input
	end


	private

		def intro
			rules()
		end
		
		def rules()
			puts "               Tic Tac Toe"
			puts "Tic-tac-toe is a game for two players where each player" 
			puts "takes turns placing either an X (echs) or O (oh) on a 3x3"
			puts "grid. The game is won when one player succeeds in placing"
			puts "three consecutive marks on a horizontal, vertical or"
			puts "diagonal line."
		end
end
