require 'rspec'
require './lib/cell'
require './lib/ship'

describe Cell do
  describe '#initialize' do
    it 'exists' do
      cell = Cell.new("B4")

      expect(cell).to be_a(Cell)  
    end
    
    it 'can have different coordinates' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C2")

      expect(cell_1.coordinate).to eq("B4")
      expect(cell_2.coordinate).to eq("C2")
    end
  end

  describe '#ship' do
    it 'by default will return nil' do
      cell_1 = Cell.new("B4")

      expect(cell_1.ship).to eq nil
    end  
  end 

  describe '#empty?' do
    it 'will return true if cell is clear' do
      cell_1 = Cell.new("B4")

      expect(cell_1.empty?).to be true
    end

    it 'will return false if cell has ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)

      expect(cell.empty?).to be false
    end
  end

  describe '#place_ship' do
    it 'can place a ship in a cell' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell_1.place_ship(cruiser)

      expect(cell_1.ship).to eq cruiser
    end
  end

end
