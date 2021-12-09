class Board
  def initialize(board_lines)
    @board = board_lines.map do |line|
      line.strip.split(" ")
    end
  end

  def mark(number)
    @board.map! do |line|
      line.map do |board_number|
        board_number == number ? "" : board_number
      end
    end
  end

  def winner?
    check_rows || check_columns
  end

  def check_rows
    @board.any? do |line|
      line.all? {|board_number| board_number.empty?}
    end
  end

  def check_columns
    width = @board.map(&:length).min
    # TODO: fix this. Trying to use map to figure out if each column is empty
    (0..width-1).map do |column|
      @board.map {|row| row[column]}.all? {|board_number| board_number.empty?}
    end.any?
  end

  def score
    @board.flatten.map(&:to_i).sum
  end
end

def calculate(file_name)
  lines = File.readlines(file_name)

  lines.map(&:chomp!)

  bingo_calls = lines.shift.split(",")
  
  boards = []
  while(lines.length > 0)
    _discard_blank = lines.shift
    board_lines = lines.shift(5)
    boards << Board.new(board_lines)
  end

  bingo_calls.each do |number|
    boards.each do |board|
      board.mark(number)
      if board.winner?
        puts "WINNER"
        puts "#{board.score} * #{number} = #{board.score * number.to_i}"
        
        # return # Part 1 - return at this point to find first winner
      end
    end
    boards.delete_if {|board| board.winner?}
  end
end

calculate("example_input.txt")
calculate("input.txt")

# class to represent the board?
# methods for: mark number, 