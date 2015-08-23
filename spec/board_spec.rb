require './lib/board'

context "a tic tac toe board" do

  describe "a boards spaces" do
    it "#initialize" do
      board = Board.new
      expect(board.spaces).to eq(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
    end
  
  end
end
