import sys
"""Module"""
def sum_tuple(a,b):
  return tuple([sum(x) for x in zip(a,b)])

def find_start(lines):
  for y, row in enumerate(lines):
    for x, height in enumerate(row):
      if height == 'E':
        return (x,y)

DIRECTIONS = [
  ( 1, 0),
  (-1, 0),
  ( 0, 1),
  ( 0,-1),
]
def potential_next_node(grid, current):
  x,y = current
  current_height = grid[y][x]
  if current_height == 'E':
    current_height = 'z'
  results = []
  for d in DIRECTIONS:
    nx, ny = sum_tuple(current, d)
    if nx < 0 or ny < 0 or ny >= len(grid) or nx >= len(grid[0]):
      continue
    next_height = grid[ny][nx]
    if next_height == 'S':
      next_height = 'a'
    if ord(next_height) + 1 >= ord(current_height):
      results.append((nx,ny))
  return results

def print_previous(previous, end):
  route = []
  p = previous.get(end, None)
  while p is not None:
    route.insert(0, p)
    p = previous.get(p)
  print(route)

def calculate(file_name):
  """Method"""
  with open(file_name) as file:
    grid = [line.rstrip() for line in file]


  start = find_start(grid)
  queue = [start]
  distance = {start: 0}
  previous = {}
  visited = set([start])
  while queue:
    x,y = current_coord = queue.pop(0)
    print(f"Visiting: {current_coord}")

    current_height = grid[y][x]
    if current_height == 'a':
      print(f"Answer: {distance[current_coord]}")
      print_previous(previous, current_coord)
      break

    for n in potential_next_node(grid, current_coord):
      if n in visited:
        continue
      n_distance = distance.get(n, sys.maxsize)
      if distance[current_coord]+1 < n_distance:
        distance[n] = distance[current_coord]+1
        previous[n] = current_coord
      queue.append(n)
      visited.add(n)


calculate("example_input.txt")
calculate("input.txt")
