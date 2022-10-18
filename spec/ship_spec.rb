require 'rspec'
require './lib/ship'



RSpec.describe Ship do
  it 'exists' do
    ship = Ship.new("Cruiser", 3)

    expect(ship).to be_a(Ship)
  end
end
