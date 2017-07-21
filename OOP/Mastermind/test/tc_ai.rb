#!/usr/bin/env ruby

# File: tc_ai.rb

require_relative '../logic/ai.rb'
require_relative '../logic/mastermind.rb'
require 'test/unit'
require 'pry'

class	TestAI < Test::Unit::TestCase
	
	def setup
		@ai = AI.new
		@game = Mastermind.new
	end

	def test_initial_guess
		assert_equal('1122', @ai.guess)
	end

	def test_generate_code_set
		assert_equal(1296, @ai.generate_code_set)
	end	

	def test_evaluate_guess
		assert_equal([2, 0], @ai.evaluate_guess('1122', '1111'))
		assert_equal([1, 1], @ai.evaluate_guess('1122', '1314'))
		assert_equal([0, 3], @ai.evaluate_guess('1432', '6324'))
		assert_equal([3, 0], @ai.evaluate_guess('1122', '1112'))
		assert_equal([2, 0], @ai.evaluate_guess('1122', '1113'))
		assert_equal([2, 0], @ai.evaluate_guess('1122', '1114'))
		assert_equal([2, 0], @ai.evaluate_guess('1122', '1115'))
	end

	def test_update_code_set
		@game.set_code('1256')
		@ai.update_response(@game.guess(@ai.guess))
		assert_equal(208, @ai.reduce_code_set)
	end

	def test_ai_minimax
		@game.set_code('1123')
		@ai.update_response(@game.guess(@ai.guess))
		assert_equal('1223', @ai.guess)
	end
end
