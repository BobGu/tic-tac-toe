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
end
