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

# Load all lines into list
# operations = File.readlines("example.txt")