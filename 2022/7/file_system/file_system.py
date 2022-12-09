from .directory import Directory

class FileSystem:
  def __init__(self):
    self.root = Directory("/")
    self.current_directory = self.root

  def change_directory(self, name):
    if name == "/":
      self.current_directory = self.root
    else:
      next_directory = self.current_directory.get_subdirectory(name)
      self.current_directory = next_directory

  def add_directory(self, directory):
    self.current_directory.add_subdirectory(directory)

  def add_file(self, file):
    self.current_directory.add_file(file)

  def size(self):
    return self.root.size()

  def all_directory_sizes(self):
    result = self.root.all_directory_sizes()
    result.append(self.root.size())
    return result

  def print(self):
    self.root.print()
