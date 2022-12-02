def calculate(file_name):
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

calculate("example_input.txt")
# calculate("input.txt")