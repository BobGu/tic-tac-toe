require 'message_printer'
require 'pry'
class Game
  attr_accessor :input, :output, :board
  def initialize
    self.input = $stdin
    self.output = $stdout
    @message_print = MessagePrinter.new
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

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please select your spot."
    until is_won?(@board) || tie?
      get_human_spot
      if !is_won?(@board) && !tie?
        eval_board
      end
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
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
        @message_print.invalid_move(spot)
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
        spot = get_best_move(@board, @com)
        if valid_move?(spot)
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def available_spaces
    board.reject { |space| space == "X" || space == "O" }
  end

  def get_best_move(board, next_player)
    available_spaces.each do |as|
      board[as.to_i] = @com
      if is_won?
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if is_won?
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
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
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

  def is_won?
    three_across? || three_vertically? || three_diagonally?
  end

  def tie?
    board.all? { |s| s == "X" || s == "O" }
  end

end
