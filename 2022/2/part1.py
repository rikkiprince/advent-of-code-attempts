def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]
  
  # A X is Rock
  # B Y is Paper
  # C Z is Scissors

  score_lookup = {
    ('A', 'X'): 1 + 3, # Rock, draw
    ('A', 'Y'): 2 + 6, # Paper, win
    ('A', 'Z'): 3 + 0, # Scissors, lose
    ('B', 'X'): 1 + 0, # Rock, lose
    ('B', 'Y'): 2 + 3, # Paper, draw
    ('B', 'Z'): 3 + 6, # Scissors, win
    ('C', 'X'): 1 + 6, # Rock, win
    ('C', 'Y'): 2 + 0, # Paper, lose
    ('C', 'Z'): 3 + 3, # Scissors, draw
  }
  
  answer = 0
  for line in lines:
    p1, p2 = line.split(" ")
    answer += score_lookup[(p1,p2)]

  print(f"Answer: {answer}")

calculate("example_input.txt")
calculate("input.txt")
