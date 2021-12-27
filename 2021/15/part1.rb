require 'set'

class Node
  attr_reader :cost_of_entry
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
end

def construct_graph(lines)
  map = []
  lines.each_with_index do |line, y|
    row = []
    line.chomp.chars.each_with_index do |cost, x|
      node = Node.new(cost, x, y, map)
      row << node
    end
    map << row
  end
  map.flatten
end

def dijkstra(graph, source, target)
  q = Set.new

  # Initialise distances
  dist = {}
  prev = {}

  graph.each do |v|
    dist[v] = Float::INFINITY
    q << v
  end
  dist[source] = 0

  while !q.empty?
    puts "q length = #{q.length}" if q.length % 1000 == 0
    v = q.min_by {|n| dist[n]}
    q.delete(v)
    break if v == target

    v.neighbours.each do |u|
      alt = dist[v] + u.cost_of_entry
      if alt < dist[u]
        dist[u] = alt
        prev[u] = v
      end
    end
  end

  return dist, prev
end

def traverse(prev, source, target)
  s = []
  u = target

  if !prev[u].nil? # || u == source
    while !u.nil?
      s.unshift(u)
      u = prev[u]
    end
  end

  s.shift
  s.reduce(0) {|cost,v| cost + v.cost_of_entry}
end

def calculate(file_name)
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  lines = File.readlines(file_name)

  all_nodes = construct_graph(lines)
  source_node = all_nodes.first
  target_node = all_nodes.last

  dist, prev = dijkstra(all_nodes, source_node, target_node)
  risk_score = traverse(prev, source_node, target_node)
  puts "Risk: #{risk_score}"
  puts "#{Process.clock_gettime(Process::CLOCK_MONOTONIC) - starting} seconds"
end

calculate("example_input.txt")
calculate("input.txt")