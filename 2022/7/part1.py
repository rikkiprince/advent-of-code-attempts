
# from file_system import FileSystem, Directory, File
from utilities import parse_commands


def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  fs = parse_commands(lines)

  fs.print()
  print(sum([s for s in fs.all_directory_sizes() if s <= 100_000]))


# calculate("example_input.txt")
calculate("input.txt")
