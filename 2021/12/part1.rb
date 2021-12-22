require 'set'
require 'pp'

def test(file_name, paths, expected_paths)
  if !expected_paths.nil?
    if expected_paths == paths
      puts "SUCCESS (#{paths} == #{expected_paths}) - #{file_name}"
    else
      puts "FAILURE (#{paths} != #{expected_paths}) - #{file_name}"
    end
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
    "#<Cave:#{@name} ~#{@big?'big':'small'}, @connected=#<Set length=#{@connected.length}>>"
  end

  def connect(other_cave)
    @connected << other_cave
  end

  def find_paths_to(destination)
    small_visited = Set.new
    visit(destination, small_visited)
  end

  def visit(destination, small_visited)
    return [[self]] if @name == destination
    return [] if small_visited === self
    small_visited << self if small?
    puts "this node: #{@name}"
    puts "connections: #{@connected.map {|n| n.name}}"
    paths = @connected.map do |other_cave|
      other_cave.visit(destination, small_visited).map do |path|
        # pp path
        # puts self
        path.unshift(self) if !path.empty?
      end.compact
    end
    pp paths
    paths
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
  puts paths.length
  # pp paths

  test(file_name, number_of_paths, expected_paths)
end

calculate("example_input_1.txt", 10)
# calculate("example_input_2.txt", 19)
# calculate("example_input_3.txt", 226)
# calculate("input.txt")