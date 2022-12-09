def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  highest_total = 0
  running_total = 0
  for line in lines:
    if line:
      running_total += int(line)
    else:
      highest_total = max(highest_total, running_total)
      running_total = 0
    # print(f"run: {running_total} high: {highest_total}")

  highest_total = max(highest_total, running_total)

  print(highest_total)

calculate("example_input.txt")
calculate("input.txt")