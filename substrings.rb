dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(sentence, dictionary)

	substrings = Hash.new(0)
	
	# split sentence into words
	words = sentence.split(" ")

	words.each { |word|

		word = word.downcase
		
		#split word into characters
		characters = word.split("")
		length = characters.length

		# for each word iterate over the substrings within
		(0...length).each { |start|

			substring = []

			(start...length).each { |stop|

				substring.push(characters[stop])

				# if found update the frequency hash
				if (dictionary.include?(substring.join))
					substrings[substring.join] += 1
				end
			}
		}
	}
	puts substrings
end

substrings("Howdy partner, sit down! How's it going?", dictionary)
