def calculate(file_name)
  lines = File.readlines(file_name)

  incomplete = lines.map do |line|
    stack = []
    score = 0
    error = false
    line.chomp.chars.each do |character|
      if stack.empty? || ['(','[','{','<'].include?(character)
        stack << character
      else
        top = stack.pop
        if (top == '(' && character != ')') ||
          (top == '[' && character != ']') ||
          (top == '{' && character != '}') ||
          (top == '<' && character != '>')
          error = true
        end
      end
    end
    stack if !error
  end.compact

  score_lookup = {
    '(' => 1,
    '[' => 2,
    '{' => 3,
    '<' => 4
  }
  
  scores = incomplete.map do |stack|
    score = 0
    stack.reverse.each do |character|
      score *= 5
      score += score_lookup[character]
    end
    score
  end
  p scores.sort[scores.length/2]
end

calculate("example_input.txt")
calculate("input.txt")