"""Module"""
def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  print(lines)

calculate("example_input.txt")
# calculate("input.txt")
