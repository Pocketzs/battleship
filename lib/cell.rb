class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    fired_upon
  end

  def fire_upon
    if ship
      ship.hit
    end
    @fired_upon = true
  end

  def render(optional = false)
    if fired_upon == true && ship == nil
      "M"
    elsif fired_upon == true && ship.sunk?
      "X"
    elsif fired_upon == true && empty? == false
      "H"
    elsif optional == true && empty? == false
      "S"
    elsif fired_upon == false
      "."
    end
  end

  def print_render
    if render == "M"
      "Miss"
    elsif render == "H"
      "Hit"
    elsif render == "X"
      "Hit"
    end
  end  
end
