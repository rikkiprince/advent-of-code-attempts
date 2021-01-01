def fill_seats(room)
  height = room.size
  room[0].chomp! if room[0].respond_to?("chomp!")
  width = room[0].size
  new_room = ([[nil]*width]*height).map(&:clone)
  (0..height-1).each do |y|
    (0..width-1).each do |x|
      new_room[y][x] = get_new_seat_state(room, x, y)
    end
  end
  new_room
end

def get_new_seat_state(room, x, y)
  height = room.size
  room[0].chomp! if room[0].respond_to?("chomp!")
  width = room[0].size
  top = [0,y-1].max
  left = [0,x-1].max
  bottom = [y+1,height].min
  right = [x+1,width].min
  
  seat = room[y][x]
  surrounding = room[top..bottom].map { |row| row[left..right] }

  if seat == "L" then
    return "#" if surrounding.flatten.count("#") <= 0
  end
  if seat == "#" then
    return "L" if surrounding.flatten.count("#") >= 4+1
  end
  return seat
end

def print_room(room)
  height = room.size - 1
  room[0].chomp! if room[0].respond_to?("chomp!")
  width = room[0].size - 1
  (0..height).each do |y|
    (0..width).each do |x|
      print "#{room[y][x]}"
    end
    puts
  end
end

# Load all lines into list
lines = File.readlines("example.txt")
print_room(lines)
puts "\n------------\n\n"
new_state = lines
old_state = []
until old_state == new_state do
  old_state = new_state
  new_state = fill_seats(old_state)
  print_room(new_state)
  puts "\n------------\n\n"
end
puts "Occupied seats: #{new_state.flatten.count("#")}"