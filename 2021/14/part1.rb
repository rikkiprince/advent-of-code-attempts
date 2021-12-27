def calculate(file_name)
  lines = File.readlines(file_name)

  template = ""
  rules = {}
  lines.each do |line|
    case line
    when /^([A-Z]+)$/
      template = $1
    when /([A-Z]{2}) -> ([A-Z])/
      rules[$1] = $2
    end
  end
  
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  30.times do |index|
    puts "#{index}/30 - #{Process.clock_gettime(Process::CLOCK_MONOTONIC)-starting} seconds"
    a = template.chars.each_cons(2).map do |pair|
      mid = rules[pair.join('')]
      pair[0] + mid
    end
    template = a.join('')+template.chars.last
  end
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "#{ending - starting} seconds"
  
  tally = template.chars.tally
  pp tally
  max = tally.max_by {|k,v| v}[1]
  min = tally.min_by {|k,v| v}[1]
  puts "#{max} - #{min} = #{max-min}"
end

calculate("example_input.txt")
# calculate("input.txt")