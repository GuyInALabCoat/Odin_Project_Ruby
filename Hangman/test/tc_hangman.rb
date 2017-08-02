#!/usr/bin/ruby

require '../lib/hangman.rb'
require 'test/unit'

class TestHangman < Test::Unit::TestCase

	def setup	
		@game = Hangman.new
	end

	def test_select_word
		assert_match(/[a-zA-Z]{5,12}/, @game.secret_word)
	end
end
