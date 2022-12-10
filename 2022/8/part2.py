def print_grid(values):
  print('\n'.join(' '.join(str(x) for x in row) for row in values))
  print('-----------------------------')

def calculate_scenic_score(x,y, grid):
  tree_height = grid[y][x]
  # horizontally
  left_count = 0
  for x1 in reversed(range(0,x)):
    left_count += 1
    if grid[y][x1] >= tree_height:
      break
  right_count = 0
  for x2 in range(x+1,len(grid[0])):
    right_count += 1
    if grid[y][x2] >= tree_height:
      break
  # vertically
  up_count = 0
  for y1 in reversed(range(0,y)):
    up_count += 1
    if grid[y1][x] >= tree_height:
      break
  down_count = 0
  for y2 in range(y+1,len(grid)):
    down_count += 1
    if grid[y2][x] >= tree_height:
      break
  return left_count * right_count * up_count * down_count

def calculate(file_name):
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  highest_scenic_score = 0
  for y, row in enumerate(lines):
    for x, _ in enumerate(row):
      scenic_score = calculate_scenic_score(x,y, lines)
      highest_scenic_score = max(highest_scenic_score, scenic_score)

  print(f"Answer: {highest_scenic_score}")

calculate("example_input.txt")
calculate("input.txt")
