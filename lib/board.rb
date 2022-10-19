class Board

  def cells
    coordinates_array = ["A1","A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    game_board = Hash.new
    coordinates_array.each do |coordinate|
      game_board[coordinate] = Cell.new(coordinate)
    end
    game_board
  end

end