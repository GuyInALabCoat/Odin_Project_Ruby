#!/usr/bin/ruby

puts "EventManager Initialized!"

path = File.expand_path('../../event_attendees.csv', __FILE__)

lines = File.readlines(path)
lines.each_with_index do |line, index|
	next if index == 0
	columns = line.split(",")
	name = columns[2]
	puts name
end
