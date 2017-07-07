#!/usr/bin/env ruby

# File: tic_tac_toe.rb

require_relative 'player'
require_relative 'board'
require_relative 'ui'
require_relative 'player'
require_relative 'ai'

class TicTacToe
	
	def initialize()
		@board = Board.new
		@ui = UI.new
		game_setup()
	end

		# sets up the variables and instances needed for the game
		def game_setup
			puts "Would you like to play? [yes|no] "

			input = gets.chomp.downcase

			if input == "yes"
				name = @ui.get_name()
				mark = @ui.get_mark(name)

				@player = Player.new(name, mark)

				mark == 'X' ? @ai = AI.new('O', @player, @board) : @ai = AI.new('X',
				@player, @board)
	
				print "\n"
				puts "To play, you will need to input a number between 1 and 9 representing to locations on the grid with 1 being the top-left corner and 9 being the bottom right corner, decreasing from left to right\n"
	
				run()

			else
				puts "Have a nice day and come play next time."
				exit
			end
		end

		def run()
		
			@board.print_board

			turn_order = [true, false].sample	#randomly set turn order

			play(turn_order)
		end

		def play(turn_order)
			
			while true
				
				if turn_order
					if player_turn() then break end
					if ai_turn() then break end
					
				else
					if ai_turn() then break end
					if player_turn() then break end
				end

			end

			if @board.winning_condition?(@player)
				player_win
			elsif @board.winning_condition?(@ai)
				ai_win
			else
				tie
			end
		end

		def player_turn()
			puts "\nPlace your mark: "
			
			while true
				input = gets.chomp.to_i
				if valid_move?(@player, input)
					break
				else
					puts "That position is either already used or invalid"
					puts "Please enter a number between 1 and 9 "
				end
			end

			@board.print_board
			
			return check_end_status
		end

		def ai_turn()
			puts "AI turn".rjust(8)

			move = @ai.move(@board)

			@board.place_mark(@ai.mark, move)

			@board.print_board

			return check_end_status()
		end

		def check_end_status
			if @board.winning_condition?(@player) || @board.winning_condition?(@ai) ||
			@board.get_available_positions == []
				return true
			else
				return false
			end
		end

		def valid_move?(player, input)
			return @board.place_mark(player.mark, input)	
		end

		def player_win()
			puts "Congradulations, You won!"
			@player.update_streak()
			puts "Your current streak is #{@player.streak}"
			
			play_again()
		end

		def ai_win()
			puts "Sorry, you lost"
			
			play_again()
		end

		def tie()
			puts "Tie"

			play_again()
		end

		def play_again()
			puts "Would you like to play again?"

			if gets.chomp.downcase == "yes"
				reset()
			else
				exit
			end
		end

		def reset()
			@board.reset()
			run()
		end
end

game = TicTacToe.new
