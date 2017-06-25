# File: tc_sorting.rb

require_relative "sorting"
require "test/unit"

class TestSorting < Test::Unit::TestCase

	def setup
		@array = [65, 72, 13, 19, -12, 0].shuffle!
		@sorted_array = [-12, 0, 13, 19, 65, 72]
	end
		
	def test_bubble_sort
		assert_equal([], Sorting.new.bubble_sort([]) )
		assert_equal([15], Sorting.new.bubble_sort([15]) )
		assert_equal(@sorted_array, Sorting.new.bubble_sort(@array) )
	end

	def test_bubble_sort_by
		string_array = ["hi", "hello", "hey"]
		sorted_string_array = ["hi", "hey", "hello"]

		assert_equal([], Sorting.new.bubble_sort_by([]) { |left, right| left.length - right.length })
		assert_equal(["hi"], Sorting.new.bubble_sort_by(["hi"]) { |left, right| left.length - right.length })
		assert_equal(sorted_string_array, Sorting.new.bubble_sort_by(string_array) { |left, right| left.length - right.length })
	end

	def test_typecheck
		assert_raise( RuntimeError ) { Sorting.new.bubble_sort('String') }
	end
end
