#!/busr/bin/env ruby

# File: tc_mastermind.rb

require_relative '../logic/mastermind.rb'
require 'test/unit'
require 'pry'

class TestMastermind < Test::Unit::TestCase
	
	def setup
		@game = Mastermind.new()
	end

	def test_generate_code
		@game.generate_code()
	end

	def test_compare_codes
		@game.set_code('4152')
		assert_equal(true, @game.guess('4152')[0])
		assert_equal(false, @game.guess('4153')[0])
	end

	def test_correct
		@game.set_code('5266')
		assert_equal(2, @game.guess('1256')[1])
		assert_equal(3, @game.guess('1266')[1])
		assert_equal(4, @game.guess('5266')[1])
	end

	def test_misplaced
		@game.set_code('5243')
		assert_equal(0, @game.guess('1111')[2])
		assert_equal(1, @game.guess('1511')[2])
		assert_equal(2, @game.guess('2511')[2])
		assert_equal(3, @game.guess('1524')[2])
		assert_equal(4, @game.guess('3524')[2])
	end
end
