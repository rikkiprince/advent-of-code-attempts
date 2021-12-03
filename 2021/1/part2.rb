lines = File.readlines("input.txt")

count = 0
lines.map(&:to_i).each_cons(3).each_cons(2) do |a,b|
  count += 1 if a.sum < b.sum
end

p count