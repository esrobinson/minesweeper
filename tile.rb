class Tile
  attr_accessor :neighbor_bombs, :bomb

  def initialize
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
    return "Boom!"
  end

  def to_s
    return "* " unless @flagged || @revealed
    return "f " if @flagged
    return "#{@neighbor_bombs} "
  end

end