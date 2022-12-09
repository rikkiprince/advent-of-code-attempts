import re

"""Module"""
from collections import defaultdict


def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip('\n') for line in file]

  # print(lines)
  
  stacks = defaultdict(list)
  line = lines.pop(0)
  max_columns = int((len(line)-1)/4) + 1
  # print(f"{len(line)} max_c: {max_columns}")
  while line:
    for idx, character in enumerate(line):
      if character.isalpha():
        # print(f"{character} {idx} {idx-1} {(idx-1)/4} {int((idx-1)/4)}")
        column = int((idx-1)/4) + 1
        stacks[column].insert(0,character)
    line = lines.pop(0)
  
  for line in lines:
    m = re.search("^move ([0-9]+) from ([0-9]+) to ([0-9]+)$", line)
    if m:
      how_many = int(m.group(1))
      source = int(m.group(2))
      destination = int(m.group(3))
      crane = []
      for _ in range(how_many):
        x = stacks[source].pop()
        crane.append(x)
      while crane:
        x = crane.pop()
        stacks[destination].append(x)

  answer = ""
  for column in range(1,max_columns+1):
    answer += stacks[column].pop()
  print(answer)

calculate("example_input.txt")
calculate("input.txt")
