class Tile
  attr_accessor :neighbor_bombs, :bomb, :coords

  def initialize(board, coords)
    @coords = coords
    @bomb = false
    @flagged = false
    @revealed = false
    @board = board
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
    @flagged = !@flagged unless revealed?
    true
  end

  def reveal
    @revealed = true
    bomb?
    # return @neighbor_bombs unless bomb?
    # false
  end

  def to_s
    if flagged?
      "F"
    elsif revealed?
      "#{@neighbor_bombs}"
    else
      "*"
    end
  end
end