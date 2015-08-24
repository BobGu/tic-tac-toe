require_relative "../lib/bot"
require_relative "../lib/board"
require 'pry'
context "the computer player" do

  describe "#initial_move" do
    it "trys to play center square first then a corner square" do
      board = Board.new
      bot = Bot.new("O")
      initial_move = bot.initial_move(board)
      expect(initial_move).to eq("4")
      board.spaces[4] = "O"
      initial_move = bot.initial_move(board)
      expect(["0", "2", "6", "8"]).to include(initial_move)
    end
  end



end
