# File: tc_enumerable_methods.rb

require_relative "enumerable_methods"
require "test/unit"

class TestEnumerableMethods < Test::Unit::TestCase

	def setup
		@instance = Class.new{ include Enumerable }.new
	end

	def test_my_each
		test_array = []
		[1,2,3].my_each {|element| test_array << element**3 }
		assert_equal([1,8,27], test_array)
	end

	def test_my_each_with_index
		test_array = []
		hash = Hash.new

		[13, 15, 17, 19].my_each_with_index do |element, index| 
			test_array << element if index.even?
		end
		
		%w(cat dog wombat).my_each_with_index do |item, index|
			hash[item] = index
		end

		assert_equal([13, 17], test_array)
		assert_equal({"cat"=>0, "dog"=>1, "wombat"=>2}, hash)
	end

	def test_my_select
		assert_equal([1, 2], [1, 2, "hello", [], :item].my_select do
			|item| item.is_a?(Integer)
		end )

		assert_equal([2, 4], [1,2,3,4,5].my_select { |num| num.even? })
	end

	def test_my_all?
		assert_equal(true, [2, 4, 6, 8].my_all? { |item| item.even? })
		assert_equal(true, %w[ant bear cat].my_all? do |word| 
			word.length >= 3
		end )

		assert_equal(false, %w[ant bear cat].my_all? do |word| 
			word.length >= 4 
		end )

		assert_equal(false, [nil, true, 99].my_all?)
	end

	def test_my_any?
		assert_equal(true, ["A", [], 13, [], true].my_any? do |item|
			item.is_a?(String)
		end )

		assert_equal(true, %w[ant bear cat].my_any? do |word| 
			word.length >= 3
		end )
		
		assert_equal(true, [nil, true, 99].my_any?)
	end

	def test_my_none?
		assert_equal(false, [15, 20, [], true, "buy"].my_none? do |item| 
			item.is_a?(String)
		end )
		
		assert_equal(true, %w{ant bear cat}.my_none? do |word| 
			word.length == 5 
		end )

		assert_equal(true, [].my_none?)
		assert_equal(true, [nil].my_none?)
		assert_equal(true, [nil, false].my_none?)
	end

	def test_my_count
		assert_equal(4, [3, 4, 1, 2].my_count)
		assert_equal(2, [1, 2, 4, 2].my_count(2))
		assert_equal(3, [1, 2, 4, 2].my_count { |x| x%2==0 })
	end

	def test_my_map
		test_proc = Proc.new { |arg1| arg1 * 3.0 / 5.0 }
		
		assert_equal([1, 3, 3, 4], [3, 6, 5, 8].my_map do |item|
			item * 3 / 5 
		end )

		assert_equal([1.8, 3.6, 3.0, 4.8], [3, 6, 5, 8].my_map(&test_proc))
	end

	def test_my_inject
		assert_equal(120, (1..15).to_a.inject do |running_total, item|
			running_total + item 
		end )
	end

	def test_multiply_els
		assert_equal(40, @instance.multiply_els([2,4,5]))
	end

end
