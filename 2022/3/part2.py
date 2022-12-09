from collections import defaultdict

def get_score(letter):
  """Method"""
  i = ord(letter)
  if i in range(65,90+1):
    return i - 38
  elif i in range(97,122+1):
    return i - 96
  else:
    print(f"ERROR: {letter} {i}")

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]
  
  running_total = 0
  groups = defaultdict(lambda: defaultdict(int))
  for idx, line in enumerate(lines):
    group_number = int(idx/3)
    group_counts = groups[group_number]
    for letter in set(line):
      group_counts[letter] += 1
    if idx % 3 == 2:
      for letter, count in group_counts.items():
        if count == 3:
          running_total += get_score(letter)
          break
  
  print(running_total)

calculate("example_input.txt")
calculate("input.txt")