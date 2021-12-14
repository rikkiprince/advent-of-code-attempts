def calculate(file_name)
  line = File.readlines(file_name).first

  count_at_state = Array.new(9,0)

  line.split(",").each do |state|
    count_at_state[state.to_i] += 1
  end

  256.times do
    zeroes = count_at_state[0]
    (1..8).each do |index|
      count_at_state[index-1] = count_at_state[index]
    end
    count_at_state[6] += zeroes
    count_at_state[8] = zeroes
  end
  puts count_at_state.sum
end

calculate("example_input.txt")
calculate("input.txt")