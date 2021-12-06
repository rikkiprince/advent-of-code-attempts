lines = File.readlines("input.txt")

horizontal_position = 0
depth = 0

lines.each do |line|
  direction, distance = line.split(" ")
  distance = distance.to_i

  case direction
  when "forward"
    horizontal_position += distance
  when "down"
    depth += distance
  when "up"
    depth -= distance
  end
end

puts "horizontal position: #{horizontal_position}"
puts "depth: #{depth}"
puts "result: #{horizontal_position*depth}"