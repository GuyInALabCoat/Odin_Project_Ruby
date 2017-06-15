def stock_picker(stocks)

	buy = stocks.max
	best_buy = 0
	best_sell = 0
	max_profit = 0

	stocks_number = stocks.length - 1

# loop through entire array
	(0..stocks_number).each { |i|

		if (stocks[i] < buy)
			buy = stocks[i]
			
			# loop from iterator to end of array i times
			(i..stocks_number).each { |j|
		
				if ((stocks[j] - buy) > max_profit)
					max_profit = stocks[j] - buy
					best_buy = i
					best_sell = j
				end
			}
		end
	}

	puts "[" + best_buy.to_s + ", " + best_sell.to_s + "]"

end

stock_picker([17,3,6,9,15,8,6,1,10])
