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

  def game_intro
    output.puts(MessagePrinter.welcome)
    output.puts(MessagePrinter.which_piece)
    assign_players_piece(get_players_piece)
    output.puts(MessagePrinter.instructions)
    output.puts(MessagePrinter.example_board)
    create_bot
  end

  def initial_moves
    output.puts(MessagePrinter.board(@board.spaces))
    output.puts(MessagePrinter.player_piece(@player.piece))
    output.puts(MessagePrinter.humans_turn)
    get_human_spot(human_move)
    output.puts(MessagePrinter.board(@board.spaces))
    cm = computer_initial_move
    output.puts(MessagePrinter.computer_move(cm, @bot.piece))
    output.puts(MessagePrinter.board(@board.spaces))
  end

  def start_game
    game_intro
    initial_moves
    until won? || tie?
      output.puts(MessagePrinter.players_turn)
      get_human_spot(human_move)
      if !won? && !tie?
        cm = computer_move
        output.puts(MessagePrinter.computer_move(cm, @bot.piece))
      end
      output.puts(MessagePrinter.board(@board.spaces))
    end
    output.puts(MessagePrinter.tie_game) if tie?
    # output.puts(MessagePrinter.) if won?
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
      output.puts(MessagePrinter.invalid_piece(input))
      assign_players_piece(get_players_piece)
    end
  end

  def bots_piece
    @player.piece == 'X'? 'O' : 'X'
  end

  def human_move
    input.gets.chomp
  end

  def get_human_spot(input)
    if board.valid_move?(input)
      board.spaces[input.to_i] = @player.piece
    else
      output.puts(MessagePrinter.invalid_move(input))
      get_human_spot(human_move)
    end
  end

  def computer_initial_move
    cm = @bot.initial_move(board).to_i
    board.spaces[cm] = @bot.piece
    cm
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
    cm = computers_best_move.to_i
    board.spaces[cm] = @bot.piece
    cm
  end

  def won?
    BoardEvaluator.check_for_wins?(@board.possible_wins)
  end

  def tie?
    BoardEvaluator.tie?(board.spaces)
  end

end
game = Game.new
game.start_game
