require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  
  # def initialize
  #   @computer_board = computer_board
  #   @player_board = player_board
  # end

  def player_1
    player_1 = gets.chomp
    player_1.upcase
  end

  def game_menu
    system 'clear'
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
      puts "Thanks for playing"
    end
  end

  def run_game
    @computer_board = Board.new
    @player_board = Board.new
    @computer_board.cells
    @player_board.cells
    computer_ship_placement
    player_ship_placement
    until @computer_board.all_sunk? || @player_board.all_sunk?
      player_turn
      if @computer_board.all_sunk? == false
        computer_turn
      end
    end
    game_end
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
    system 'clear'
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

  def player_turn
    system 'clear'
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    puts "Enter the coordinate for your shot:"
    input = player_1
    coordinate = input
    until @computer_board.valid_coordinate?(coordinate)
      puts "Please enter a valid coordinate:"
      input = player_1
      coordinate = input
    end
    until @computer_board.cells[coordinate].fired_upon? == false
      puts "You have already fired upon that coordiante, please choose again"
      input = player_1
      coordinate = input
    end
    cell = @computer_board.cells[coordinate]
    cell.fire_upon
    system 'clear'
    puts "=============COMPUTER BOARD============="
    puts "Your shot on #{coordinate} was a #{cell.print_render}!"
    puts ""
    puts @computer_board.render
    if cell.ship
      if cell.ship.sunk?
        puts ""
        puts "You sunk their #{cell.ship.name}!"
      end
    end
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    puts ""
    puts "Enter to proceed"
    input = player_1
    until input == ""
      puts "Hit enter"
      input = player_1
    end
  end

  def computer_turn
    system 'clear'
    random_coordinate = @player_board.cells.values.sample
    until random_coordinate.fired_upon? == false
      random_coordinate = @player_board.cells.values.sample
    end
    
    random_coordinate.fire_upon
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts "CPU shot on #{random_coordinate.coordinate} was a #{random_coordinate.print_render}!"
    puts ""
    puts @player_board.render(true)
    if random_coordinate.ship
      if random_coordinate.ship.sunk?
        puts ""
        puts "CPU sunk your #{random_coordinate.ship.name}!"
      end
    end
    puts ""
    puts "Enter to proceed"
    input = player_1
    until input == ""
      puts "Hit enter"
      input = player_1
    end
  end

  def game_end
    system 'clear'
    if @computer_board.all_sunk?
      puts "Congratulations, you WON!"
    elsif @player_board.all_sunk?
      puts "You've lost!"
    end
    puts "Play again?"
    puts "Type P or Q"
    input = player_1
    until input == "P" || input == "Q"
      puts "Invalid input.  Please enter P to play or Q to quit."
      input = player_1
    end
    if input == "P"
      run_game
    elsif input == "Q"
      puts "Thanks for playing"
    end
  end
end
