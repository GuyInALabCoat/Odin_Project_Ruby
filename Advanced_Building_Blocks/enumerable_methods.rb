#!/usr/bin/ruby

# File: enumerable_methods

module Enumerable
	
	def my_each(&block)
		i = 0
		while i < self.size
			block.call(self[i])
			i += 1
		end
		return self
	end

	def my_each_with_index(&block)
		i = 0
		while i < self.size
			block.call(self[i], i)
			i += 1
		end
		return self
	end

	def my_select(&block)
		selected_items = []
		i = 0
		while i < self.size
			if block.call(self[i])
				selected_items << self[i]
			end
			i += 1
		end
		return selected_items
	end

	def my_all?(&block)
		block ||= lambda {|obj| obj}
		i = 0

		while i < self.size
			unless block.call(self[i])
				return false
			end
			i += 1
		end
		return true
	end

	def my_any?(&block)
		block ||= lambda {|obj| obj}
		i = 0

		while i < self.size
			if block.call(self[i])
				return true
			end
			i += 1
		end
		return false
	end

	def my_none?(&block)
		block ||= lambda {|obj| obj}
		i = 0

		while i < self.size
			if block.call(self[i])
				return false
			end
			i += 1
		end
		return true
	end

	def my_count(number=nil, &block)
		i = 0
		count = 0

		if number != nil
			while i < self.size
				if self[i] == number then count += 1 end
				i += 1
			end

		elsif block_given?
			while i < self.size
				if block.call(self[i]) then count += 1 end
				i += 1
			end

		else
			return self.size
		end
		
		return count
	end

	def my_map(&block)
		i = 0
		new_array = []

		while i < self.size
			new_array << block.call(self[i])
			i += 1
		end
		return new_array
	end
			
	def my_inject
		i = 1
		sum = self[0]

		while i < self.size
			sum = yield(sum, self[i])
			i += 1
		end
		return sum
	end

	def multiply_els(array)
		array.my_inject {|product, item| product * item }
	end
end
