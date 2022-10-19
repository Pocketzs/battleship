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
    it 'will confirm valid ship placement' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.cells

      expect(board.valid_placement?(cruiser, ["A1","A2","A3"])).to be true
      expect(board.valid_placement?(cruiser, ["A1","A2"])).to be false
    end

    it 'will confirm consecutive coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.cells

      expect(board.valid_placement?(cruiser, ["A1","A2","A4"])).to be false
      # expect(board.valid_placement?(cruiser, ["A1","A2"])).to be false
    end
  end
end
