require_relative '../lib/game'

context "when playing the game" do
  before(:each) do
    @game = Game.new
  end

  describe "#assign_player_piece" do
    it "assigns a humans piece" do
      @game.send(:assign_human_name, "John")
      @game.send(:assign_player_piece, "X")
      expect(@game.send(:human).piece).to eq('X')
    end
  end

  describe "#opposite_piece" do
    it "returns the opposite piece of the humans" do
      @game.send(:assign_human_name, "John")
      @game.send(:assign_player_piece, "X")
      @game.send(:create_bot)
      human_piece = @game.send(:human).piece
      expect(@game.send(:opposite_piece, human_piece)).to eq('O')
      @game.send(:human).piece = 'O'
      human_piece = @game.send(:human).piece
      expect(@game.send(:opposite_piece, human_piece)).to eq('X')
    end
  end

  describe "#won?" do
    it "returns true or false if game is won" do
      @game.send(:board).spaces = ["O", "1", "2", "X", "O", "X", "O", "7", "O"]
      expect(@game.send(:won?)).to be true
      @game.send(:board).spaces = ["0", "1", "X", "3", "X", "O", "6", "O", "8"]
      expect(@game.send(:won?)).to be false
      @game.send(:board).spaces = ["O", "1", "X", "O", "X", "5", "O", "7", "8"]
      expect(@game.send(:won?)).to be true
      @game.send(:board).spaces = ["O", "X", "O", "X", "X", "X", "6", "7", "8"]
      expect(@game.send(:won?)).to be true
    end
  end

  describe "#tie?" do
    it "returns true or false if it is a tie" do
      @game.send(:board).spaces = ["O", "X", "O", "X", "O", "X", "X", "O", "X"]
      expect(@game.send(:tie?)).to be true
      @game.send(:board).spaces = ["O", "X", "O", "X", "O", "X", "X", "O", "8"]
      expect(@game.send(:tie?)).to be false
    end
  end

  describe "#get_human_spot" do
    it "takes a human spot and places it on the board" do
      @game.send(:assign_human_name, "John")
      @game.send(:assign_player_piece, "O")
      @game.send(:get_human_spot, "1")
      expect(@game.send(:board).spaces).not_to include('1')
    end

    it "asks player again for a spot on invalid input" do
      @input  = StringIO.new("1\n")
      @game.input = @input
      @game.send(:assign_human_name, "John")
      @game.send(:assign_player_piece, "X")
      @game.send(:get_human_spot, "10")
      expect(@game.send(:board).spaces[1]).to eq("X")
    end
  end

  describe "#moves" do
    it "always ends up in a tie in a computer vs computer game" do
      @game.send(:create_bot)
      @game.send(:assign_player_piece, "X")
      @game.send(:create_bot)
      player_piece = @game.send(:players)[-2].piece
      @game.send(:assign_player_piece, @game.send(:opposite_piece, player_piece))
      @game.send(:assign_turn_order, "1")
      100.times do
        @input = StringIO.new('n')
        @game.input = @input
        @game.send(:moves)
        expect(@game.send(:tie?)).to eq true
      end
    end
  end


end
