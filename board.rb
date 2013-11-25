class Board

  def initialize
    @tile_grid = Array.new(9) { Array.new(9) { Tile.new() } }
    set_tile_coords
  end

  def set_tile_coords
    @tile_grid.each_with_index do |row, r_index|
      row.each_with_index do |tile, c_index|
        tile.coords = [r_index, c_index]
      end
    end
  end

  def make_move(move)
    move_type, coords = move
    move_type == "f" ? flag(coords) : reveal(coords)
  end

  def set_bombs(no_of_bombs = 9)
    total_bombs = 0
    until total_bombs == no_of_bombs do
      tile = @tile_grid.sample.sample
      total_bombs += 1 unless tile.bomb?
      tile.bomb = true
    end
  end

  def get_tile(coords)
    x,y = coords
    @tile_grid[x][y]
  end

  def adjacent_tiles(coords)
    coords_x, coords_y = coords
    neighbor_offsets =
        [[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]
    [].tap do |neighbors|
      neighbor_offsets.each do |offset_x,offset_y|
        next unless (coords_x + offset_x).between?(0,8)
        next unless (coords_y + offset_y).between?(0,8)
        neighbors << @tile_grid[coords_x + offset_x][coords_y + offset_y]
      end
    end
  end

  def print
    @tile_grid.each do |row|
      puts row.join(" ")
    end
  end


  def won?
    false
    true if #(all mines flagged && no of mines == no of flags) || all others              revealed
  end

  def lost?
    true if #last move was a mine
  end

end