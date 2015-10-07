require 'pry'
class Bot
  attr_accessor :piece, :name

  def initialize
    @name = random_name
  end

  def opposite_piece
    piece == "X" ? "O" : "X"
  end

  def random_name
    ["Johnny5", "T-1000", "Siri", "Skynet", "Al Gore", "iRobot"].sample
  end

  def detect_opposite_corner_strategy?(spaces)
    spaces[4] == piece && (spaces[0] == spaces[8] || spaces[6] == spaces[2])
  end

  def counter_opposite_corner_strategy
    ["1", "3", "5", "7"].sample
  end

  def detect_corner_triangle_strategy?(spaces)
    spaces[4] == piece &&
    less_than_five_pieces_on_board?(spaces) &&
    (
     spaces[1] == spaces[3] ||
     spaces[1] == spaces[5] ||
     spaces[3] == spaces[7] ||
     spaces[5] == spaces[7]
    )
  end

  def less_than_five_pieces_on_board?(spaces)
    spaces.select { |space| space == "X" || space == "O" }.count < 5
  end

  def counter_corner_triangle_strategy(spaces)
    return "0" if spaces[1] == spaces[3]
    return "2" if spaces[1] == spaces[5]
    return "6" if spaces[3] == spaces[7]
    return "8" if spaces[5] == spaces[7]
  end

  def detect_corner_side_middle_strategy?(board)
    board.corners.any? { |diagonal| diagonal == opposite_piece } &&
    board.side_middles.any? { |side_middle| side_middle == opposite_piece } &&
    less_than_five_pieces_on_board?(board.spaces)
  end

  def counter_corner_side_middle_strategy(board)
    corner_number = board.corners.index(opposite_piece)
    case corner_number
    when 0
      "8"
    when 1
      "6"
    when 2
      "2"
    when 3
      "0"
    end
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
