def calculate(file_name)
  lines = File.readlines(file_name)

  lines.map(&:chomp!)

  map = Hash.new(0)

  lines.each do |line|
    result = /([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/.match(line)
    x1 = result[1].to_i
    y1 = result[2].to_i
    x2 = result[3].to_i
    y2 = result[4].to_i

    if x1 == x2
      ys = [y1,y2].sort
      (ys[0]..ys[1]).each do |y|
        coord = [x1,y]
        map[coord] += 1
      end
    elsif y1 == y2
      xs = [x1,x2].sort
      (xs[0]..xs[1]).each do |x|
        coord = [x, y1]
        map[coord] += 1
      end
    end
  end

  p map.select {|key, value| value >= 2}.length
end

calculate("example_input.txt")
calculate("input.txt")