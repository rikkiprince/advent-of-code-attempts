def is_valid_next_number?(number, previous_numbers)
  previous_numbers.combination(2).map(&:sum).include?(number)
end

first_example = ((1..19).to_a + (21..25).to_a).shuffle.unshift(20)
p first_example

puts "26: #{is_valid_next_number?(26, first_example)}"
puts "49: #{is_valid_next_number?(49, first_example)}"
puts "100: #{is_valid_next_number?(100, first_example)}"
puts "50: #{is_valid_next_number?(50, first_example)}"

first_example.push(45)
p first_example[1,25]

puts "26: #{is_valid_next_number?(26, first_example[1,25])}"
puts "65: #{is_valid_next_number?(65, first_example[1,25])}"
puts "64: #{is_valid_next_number?(64, first_example[1,25])}"
puts "66: #{is_valid_next_number?(66, first_example[1,25])}"

puts "-"*10

def find_invalid_number(numbers, preamble_length)
  (0..(numbers.size - preamble_length - 1)).each do |offset|
    previous_numbers = numbers[offset, preamble_length]
    next_number = numbers[offset+preamble_length]
    if !is_valid_next_number?(next_number, previous_numbers) then
      puts "#{next_number} is NOT a valid next number after #{previous_numbers}."
      return next_number
    end
  end
end

def sequence_that_sums_to(target, numbers)
  (2..numbers.size).each do |length|
    # puts "TARGET: #{target}"
    # puts "Checking sequences of length #{length}"
    (0..numbers.size-length).each do |offset|
      sequence = numbers[offset, length]
      # puts "  sum(#{sequence}) => #{sequence.sum}"
      return sequence if sequence.sum == target
    end
  end
end

def output_sequence_answer(sequence)
  puts "Sequence: #{sequence}. #{sequence.min}+#{sequence.max} = #{sequence.min + sequence.max}"
end

# Load all lines into list
example_numbers = File.readlines("example.txt")
example_numbers.map!(&:to_i)
example_invalid_number = find_invalid_number(example_numbers, 5)
example_sequence = sequence_that_sums_to(example_invalid_number, example_numbers)
output_sequence_answer(example_sequence)
puts

# For actual input data
numbers = File.readlines("input.txt")
numbers.map!(&:to_i)
actual_invalid_number = find_invalid_number(numbers, 25)
actual_sequence = sequence_that_sums_to(actual_invalid_number, numbers)
output_sequence_answer(actual_sequence)