#!/usr/bin/ruby

# File: tc_player.rb

require_relative "../logic/player.rb"
require "test/unit"

class TestSomething < Test::Unit::TestCase
	
	def test_name
		player = Player.new("James")
		assert_equal("James", player.name)
	end

	def test_streak
		player = Player.new("")
		assert_equal(0, player.streak)
		player.update_streak
		assert_equal(1, player.streak)
	end

end	
