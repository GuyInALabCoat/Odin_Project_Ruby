#!/usr/bin/ruby

# File: sorting.rb

class Sorting

	def bubble_sort(array)
		raise unless array.is_a?(Array)

		if is_one_or_empty?(array)
			return array
		
		else
			i = 1
			n = array.length

			while i < n
				j = 0
				while j < n - i

					if block_given?
						if yield(array[j], array[j+1]) > 0
							swap(array, j, j+1)
						end
					
					else
						if array[j] > array[j+1]
							swap(array, j, j+1)
						end
					end

					j += 1
				end
				i += 1
			end
		end

		return array
	end

	def bubble_sort_by(array)
		bubble_sort(array, &Proc.new)
	end

	def is_one_or_empty?(array)
		if array.empty? || array.length == 1
			return true
		else
			return false
		end
	end

	def swap(array, x, y)
		temp = array[x]
		array[x] = array[y]
		array[y] = temp
	end

end
