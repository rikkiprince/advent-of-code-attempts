def calculate(file_name)
  lines = File.readlines(file_name)

  oxygen_generator_rating = find_the_rating(lines, 0, true)
  co2_generator_rating = find_the_rating(lines, 0, false)

  puts "oxygen: #{oxygen_generator_rating}"
  puts "co2: #{co2_generator_rating}"

  puts "result: #{oxygen_generator_rating.to_i(2)*co2_generator_rating.to_i(2)}"
end

def find_the_rating(numbers, index, most_significant)
  return numbers.first if numbers.length == 1

  numbers_with_zeroes, numbers_with_ones = numbers.partition { |number| number[index] == "0" }
  if most_significant
    if numbers_with_ones.length >= numbers_with_zeroes.length
      return find_the_rating(numbers_with_ones, index+1, most_significant)
    else
      return find_the_rating(numbers_with_zeroes, index+1, most_significant)
    end
  else
    if numbers_with_ones.length >= numbers_with_zeroes.length
      return find_the_rating(numbers_with_zeroes, index+1, most_significant)
    else
      return find_the_rating(numbers_with_ones, index+1, most_significant)
    end
  end
end

calculate("example_input.txt")
calculate("input.txt")