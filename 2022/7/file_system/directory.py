class Directory:
  def __init__(self, name: str):
    self.name = name
    self.parent = None
    self.subdirectories = {}
    self.files = {}

  def set_parent(self, parent):
    self.parent = parent

  def get_name(self):
    return self.name

  def add_subdirectory(self, directory):
    directory.set_parent(self)
    self.subdirectories[directory.get_name()] = directory

  def add_file(self, file):
    self.files[file.get_name()] = file

  def get_subdirectory(self, name):
    if name == "..":
      return self.parent
    return self.subdirectories[name]

  def get_file(self, name):
    return self.files[name]

  def size(self):
    size = 0
    for _, file in self.files.items():
      size += file.get_size()
    for _, directory in self.subdirectories.items():
      size += directory.size()
    return size

  def all_directory_sizes(self):
    result = []
    for _, directory in self.subdirectories.items():
      result += directory.all_directory_sizes()
      result.append(directory.size())
    return result

  def print(self, indent=0):
    print(f"{'  '*indent}- {self.name} (dir, size={self.size()})")
    for _, directory in self.subdirectories.items():
      directory.print(indent+1)
    for _, file in self.files.items():
      file.print(indent+1)

  def __str__(self):
    return f"{self.name}"