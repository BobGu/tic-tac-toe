require './lib/message_printer'
require 'pry'
require 'player'
require 'board'
require 'bot'
class Game
  attr_accessor :input, :output, :board

  def initialize
    self.input = $stdin
    self.output = $stdout
    @board = Board.new
  end

  def get_players_piece
    input.gets.chomp.upcase
  end

  def start_game
    MessagePrinter.welcome
    MessagePrinter.which_piece
    assign_players_piece(get_players_piece)
    MessagePrinter.instructions(@player.piece)
    create_bot
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

  def board
    @board
  end

  def player
    @player
  end

  def bot
    @bot
  end

  def create_bot
    @bot = Bot.new(bots_piece)
  end

  def valid_piece?(input)
    input == 'X' || input == 'O'
  end

  def assign_players_piece(input)
    if valid_piece?(input)
      @player = Player.new(input)
    else
      MessagePrinter.invalid_piece(input)
      assign_players_piece(get_players_piece)
    end
  end

  def bots_piece
    @player.piece == 'X'? 'O' : 'X'
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if valid_move?(spot)
        @board[spot] = @player.piece
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
        @board[4] = @bot.piece
        spot = 4
      else
        spot = get_best_move
        if valid_move?(spot)
          @board[spot] = @bot.piece
        else
          spot = nil
        end
      end
    end
    MessagePrinter.computer_move(spot, @bot.piece)
  end

  def available_spaces
    board.reject { |space| space == "X" || space == "O" }
  end

  def get_best_move
    best_move = nil
    available_spaces.each do |as|
      board[as.to_i] = @bot.piece
      if won?
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @player.piece
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
