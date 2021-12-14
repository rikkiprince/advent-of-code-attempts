def triangle(x)
  (0..x).reduce {|a,b| a+b}
end

def calculate(file_name)
  line = File.readlines(file_name).first

  positions = line.split(",").map(&:to_i)
  from = positions.min
  to = positions.max
  p (from..to).map {|y| positions.map {|x| triangle((x-y).abs)}.sum}.min
end

calculate("example_input.txt")
calculate("input.txt") # takes a few minutes to run