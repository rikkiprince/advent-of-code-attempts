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
      low_points << point if adjacent.all? {|item| item > point}
    end
  end

  p low_points.reduce(0) {|a,b| a+b+1}
end

calculate("example_input.txt")
calculate("input.txt")