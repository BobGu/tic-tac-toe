require 'pry'
class Bot
  attr_accessor :piece, :name

  def initialize
    @name = random_name
  end

  def random_name
    ["Johnny5", "T-1000", "Siri", "Skynet", "Al Gore", "iRobot"].sample
  end

  def next_best_move(board)
    return "4" if board.center_square_available?
    return board.available_corners.sample if board.available_corner?
    board.available_spaces.sample
  end

  def random_move(available_spaces)
    available_spaces.sample
  end

end
