require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize #may need may not......
  end

  def player1 #thought it would be helpful to have a method to call on when user inputs rather than keep writing same code.
    player1 = gets.chomp.downcase
  end

  def game_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = player1

    if input == "p"
      #run game
    elsif input == "q"
      puts "Thanks for playing" #goodbye statement or similar
    else
      puts "Invalid please re enter choice" #or something similar
    end
  end







end