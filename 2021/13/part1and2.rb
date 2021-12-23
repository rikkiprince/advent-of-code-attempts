require 'pp'

class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def bold;           "\e[1m#{self}\e[22m" end
end

def plot(dots)
  max_x = (dots.max {|a,b| a["x"] <=> b["x"]})["x"] + 1
  max_y = (dots.max {|a,b| a["y"] <=> b["y"]})["y"] + 1
  map = Array.new(max_y) {Array.new(max_x," ")}
  dots.each do |d|
    map[d["y"]][d["x"]] = "#"
  end

  max_y.times do |y|
    max_x.times do |x|
      print map[y][x].red
    end
    puts
  end
end

def calculate(file_name)
  lines = File.readlines(file_name)

  part1 = false

  dots = []
  folds = []
  lines.each do |line|
    case line
    when /([0-9]+),([0-9]+)/
      dots << {"x"=>$1.to_i,"y"=>$2.to_i}
    when /fold along ([xy])=([0-9]+)/
      folds << [$1,$2.to_i]
    end
  end

  folds.each do |fold|
    axis = fold[0]
    position = fold[1]
    to_fold,stay_still = dots.partition {|d| d[axis] > position }

    to_fold.map! do |d|
      d[axis] -= 2*(d[axis]-position)
      d
    end
    dots = to_fold | stay_still
    break if part1
  end
  pp dots.length

  plot(dots) if !part1
end

calculate("example_input.txt")
calculate("input.txt")