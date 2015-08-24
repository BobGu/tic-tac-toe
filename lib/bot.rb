require 'pry'
class Bot
  def initialize(piece)
    @piece = piece
  end

  def next_best_move(board)
    return "4" if board.center_square_available?
    return board.available_corners.sample if board.available_corner?
    board.available_spaces.sample
  end

end
