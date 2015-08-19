require 'colorize'
class MessagePrinter
  def self.welcome
    puts "Welcome to Tic Tac Toe!"
  end

  def self.board(board)
    uncolored_board = "     |     |    \n #{board[0]}   |  #{board[1]}  |  #{board[2]}\n_____|_____|_____\n     |     |    \n #{board[3]}   |  #{board[4]}  |  #{board[5]}\n_____|_____|_____\n     |     |\n #{board[6]}   |  #{board[7]}  |  #{board[8]}\n_____|_____|_____"
    colored_board = uncolored_board.gsub('X', 'X'.colorize(:red))
    colored_board = colored_board.gsub('O', 'O'.colorize(:light_blue))
    puts colored_board
    # puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def self.invalid_move(spot)
    puts "Placing a piece in the #{spot} is not a valid move"
  end

  def self.instructions(hum)
    blue_o = "O".colorize(:light_blue)
    puts "Hi!  To place a piece on the board please enter
    the number of the space you want to place your piece.
    For instance typing in the number 4 places a piece in the center space
    The board would look like this if you are the letter O and placed it in the center space
     |     |    \n 0   |  1  |  2\n_____|_____|_____\n     |     |    \n 3   |  #{blue_o}  |  5\n_____|_____|_____\n     |     |\n 6   |  7  |  8\n_____|_____|_____\n\n\n"



    puts "You are the letter #{hum}"
  end

  def self.computer_move(spot, com)
    puts "The computer placed a #{com} in the #{spot}"
  end

  def self.players_turn
    "It's your turn please pick an available space"
  end

end
