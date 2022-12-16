"""Module"""
import functools


def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  reg_X = 1
  cycle = 0
  signals = {}

  for line in lines:
    cycle += 1
    if (cycle-20) % 40 == 0:
      signals[cycle] = reg_X
    if line[0:4] == "addx":
      cycle += 1
      if (cycle-20) % 40 == 0:
        signals[cycle] = reg_X
      reg_X += int(line[5:])
  
  print(signals.items())
  answer = functools.reduce(lambda a,b: a+b[0]*b[1], signals.items(), 0)
  print(f"Answer: {answer}")


calculate("example_input.txt")
calculate("example_input_2.txt")
calculate("input.txt")
