require './lib/player'
context "a human player playing the game" do
  describe "#piece" do
    it "knows which piece it is" do
      player = Player.new("O")
      expect(player.piece).to eq("O")
    end
  end
end
