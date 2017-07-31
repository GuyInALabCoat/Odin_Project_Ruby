#!/usr/bin/ruby

require "csv"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, "0")[0..4]
end

puts "EventManager Initialized."

path = File.expand_path('../../event_attendees.csv', __FILE__)

contents = CSV.open(path, headers: true, header_converters: :symbol)

contents.each do |row|
	name = row[:first_name]

	zipcode = clean_zipcode(row[:zipcode])

	puts "#{name} #{zipcode}"
end
