def sum_tuple(a,b):
  return tuple([sum(x) for x in zip(a,b)])

def sign(x):
  if x == 0: return 0
  elif x < 0: return -1
  elif x > 0: return 1

def move_tail(head, tail):
  dx = head[0] - tail[0]
  dy = head[1] - tail[1]
  if abs(dx) > 1:
    dx = sign(dx) * (abs(dx)-1)
    tail = sum_tuple(tail,(dx,dy))
  elif abs(dy) > 1:
    dy = sign(dy) * (abs(dy)-1)
    tail = sum_tuple(tail,(dx,dy))
  return tail

def print_grid(width, height, head, tail):
  for y in reversed(range(height)):
    for x in range(width):
      pos = (x,y)
      char = "."
      if pos == head:
        char = "H"
      elif pos == tail:
        char = "T"
      elif pos == (0,0):
        char = "s"
      print(char, end="")
    print("")
  print("")

def calculate(file_name):
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  direction_lookup = {
    'R': ( 1,0),
    'L': (-1,0),
    'U': (0, 1),
    'D': (0,-1),
  }
  tail = head = (0,0)
  tail_visited = set([tail])

  print("== Initial State ==")
  print_grid(6,5, head,tail)
  for line in lines:
    direction, distance = line.split(' ')
    distance = int(distance)
    print(f"== {direction} {distance} ==")
    vector = direction_lookup[direction]
    for _ in range(1,distance+1):
      head = sum_tuple(head,vector)
      tail = move_tail(head, tail)
      # print_grid(6,5, head,tail)
      tail_visited.add(tail)
  print(f"Answer: {len(tail_visited)}")

calculate("example_input.txt")
calculate("input.txt")
