require_relative '../lib/message_printer'
require 'pry'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/bot'
require_relative '../lib/board_evaluator'
class Game
  attr_accessor :input,
                :board,
                :human,
                :bot,
                :players,
                :first_player,
                :second_player

  def initialize
    self.input = $stdin
    @board = Board.new
    @players ||= []
  end


  def start_game
    game_intro
  end

  private

  def get_input
    input.gets.chomp
  end

  def create_bot
    @bot = Bot.new
    if !same_bot_name?(@bot)
      players << @bot
    else
      create_bot
    end
  end

  def same_bot_name?(bot)
    if players[-1]
      bot.name == players[-1].name
    end
  end

  def valid_piece?(input)
    input == 'X' || input == 'O'
  end

  def valid_game_type?(input)
    input == "HH" ||
    input == "HC" ||
    input == "CC"
  end

  def play_again?(input)
    input.upcase == 'Y'
  end

  def assign_player_piece(input)
    if valid_piece?(input.upcase)
      players[-1].piece = input.upcase
    else
      MessagePrinter.invalid_piece(input)
      assign_player_piece(get_input)
    end
  end

  def assign_game_type(input)
    input = input.upcase
    if !valid_game_type?(input)
      MessagePrinter.invalid_game_type(input.upcase)
      assign_game_type(get_input)
    elsif input == "HC"
      human_vs_computer
    elsif input == "CC"
      computer_vs_computer
    elsif input == "HH"
      human_vs_human
    end
  end

  def assign_human_name(get_input)
    @human = Human.new(get_input)
    players << @human
  end

  def game_intro
    MessagePrinter.welcome
    MessagePrinter.which_game
    assign_game_type(get_input)
  end

  def get_player_piece
    MessagePrinter.which_piece(players[-1].name)
    assign_player_piece(get_input)
  end

  def get_player_info
    MessagePrinter.ask_for_name
    assign_human_name(get_input)
    get_player_piece
  end

  def game_instructions
    MessagePrinter.instructions
    MessagePrinter.example_board
    MessagePrinter.board(board.spaces)
  end

  def bot_or_human(player)
    player.class == Bot ? computer_move(player.piece) : get_human_spot(get_input, player)
  end

  def valid_turn_input?(input)
    input == "1" || input == "2"
  end

  def assign_turn_order(input)
    if valid_turn_input?(input)
      if input == "1"
        @first_player = players[-2]
        @second_player = players[-1]
      else
        @first_player = players[-1]
        @second_player = players[-2]
      end
    else
      MessagePrinter.invalid_turn(input)
      MessagePrinter.ask_for_turn_order(players[-1].name)
      assign_turn_order(get_input)
    end
  end

  def moves
    until game_over?
      MessagePrinter.players_turn(first_player.name)
      bot_or_human(first_player)
      MessagePrinter.board(board.spaces)
      if !game_over?
        MessagePrinter.players_turn(second_player.name)
        bot_or_human(second_player)
        MessagePrinter.board(board.spaces)
      end
    end
    MessagePrinter.tie_game if tie?
    MessagePrinter.play_again
    if play_again?(get_input)
      @board = Board.new
      MessagePrinter.ask_for_turn_order(players[-2].name)
      assign_turn_order(get_input)
      MessagePrinter.board(board.spaces)
      moves
    end
  end

  def human_vs_computer
    get_player_info
    MessagePrinter.player_confirmation(human.name, human.piece)
    create_bot
    assign_player_piece(opposite_piece(human.piece))
    MessagePrinter.ask_for_turn_order(human.name)
    assign_turn_order(get_input)
    MessagePrinter.ask_for_turn_order(players[-2].name)
    game_instructions
    moves
  end

  def human_vs_human
    get_player_info
    MessagePrinter.player_confirmation(human.name, human.piece)
    MessagePrinter.ask_for_name
    assign_human_name(get_input)
    assign_player_piece(opposite_piece(players[-2].piece))
    MessagePrinter.player_confirmation(human.name, human.piece)
    MessagePrinter.ask_for_turn_order(players[-2].name)
    assign_turn_order(get_input)
    game_instructions
    moves
  end

  def computer_vs_computer
    create_bot
    get_player_piece
    MessagePrinter.player_confirmation(bot.name, bot.piece)
    create_bot
    assign_player_piece(opposite_piece(players[-2].piece))
    MessagePrinter.player_confirmation(bot.name, bot.piece)
    MessagePrinter.ask_for_turn_order(players[-2].name)
    assign_turn_order(get_input)
    moves
  end

  def opposite_piece(piece)
    piece == 'X' ? 'O' : 'X'
  end

  def get_human_spot(input, player= human)
    if board.valid_move?(input)
      board.spaces[input.to_i] = player.piece
    else
      MessagePrinter.invalid_move(input)
      get_human_spot(get_input)
    end
  end

  def computer_next_best_move
    cm = bot.next_best_move(board).to_i
    board.spaces[cm] = bot.piece
    cm
  end

  def computer_winning_move(piece)
    BoardEvaluator.find_winning_move(board.possible_wins, piece)
  end

  def computer_blocking_move(piece)
    BoardEvaluator.find_winning_move(board.possible_wins, opposite_piece(piece))
  end

  def computers_best_move(piece)
    return computer_winning_move(piece) if computer_winning_move(piece)
    return computer_blocking_move(piece) if computer_blocking_move(piece)
    return bot.counter_opposite_corner_strategy if bot.detect_opposite_corner_strategy?(board.spaces)
    return bot.counter_corner_triangle_strategy(board.spaces) if bot.detect_corner_triangle_strategy?(board.spaces)
    return bot.counter_corner_side_middle_strategy(board) if bot.detect_corner_side_middle_strategy?(board)
    return board.spaces[4] if board.center_square_available?
    return board.available_corners.sample if board.available_corner?
    board.available_spaces.sample
  end

  def computer_move(piece)
    sleep(0.3)
    cm = computers_best_move(piece).to_i
    board.spaces[cm] = piece
  end

  def game_over?
    won? || tie?
  end

  def won?
    BoardEvaluator.check_for_wins?(board.possible_wins)
  end

  def tie?
    BoardEvaluator.tie?(board.spaces)
  end

  private :board,
            :players,
            :first_player,
            :second_player,
            :bot,
            :human

end
