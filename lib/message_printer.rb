require 'colorize'
class MessagePrinter
  def self.which_piece(name)
    puts "Would you like #{name} to be X's or O's".colorize(:green)
  end

  def self.welcome
    puts "Welcome to Tic Tac Toe!".colorize(:green)
  end

  def self.which_game
    puts "Choose which game type you would like to play.  Type in (hh) for human v human (hc) human vs computer or (cc) computer vs computer".colorize(:green)
  end

  def self.player_piece(piece)
    puts "You are the letter #{piece}".colorize(:green)
  end

  def self.ask_for_name
    puts "\nHi what is your name?".colorize(:green)
  end

  def self.invalid_game_type(input)
    puts "#{input} is not a valid game type".colorize(:red)
  end

  def self.invalid_piece(input)
    puts "Hi you must either select the letter O or X! #{input} is an incorrect choice".colorize(:red)
  end

  def self.invalid_turn(input)
    puts "#{input} is not a valid turn order"
  end

  def self.player_confirmation(name, piece)
    puts "\nHey #{name} you are the #{piece}'s".colorize(:yellow)
  end

  def self.ask_for_turn_order(name)
    puts "Type in 1 if you would like #{name} to go first and 2 for #{name} to go second"
  end

  def self.board(board)
    uncolored_board = "     |     |    \n #{board[0]}   |  #{board[1]}  |  #{board[2]}\n_____|_____|_____\n     |     |    \n #{board[3]}   |  #{board[4]}  |  #{board[5]}\n_____|_____|_____\n     |     |\n #{board[6]}   |  #{board[7]}  |  #{board[8]}\n_____|_____|_____\n\n"
    colored_board = uncolored_board.gsub('X', 'X'.colorize(:red))
    colored_board = colored_board.gsub('O', 'O'.colorize(:light_blue))
    puts colored_board
  end

  def self.humans_turn(name)
    puts "It's your turn #{name} please pick an available space".colorize(:green)
  end

  def self.invalid_move(spot)
    puts "Placing a piece in the #{spot} is not a valid move".colorize(:red)
  end

  def self.instructions
    puts "Hi!  To place a piece on the board please enter the number of the space you want to place your piece. For instance if I was the letter O and typed in the number 4 the board would look like this.".colorize(:yellow)
  end

  def self.example_board
    blue_o = "O".colorize(:light_blue)
    puts "     |     |    \n 0   |  1  |  2\n_____|_____|_____\n     |     |    \n 3   |  #{blue_o}  |  5\n_____|_____|_____\n     |     |\n 6   |  7  |  8\n_____|_____|_____\n\n\n"
  end

  def self.computer_move(spot, piece)
    puts "\nThe computer placed a #{piece} in the #{spot}\n".colorize(:yellow)
  end

  def self.players_turn(name)
    puts "It's #{name}'s turn please pick an available space".colorize(:green)
  end

  def self.tie_game
    puts "'A strange game.  The only winning move is not to play.' - War Games".colorize(:yellow)
  end

  def self.play_again
    puts "Would you like to play again?  Type (y) for yes and (n) for no.".colorize(:green)
  end

end
