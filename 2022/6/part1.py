"""Module"""
def end_of_marker(buffer):
  """Method"""
  for n in range(4,len(buffer)):
    if len(set(buffer[n-4:n])) == 4:
      return n
  return 0

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  for line in lines:
    print(end_of_marker(line))

calculate("example_input.txt")
calculate("input.txt")
