def chain(a)
  a.sort!
  a.unshift(0)
  a.push(a.last+3)
  chain = a[0..-2].zip(a[1..-1])
  diffs = chain.map { |pair| pair.sort.reverse.reduce(&:-) }
  return diffs.count(1), diffs.count(3)
end

def output_counts(count1, count3)
  puts "#{count1} 1s, #{count3} 3s. #{count1}*#{count3} = #{count1*count3}"
end

def process_file(filename)
  joltages = File.readlines(filename)
  joltages.map!(&:to_i)
  count1, count3 = chain(joltages)
  output_counts(count1, count3)
end

process_file("example1.txt")

process_file("example2.txt")

process_file("input.txt")