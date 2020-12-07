def count_trees_hit(map, dx, dy)
    number_of_trees_hit = 0
    x = dx
    width = map[0].length - 1
    # puts "width: #{width}"
    map[dy..-1].each_slice(dy).map(&:first).each do |line|
        # puts "x: #{x}, x%width: #{x%width}, symbol: #{line[x % width]}"
        if line[x % width] == "#" then
            number_of_trees_hit += 1
        end
        x += dx
    end

    return number_of_trees_hit
end

# Load all lines into list
lines = File.readlines("input.txt")

slope_1_1 = count_trees_hit(lines, 1, 1)
slope_3_1 = count_trees_hit(lines, 3, 1)
slope_5_1 = count_trees_hit(lines, 5, 1)
slope_7_1 = count_trees_hit(lines, 7, 1)
slope_1_2 = count_trees_hit(lines, 1, 2)

puts "#{slope_1_1}*#{slope_3_1}*#{slope_5_1}*#{slope_7_1}*#{slope_1_2} = #{slope_1_1*slope_3_1*slope_5_1*slope_7_1*slope_1_2}"