require 'message_printer'
require 'pry'
class Game
  attr_accessor :input, :output, :board
  def initialize
    self.input = $stdin
    self.output = $stdout
    @message_print = MessagePrinter.new
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X"
    @hum = "O"
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
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
    board.reject { |space| space == "X" || space == "Y" }
  end

  def get_best_move(board, next_player)
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
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

  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

end
