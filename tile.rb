class Tile
  attr_accessor :neighbor_bombs, :bomb
  attr_reader :coords

  def initialize()
    @coords = nil
    @bomb = false
    @flagged = false
    @revealed = false
    @neighbor_bombs = 0
  end

  def bomb?
    @bomb
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def flag
    @flagged = !@flagged
  end

  def reveal
    @revealed = true
    return @neighbor_bombs unless bomb?
    false
  end

  def to_s
    if flagged?
      "f "
    elsif revealed?
      "#{@neighbor_bombs}"
    else
      "* "
    end
  end

end