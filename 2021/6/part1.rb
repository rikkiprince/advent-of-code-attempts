class Lanternfish
  def initialize(timer_initial_state)
    @timer = timer_initial_state
  end

  def iterate
    if @timer == 0
      @timer = 6
      return [self, Lanternfish.new(8)]
    end
    @timer -= 1
    return [self]
  end
end

def calculate(file_name)
  line = File.readlines(file_name).first

  fish = line.split(",").map {|state| Lanternfish.new(state.to_i)}
  80.times do
    fish = fish.flat_map(&:iterate)
  end
  puts fish.length
end

calculate("example_input.txt")
calculate("input.txt")