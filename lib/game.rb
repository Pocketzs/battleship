require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
  end

  def player_input #thought it would be helpful to have a method to call on when user inputs rather than keep writing same code.
    player1 = gets.chomp
  end

  def game_menu
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit"
  end

end