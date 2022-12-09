class File:
  def __init__(self, name: str, size: int):
    self.name = name
    self.size = size

  def get_name(self):
    return self.name

  def get_size(self):
    return self.size

  def print(self, indent=0):
    print(f"{'  '*indent}- {self.name} (file, size={self.size})")

  def __str__(self):
    return f"{self.name} ({self.size})"
