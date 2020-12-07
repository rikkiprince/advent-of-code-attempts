require 'set'

# Load all lines into list
lines = File.readlines("input.txt")
# Use set to store unique differences from 2020
initial_numbers = Set.new
lines.each do |line|
    number = line.to_i
    initial_numbers.add(number)
end

# Loop through list once
initial_numbers.each do |number1|
    # Loop through list excluding number from first list
    (initial_numbers - [number1]).each do |number2|
        difference = 2020 - number1 - number2
        # See if the difference is in the number set
        if initial_numbers.include?(difference) then
            puts "#{difference} x #{number1} x #{number2} = #{difference*number1*number2}"
            break
        end
    end
end

=begin
Notes

This outputs 3 different permutations of ordering of the numbers.
Not sure it's worth fixing that.

Also, if the 1 of the numbers required to solve this appeared twice,
this solution might require a bit of human intervention to resolve.
=end
