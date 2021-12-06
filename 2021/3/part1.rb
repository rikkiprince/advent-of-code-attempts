def calculate(file_name)
  lines = File.readlines(file_name)

  zeroes = Hash.new(0)
  ones = Hash.new(0)
  number_of_digits = 0

  lines.each do |line|
    line.split("").each_with_index do |digit, index|
      case digit
      when "0"
        zeroes[index] += 1
      when "1"
        ones[index] += 1
      end
    end
    number_of_digits = line.length
  end

  most_common = ""
  least_common = ""
  number_of_digits.times do |index|
    if ones[index] > zeroes[index]
      most_common = "#{most_common}1"
      least_common = "#{least_common}0"
    else
      most_common = "#{most_common}0"
      least_common = "#{least_common}1"
    end
  end
  gamma = most_common.to_i(2)
  epsilon = least_common.to_i(2)
  puts "#{gamma} (0x#{most_common})"
  puts "#{epsilon} (0x#{least_common})"
  puts "result: #{gamma*epsilon}"
end

calculate("example_input.txt")
calculate("input.txt")