require_relative '../lib/game'

context "when playing the game" do
  before(:each) { @game = Game.new }
  describe "#valid_move?" do
      it "return true for valid moves and false for invalid" do
        @game.board = ["0", "1", "2", "X", "4", "5", "6", "7", "O"]
        expect(@game.valid_move?(0)).to be true
        expect(@game.valid_move?(3)).to be false
        expect(@game.valid_move?(8)).to be false
        expect(@game.valid_move?("hello")).to be false
      end
  end

  describe "#available_spaces" do
    it "return the available spaces" do
      @game.board = ["0", "1", "2", "X", "Y", "X", "6", "7", "8"]
      expect(@game.available_spaces).to eq(["0", "1", "2", "6", "7", "8"])
    end
  end


end
