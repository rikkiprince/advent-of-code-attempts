require 'set'
require 'pp'

def test(file_name, paths, expected_paths)
  if !expected_paths.nil?
    if expected_paths == paths
      puts "SUCCESS (#{paths} == #{expected_paths}) - #{file_name}"
    else
      puts "FAILURE (#{paths} != #{expected_paths}) - #{file_name}"
    end
  else
    puts "FOUND #{paths} paths - #{file_name}"
  end
end

class Path
  def initialize(path)
    @path = path
  end

  def inspect
    @path
  end

  def to_s
    @path
  end
end

class Cave
  attr_reader :name
  def initialize(name)
    @name = name
    @big = (name == name.upcase)
    @connected = Set.new
  end

  def small?
    !@big
  end

  def to_s
    "#<Cave: #{@name}>"
  end

  def inspect
    # "#<Cave:#{@name} ~#{@big?'big':'small'}, @connected=#<Set length=#{@connected.length}>>"
    @name
  end

  def connect(other_cave)
    @connected << other_cave
  end

  def find_paths_to(destination)
    small_visited = Set.new
    visit(destination, small_visited, [], false)
  end

  def visit(destination, small_visited, path_so_far, small_revisted)
    if @name == destination
      return Path.new(path_so_far + [self])
    end
    if small_visited === self
      return if small_revisted || ["start","end"].include?(@name)

      small_revisted = true
    end
    small_visited << self if small?
    @connected.map do |other_cave|
      other_cave.visit(destination, small_visited.dup, path_so_far + [self], small_revisted.dup)
    end.compact.flatten
  end
end

def calculate(file_name, expected_paths=nil)
  lines = File.readlines(file_name)
  number_of_paths = 0

  cave_lookup = {}

  lines.each do |line|
    cave1_name, cave2_name = line.chomp.split("-")
    
    cave_lookup[cave1_name] = Cave.new(cave1_name) if !cave_lookup.key?(cave1_name)
    cave1 = cave_lookup[cave1_name]

    cave_lookup[cave2_name] = Cave.new(cave2_name) if !cave_lookup.key?(cave2_name)
    cave2 = cave_lookup[cave2_name]

    cave1.connect(cave2)
    cave2.connect(cave1)
  end

  start = cave_lookup["start"]
  paths = start.find_paths_to("end")
  number_of_paths = paths.length

  test(file_name, number_of_paths, expected_paths)
end

calculate("example_input_0.txt")
calculate("example_input_1.txt", 36)
calculate("example_input_2.txt", 103)
calculate("example_input_3.txt", 3509)
calculate("input.txt")