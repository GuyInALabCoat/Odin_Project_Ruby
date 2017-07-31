#!/usr/bin/ruby

puts "EventManager Initialized!"

path = File.expand_path('../../event_attendees.csv', __FILE__)

lines = File.readlines(path)
lines.each do |line|
	puts line
end
