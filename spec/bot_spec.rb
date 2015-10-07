require_relative "../lib/bot"
require_relative "../lib/board"
require 'pry'
context "the computer player" do
  describe "#opposite_corner_strategy?" do
    it "returns true when human player is using an opposite corner strategy" do
      board = Board.new
      bot = Bot.new
      bot.piece = "O"
      board.spaces = [
                       "X", "1", "2",
                       "3", "O", "5",
                       "6", "7", "X"
                     ]
      expect(bot.detect_opposite_corner_strategy?(board.spaces)).to be true
      board.spaces = [
                       "X", "1", "2",
                       "3", "O", "5",
                       "X", "7", "8"
                    ]

      expect(bot.detect_opposite_corner_strategy?(board.spaces)).to be false
    end
  end

  describe "#counter_opposite_corner_strategy" do
    it "prevents the human player from making two possible wins using a opposite corner strategy" do
      board = Board.new
      bot = Bot.new
      bot.piece = "O"
      board.spaces = [
                       "X", "1", "2",
                       "3", "O", "5",
                       "6", "7", "X"
                     ]
      counter_move = bot.counter_opposite_corner_strategy
      expect(["1", "3", "5", "7"]).to include(counter_move)
    end
  end

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
