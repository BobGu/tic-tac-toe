class Board
  attr_accessor :spaces

  def initialize
    @spaces = ("0".."8").to_a
  end

  def available_spaces
    spaces.reject { |space| space == "X" || space == "O" }
  end

  def center_square_available?
    available_spaces.include?("4")
  end

  def valid_move?(spot)
    available_spaces.include?(spot)
  end

  def rows
    spaces.each_slice(3).to_a
  end

  def columns
    rows[0].zip(rows[1], rows[2])
  end

  def diagonals
    [[spaces[0], spaces[4], spaces[8]] , [spaces[2], spaces[4], spaces[6]]]
  end

  def possible_wins
    rows + columns + diagonals
  end

  def available_corners
    available_spaces.select { |space| space == "0" || space == "2" || space == "6" || space == "8"}
  end

  def available_corner?
    available_corners.count > 0
  end

  def side_middles
    [spaces[1], spaces[3], spaces[5], spaces[7]]
  end

  def corners
    [spaces[0], spaces[2], spaces[6], spaces[8]]
  end

end
