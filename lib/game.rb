require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  attr_reader :computer_board, :player_board
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
     #may need may not......
  end

  def player_1 #thought it would be helpful to have a method to call on when user inputs rather than keep writing same code.
    player_1 = gets.chomp
    player_1.upcase
  end

  def game_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter P to play. Enter Q to quit"
    input = player_1
    until input == "P" || input == "Q"
      puts "Invalid input.  Please enter P to play or Q to quit."
      input = player_1
    end
    if input == "P"
      run_game
    elsif input == "Q"
      puts "Thanks for playing" #goodbye statement or similar
    end
  end

  def run_game
    @computer_board.cells
    @player_board.cells
    computer_ship_placement
    player_ship_placement
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

  def player_ship_placement
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."

    puts @player_board.render(true)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    puts "Enter the squares for the Cruiser (3 spaces):"
    input = player_1
    coordinates = input.split

    until @player_board.valid_placement?(cruiser, coordinates)
      puts "Invalid input.  Please enter the squares for the Cruiser (follow the example below)"
      puts "  example coordinates: A1 A2 A3" #deliberate tab for grouping
      puts " "
      puts "Enter the squares for the Cruiser (3 spaces):"
      input = player_1
      coordinates = input.split
    end

    @player_board.place(cruiser, coordinates)

    puts @player_board.render(true)
    puts "Enter the squares for the Submarine (2 spaces):"
    input = player_1
    coordinates = input.split

    until @player_board.valid_placement?(submarine, coordinates)
      puts "Invalid input.  Please enter the squares for the Submarine (follow the example below)"
      puts "  example coordinates: B3 B4" #deliberate tab for grouping
      puts " "
      puts "Enter the squares for the Submarine (2 spaces):"
      input = player_1
      coordinates = input.split
    end
    # NOTES: until does not catch coordinates inputted that are not on board
    @player_board.place(submarine, coordinates)
    puts @player_board.render(true)
  end








end
