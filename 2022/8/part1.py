def print_grid(values):
  print('\n'.join(' '.join(str(x) for x in row) for row in values))
  print('-----------------------------')

def calculate(file_name):
  with open(file_name) as file:
    lines = [line.rstrip() for line in file]

  height = len(lines)
  width = len(lines[0])
  visibility = [ [False]*width for i in range(height)]
  # horizontally
  for y, row in enumerate(lines):
    tallest_tree = -1
    for x, tree_height in enumerate(row):
      tree_height = int(tree_height)
      if tree_height > tallest_tree:
        visibility[y][x] = True
        tallest_tree = tree_height

    tallest_tree = -1
    for x, tree_height in reversed(list(enumerate(row))):
      tree_height = int(tree_height)
      if tree_height > tallest_tree:
        visibility[y][x] = True
        tallest_tree = tree_height


  # vertically
  for x in range(len(lines[0])):
    tallest_tree = -1
    for y, row in enumerate(lines):
      tree_height = int(row[x])
      if tree_height > tallest_tree:
        visibility[y][x] = True
        tallest_tree = tree_height

    tallest_tree = -1
    for y, row in reversed(list(enumerate(lines))):
      tree_height = int(row[x])
      if tree_height > tallest_tree:
        visibility[y][x] = True
        tallest_tree = tree_height

  
  count = 0
  for row in visibility:
    for v in row:
      count += 1 if v else 0
  
  print(f"Answer: {count}")

calculate("example_input.txt")
calculate("input.txt")
