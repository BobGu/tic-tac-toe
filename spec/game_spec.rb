require_relative '../lib/game'
# additional features
# player start should be random

context "when playing the game" do
  before(:each) do
    @game = Game.new
  end

  describe "#assign_human_piece" do
    it "assigns a humans piece" do
      @game.assign_human_name("John")
      @game.assign_human_piece('X')
      expect(@game.human.piece).to eq('X')
    end
  end

  describe "#opposite_piece" do
    it "returns the opposite piece of the humans" do
      @game.assign_human_name("John")
      @game.assign_human_piece('X')
      @game.create_bot
      expect(@game.opposite_piece).to eq('O')
      @game.human.piece = 'O'
      expect(@game.opposite_piece).to eq('X')
    end
  end

  describe "#won?" do
    it "returns true or false if game is won" do
      @game.board.spaces = ["O", "1", "2", "X", "O", "X", "O", "7", "O"]
      expect(@game.won?).to be true
      @game.board.spaces = ["0", "1", "X", "3", "X", "O", "6", "O", "8"]
      expect(@game.won?).to be false
      @game.board.spaces = ["O", "1", "X", "O", "X", "5", "O", "7", "8"]
      expect(@game.won?).to be true
      @game.board.spaces = ["O", "X", "O", "X", "X", "X", "6", "7", "8"]
      expect(@game.won?).to be true
    end
  end

  describe "#tie?" do
    it "returns true or false if it is a tie" do
      @game.board.spaces = ["O", "X", "O", "X", "O", "X", "X", "O", "X"]
      expect(@game.tie?).to be true
      @game.board.spaces = ["O", "X", "O", "X", "O", "X", "X", "O", "8"]
      expect(@game.tie?).to be false
    end
  end

  describe "#get_human_spot" do
    it "takes a human spot and places it on the board" do
      @game.assign_human_name('John')
      @game.assign_human_piece('O')
      @game.get_human_spot("1")
      expect(@game.board.spaces).not_to include('1')
    end

    it "asks player again for a spot on invalid input" do
      @input  = StringIO.new("1\n")
      @output = StringIO.new
      @game.input = @input
      @game.output = @output
      @game.assign_human_name("John")
      @game.assign_human_piece("X")
      @game.get_human_spot("10")
      expect(@game.board.spaces[1]).to eq("X")
    end
  end


end
