require 'set'

class Node
  attr_reader :cost_of_entry, :x, :y
  def initialize(cost, x, y, map)
    @cost_of_entry = cost.to_i
    @x = x
    @y = y
    @map = map
  end

  def neighbours
    # coords = (-1..1).to_a.product((-1..1).to_a).to_set.delete([0,0])
    coords = [
      [-1,0],
      [0,-1],
      [0,1],
      [1,0],
    ]
    coords.map do |cx,cy|
      x = @x + cx
      y = @y + cy
      @map[y][x] if y >= 0 && y < @map.length && x >= 0 && x < @map[y].length
    end.compact
  end

  def inspect
    "(#{@x},#{@y})"
  end

  def to_s
    "(#{@x},#{@y})"
  end

  def manhattan(other)
    dx = (@x - other.x).abs
    dy = (@y - other.y).abs
    dx+dy
  end
end

def wrap(x);(x-1)%9+1;end

def construct_graph(lines)
  map = []
  5.times do |yt|
    lines.each_with_index do |line, y|
      line.chomp!
      row = []
      5.times do |xt|
        line.chars.each_with_index do |cost, x|
          node = Node.new(wrap(cost.to_i+xt+yt), x+(xt*line.length), y+(yt*lines.length), map)
          row << node
        end
      end
      map << row
    end
  end
  map.flatten
end

def heuristic(node, goal)
  node.manhattan(goal)
end

def reconstruct_path(came_from, current)
  total_path = [current]
  while came_from.key?(current)
    current = came_from[current]
    total_path.unshift(current)
  end
  # return total_path
  total_path.shift
  total_path.reduce(0) {|cost,v| cost + v.cost_of_entry}
end

def a_star(start, goal)
  open_set = Set[start]

  came_from = {}

  g_score = Hash.new(Float::INFINITY)
  g_score[start] = 0

  f_score = Hash.new(Float::INFINITY)
  f_score[start] = heuristic(start, goal)

  while !open_set.empty?
    current = open_set.min_by {|n| f_score[n]}
    return reconstruct_path(came_from, current) if current == goal

    open_set.delete(current)

    current.neighbours.each do |neighbour|
      tentative_g_score = g_score[current] + neighbour.cost_of_entry

      if tentative_g_score < g_score[neighbour]
        # This path to neighbor is better than any previous one. Record it!
        came_from[neighbour] = current
        g_score[neighbour] = tentative_g_score
        f_score[neighbour] = tentative_g_score + heuristic(neighbour, goal)
        if !open_set.include?(neighbour)
          open_set << neighbour
        end
      end
    end
  end

  return "FAILURE"
end

def calculate(file_name)
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  lines = File.readlines(file_name)

  all_nodes = construct_graph(lines)
  source_node = all_nodes.first
  target_node = all_nodes.last

  path = a_star(source_node, target_node)
  pp path
  puts "#{Process.clock_gettime(Process::CLOCK_MONOTONIC) - starting} seconds"
end

calculate("example_input.txt")
calculate("input.txt") # took 73 seconds with A*