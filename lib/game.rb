require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  attr_reader :computer_board
  def initialize
    @computer_board = Board.new
     #may need may not......
  end

  def player1 #thought it would be helpful to have a method to call on when user inputs rather than keep writing same code.
    player1 = gets.chomp.downcase
  end

  def game_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = player1

    if input == "p"
      run_game
      puts @computer_board.render(true)
    elsif input == "q"
      puts "Thanks for playing" #goodbye statement or similar
    else
      puts "Invalid please re enter choice" #or something similar
    end
  end

  def run_game
    @computer_board.cells
    computer_ship_placement
  end

  def computer_ship_placement
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    coordinates_array = ["A1","A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    coordinates_1 = []
    coordinates_2 = []
    until @computer_board.valid_placement?(cruiser, coordinates_1) do
      coordinates_1 = coordinates_array.sample(cruiser.length)
    end
    @computer_board.place(cruiser,coordinates_1)
    until @computer_board.valid_placement?(submarine, coordinates_2) do
      coordinates_2 = coordinates_array.sample(submarine.length)
    end
    @computer_board.place(submarine,coordinates_2)
  end


end
