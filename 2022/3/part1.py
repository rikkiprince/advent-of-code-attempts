def get_score(letter):
  i = ord(letter)
  if i in range(65,90+1):
    return i - 38
  elif i in range(97,122+1):
    return i - 96
  else:
    print(f"ERROR: {letter} {i}")

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]
  
  running_total = 0
  for line in lines:
    l = len(line)
    h = int(l/2)
    first = set(line[:h])
    second = set(line[h:])
    # print(f"{line} {l} {h} {first} {second}")
    in_both = first.intersection(second).pop()
    running_total += get_score(in_both)
  
  print(running_total)

calculate("example_input.txt")
calculate("input.txt")