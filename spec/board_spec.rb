require 'rspec'
require './lib/cell'
require './lib/board'

describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_a(Board)
  end

  describe '#cells' do
    it 'is a hash' do
      board = Board.new

      expect(board.cells).to be_a(Hash)
    end

    it 'has 16 cells' do
      board = Board.new

      expect(board.cells.length).to eq 16
    end

    it 'has cell objects' do
      board = Board.new

      expect(board.cells.values_at("A1")[0]).to be_a(Cell)
    end

    it 'uses the same board' do
      board = Board.new
      game_board_1 = board.cells
      game_board_2 = board.cells

      expect(game_board_1).to eq(game_board_2)
    end
  end

  describe '#valid_coordinate?' do
    it 'will confirm if coordinate on board' do
      board = Board.new

      board.cells

      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#valid_placement?' do
    describe '#length_check?' do
      it 'will confirm confirm coordinates that match the length of the ship' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.cells
  
        expect(board.valid_placement?(cruiser, ["A1","A2","A3"])).to be true
        expect(board.valid_placement?(cruiser, ["A1","A2"])).to be false

        expect(board.valid_placement?(submarine, ["A1","A2"])).to be true
        expect(board.valid_placement?(submarine, ["A1"])).to be false
      end
    end

    describe '#consecutive_check?' do
      it 'will confirm consecutive coordinates in either ascending or descending order' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.cells
  
        expect(board.valid_placement?(cruiser,["A3","A2","A1"])).to be true
        expect(board.valid_placement?(submarine,["A2","A1"])).to be true
      end
  
      it 'will confirm consecutive coordinates regardless of input order' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        board.cells
  
        expect(board.valid_placement?(cruiser,["A1","A3","A2"])).to be true
      end
  
      it 'will not allow for coordinates that are not consecutive either horizontally or vertically' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.cells
  
        expect(board.valid_placement?(submarine, ["B1","B3"])).to be false
        expect(board.valid_placement?(submarine, ["B1","D1"])).to be false
        expect(board.valid_placement?(cruiser, ["A1","A2","A4"])).to be false
        expect(board.valid_placement?(cruiser, ["A1","B1","D1"])).to be false
      end
  
      it 'will confirm consecutive coordinates placed horizontally or vertically' do
        board = Board.new
        cruiser_1 = Ship.new("Cruiser", 3)
        cruiser_2 = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.cells
  
        expect(board.valid_placement?(cruiser_1,["A1","A2","A3"])).to be true
        expect(board.valid_placement?(cruiser_2,["A1","B1","C1"])).to be true
        expect(board.valid_placement?(submarine,["A1","A2"])).to be true
        expect(board.valid_placement?(submarine,["A1","B1"])).to be true
      end
  
      it 'will not allow diagonal placement' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.cells
  
        expect(board.valid_placement?(cruiser,["A1","B2","C3"])).to be false
        expect(board.valid_placement?(submarine,["A1","B2"])).to be false
      end
    end

    describe '#overlap_check?' do
      it 'checks for overlapping ships' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
  
        board.place(cruiser, ["A1", "A2", "A3"])
  
        expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
      end
    end
    
    describe '#unique_coordinates_check?' do
      it 'checks for unique coordinates' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "A1", "A1"])).to be false
        expect(board.valid_placement?(submarine, ["A1", "A1"])).to be false
      end
    end

    describe 'valid_coordinates_check?' do
      it 'checks for valid coordinates' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "A2", "A22"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A22"])).to be false
      end
    end
  end

  describe "#place" do
    it 'allows us to place a ship on the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq cruiser
      expect(cell_2.ship).to eq cruiser
      expect(cell_3.ship).to eq cruiser
    end

    it 'checks to see if the same ship is in consecutive cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_3.ship == cell_2.ship).to be true
    end

    it 'returns invalid placement for wrong placements' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.place(cruiser, ["A1", "A1", "A1"])).to eq "Invalid Ship Placement"
      expect(board.place(cruiser, ["A1", "B1"])).to eq "Invalid Ship Placement"
      expect(board.place(cruiser, ["A1", "B2", "C3"])).to eq "Invalid Ship Placement"
      expect(board.place(cruiser, ["A1", "A2", "A33"])).to eq "Invalid Ship Placement"
      expect(board.place(cruiser, ["A1", "A2", "A33"])).to eq "Invalid Ship Placement"

      board.place(submarine, ["A1", "A2"])
      expect(board.place(cruiser, ["A1", "A2", "A3"])).to eq "Invalid Ship Placement"
    end
  end

  describe "#render" do
    it 'returns the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end

  describe '#all sunk?' do
    it 'check if all the ships on the board are sunk' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_4 = board.cells["B1"]
      cell_5 = board.cells["B2"]
      
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["B1", "B2"])

      expect(board.all_sunk?).to be false

      cell_1.fire_upon
      cell_2.fire_upon
      cell_3.fire_upon

      expect(board.all_sunk?).to be false
    
      cell_4.fire_upon
      cell_5.fire_upon
      
      expect(board.all_sunk?).to be true
    end
  end
end
