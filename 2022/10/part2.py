"""Module"""
def draw(reg_X, cycle):
  if (cycle % 40) in [reg_X-1,reg_X,reg_X+1]:
    print("#", end="")
  else:
    print(".", end="")
  if (cycle+1) % 40 == 0:
    print("")

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  reg_X = 1
  cycle = 0

  for line in lines:
    draw(reg_X, cycle)
    cycle += 1

    if line[0:4] == "addx":
      draw(reg_X, cycle)
      cycle += 1
      reg_X += int(line[5:])
  print("\n-------------")


# calculate("example_input.txt")
calculate("example_input_2.txt")
calculate("input.txt")
