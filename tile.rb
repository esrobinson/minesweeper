class Tile
  attr_accessor :bomb, :coords

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


  NEIGHBOR_OFFSETS =
    [[-1,  1],
    [  0,  1],
    [  1,  1],
    [  1,  0],
    [  1, -1],
    [  0, -1],
    [ -1, -1],
    [ -1,  0]]

  def adjacent_tiles
    coords_x, coords_y = coords    
    [].tap do |neighbors|
      NEIGHBOR_OFFSETS.each do |offset_x, offset_y|
        next unless valid_square?(offset_x, offset_y)
        neighbors << @board.tile_grid[coords_x + offset_x][coords_y + offset_y]
      end
    end
  end

  def bombed_neighbors
    adjacent_tiles.count { |tile| tile.bomb? }
  end

  def valid_square? (offset_x, offset_y)
    coords_x, coords_y = coords
    adjusted = [coords_x + offset_x, coords_y + offset_y]
    adjusted.max < 9 and adjusted.min > -1
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
      "#{bombed_neighbors}"
    else
      "*"
    end
  end
end