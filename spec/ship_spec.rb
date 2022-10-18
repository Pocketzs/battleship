require 'rspec'
require './lib/ship'



RSpec.describe Ship do
  describe '#initialize' do
    it 'exists' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser).to be_a(Ship)
    end

    it 'has a name' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.name).to eq "Cruiser"
    end


    it 'has a length' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.length).to eq 3
    end

    it 'has health' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.health).to eq 3
    end

    it 'starts with health based on its length' do
      cruiser = Ship.new("Cruiser", 2)

      expect(cruiser.length).to eq 2
      expect(cruiser.health).to eq 2
    end

    it 'can have different names' do
      submarine = Ship.new("Submarine", 3)

      expect(submarine.name).to eq "Submarine"
    end

    it 'can have a different length' do
      submarine = Ship.new("Submarine", 2)

      expect(submarine.length).to eq 2
    end

    it 'can have a different health' do
      submarine = Ship.new("Submarine", 2)

      expect(submarine.health).to eq 2
    end
  end

  describe '#sunk?' do
    it 'starts not sunk' do
      submarine = Ship.new("Submarine", 2)

      expect(submarine.sunk?).to be false
    end

    it 'sinks the ship when health is 0' do
      submarine = Ship.new("Submarine", 2)

      expect(submarine.sunk?).to be false

      2.times {submarine.hit}

      expect(submarine.sunk?).to be true
    end
  end

  describe '#hit' do
    it 'reduces health by one' do
      submarine = Ship.new("Submarine", 2)

      submarine.hit

      expect(submarine.health).to eq 1
    end

    it 'will not reduce health if ship is sunk' do
      submarine = Ship.new("Submarine", 2)

      2.times {submarine.hit}
      expect(submarine.health).to eq 0

      submarine.hit

      expect(submarine.health).to eq 0
    end
  end

end
