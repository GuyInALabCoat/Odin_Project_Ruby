#!/usr/bin/env ruby

# File: code.rb

class Code
	
	def initialize(number)

		number = number.to_s.split('')

		@ones = number[3].to_i
		@tens = number[2].to_i
		@hundreds = number[1].to_i
		@thousands = number[0].to_i
		
	end

	def increment
		
		if @ones != 6
			@ones += 1

		else
			@ones = 1

			if @tens != 6
				@tens += 1

			else
				@tens = 1

				if @hundreds != 6
					@hundreds += 1

				else
					@hundreds = 1

					if @thousands != 6
						@thousands += 1

					else
						@thousands = 1
					end
				end
			end
		end
	end

	def number
		return @thousands.to_s + @hundreds.to_s + @tens.to_s + @ones.to_s
	end
end
