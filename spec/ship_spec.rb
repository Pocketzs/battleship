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

end
