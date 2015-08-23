require_relative '../lib/game'
# additional features
# player start should be random

context "when playing the game" do
  before(:each) do
    @game = Game.new
  end

  describe "#assign_players_piece" do
    it "assign_players_piece" do
      @game.assign_players_piece('X')
      expect(@game.player.piece).to eq('X')
    end
  end

  describe "#bots_piece" do
    it "returns the opposite piece of the humans" do
      @game.assign_players_piece('X')
      expect(@game.bots_piece).to eq('O')
      @game.assign_players_piece('O')
      expect(@game.bots_piece).to eq('X')
    end
  end

  describe "#eval_board" do
    it "computer plays center square if available" do
      @game.assign_players_piece('O')
      @game.create_bot
      @game.eval_board
      expect(@game.board.center_square_available?).to be false
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

  describe "#get_best_move" do
    it "automatically returns a corner spot if center square is taken" do
      @game.assign_players_piece('O')
      @game.create_bot
      @game.board.spaces[4] = 'O'
      result = @game.get_best_move
      expect(["0", "2", "6", "8"]).to include(result.to_s)
    end
  end

end
