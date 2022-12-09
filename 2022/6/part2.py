"""Module"""
def end_of_marker(buffer, length):
  """Method"""
  for n in range(length,len(buffer)):
    if len(set(buffer[n-length:n])) == length:
      return n
  return 0

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  for line in lines:
    print(end_of_marker(line, 14))

calculate("example_input.txt")
calculate("input.txt")
