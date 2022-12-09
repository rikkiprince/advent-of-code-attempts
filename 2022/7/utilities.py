from file_system import FileSystem, Directory, File

def add_to_filesystem(fs, subdirectories, files):
  for directory in subdirectories:
    fs.add_directory(directory)
  for file in files:
    fs.add_file(file)

def parse_commands(lines) -> FileSystem:
  fs = FileSystem()
  subdirectories = []
  files = []
  while lines:
    line = lines.pop(0)
    match line[0]:
      case "$":
        add_to_filesystem(fs, subdirectories, files)
        subdirectories = []
        files = []
        if line[2:4] == "cd":
          fs.change_directory(line[5:])
        elif line[2:4] == "ls":
          pass
      case "d":
        subdirectories.append(Directory(line[4:]))
      case '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9':
        size, name = line.split(' ')
        files.append(File(name, int(size)))
      case _:
        print(f"ERROR: {line}")
  add_to_filesystem(fs, subdirectories, files)
  return fs