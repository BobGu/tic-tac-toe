require 'pry'
class BoardEvaluator
  def self.check_for_wins?(possible_wins)
    possible_wins.any? do |possible_win|
      three_pieces_in_a_row?(possible_win)
    end
  end

  def self.three_pieces_in_a_row?(possible_win)
    possible_win.all? { |space| space == 'X' } || possible_win.all? { |space| space == 'O' }
  end

  def self.tie?(spaces)
    spaces.all? { |space|  space == 'X' || space == 'O' }
  end

  def self.blocking_a_win?(possible_win, piece)
    possible_win.any? { |space| space == piece }
  end

  def self.opposite_piece(piece)
    piece == 'X' ? 'O' : 'X'
  end

  def self.has_two_out_of_three_spaces?(possible_win, piece)
    possible_win.select{ |space| space == piece }.count == 2
  end

  def self.has_winning_move?(possible_win, piece)
    !blocking_a_win?(possible_win, opposite_piece(piece)) &&
    has_two_out_of_three_spaces?(possible_win, piece)
  end

  def self.find_winning_move(possible_wins, piece)
    possible_wins.select do |possible_win|
      has_winning_move?(possible_win, piece)
    end.flatten.detect { |space| space != piece }
  end

end
