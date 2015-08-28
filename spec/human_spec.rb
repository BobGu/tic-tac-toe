require './lib/player'
context "a human player playing the game" do
  describe "#piece" do
    it "knows which piece it is" do
      player = Human.new("John")
      player.piece = "O"
      expect(player.piece).to eq("O")
    end
  end
end
