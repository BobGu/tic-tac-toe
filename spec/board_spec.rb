require_relative '../lib/board'

context "a tic tac toe board" do
  before(:each) { @board = Board.new }

  describe "#initialize" do
    it "it creates a new set of spaces" do
      board = Board.new
      expect(board.spaces).to eq(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
    end
  end

  describe "#available_spaces" do
    it "returns the available spaces" do
      @board.spaces = ["0", "1", "2", "X", "O", "X", "6", "7", "8"]
      expect(@board.available_spaces).to eq(["0", "1", "2", "6", "7", "8"])
    end
  end

  describe "#center_square_available?" do
    it "returns true or false if avaialbe" do
      expect(@board.center_square_available?).to be true
      @board.spaces[4] = "X"
      expect(@board.center_square_available?).to be false
    end
  end

  describe "#valid_move?" do
    it "returns true for valid moves and false for invalid" do
      @board.spaces = ["0", "1", "2", "X", "4", "5", "6", "7", "O"]
      expect(@board.valid_move?("0")).to be true
      expect(@board.valid_move?("3")).to be false
      expect(@board.valid_move?("8")).to be false
      expect(@board.valid_move?("hello")).to be false
    end
  end

  describe "#rows" do
    it "returns the rows from the board" do
      rows = @board.rows
      expect(rows[0]).to eq(["0", "1", "2"])
      expect(rows[1]).to eq(["3", "4", "5"])
      expect(rows[2]).to eq(["6", "7", "8"])
    end
  end

  describe "#columns" do
    it "returns the columns from the board" do
      columns = @board.columns
      expect(columns[0]).to eq(["0", "3", "6"])
      expect(columns[1]).to eq(["1", "4", "7"])
      expect(columns[2]).to eq(["2", "5", "8"])
    end
  end

  describe "#diagonals" do
    it "returns the diagonals from the board" do
      diagonals = @board.diagonals
      expect(diagonals[0]).to eq(["0", "4", "8"])
      expect(diagonals[1]).to eq(["2", "4", "6"])
    end
  end

  describe "#available_corners" do
    it "returns the availble corners" do
      expect(@board.available_corners).to eq(["0", "2", "6", "8"])
      @board.spaces[0] = ["X"]
      expect(@board.available_corners).to eq(["2", "6", "8"])
    end
  end

  describe "#possible_wins" do
    it "returns all sets of possible_wins" do
      expect(@board.possible_wins).to eq([["0", "1", "2"], ["3", "4", "5"], ["6", "7", "8"],
                                         ["0", "3", "6"], ["1", "4", "7"], ["2", "5", "8"],
                                         ["0", "4", "8"], ["2", "4", "6"]])
    end
  end

  describe "#side_middles" do
    it "returns all the spaces that are on the edge and in the middle" do
      expect(@board.side_middles).to eq(["1", "3", "5", "7"])
    end
  end

  describe "#corners" do
    it "return all the corners from the board" do
      expect(@board.corners).to eq (["0", "2", "6", "8"])
    end
  end

end
