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
      @game.board = ["0", "1", "2", "X", "Y", "X", "6", "7", "8"]
      expect(@game.available_spaces).to eq(["0", "1", "2", "6", "7", "8"])
    end
  end

  describe "#center_square_available?" do
    it "returns true or false if avaialbe" do
      @game.board = (0..8).to_a.map { |number| number.to_s }
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


end
