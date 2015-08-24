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
    get_human_spot(human_move)
    MessagePrinter.board(@board.spaces)
    cm = computer_initial_move
    MessagePrinter.computer_move(cm, @bot.piece)
    MessagePrinter.board(@board.spaces)
    until won? || tie?
      MessagePrinter.players_turn
      get_human_spot(human_move)
      if !won? && !tie?
        cm = computer_move
        MessagePrinter.computer_move(cm, @bot.piece)
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

  def computer_initial_move
    board.spaces[@bot.initial_move(board).to_i] = @bot.piece
  end

  def computer_winning_move
    BoardEvaluator.find_winning_move(board.possible_wins, bot.piece)
  end

  def computer_blocking_move
    BoardEvaluator.find_winning_move(board.possible_wins, player.piece)
  end

  def computers_best_move
    return computer_winning_move if computer_winning_move
    return computer_blocking_move if computer_blocking_move
    return @board.available_corners.sample if @board.available_corner?
    @board.available_spaces.sample
  end

  def computer_move
    board.spaces[computers_best_move.to_i] = @bot.piece
  end

  def won?
    BoardEvaluator.check_for_wins?(@board.possible_wins)
  end

  def tie?
    BoardEvaluator.tie?(board.spaces)
  end

end
