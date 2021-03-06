require_relative "../lib/bot"
require_relative "../lib/board"
require 'pry'
context "the computer player" do
  describe "#detect_opposite_corner_strategy?" do
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
      counter_move = bot.counter_opposite_corner_strategy
      expect(["1", "3", "5", "7"]).to include(counter_move)
    end
  end

  describe "#detect_corner_triangle_strategy?" do
    it "detects if human is using a corner triangle strategy" do
      board = Board.new
      bot = Bot.new
      bot.piece = "O"
      board.spaces = [
                       "0", "X", "2",
                       "X", "O", "5",
                       "6", "7", "8"
                     ]

      expect(bot.detect_corner_triangle_strategy?(board.spaces)).to be true

      board.spaces = [
                       "1", "X", "2",
                       "3", "O", "X",
                       "6", "7", "8"
                     ]

      expect(bot.detect_corner_triangle_strategy?(board.spaces)).to be true

      board.spaces = [
                       "1", "2", "3",
                       "X", "O", "5",
                       "6", "X", "8"
                     ]

      expect(bot.detect_corner_triangle_strategy?(board.spaces)).to be true

      board.spaces = [
                       "X", "X", "2",
                       "3", "O", "5",
                       "6", "7", "8"
                     ]

      expect(bot.detect_corner_triangle_strategy?(board.spaces)).to be false
    end
  end

  describe "detect_corner_side_middle_strategy?" do
    board = Board.new
    bot = Bot.new
    bot.piece = "O"
    # detect if playing corner middle strategy
    # playing corner side middle when side middle is not right next to the corner its playing
    it "returns true if the human is using a corner and side middle opening move" do
      board.spaces = [
                       "X", "1", "2",
                       "3", "O", "5",
                       "6", "X", "8"
                     ]
      expect(bot.detect_corner_side_middle_strategy?(board)).to be true

      board.spaces = [
                       "0", "X", "2",
                       "3", "O", "5",
                       "6", "7", "X"
                     ]

      expect(bot.detect_corner_side_middle_strategy?(board)).to be true

      board.spaces = [
                       "0", "1", "2",
                       "X", "O", "5",
                       "6", "7", "X"
                     ]

      expect(bot.detect_corner_side_middle_strategy?(board)).to be true
    end
  end

  describe "#counter_corner_side_middle_strategy" do
    it "returns the opposite corner space of the humans piece" do
      board = Board.new
      bot = Bot.new
      bot.piece = "O"
      board.spaces = [
                       "0", "1", "X",
                       "3", "O", "5",
                       "6", "X", "8"
                     ]
      expect(bot.counter_corner_side_middle_strategy(board)).to eq("6")

      board.spaces = [
                       "X", "1", "2",
                       "3", "O", "5",
                       "6", "X", "8"
                     ]

      expect(bot.counter_corner_side_middle_strategy(board)).to eq("8")
    end
  end

  describe "#counter_corner_triangle_strategy" do
    it "returns the appropriate corner when countering a corner triangle strategy" do
      board = Board.new
      bot = Bot.new
      bot.piece = "O"
      board.spaces = [
                       "0", "X", "2",
                       "X", "O", "5",
                       "6", "7", "8"
                     ]
      expect(bot.counter_corner_triangle_strategy(board.spaces)).to eq("0")

      board.spaces = [
                       "1", "X", "2",
                       "3", "O", "X",
                       "6", "7", "8"
                     ]
      expect(bot.counter_corner_triangle_strategy(board.spaces)).to eq("2")

      board.spaces = [
                       "1", "2", "3",
                       "X", "O", "5",
                       "6", "X", "8"
                     ]

      expect(bot.counter_corner_triangle_strategy(board.spaces)).to eq("6")

      board.spaces = [
                       "0", "1", "2",
                       "3", "O", "X",
                       "6", "X", "8"
                     ]

      expect(bot.counter_corner_triangle_strategy(board.spaces)).to eq("8")
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
