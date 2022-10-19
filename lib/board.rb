class Board

  def cells
    coordinates_array = ["A1","A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    game_board = Hash.new
    coordinates_array.each do |coordinate|
      game_board[coordinate] = Cell.new(coordinate)
    end
    game_board
  end

  def valid_coordinate?(coordinate)
    if cells.key?(coordinate)
      true
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    # if time, allow valid coordinates to be passed out of order
    length_check = ship.length == coordinates.length
    row_numbers = coordinates.map do |coordinate|
      coordinate.scan(/\d+/).join.to_f
    end
    length = row_numbers.length
    min = row_numbers.min
    max = row_numbers.max
    sum_1 = row_numbers.reduce(:+)
    sum_2 = length*(min + max)/2
    consecutive_check = sum_1 == sum_2
    if length_check && consecutive_check
      true
    else
      false
    end
  end
end
