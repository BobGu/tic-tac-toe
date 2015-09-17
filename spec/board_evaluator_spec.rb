require_relative '../lib/board_evaluator'

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

  describe ".tie" do
    it "returns true if the entire board is filled" do
      spaces = [
                "X", "O", "X",
                "O", "O", "X",
                "X", "X", "O"
              ]
      expect(BoardEvaluator.tie?(spaces)).to be true
    end
  end

  describe ".blocking_a_win" do
    it "returns true if opponents piece is in a set of three" do
      possible_win = ["X", "O", "X"]
      expect(BoardEvaluator.blocking_a_win?(possible_win, "O")).to be true
      possible_win = ["X", "1", "X"]
      expect(BoardEvaluator.blocking_a_win?(possible_win, "O")).to be false
    end
  end

  describe ".opposite_piece" do
    it "returns the opposite piece" do
      piece = "X"
      expect(BoardEvaluator.opposite_piece(piece)).to eq("O")
      piece = "O"
      expect(BoardEvaluator.opposite_piece(piece)).to eq("X")
    end
  end

  describe ".has_two_out_of_three_spaces?" do
    it "returns true if there are two of the specified pieces present" do
      piece = "X"
      possible_win = ["X", "X", "2"]
      expect(BoardEvaluator.has_two_out_of_three_spaces?(possible_win, piece)).to be true
      piece = "O"
      possible_win = ["O", "O", "8"]
      expect(BoardEvaluator.has_two_out_of_three_spaces?(possible_win, piece)).to be true
      possible_win = ["X", "1", "2"]
      piece = "X"
      expect(BoardEvaluator.has_two_out_of_three_spaces?(possible_win, piece)).to be false
    end
  end

  describe ".has_winning_move?" do
    it "returns true or false if the set of three has a winning move" do
      piece = "X"
      possible_win = ["X", "X", "2"]
      expect(BoardEvaluator.has_winning_move?(possible_win, piece)).to be true
      possible_win = ["O", "O", "X"]
      expect(BoardEvaluator.has_winning_move?(possible_win, piece)). to be false
    end
  end

  describe ".find_winning_move" do
    it "returns the winning move if that move exists" do
      piece = "X"
      board = [
                "X", "X", "O",
                "X", "O", "5",
                "6", "O", "O"
              ]
      possible_wins = [
                        ["X", "X", "O"], ["X", "O", "5"], ["6", "O", "O"],
                        ["X", "X", "6"], ["X", "O", "O"], ["O", "5", "O"],
                        ["X", "O", "O"], ["O", "O", "6"]
                      ]
      winning_move = BoardEvaluator.find_winning_move(possible_wins, piece)
      expect(winning_move).to eq("6")
    end
  end
end
