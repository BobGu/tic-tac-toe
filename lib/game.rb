require './lib/message_printer'
require 'pry'
class Game
  attr_accessor :input, :output, :board
  def initialize
    self.input = $stdin
    self.output = $stdout
    @board = (0..8).to_a.map { |n| n.to_s }
    @com = "X"
    @hum = "O"
  end

  def rows
    board.each_slice(3).to_a
  end

  def columns
    rows[0].zip(rows[1], rows[2])
  end

  def diagonals
    [[board[0], board[4], board[8]] , [board[2], board[4], board[6]]]
  end

  def available_corners
    available_spaces.select { |space| space == "0" || space == "2" || space == "6" || space == "8"}
  end

  def start_game
    MessagePrinter.welcome
    MessagePrinter.instructions(@hum)
    MessagePrinter.board(@board)
    puts "Please select your spot."
    until won? || tie?
      MessagePrinter.players_turn
      get_human_spot
      if !won? && !tie?
        eval_board
      end
      MessagePrinter.board(@board)
    end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if valid_move?(spot)
        @board[spot] = @hum
      else
        MessagePrinter.invalid_move(spot)
        spot = nil
      end
    end
  end

  def valid_move?(spot)
    @board.include?(spot.to_s) && @board[spot] != "X" && @board[spot] != "O"
  end

  def center_square_available?
    @board.include?("4")
  end

  def eval_board
    spot = nil
    until spot
      if center_square_available?
        @board[4] = @com
        spot = 4
      else
        spot = get_best_move
        if valid_move?(spot)
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
    MessagePrinter.computer_move(spot, @com)
  end

  def available_spaces
    board.reject { |space| space == "X" || space == "O" }
  end

  def get_best_move
    best_move = nil
    available_spaces.each do |as|
      board[as.to_i] = @com
      if won?
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if won?
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      if available_corners.count > 0
        n = available_corners.sample
      else
        n = available_spaces.sample
      end
      return n.to_i
    end
  end

  def three_across?
    rows.any? do |row|
      row.all? { |space| space == 'X' } || row.all? { |space| space == 'O' }
    end
  end

  def three_vertically?
    columns.any? do |column|
      column.all? { |space| space == 'X' } || column.all? { |space| space == 'O' }
    end
  end

  def three_diagonally?
    diagonals.any? do |diagonal|
      diagonal.all? { |space| space == 'X' } || diagonal.all? { |space| space == 'O' }
    end
  end

  def won?
    three_across? || three_vertically? || three_diagonally?
  end

  def tie?
    board.all? { |s| s == "X" || s == "O" }
  end


end
