def calculate(file_name)
  lines = File.readlines(file_name)

  x = lines.map do |line|
    input, output = line.chomp.split(" | ")

    inputs = input.split(" ")
    outputs = output.split(" ")

    outputs.select {|i| [2,4,3,7].include?(i.length) }.length
  end
  p x.sum
end

calculate("example_input.txt")
calculate("input.txt")