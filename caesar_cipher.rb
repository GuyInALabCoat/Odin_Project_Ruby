def caesar_cipher(input, shift)
	
	words = input.split(" ")

	new_string = ""
	
	words.each { |word| 
		word.each_byte { |character|
		
			if (65..90).include?(character)
			
				if (character + shift > 90)
					loop_append(new_string, (character + shift))
				else 
					char_append(new_string, (character + shift))
				end
	
			elsif (97..122).include?(character)

				if (character + shift > 122)
					loop_append(new_string, character + shift)
				else
					char_append(new_string, character + shift)
				end

			else 
				new_string << (character).chr
			end
		}
		new_string << " "
	}

	return new_string

end
	
def loop_append(string, character)
	string << (character - 26).chr
end

def char_append(string, character)
	string << (character).chr
end

puts "What is your input? "
text = gets.strip

puts "What is the offset: "
shift_factor = gets.strip.to_i

puts "#{caesar_cipher(text, shift_factor)}"
