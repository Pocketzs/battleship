require 'rspec'
require './lib/cell'

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
end