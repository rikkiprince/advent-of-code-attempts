class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def bold;           "\e[1m#{self}\e[22m" end
end

class Octopus
  attr_reader :energy_level, :flashed
  def initialize(starting_energy_level)
    @energy_level = starting_energy_level
  end

  def increment
    @energy_level += 1
  end

  def flashes?
    @flashed = @energy_level > 9
  end

  def reset
    @energy_level = 0 if @flashed
    @flashed = false
  end

  def to_s
    case @energy_level
    when 0
      @energy_level.to_s.bold.red
    when 9
      @energy_level.to_s.bold.blue
    when 10..(1.0/0.0)
      "X".bold.green
    else
      @energy_level.to_s
    end
  end
end

def print_map(map,step)
  puts "- Step #{step} -"
  map.each_with_index do |row,y|
    row.each do |octopus,x|
      print octopus
    end
    print "\n"
  end
  puts "-"*10
end

def adjacents(map, x, y)
  adjacents = []
  adjacents << [x-1,y-1]
  adjacents << [x,y-1]
  adjacents << [x+1,y-1]
  adjacents << [x-1,y]
  adjacents << [x+1,y]
  adjacents << [x-1,y+1]
  adjacents << [x,y+1]
  adjacents << [x+1,y+1]
  adjacents.select do |x,y|
    y >= 0 && y < map.length &&
    x >= 0 && x < map[y].length
  end
end

def process_adjacent(map, x, y)
  adjacent_octopus = map[y][x]
  adjacent_octopus.increment
  !adjacent_octopus.flashed && adjacent_octopus.flashes?
end

def propagate_flashes(map, flashers, step, substep)
  return 0 if flashers.length < 1

  new_flashers = flashers.map do |x,y|
    adjacents(map, x, y).select {|ax,ay| process_adjacent(map, ax, ay)}
  end.flatten(1)
  new_flashers.length + propagate_flashes(map, new_flashers, step, substep+1)
end

def calculate(file_name)
  lines = File.readlines(file_name)

  # initialize
  map = []
  lines.each do |line|
    row = []
    line.chomp.chars.each do |number|
      row << Octopus.new(number.to_i)
    end
    map << row
  end
  print_map(map,0)
  
  flash_count = 0
  1000.times do |count|
    # increment
    map.each_with_index do |row,y|
      row.each do |octopus,x|
        octopus.increment
      end
    end

    # flash
    flashers = []
    map.each_with_index do |row,y|
      row.each_with_index do |octopus,x|
        if octopus.flashes?
          flashers << [x,y]
        end
      end
    end
    flash_count += flashers.length + propagate_flashes(map,flashers, count, 1)

    # reset
    map.each_with_index do |row,y|
      row.each do |octopus,x|
        octopus.reset
      end
    end

    if map.flatten.all? {|o| o.energy_level.zero?}
      print_map(map, count+1)
      break
    end
  end
  puts "flashes: #{flash_count}"
end

calculate("example_input.txt")
calculate("input.txt")