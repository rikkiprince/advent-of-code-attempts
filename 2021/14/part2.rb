# Attempted a divide and conquer strategy, but that didn't speed
# it up anywhere near enough. Would have taken years to complete!

def test(file_name, times, answer, expected_answer)
  if !expected_answer.nil?
    if expected_answer == answer
      puts "SUCCESS (#{answer} == #{expected_answer}) - #{file_name}*#{times}"
    else
      puts "FAILURE (#{answer} != #{expected_answer}) - #{file_name}*#{times}"
    end
  else
    puts "ANSWER #{answer} - #{file_name}*#{times}"
  end
  puts "-------"
end

def calculate(file_name, this_many, expected_answer=nil)
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

  count_of_pairs = Hash.new(0)
  template.chars.each_cons(2) do |a,b|
    count_of_pairs[a+b] += 1
  end
  tally = Hash.new(0)
  tally.merge!(template.chars.tally)
  
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  this_many.times do |index|
    # puts "#{index}/#{this_many} - #{Process.clock_gettime(Process::CLOCK_MONOTONIC)-starting} seconds"
    
    new_count_of_pairs = Hash.new(0)
    count_of_pairs.each do |pair, count|
      inserted_character = rules[pair]
      a = pair[0] + inserted_character
      b = inserted_character + pair[1]
      tally[inserted_character] += count

      new_count_of_pairs[a] += count
      new_count_of_pairs[b] += count
    end
    count_of_pairs = new_count_of_pairs
  end
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "#{ending - starting} seconds"
  
  # pp tally
  max = tally.max_by {|k,v| v}[1]
  min = tally.min_by {|k,v| v}[1]
  puts "#{max} - #{min} = #{max-min}"
  
  test(file_name, this_many, max-min, expected_answer)
end

calculate("example_input.txt", 10, 1588)
calculate("input.txt", 10, 3306)
calculate("example_input.txt", 40, 2188189693529)
calculate("input.txt", 40)