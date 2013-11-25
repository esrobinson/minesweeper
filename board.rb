class Board

  def initialize
    @tile_grid = Array.new(9) { Array.new(9) { Tile.new() } }
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

  def won?
    false
    true if #(all mines flagged && no of mines == no of flags) || all others              revealed
  end

  def lost?
    true if #last move was a mine
  end

end