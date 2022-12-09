def fully_encloses(a,b):
  """Method"""
  if (b[0] <= a[0] and a[1] <= b[1]):
    # print(f"{b[0]}-{b[1]} fully encloses {a[0]}-{a[1]}")
    return True

def overlaps(a,b):
  """Method"""
  if (a[1] >= b[0] and a[0] <= b[1]):
    return True

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]
  
  running_total = 0
  for line in lines:
    a,b = line.split(',')
    a = tuple([int(x) for x in a.split('-')])
    b = tuple([int(x) for x in b.split('-')])

    if overlaps(a,b) or overlaps(b,a):
      running_total += 1
    elif fully_encloses(a,b) or fully_encloses(b,a):
      running_total += 1

  print(running_total)

calculate("example_input.txt")
calculate("input.txt")
