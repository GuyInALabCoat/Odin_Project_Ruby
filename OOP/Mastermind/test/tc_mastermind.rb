#!/busr/bin/env ruby

# File: tc_mastermind.rb

require_relative '../logic/mastermind.rb'
require 'test/unit'

class TestMastermind < Test::Unit::TestCase
	
	def setup
		@game = Mastermind.new()
	end

	def test_generate_code
		@game.generate_code()
	end

	def test_input
	end

	def test_compare_codes
		@game.set_code('4152')
		assert_equal(true, @game.guess('4152'))
	end

	def test_feedback
		@game.set_code('5133')
		@game.guess('5313')
		assert_equal(2, @game.correct)
		assert_equal(2, @game.misplaced)
	end
end
