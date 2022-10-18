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
  end

end
