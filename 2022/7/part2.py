
# from file_system import FileSystem, Directory, File
from utilities import parse_commands


def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  fs = parse_commands(lines)

  fs.print()
  used_space = fs.size()
  extra_space_required = 30_000_000 - (70_000_000 - used_space)
  print(min([s for s in fs.all_directory_sizes() if s >= extra_space_required]))


# calculate("example_input.txt")
calculate("input.txt")
