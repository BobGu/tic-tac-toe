require_relative "../lib/bot"
require_relative "../lib/board"
require 'pry'
context "the computer player" do

  describe "#next_best_move" do
    it "trys to play center square first then a corner square" do
      board = Board.new
      bot = Bot.new
      best_move = bot.next_best_move(board)
      expect(best_move).to eq("4")
      board.spaces[4] = 'X'
      best_move = bot.next_best_move(board)
      expect(["0", "2", "6", "8"]).to include(best_move)
    end
  end

  

end
