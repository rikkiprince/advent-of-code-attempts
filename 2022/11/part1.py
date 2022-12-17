import functools


class Monkey:
  def __init__(self, lines):
    self.items = list(map(int, lines.pop(0)[18:].split(", "))) # __Starting items: 79, 98
    self.operator = lines[0][23] # __Operation: new = old * old
    self.operand = lines.pop(0)[25:]
    self.test_divisor = int(lines.pop(0)[21:])
    self.if_true = int(lines.pop(0)[29:])
    self.if_false = int(lines.pop(0)[30:])

    self.inspections = 0

  def throw_to(self, monkey, item):
    monkey.items.append(item)

  def operation(self, worry):
    if self.operand == "old":
      operand = worry
    else:
      operand = int(self.operand)

    if self.operator == "+":
      # print(f"Worry level increases by {operand}.")
      answer = worry + operand
    elif self.operator == "*":
      # print(f"Worry level is multiplied by {operand}.")
      answer = worry * operand
    else:
      print("ERROR: unknown operator `{self.operator}`")

    return answer

  def round(self, monkeys):
    while self.items:
      self.inspections += 1
      worry = self.items.pop(0)
      # print(f"  Monkey inspects an item with a worry level of {worry}")
      new_worry = self.operation(worry)
      new_worry = int(new_worry/3)
      if new_worry % self.test_divisor == 0:
        self.throw_to(monkeys[self.if_true], new_worry)
      else:
        self.throw_to(monkeys[self.if_false], new_worry)

def print_monkeys(monkeys):
  for n, monkey in monkeys.items():
    print(f"Monkey {n}: {monkey.items}")

"""Module"""
def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  monkeys = {}
  while lines:
    if not lines[0]:
      lines.pop(0)
      continue

    n = int(lines.pop(0)[7:-1])
    monkeys[n] = Monkey(lines[:5])
    lines = lines[5:]

  print_monkeys(monkeys)

  for r in range(1,21):
    print(f"\n== Round {r} ==")
    for n, monkey in monkeys.items():
      # print(f"Monkey {n}:")
      monkey.round(monkeys)
    print_monkeys(monkeys)

  inspections = list(map(lambda x: x.inspections, monkeys.values()))
  top_2 = list(reversed(sorted(inspections)))[:2]
  print(f"\nAnswer: {top_2[0] * top_2[1]}")

calculate("example_input.txt")
calculate("input.txt")
