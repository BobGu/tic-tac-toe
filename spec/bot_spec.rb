require_relative "../lib/bot"

context "the computer player" do
  describe "#piece" do
    it "returns its piece, X or O" do
      bot = Bot.new('O')
      expect(bot.piece).to eq('O')
      bot2 = Bot.new('X')
      expect(bot2.piece).to eq('X')
    end
  end

end
