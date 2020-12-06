require 'set'

# Load all lines into list
lines = File.readlines("input.txt")
# Use set to store unique differences from 2020
known_differences = Set.new

# Loop through each line
lines.each do |line|
    number = line.to_i
    difference = 2020 - number
    # If the difference between current number and 2020 is already
    # in the set, then we've found out pair.
    if known_differences.include?(difference) then
        puts "#{difference} x #{number} = #{difference*number}"
        break
    end
    # Add current number and its difference from 2020 to the set.
    known_differences.add(difference)
    known_differences.add(number)
end