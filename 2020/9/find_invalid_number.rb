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

def find_invalid_number(numbers, preamble_length)
  (0..(numbers.size - preamble_length - 1)).each do |offset|
    previous_numbers = numbers[offset, preamble_length]
    next_number = numbers[offset+preamble_length]
    if !is_valid_next_number?(next_number, previous_numbers) then
      puts "#{next_number} is NOT a valid next number after #{previous_numbers}?"
      break
    end
  end
end

# Load all lines into list
example_numbers = File.readlines("example.txt")
example_numbers.map!(&:to_i)
find_invalid_number(example_numbers, 5)

# For actual input data
numbers = File.readlines("input.txt")
numbers.map!(&:to_i)
find_invalid_number(numbers, 25)