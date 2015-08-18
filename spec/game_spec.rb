require_relative '../lib/game'

context "when playing the game" do
  before(:each) { @game = Game.new }
  it "gives evaluates if a move is valid" do
    @game.board = ["0", "1", "2", "X", "4", "5", "6", "7", "O"]
    expect(@game.valid_move?(0)).to be true
    expect(@game.valid_move?(3)).to be false
    expect(@game.valid_move?(8)).to be false
    expect(@game.valid_move?("hello")).to be false
  end
end
