class Board
  attr_reader :game_board

  def initialize
    @game_board
  end

  def cells
    if game_board == nil 
      coordinates_array = ["A1","A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
      game_board = Hash.new
      coordinates_array.each do |coordinate|
        game_board[coordinate] = Cell.new(coordinate)
      end
      @game_board = game_board
    else
      @game_board
    end
  end

    def valid_coordinate?(coordinate)
     if cells.key?(coordinate)
       true
     else
       false
    end
  end

  def length_check(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive_check(ship, coordinates)
    numbers = coordinates.map do |coordinate|
      coordinate.scan(/\d+/).join.to_f
    end
    letters = coordinates.map do |coordinate|
      coordinate.scan(/[a-zA-z]/).join.ord.to_f
    end
    numbers_length = numbers.length
    letters_length = letters.length
    numbers_min = numbers.min
    numbers_max = numbers.max
    letters_min = letters.min
    letters_max = letters.max
    numbers_sum_1 = numbers.reduce(:+)
    numbers_sum_2 = numbers_length*(numbers_min + numbers_max)/2
    letters_sum_1 = letters.reduce(:+)
    letters_sum_2 = letters_length*(letters_min + letters_max)/2
    # this famous formula proved by Gauss is an equivalency statment that
    # is only true for a set of consecutive natural numbers
    if letters.uniq.length == 1
      numbers_sum_1 == numbers_sum_2
    elsif numbers.uniq.length == 1
      letters_sum_1 == letters_sum_2
    end
  end

  def valid_placement?(ship, coordinates)
    # later in the interaction pattern it's stated to not desire
    # the ability to input coordinates out of ascending or descending order
    # even if the cells are right next to each other on the grid
    # consecutive_check allows for this and we think it should be a feature
    if length_check(ship, coordinates) && consecutive_check(ship, coordinates)
      true
    else
      false
    end
  end

  def overlap_check(ship, coordinates)
    ships = coordinates.map do |coordinate|
      cells[coordinate].ship
    end
    if ships.all? {|ship|  ship == nil}
      true
    else
      false
    end
  end
  



  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
      cells[coordinate].place_ship(ship)
      end
    end
  end
end

