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

def print_grid(w1, w2, h1, h2, snake):
  for y in reversed(range(h1,h2)):
    for x in range(w1,w2):
      pos = (x,y)
      char = "."
      try:
        idx = snake.index(pos)
      except ValueError:
        idx = -1
      if idx == 0:
        char = "H"
      elif idx > 0:
        char = f"{idx}"
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
  # tail = head = (0,0)
  snake = [(0,0)]*10
  tail_visited = set([snake[-1]])

  print("== Initial State ==")
  print_grid(-11,15,-5,15, snake)
  for line in lines:
    direction, distance = line.split(' ')
    distance = int(distance)
    print(f"== {direction} {distance} ==")
    vector = direction_lookup[direction]
    for _ in range(1,distance+1):
      snake[0] = sum_tuple(snake[0],vector)
      for i in range (1,10):
        snake[i] = move_tail(snake[i-1], snake[i])
      tail_visited.add(snake[-1])
      print_grid(-11,15,-5,15, snake)
  print(f"Answer: {len(tail_visited)}")

# calculate("example_input.txt")
calculate("example_input_2a.txt")
# calculate("input.txt")
