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
		self.game_setup()
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
	
				self.run()

			else
				puts "Have a nice day and come play next time."
				exit
			end
		end

		def run()
		
			@board.print_board

			turn_order = [true, false].sample	#randomly set turn order

			self.play(turn_order)
		end

		def play(turn_order)
			
			while true
				
				# based on boolean turn_order call turn methods in correct sequence
				if turn_order

				# a turn method returns true when game is won or no more moves are
				# available
					if self.player_turn() then break end		
					if self.ai_turn() then break end
					
				else
					if self.ai_turn() then break end
					if self.player_turn() then break end
				end

			end

			if @board.winning_condition?(@player)
				self.player_win
			elsif @board.winning_condition?(@ai)
				self.ai_win
			else
				self.tie
			end
		end

		# handles player input and returns true if game is won, lost or tied
		def player_turn()
			puts "\nPlace your mark: "
			
			while true
				input = gets.chomp.to_i
				if self.valid_move?(@player, input)		# validates that input is correct
					break
				else
					puts "That position is either already used or invalid"
					puts "Please enter a number between 1 and 9 "
				end
			end

			@board.print_board		# print the status of the board at the end of a turn
			
			return self.check_end_status
		end
	
		# functions similarly to self.player_turn method
		def ai_turn()
			puts "AI is thinking".rjust(8)

			move = @ai.move(@board)

			@board.place_mark(@ai.mark, move)

			@board.print_board

			return self.check_end_status()
		end

		# boolean check whether game is won, lost or tied regardless of the player
		def check_end_status
			if @board.winning_condition?(@player) || @board.winning_condition?(@ai) ||
			@board.get_available_positions == []
				return true
			else
				return false
			end
		end
		
		# attempts to place a mark which returns false if it's not possible
		def valid_move?(player, input)
			return @board.place_mark(player.mark, input)	
		end

		def player_win()
			puts "Congradulations, You won!"
			@player.update_streak()
			puts "Your current streak is #{@player.streak}"
			
			self.play_again()
		end

		def ai_win()
			puts "Sorry, you lost"
			
			self.play_again()
		end

		def tie()
			puts "Tie"

			self.play_again()
		end

		def play_again()
			puts "Would you like to play again?"

			if gets.chomp.downcase == "yes"
				self.reset()
			else
				exit
			end
		end

		def reset()
			@board.reset()
			self.run()
		end
end

game = TicTacToe.new
