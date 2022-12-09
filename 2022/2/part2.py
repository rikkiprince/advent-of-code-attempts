def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]
  
  # A is Rock (1)
  # B is Paper (2)
  # C is Scissors (3)
  # X is draw (3)
  # Y is lose (0)
  # Z is win (6)

  score_lookup = {
    ('A', 'X'): 3 + 0, # Rock, lose (Scissors)
    ('A', 'Y'): 1 + 3, # Rock, draw
    ('A', 'Z'): 2 + 6, # Rock, win (Paper)
    ('B', 'X'): 1 + 0, # Paper, lose (Rock)
    ('B', 'Y'): 2 + 3, # Paper, draw
    ('B', 'Z'): 3 + 6, # Paper, win (Scissors)
    ('C', 'X'): 2 + 0, # Scissors, lose (Paper)
    ('C', 'Y'): 3 + 3, # Scissors, draw
    ('C', 'Z'): 1 + 6, # Scissors, win (Rock)
  }
  
  answer = 0
  for line in lines:
    p1, p2 = line.split(" ")
    answer += score_lookup[(p1,p2)]

  print(f"Answer: {answer}")

calculate("example_input.txt")
calculate("input.txt")
