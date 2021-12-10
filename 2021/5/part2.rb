def range_as_array(a,b)
  if b >= a
    (a..b).to_a
  else
    (b..a).to_a.reverse
  end
end

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
      ys = range_as_array(y1,y2)
      xs = Array.new(ys.length,x1)
    elsif y1 == y2
      xs = range_as_array(x1,x2)
      ys = Array.new(xs.length,y1)
    else
      xs = range_as_array(x1,x2)
      ys = range_as_array(y1,y2)
    end

    coords = xs.zip(ys)
    coords.each do |coord|
      map[coord] += 1
    end
  end

  p map.select {|key, value| value >= 2}.length
end

calculate("example_input.txt")
calculate("input.txt")