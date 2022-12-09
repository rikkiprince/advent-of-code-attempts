def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  highest_three = []
  running_total = 0
  for line in lines:
    if line:
      running_total += int(line)
    else:
      highest_three.append(running_total)
      highest_three.sort()
      highest_three.reverse()
      highest_three = highest_three[:3]
      running_total = 0
    # print(f"run: {running_total} high: {highest_total}")

  highest_three.append(running_total)
  highest_three.sort()
  highest_three.reverse()
  highest_three = highest_three[:3]

  print(highest_three)
  print(sum(highest_three))

calculate("example_input.txt")
calculate("input.txt")