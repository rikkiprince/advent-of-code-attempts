require 'set'
# Load all lines into list
raw_groups = File.read("input.txt").split("\n\n")
answer = raw_groups.map do |raw_group|
  raw_group.gsub("\n","").split("").reduce(Set.new) do |set, answer|
    set.add answer
  end.size
end.reduce :+
puts "Total: #{answer}"