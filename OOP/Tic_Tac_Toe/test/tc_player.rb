#!/usr/bin/ruby

# File: tc_player.rb

require_relative "../logic/player.rb"
require "test/unit"

class TestSomething < Test::Unit::TestCase
	
	def setup
		@player = Player.new("", "X")
	end

	def test_name
		player = Player.new("James", "X")
		assert_equal("James", player.name)
	end

	def test_streak
		assert_equal(0, @player.streak)
		@player.update_streak
		assert_equal(1, @player.streak)
	end

	def test_player_mark
		assert_equal("X", @player.mark)
		assert_not_equal(nil, @player.mark)
	end

end
