require './lib/board_evaluator'

context "evaluates a board" do
  describe ".three_pieces_in_a_row?" do
    it "returns true if there are three pieces in a row" do
      possible_win = ["O", "O", "O"]
      expect(BoardEvaluator.three_pieces_in_a_row?(possible_win)).to be true
      possible_win = ["X", "X", "X"]
      expect(BoardEvaluator.three_pieces_in_a_row?(possible_win)).to be true
      possible_win = ["O", "O", "X"]
      expect(BoardEvaluator.three_pieces_in_a_row?(possible_win)).to be false
    end
  end

  describe ".check_for_wins?" do
    it "return true if any possible wins have the pieces that are the same" do
      possible_wins = [["O", "O", "O"], ["O", "O", "5"], ["6", "7", "8"]]
      expect(BoardEvaluator.check_for_wins?(possible_wins)).to be true
      possible_wins = [["O", "X", "O"], ["X", "X", "X"], ["6", "7", "8"]]
      expect(BoardEvaluator.check_for_wins?(possible_wins)).to be true
      possible_wins = [["O", "X", "O"], ["X", "X", "5"], ["6", "7", "8"]]
      expect(BoardEvaluator.check_for_wins?(possible_wins)).to be false
    end
  end
end
