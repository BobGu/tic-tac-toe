require 'colorize'
class MessagePrinter
  def self.which_piece(name)
    "Would you like #{name} to be X's or O's".colorize(:green)
  end

  def self.welcome
    "Welcome to Tic Tac Toe!".colorize(:green)
  end

  def self.which_game
    "Choose which game type you would like to play.  Type in (hh) for human v human (hc) human vs computer or (cc) computer vs computer".colorize(:green)
  end

  def self.player_piece(piece)
    "You are the letter #{piece}".colorize(:green)
  end

  def self.ask_for_name
    "\nHi what is your name?".colorize(:green)
  end

  def self.invalid_game_type(input)
    "#{input} is not a valid game type".colorize(:red)
  end

  def self.invalid_piece(input)
    "Hi you must either select the letter O or X! #{input} is an incorrect choice".colorize(:red)
  end

  def self.invalid_turn(input)
    "#{input} is not a valid turn order"
  end

  def self.player_confirmation(name, piece)
    "\nHey #{name} you are the #{piece}'s".colorize(:yellow)
  end

  def self.ask_for_turn_order(name)
    "Type in 1 if you would like #{name} to go first and 2 for #{name} to go second"
  end

  def self.board(board)
    uncolored_board = "     |     |    \n #{board[0]}   |  #{board[1]}  |  #{board[2]}\n_____|_____|_____\n     |     |    \n #{board[3]}   |  #{board[4]}  |  #{board[5]}\n_____|_____|_____\n     |     |\n #{board[6]}   |  #{board[7]}  |  #{board[8]}\n_____|_____|_____\n\n"
    colored_board = uncolored_board.gsub('X', 'X'.colorize(:red))
    colored_board = colored_board.gsub('O', 'O'.colorize(:light_blue))
    colored_board
  end

  def self.humans_turn(name)
    "It's your turn #{name} please pick an available space".colorize(:green)
  end

  def self.invalid_move(spot)
    "Placing a piece in the #{spot} is not a valid move".colorize(:red)
  end

  def self.instructions
    "Hi!  To place a piece on the board please enter the number of the space you want to place your piece. For instance if I was the letter O and typed in the number 4 the board would look like this.".colorize(:yellow)
  end

  def self.example_board
    blue_o = "O".colorize(:light_blue)
    "     |     |    \n 0   |  1  |  2\n_____|_____|_____\n     |     |    \n 3   |  #{blue_o}  |  5\n_____|_____|_____\n     |     |\n 6   |  7  |  8\n_____|_____|_____\n\n\n"
  end

  def self.computer_move(spot, piece)
    "\nThe computer placed a #{piece} in the #{spot}\n".colorize(:yellow)
  end

  def self.players_turn(name)
    "It's #{name}'s turn please pick an available space".colorize(:green)
  end

  def self.tie_game
    "'A strange game.  The only winning move is not to play.' - War Games".colorize(:yellow)
  end

  def self.play_again
    "Would you like to play again?  Type (y) for yes and (n) for no.".colorize(:green)
  end

end
