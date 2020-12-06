require 'set'

lines = File.readlines("input.txt")
known_differences = Set.new
lines.each do |line|
    number = line.to_i
    difference = 2020 - number
    if known_differences.include?(difference) then
        puts "#{difference} x #{number} = #{difference*number}"
        break
    end
    known_differences.add(difference)
    known_differences.add(number)
end