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
		assert_equal(true, @game.guess('4152'))
		assert_equal(false, @game.guess('4153'))
	end

end
