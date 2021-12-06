lines = File.readlines("input.txt")

horizontal_position = 0
depth = 0
aim = 0

lines.each do |line|
  direction, x = line.split(" ")
  x = x.to_i

  case direction
  when "forward"
    horizontal_position += x
    depth += aim*x
  when "down"
    aim += x
  when "up"
    aim -= x
  end
end

puts "horizontal position: #{horizontal_position}"
puts "depth: #{depth}"
puts "result: #{horizontal_position*depth}"