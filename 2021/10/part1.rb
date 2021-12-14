def calculate(file_name)
  lines = File.readlines(file_name)

  score_lookup = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
  }

  scores = lines.map do |line|
    stack = []
    score = 0
    line.chomp.chars.each do |character|
      if stack.empty? || ['(','[','{','<'].include?(character)
        stack << character
      else
        top = stack.pop
        if (top == '(' && character != ')') ||
          (top == '[' && character != ']') ||
          (top == '{' && character != '}') ||
          (top == '<' && character != '>')
          puts "ERROR - #{line.chomp} - top: #{top}, character: #{character}"
          score = score_lookup[character]
        end
      end
    end
    score
  end
  p scores.sum
end

calculate("example_input.txt")
calculate("input.txt")