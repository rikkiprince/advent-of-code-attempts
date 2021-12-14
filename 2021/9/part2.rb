require 'set'

def fill(point, map, seen, previous_height)
  return if seen === point
  x,y = point
  return if x < 0 || y < 0
  return if y >= map.length || x >= map[y].length
  height = map[y][x].to_i
  return if previous_height >= height # check this logic
  return if height >= 9
  seen << point

  fill([x-1,y], map, seen, height)
  fill([x,y-1], map, seen, height)
  fill([x+1,y], map, seen, height)
  fill([x,y+1], map, seen, height)
end

def calculate(file_name)
  lines = File.readlines(file_name).map(&:chomp)
  
  low_points = []

  lines.each_with_index do |line,y|
    line.chars.each_with_index do |point,x|
      point = point.to_i
      # puts "#{x},#{y} = #{point}"
      adjacent = []
      adjacent << lines[y][x-1].to_i if x-1 >= 0
      adjacent << lines[y-1][x].to_i if y-1 >= 0
      adjacent << lines[y][x+1].to_i if x+1 < line.length
      adjacent << lines[y+1][x].to_i if y+1 < lines.length
      low_points << [x,y] if adjacent.all? {|item| item > point}
    end
  end

  sizes = low_points.map do |low_point|
    basin = Set.new
    fill(low_point, lines, basin, -1)
    basin.length
  end
  p sizes.sort.reverse[0..2].reduce(:*)
end

calculate("example_input.txt")
calculate("input.txt")