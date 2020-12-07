# Load all lines into list
lines = File.readlines("input.txt")

number_of_trees_hit = 0
x = 3
width = (lines.shift).length - 1
puts "width: #{width}"
lines.each do |line|
    puts "x: #{x}, x%width: #{x%width}, symbol: #{line[x % width]}"
    if line[x % width] == "#" then
        number_of_trees_hit += 1
    end
    x += 3
end

puts "Number of tress hit: #{number_of_trees_hit}"