require './lib/message_printer'
require 'pry'
require './lib/player'
require './lib/board'
require './lib/bot'
require './lib/board_evaluator'
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
    MessagePrinter.board(@board.spaces)
    puts "Please select your spot."
    until won? || tie?
      MessagePrinter.players_turn
      get_human_spot
      if !won? && !tie?
        eval_board
      end
      MessagePrinter.board(@board.spaces)
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

  def human_move
    input.gets.chomp.to_i
  end

  def get_human_spot(input)
    if board.valid_move?(input)
      board.spaces[input] = @player.piece
    else
      output.puts(MessagePrinter.invalid_move(input))
      get_human_spot(human_move)
    end
  end

  def eval_board
    spot = nil
    until spot
      if board.center_square_available?
        board.spaces[4] = @bot.piece
        spot = 4
      else
        spot = get_best_move
        if board.valid_move?(spot)
          board.spaces[spot] = @bot.piece
        else
          spot = nil
        end
      end
    end
    MessagePrinter.computer_move(spot, @bot.piece)
  end

  def get_best_move
    best_move = nil
    board.available_spaces.each do |as|
      board.spaces[as.to_i] = @bot.piece
      if won?
        binding.pry
        best_move = as.to_i
        board.spaces[as.to_i] = as
        return best_move
      else
        board.spaces[as.to_i] = @player.piece
        if won?
          best_move = as.to_i
          board.spaces[as.to_i] = as
          return best_move
        else
          board.spaces[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      if board.available_corners.count > 0
        n = board.available_corners.sample
      else
        n = board.available_spaces.sample
      end
      return n.to_i
    end
  end

  def won?
    BoardEvaluator.check_for_wins?(@board.possible_wins)
  end

  def tie?
    BoardEvaluator.tie?(board.spaces)
  end

end
