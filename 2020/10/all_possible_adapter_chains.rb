$cache = {}

def count_possible_chains(joltages)
  return $cache[joltages] if $cache.key?(joltages)
  a = joltages.clone.map(&:clone)
  head = a.shift
  return 1 if a.size == 0
  p head
  p a

  count = 0
  (1..3).each do |next_number|
    index = a.index(head+next_number)
    puts "#{next_number}:#{index} #{a[index..-1]}" if index
    count += count_possible_chains(a[index..-1]) if index
  end
  $cache[joltages] = count
  return count
end

def count_all_possible_chains(a)
  a.sort!
  a.unshift(0)
  # a.push(a.last+3)
  count_possible_chains(a)
end

def process_file(filename)
  joltages = File.readlines(filename).map!(&:to_i)
  # p joltages
  count_all_possible_chains(joltages)
end

puts "Example 1 Count: #{process_file("example1.txt")}"
puts "Example 2 Count: #{process_file("example2.txt")}"
puts "Input Count: #{process_file("input.txt")}"