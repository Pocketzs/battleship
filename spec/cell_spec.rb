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

  describe '#fired_upon?' do
    it 'defaults false' do
      cell = Cell.new("B4")

      expect(cell.fired_upon?).to be false
    end

    it 'is true when fired upon' do
      cell = Cell.new("B4")

      cell.fire_upon

      expect(cell.fired_upon?).to be true
    end
  end

  describe '#fire_upon' do
    it 'can hit a ship' do
      cell = Cell.new("B4")
      cell_2 = Cell.new("A3")
      cruiser = Ship.new("Cruiser", 3)

      cell_2.fire_upon

      expect(cruiser.health).to eq 3
      expect(cell_2.fired_upon?).to be true

      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.ship.health).to eq 2
      expect(cell.fired_upon?).to be true
    end
  end

  describe '#render' do
    it 'shows cell has not been fired on' do
      cell_1 = Cell.new("B4")

      expect(cell_1.render).to eq "."
    end

    it 'shows shot was a miss' do
      cell_1 = Cell.new("B4")

      cell_1.fire_upon

      expect(cell_1.render).to eq "M"
    end

    it 'shows shot was a hit' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell_1.place_ship(cruiser)
      cell_1.fire_upon

      expect(cell_1.render).to eq "H"
    end

    it 'shows if ship was sunk' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell_1.place_ship(cruiser)
      3.times {cell_1.fire_upon}

      expect(cell_1.render).to eq "X"
    end

    it 'shows ship if optional on' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell_1.place_ship(cruiser)

      expect(cell_1.render(true)).to eq "S"

      cell_1.fire_upon

      expect(cell_1.render(true)).to eq "H"

      2.times {cell_1.fire_upon}

      expect(cell_1.render(true)).to eq "X"
    end
  end

  describe "#print_render" do
    it 'prints the outcome of the chosen coordinate' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("D4")
      cell_3 = Cell.new("C4")
      cell_4 = Cell.new("A4")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_1.place_ship(cruiser)
      cell_1.fire_upon
      cell_2.fire_upon

      expect(cell_1.print_render).to eq "Hit"
      expect(cell_2.print_render).to eq "Miss"
      
      cell_3.place_ship(cruiser)
      cell_4.place_ship(cruiser)
      cell_3.fire_upon
      cell_4.fire_upon

      expect(cell_3.ship.health).to eq 0
      expect(cell_3.print_render).to eq "Hit"
      expect(cell_4.print_render).to eq "Hit"
    end
  end
end
