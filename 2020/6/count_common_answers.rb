require 'set'
# Load all lines into list
raw_groups = File.read("input.txt").split("\n\n")
answer = raw_groups.map do |raw_group|
  group_sets = raw_group.split("\n").map do |person|
    Set.new(person.split(""))
  end
  
  all_group_answers = group_sets.reduce(Set.new) do |all, person|
    all | person
  end

  same_group_answers = group_sets.reduce(all_group_answers) do |common, person|
    common & person
  end

  same_group_answers.size
end.reduce :+
puts "Total: #{answer}"