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
    cells.key?(coordinate)
  end

  def valid_coordinates_check?(ship,coordinates)
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def length_check?(ship, coordinates)
    ship.length == coordinates.length
  end

  def unique_coordinates_check?(ship, coordinates)
    coordinates.uniq.length > 1
  end

  def consecutive_check?(ship, coordinates)
    numbers = coordinates.map do |coordinate|
      coordinate.scan(/\d+/).join.to_f
    end
    letters = coordinates.map do |coordinate|
      coordinate.scan(/[a-zA-z]/).join.ord.to_f
    end
    # numbers_length = numbers.length
    # letters_length = letters.length
    # numbers_min = numbers.min
    # numbers_max = numbers.max
    # letters_min = letters.min
    # letters_max = letters.max
    # numbers_sum_1 = numbers.reduce(0) do |sum, number|
    #   sum + number
    # end
    # numbers_sum_2 = numbers_length*(numbers_min + numbers_max)/2
    # letters_sum_1 = letters.reduce(0) do |sum, number|
    #   sum + number
    # end
    # letters_sum_2 = letters_length*(letters_min + letters_max)/2
    # this famous formula proved by Gauss is an equivalency statment that
    # is only true for a set of consecutive natural numbers

    # Above formula does not work for numbers sets of length 2
    
    numbers_min = numbers.min - 1
    numbers_max = numbers.max
    letters_min = letters.min - 1
    letters_max = letters.max
    numbers_sum_1 = numbers.reduce(0) do |sum, number|
      sum + number
    end
    numbers_sum_2 = (numbers_max*(numbers_max + 1) - numbers_min*(numbers_min + 1))/2
    letters_sum_1 = letters.reduce(0) do |sum, number|
      sum + number
    end
    letters_sum_2 = (letters_max*(letters_max + 1) - letters_min*(letters_min + 1))/2
    if letters.uniq.length == 1
      numbers_sum_1 == numbers_sum_2
    elsif numbers.uniq.length == 1
      letters_sum_1 == letters_sum_2
    end
  end

  def overlap_check?(ship, coordinates)
    ships = coordinates.map do |coordinate|
      cells[coordinate].ship
    end
    ships.all? {|ship|  ship == nil}
  end

  def all_valid_checks?(ship,coordinates)
    if valid_coordinates_check?(ship,coordinates)
      length_check?(ship,coordinates) &&
      consecutive_check?(ship,coordinates) &&
      overlap_check?(ship,coordinates) &&
      unique_coordinates_check?(ship,coordinates) 
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    if all_valid_checks?(ship,coordinates)
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
    else
      "Invalid Ship Placement"
    end
  end

  def render(optional = false)
    render_arr = cells.map do |name, object|
      object.render(optional)
    end

    a_render = render_arr.slice(0..3)
    b_render = render_arr.slice(4..7)
    c_render = render_arr.slice(8..11)
    d_render = render_arr.slice(12..15)

    a_string = "A , \n"
    b_string = "B , \n"
    c_string = "C , \n"
    d_string = "D , \n"

    a_row = a_string.gsub(",", a_render.join(" "))
    b_row = b_string.gsub(",", b_render.join(" "))
    c_row = c_string.gsub(",", c_render.join(" "))
    d_row = d_string.gsub(",", d_render.join(" "))

    first_row = "  1 2 3 4 \n"
    board = first_row + a_row + b_row + c_row + d_row
    board
  end

  def all_sunk?
    ship_locations = cells.values.select do |cell|
      cell.ship
    end
    ships = ship_locations.map do |cell|
      cell.ship
    end
    ships.all? do |ship|
      ship.sunk?
    end
  end

end
