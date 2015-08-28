require_relative "../lib/bot"
require_relative "../lib/board"
require 'pry'
context "the computer player" do

  describe "#next_best_move" do
    it "trys to play center square first then a corner square" do
      board = Board.new
      bot = Bot.new
      bot.piece = "O"
      next_best_move = bot.next_best_move(board)
      expect(next_best_move).to eq("4")
      board.spaces[4] = "O"
      next_best_move = bot.next_best_move(board)
      expect(["0", "2", "6", "8"]).to include(next_best_move)
    end
  end

  describe "#random_name" do
    it "creates a random name" do
      bot = Bot.new
      expect(bot.name).not_to be_empty
    end
  end

end
