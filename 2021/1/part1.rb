lines = File.readlines("input.txt")

count = 0
lines.each_cons(2) do |a,b|
  count += 1 if b.to_i > a.to_i
end

p count