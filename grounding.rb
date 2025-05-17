#!/usr/bin/env ruby
# Simple CLI app implementing the 5-4-3-2-1 grounding technique
# Users advance through each item by pressing the space bar or Enter

require 'io/console'

STEPS = [
  [5, 'things you can see'],
  [4, 'things you can feel'],
  [3, 'things you can hear'],
  [2, 'things you can smell'],
  [1, 'thing you can taste']
].freeze

puts 'Welcome to the 5-4-3-2-1 grounding technique.'
puts 'Press SPACE or ENTER after you identify each item.'

# Waits for either space or return
# Returns immediately when one of those keys is pressed

def wait_for_trigger
  loop do
    char = STDIN.getch
    return if char == ' ' || char == "\r" || char == "\n"
  end
end

STEPS.each do |count, description|
  puts
  puts "Identify #{count} #{description}."
  count.downto(1) do |i|
    print "#{i}... "
    wait_for_trigger
  end
  puts
end

puts 'Grounding exercise complete. Take a deep breath.'
