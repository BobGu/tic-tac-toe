require_relative '../lib/game'
# additional features
# player start should be random

context "when playing the game" do
  before(:each) { @game = Game.new }
  describe "#valid_move?" do
      it "returns true for valid moves and false for invalid" do
        @game.board = ["0", "1", "2", "X", "4", "5", "6", "7", "O"]
        expect(@game.valid_move?(0)).to be true
        expect(@game.valid_move?(3)).to be false
        expect(@game.valid_move?(8)).to be false
        expect(@game.valid_move?("hello")).to be false
      end
  end

  describe "#available_spaces" do
    it "returns the available spaces" do
      @game.board = ["0", "1", "2", "X", "O", "X", "6", "7", "8"]
      expect(@game.available_spaces).to eq(["0", "1", "2", "6", "7", "8"])
    end
  end

  describe "#center_square_available?" do
    it "returns true or false if avaialbe" do
      expect(@game.center_square_available?).to be true
      @game.board[4] = "X"
      expect(@game.center_square_available?).to be false
    end
  end

  describe "#eval_board" do
    it "computer plays center square if available" do
      @game.board = (0..8).to_a.map { |number| number.to_s }
      @game.eval_board
      expect(@game.center_square_available?).to be false
    end
  end

  describe "#rows" do
    it "returns the rows of the game board" do
      rows = @game.rows
      expect(rows[0]).to eq(["0", "1", "2"])
      expect(rows[1]).to eq(["3", "4", "5"])
      expect(rows[2]).to eq(["6", "7", "8"])
    end
  end

  describe "#three_across?" do
    it "return true if 3 of the pieces are the same" do
      @game.board = ["O", "O", "O", "O", "O", "5", "6", "7", "8"]
      expect(@game.three_across?).to be true
      @game.board = ["O", "X", "O", "X", "X", "X", "6", "7", "8"]
      expect(@game.three_across?).to be true
      @game.board = ["O", "X", "O", "X", "X", "5", "6", "7", "8"]
      expect(@game.three_across?).to be false
    end
  end

  describe "#columns" do
    it "return the columns of the game board" do
      columns = @game.columns
      expect(columns[0]).to eq(["0","3","6"])
      expect(columns[1]).to eq(["1","4","7"])
      expect(columns[2]).to eq(["2","5","8"])
    end
  end

  describe "#three_vertically?" do
    it "returns true if 3 of the pieces are the same vertically" do
      @game.board = ["O", "1", "X", "O", "X", "5", "O", "7", "8"]
      expect(@game.three_vertically?).to be true
      @game.board = ["0", "O", "X", "3", "O", "X", "6", "O", "8"]
      expect(@game.three_vertically?).to be true
      @game.board = ["X", "X", "2", "X", "4", "O", "6", "O", "8"]
      expect(@game.three_vertically?).to be false
    end
  end


  describe "#diagonals" do
    it "return the diagoanls based on the board" do
      diagonals = @game.diagonals
      expect(diagonals[0]).to eq(["0","4","8"])
      expect(diagonals[1]).to eq(["2","4","6"])
    end
  end

  describe "#three_diagonally?" do
    it "returns true or false if 3 of the pieces are the same diagonally" do
      @game.board = ["O", "1", "2", "X", "O", "X", "O", "7", "O"]
      expect(@game.three_diagonally?).to be true
      @game.board = ["0", "1", "X", "3", "X", "O", "X", "O", "8"]
      expect(@game.three_diagonally?).to be true
      @game.board = ["0", "1", "X", "3", "X", "O", "6", "O", "8"]
      expect(@game.three_diagonally?).to be false
    end
  end

  describe "#won?" do
    it "returns true or false if game is won" do
      @game.board = ["O", "1", "2", "X", "O", "X", "O", "7", "O"]
      expect(@game.won?).to be true
      @game.board = ["0", "1", "X", "3", "X", "O", "6", "O", "8"]
      expect(@game.won?).to be false
      @game.board = ["O", "1", "X", "O", "X", "5", "O", "7", "8"]
      expect(@game.won?).to be true
      @game.board = ["O", "X", "O", "X", "X", "X", "6", "7", "8"]
      expect(@game.won?).to be true
    end
  end

  describe "#tie?" do
    it "returns true or false if it is a tie" do
      @game.board = ["O", "X", "O", "X", "O", "X", "X", "O", "X"]
      expect(@game.tie?).to be true
      @game.board = ["O", "X", "O", "X", "O", "X", "X", "O", "8"]
      expect(@game.tie?).to be false
    end
  end
end
